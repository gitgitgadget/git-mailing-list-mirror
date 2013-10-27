From: Johan Herland <johan@herland.net>
Subject: [PATCH v2] sha1_file.c:create_tmpfile(): Fix race when creating loose object dirs
Date: Sun, 27 Oct 2013 12:35:43 +0100
Message-ID: <1382873743-4648-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 27 12:36:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaOda-0008QY-5o
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 12:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161Ab3J0LgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 07:36:00 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:57337 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab3J0Lf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 07:35:59 -0400
Received: by mail-la0-f46.google.com with SMTP id hp15so4300691lab.5
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 04:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=fjdAkG7y8IR6c0v/ko0/3T9kGxmoajY+ZOqzx+9vCdA=;
        b=CoeQXvYwurih8uFVoJRajlfJMC8bDh/gF2/J0c6AJop8/bqNJoIItY7Z99Uh8A/K5A
         mQtdABVz6LwVcrkOzQhXl3DRY+xpMPbT3bJz0kmqR4IQbA9iISVmNmm3pYEDNVXtNlwn
         GUcRrFJqLphA8nlOlaZPLCwcGBLWhlM3gd7FyQe+OYTBknvHOi1oROH6yUSkA4//aqyA
         T69GgnXxTRAmKqFzDlHBYSDEiXKB7Eegg0gCH+78okLHYkY/wIK20pYdln5URpLFcXq3
         SvzbmWkZ+6LHzC+GyVB7CbBROa29vKQPFFYKUYc8Ps+8Zlr4bsFciFlRVsuoUm31Vqx/
         XE5A==
X-Received: by 10.112.72.229 with SMTP id g5mr7754623lbv.10.1382873757612;
        Sun, 27 Oct 2013 04:35:57 -0700 (PDT)
Received: from beta.herland (96.37-191-129.fiber.lynet.no. [37.191.129.96])
        by mx.google.com with ESMTPSA id kx1sm15938073lac.7.2013.10.27.04.35.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2013 04:35:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.653.g2df02b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236801>

There are cases (e.g. when running concurrent fetches in a repo) where
multiple Git processes concurrently attempt to create loose objects
within the same objects/XX/ dir. The creation of the loose object files
is (AFAICS) safe from races, but the creation of the objects/XX/ dir in
which the loose objects reside is unsafe, for example:

Two concurrent fetches - A and B. As part of its fetch, A needs to store
12aaaaa as a loose object. B, on the other hand, needs to store 12bbbbb
as a loose object. The objects/12 directory does not already exist.
Concurrently, both A and B determine that they need to create the
objects/12 directory (because their first call to git_mkstemp_mode()
within create_tmpfile() fails witn ENOENT). One of them - let's say A -
executes the following mkdir() call before the other. This first call
returns success, and A moves on. When B gets around to calling mkdir(),
it fails with EEXIST, because A won the race. The mkdir() error causes B
to return -1 from create_tmpfile(), which propagates all the way,
resulting in the fetch failing with:

  error: unable to create temporary file: File exists
  fatal: failed to write object
  fatal: unpack-objects failed

Although it's hard to add a testcase reproducing this issue, it's easy
to provoke if we insert a sleep after the

  if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
      return -1;

block, and then run two concurrent "git fetch"es against the same repo.

The fix is to simply handle mkdir() failing with EEXIST as a success.
If EEXIST is somehow returned for the wrong reasons (because the relevant
objects/XX is not a directory, or is otherwise unsuitable for object
storage), the following call to adjust_shared_perm(), or ultimately the
retried call to git_mkstemp_mode() will fail, and we end up returning
error from create_tmpfile() in any case.

Note that there are still cases where two users with unsuitable umasks
in a shared repo can end up in two races where one user first wins the
mkdir() race to create an objects/XX/ directory, and then the other user
wins the adjust_shared_perms() race to chmod() that directory, but fails
because it is (transiently, until the first users completes its chmod())
unwriteable to the other user. However, (an equivalent of) this race also
exists before this patch, and is made no worse by this patch.

Signed-off-by: Johan Herland <johan@herland.net>
---

I didn't see this in the latest "What's cooking", so here's a resend, with
an expanded commit message to reflect our discussion. The patch itself is
unchanged.

In order to fix the remaining race, I assume we have to ensure the dir
creation obeys the same rules as the object creation, i.e. that there are
only two possible states at any time:

 - The directory does not exist

 - The directory exists with the correct permissons

To achieve this, I guess we have to follow the same procedure we do for
loose object creation:

 1. Create a temporary directory with a unique name (mkdtemp?)

 2. Adjust permissions

 3. Rename into place

Can this be done sufficiently atomically across all platforms?

...Johan


 sha1_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index f80bbe4..00ffffe 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2857,7 +2857,9 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 		/* Make sure the directory exists */
 		memcpy(buffer, filename, dirlen);
 		buffer[dirlen-1] = 0;
-		if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
+		if (mkdir(buffer, 0777) && errno != EEXIST)
+			return -1;
+		if (adjust_shared_perm(buffer))
 			return -1;
 
 		/* Try again */
-- 
1.8.4.653.g2df02b3
