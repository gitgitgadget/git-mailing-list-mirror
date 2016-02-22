From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] git.c: simplify stripping extension of a file in handle_builtin()
Date: Mon, 22 Feb 2016 13:18:29 +0600
Message-ID: <1456125509-2317-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git @ vger . kernel . org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 08:22:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXkpV-0006hU-WE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 08:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbcBVHWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 02:22:46 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32908 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbcBVHWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 02:22:45 -0500
Received: by mail-lf0-f48.google.com with SMTP id m1so88677025lfg.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 23:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8z9Rq5BDxdQECP4mwbqJQh3FRXNdCD7QO3RLWtkgs2A=;
        b=obazAAH/5vqmFDd+3jsGASQG7Fydr9+35dYBIRWikdkeoJ3OtzvcoLaPzp2wY1HbAl
         V5utrxWViG9Z988D6rBzGIChUPq/p0bzuqW9YdH0OsIZxriiOLh5nXhx4K0frfE5tY4e
         qPXaKTdm4varEhbIw8sysBfMpnpt+eEaHAnEAKdoTFIFn5j1JXJit8sWrhVQy9tSFkrA
         CkCiVcAt0jIrSGSde9NqDpS3CE5jkO2VewhAZp8LHhYRqvNjhGpFNJnmGLktoZin6D+X
         U1QBoFvBulXBvF0Zr+RoTwlRrNbLKkAF5lW9j2R/DJjBmUn30K7qDxuS9kDU85K7Q2Q0
         geeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8z9Rq5BDxdQECP4mwbqJQh3FRXNdCD7QO3RLWtkgs2A=;
        b=lTIpAHSCOrh0XGmnW+hh5bTtapP626GsfGajoHU99TFns5rPsOLax4rdbbxa7sW21x
         MA2UR+S+bm7CgL6aOA8tqzOw4aQqr+bCqv20ThiPNKPEHUb8oIuTw6yuDlI12a2BLhFj
         FGsXukhIxlfokHFrQOa4U2gywi8XJQgkoE8EjYYs+UpkveZDqSMP2oHae9wR5mQ2U411
         cN/V+LaHrjo8bKbfp2ktFM3KrTxtwZiKJni+iUvg8hKN6nU+4ChgwXP6/a6l+kYzRrFS
         8riVYY/AJSDC8pcdzeJzY13eIflCWgBd/03vO9lpq8W9jdV9nf7EO01SU70/RzQMjHKO
         0BOg==
X-Gm-Message-State: AG10YOSl2ObPUoB+LDYdMpKSIfYPTooL9F6TLD/bGintdnzetr2E1Vl5sgmVJjFY+ODUdA==
X-Received: by 10.25.169.74 with SMTP id s71mr9828680lfe.135.1456125763721;
        Sun, 21 Feb 2016 23:22:43 -0800 (PST)
Received: from localhost.localhost ([2.135.53.16])
        by smtp.gmail.com with ESMTPSA id rp10sm3174893lbb.13.2016.02.21.23.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 23:22:42 -0800 (PST)
X-Mailer: git-send-email 2.7.1.339.g0233b80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286887>

The handle_builtin() starts from stripping of command extension if
STRIP_EXTENSION is enabled. Actually STRIP_EXTENSION does not used
anywhere else.

This patch introduces strip_extension() helper to strip STRIP_EXTENSION
extension from argv[0] with the strip_suffix() instead of manually
stripping.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
Helped-by: Jeff King <peff@peff.net>
---
Changelog:

v2: typos fixed in commit message.

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
2.7.1.339.g0233b80
