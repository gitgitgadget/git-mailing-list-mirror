From: Johan Herland <johan@herland.net>
Subject: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating loose object dirs
Date: Fri, 18 Oct 2013 15:17:47 +0200
Message-ID: <1382102267-18151-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 15:18:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VX9wG-00051H-Tz
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 15:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab3JRNR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 09:17:56 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:49278 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3JRNR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 09:17:56 -0400
Received: by mail-ee0-f52.google.com with SMTP id d51so143665eek.25
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 06:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=9Luoe19UAeI8b5c/tuVdqBA+Wxy+LihUdPMLCscJYlU=;
        b=XrO9ZoOySGTRmnkIRBvExcvmy758y2lVPYQAtelX0Ev/p0QCct9m6UtA3Lyr8PdPUW
         SdMMExXRN1QI8AGPVBXoStX7h2DPJIuuPxNWH6M/bFG1NFN2sBxjpV7c85Nl3amXAp33
         bNcFJTjyKfo8+LLz03GKhRzuDz73HRl5tYpfnE5nvS7shvu3GWis7lgtwGnJZSnL95CV
         5OQP36ir+XZPmKZx5gQqO2VePaQ0UF6fKarVjC1J15e+81ZEtNT3Wguh+HHIlWmRKCOj
         g80Yi09VKyo6HhNayxzO5KH0ZXpp5s2Dj8Rk/NPxa+veBl8E1aRJ45r6eGt/MecE0f3t
         bSqw==
X-Received: by 10.15.94.78 with SMTP id ba54mr100957eeb.117.1382102274952;
        Fri, 18 Oct 2013 06:17:54 -0700 (PDT)
Received: from beta.cisco.com (173-38-208-169.cisco.com. [173.38.208.169])
        by mx.google.com with ESMTPSA id bn13sm4388004eeb.11.2013.10.18.06.17.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2013 06:17:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.653.g2df02b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236348>

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
to reproduce if we insert a sleep after the

  if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
      return -1;

block, and then run two concurrent "git fetch"es against the same repo.

The fix is to simply handle mkdir() setting errno = EEXIST as success.

Signed-off-by: Johan Herland <johan@herland.net>
---
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
