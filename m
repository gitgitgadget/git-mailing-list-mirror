From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] help: introduce man.viewer = eman
Date: Sat, 22 Jun 2013 17:13:29 +0530
Message-ID: <1371901409-8319-1-git-send-email-artagnon@gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 13:46:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqMHL-0003Y7-VG
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 13:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152Ab3FVLqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 07:46:48 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38861 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab3FVLqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 07:46:47 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so8942927pab.6
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=46XsD7bQ4r9t4no8TOxLPnY/GbPtgV99bR0rBO6K0aQ=;
        b=A0PLxdcmjWZlmjPSZy9JyD5PQg3RcyGm5bvjDaj4ATGf+AdL35gKGdhu85oMkHnFCM
         iWtMhIHd2XPsijKUx45PJ4/3dzPptqYzurvFrmRYVPA3uJi+gu+9upcqCOfFDLEvIwq9
         rXWgRaz3IlhA1nNoLPbiNiMJRviQly8/RLnAd7Kusx9FQpjWqDA30fzJrtjO3UTkz0Mc
         /Rxe94Ov1mBZlPVizg16qaLeDMbmndELgmpwL9028gk4fvKarOXhmoCuYRss5z1i19PG
         WndNGH7buUqnfAuYk4AJtECg6e3N5PtwpKvsal6qJrQf0lj6CsckSDjZioI+kmGy9gxk
         xLnA==
X-Received: by 10.66.254.167 with SMTP id aj7mr20503649pad.100.1371901607141;
        Sat, 22 Jun 2013 04:46:47 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id xj9sm9013443pbc.16.2013.06.22.04.46.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 04:46:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.g3e7a5b4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228698>

Corresponding to woman.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-help.txt |  3 +++
 builtin/help.c             | 11 ++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index b21e9d7..0cb4c46 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -104,6 +104,9 @@ The 'man.viewer' config variable will be checked if the 'man' format
 is chosen. The following values are currently supported:
 
 * "man": use the 'man' program as usual,
+* "eman": use 'emacsclient' to launch the "man" mode in emacs
+(this only works starting with emacsclient versions 22), on systems
+with man,
 * "woman": use 'emacsclient' to launch the "woman" mode in emacs
 (this only works starting with emacsclient versions 22),
 * "konqueror": use 'kfmclient' to open the man page in a new konqueror
diff --git a/builtin/help.c b/builtin/help.c
index 062957f..7cb44e0 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -120,7 +120,7 @@ static int check_emacsclient_version(void)
 	return 0;
 }
 
-static void exec_woman_emacs(const char *path, const char *page)
+static void exec_woman_emacs(const char *path, const char *page, int eman)
 {
 	if (!check_emacsclient_version()) {
 		/* This works only with emacsclient version >= 22. */
@@ -128,7 +128,10 @@ static void exec_woman_emacs(const char *path, const char *page)
 
 		if (!path)
 			path = "emacsclient";
-		strbuf_addf(&man_page, "(woman \"%s\")", page);
+		if (eman)
+			strbuf_addf(&man_page, "(man \"%s\")", page);
+		else
+			strbuf_addf(&man_page, "(woman \"%s\")", page);
 		execlp(path, "emacsclient", "-e", man_page.buf, (char *)NULL);
 		warning(_("failed to exec '%s': %s"), path, strerror(errno));
 	}
@@ -341,8 +344,10 @@ static void exec_viewer(const char *name, const char *page)
 
 	if (!strcasecmp(name, "man"))
 		exec_man_man(info, page);
+	else if (!strcasecmp(name, "eman"))
+		exec_woman_emacs(info, page, 1);
 	else if (!strcasecmp(name, "woman"))
-		exec_woman_emacs(info, page);
+		exec_woman_emacs(info, page, 0);
 	else if (!strcasecmp(name, "konqueror"))
 		exec_man_konqueror(info, page);
 	else if (info)
-- 
1.8.3.1.487.g3e7a5b4.dirty
