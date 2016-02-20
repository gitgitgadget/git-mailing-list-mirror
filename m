From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] git.c: simplify striping extension of a file in handle_builtin()
Date: Sat, 20 Feb 2016 20:27:48 +0600
Message-ID: <1455978468-14387-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git @ vger . kernel . org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 15:32:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX8a1-0004B9-LA
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 15:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbcBTOcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 09:32:07 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34309 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbcBTOcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 09:32:05 -0500
Received: by mail-lb0-f177.google.com with SMTP id of3so61575546lbc.1
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 06:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/Jols1lyYnqwA1Pq63PiH96MiLYVjWfxRb6wJFVhD6c=;
        b=nOQXTtLet4FBgSzIbFQhjr+4bjjwwqVnBLm/Ve1oqyxddzhZWGsxpHoEgSdhaFUUPG
         Ct/aozpWARpzNc6ype7XxwAUoCeoV97yh6X3tZV9Jw3WQUcJCY/v2X6HvGAkWrX1FNqf
         D4ts0pHu2udYhkLWFwsr8mDmOR6RlfQgvwP3bcBogBOGhh5p3udwuCuzaaVny8o1+5ZM
         it8v7pQyR7CFpKrd0iB1uUsLn2921f3X3wRXjYvO/GhNS9oFoQ8oSDBupuM4op3pNjLh
         Tm+IzKydnN5Qausb2tA5ZAlWPyh9V/s8L5jshMFwTygjikqqz60RKrNxbdv+V6judNbd
         LXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Jols1lyYnqwA1Pq63PiH96MiLYVjWfxRb6wJFVhD6c=;
        b=IRRt/jdGS5NXPRKrz81lMcq2WYWtvRa0iSlXuOjZev729jTdXcmXvKjmEOH3FzJoTU
         q6uHJD4IuG8dgNdGDzzOZglmxfDh/RFZgGBBjbA8s4jaCqbdRvSDKwO25yHQRXceac4Z
         KKKLsScLmbLg49XSSsQtUVbmAnnMWO4pXPT8lJzmDdAyzoHG44D5DHPndr2YzJoVkutv
         fKZzXxBJcnBomAVVSmDn6dxauZivPWIqikUlrQmy6gTbyidzasfXY/dpxQRQVnqzg6MS
         BT2cgOqZ7+or9EZfl7L8YAQE7yQN69fTjcMn4jh0PQhxVlodlcnYmF7I33Mj3i9JVM82
         Wmmw==
X-Gm-Message-State: AG10YOQRjjfgQ6ShPfvc7aWSeDtKkWudFGmGJ9+pYC4/M1ykx4t5kec7Ifdt0G95qUyPcg==
X-Received: by 10.112.198.162 with SMTP id jd2mr6140469lbc.53.1455978723761;
        Sat, 20 Feb 2016 06:32:03 -0800 (PST)
Received: from localhost.localhost ([37.151.37.102])
        by smtp.gmail.com with ESMTPSA id ke9sm2160968lbc.28.2016.02.20.06.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2016 06:32:02 -0800 (PST)
X-Mailer: git-send-email 2.7.1.544.g06068ab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286781>

The handle_builtin() starts from striping of command extension if
STRIP_EXTENSION is enabled. Actually STRIP_EXTENSION does not used
anywhere else.

This patch introduces strip_extension() helper to strip STRIP_EXTENSION
extension from argv[0] with the strip_suffix() instead of manually
striping.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
Helped-by: Jeff King <peff@peff.net>
---
 git-compat-util.h |  4 ----
 git.c             | 26 +++++++++++++++-----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8f0e76b..b35251c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -333,10 +333,6 @@ extern char *gitdirname(char *);
 #define _PATH_DEFPATH "/usr/local/bin:/usr/bin:/bin"
 #endif
 
-#ifndef STRIP_EXTENSION
-#define STRIP_EXTENSION ""
-#endif
-
 #ifndef has_dos_drive_prefix
 static inline int git_has_dos_drive_prefix(const char *path)
 {
diff --git a/git.c b/git.c
index 087ad31..6cc0c07 100644
--- a/git.c
+++ b/git.c
@@ -509,21 +509,25 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
+#ifdef STRIP_EXTENSION
+static void strip_extension(const char **argv)
+{
+	size_t len;
+
+	if (strip_suffix(argv[0], STRIP_EXTENSION, &len))
+		argv[0] = xmemdupz(argv[0], len);
+}
+#else
+#define strip_extension(cmd)
+#endif
+
 static void handle_builtin(int argc, const char **argv)
 {
-	const char *cmd = argv[0];
-	int i;
-	static const char ext[] = STRIP_EXTENSION;
+	const char *cmd;
 	struct cmd_struct *builtin;
 
-	if (sizeof(ext) > 1) {
-		i = strlen(argv[0]) - strlen(ext);
-		if (i > 0 && !strcmp(argv[0] + i, ext)) {
-			char *argv0 = xstrdup(argv[0]);
-			argv[0] = cmd = argv0;
-			argv0[i] = '\0';
-		}
-	}
+	strip_extension(argv);
+	cmd = argv[0];
 
 	/* Turn "git cmd --help" into "git help cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
-- 
2.5.0
