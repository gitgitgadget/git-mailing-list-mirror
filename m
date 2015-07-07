From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 14/44] builtin-am: reject patches when there's a session in progress
Date: Tue,  7 Jul 2015 22:20:32 +0800
Message-ID: <1436278862-2638-15-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:22:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTla-0004dj-Vx
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757693AbbGGOW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:26 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33575 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756991AbbGGOV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:57 -0400
Received: by pdbdz6 with SMTP id dz6so31981779pdb.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BGOLxE6OQs3Jd19RKt2Zyn67dYJCuL3OFhXGUzZnCAw=;
        b=AuEdM/fCxOXj16LWUlDWUO4Ev+aXDWdBCgunS6ztDVINNKXecXHZjkN0CCG/45sx2r
         Tr5SdOQsHW3Oa5jleqjHbks2yVoRC6+pUfZtpb2knjLpmBeMKOPSBFuRaiPJ+Ys67AgH
         J31Mm8aFLGc4mvMyj1wugIO3whHTv1IyHU8tLEv2nhBTbgOSlkTYiltBs50+JGvY23uz
         uBJEHkdzuix/U/SjpF4DqBoqV4QS6MJESSeWfVAbsej4Z4zE7Lh92qdlyaFWhT6sBgoK
         2BJaqN5h2IGCxz/20ROsPRHUivcNgAvRk8GXo5EUAfavuX9gd0IncYHBfDyBLgTglpny
         8rww==
X-Received: by 10.66.63.70 with SMTP id e6mr9464285pas.62.1436278916385;
        Tue, 07 Jul 2015 07:21:56 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:55 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273532>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
would error out if the user gave it mbox(s) on the command-line, but
there was a session in progress.

Since c95b138 (Fix git-am safety checks, 2006-09-15), git-am would
detect if the user attempted to feed it a mbox via stdin, by checking if
stdin is not a tty and there is no resume command given.

Re-implement the above two safety checks.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1db95f2..e066a97 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1147,9 +1147,24 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-	if (am_in_progress(&state))
+	if (am_in_progress(&state)) {
+		/*
+		 * Catch user error to feed us patches when there is a session
+		 * in progress:
+		 *
+		 * 1. mbox path(s) are provided on the command-line.
+		 * 2. stdin is not a tty: the user is trying to feed us a patch
+		 *    from standard input. This is somewhat unreliable -- stdin
+		 *    could be /dev/null for example and the caller did not
+		 *    intend to feed us a patch but wanted to continue
+		 *    unattended.
+		 */
+		if (argc || (resume == RESUME_FALSE && !isatty(0)))
+			die(_("previous rebase directory %s still exists but mbox given."),
+				state.dir);
+
 		am_load(&state);
-	else {
+	} else {
 		struct argv_array paths = ARGV_ARRAY_INIT;
 		int i;
 
-- 
2.5.0.rc1.76.gf60a929
