From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Cast execl*() NULL sentinels to (char *)
Date: Sat, 24 Jul 2010 17:20:23 +0200
Message-ID: <00564b8ba93617801bb78b4a0ec67784e597d02a.1279983892.git.trast@student.ethz.ch>
References: <201007141740.37867.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Greg Brockman <gdb@mit.edu>,
	<avarab@gmail.com>, <kpfleming@digium.com>, <brlink@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 17:20:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgWm-0004Yx-QB
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756403Ab0GXPUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:20:36 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:45162 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756386Ab0GXPUf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:20:35 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 24 Jul
 2010 17:20:33 +0200
Received: from localhost.localdomain (217.162.250.31) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sat, 24 Jul
 2010 17:20:33 +0200
X-Mailer: git-send-email 1.7.2.278.g76edd.dirty
In-Reply-To: <201007141740.37867.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151656>

The NULL sentinel argument to the execl*() family of calls must be
cast to (char *), as otherwise:

- platforms where NULL is just 0 (not (void *)) would pass an int

- (admittedly esoteric) platforms where NULL is (void *)0 and (void *)
  and (char *) have different memory layouts would pass the wrong kind
  of pointer

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Let's not forget about this.

 builtin/help.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index a9836b0..61ff798 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -120,7 +120,7 @@ static void exec_woman_emacs(const char *path, const char *page)
 		if (!path)
 			path = "emacsclient";
 		strbuf_addf(&man_page, "(woman \"%s\")", page);
-		execlp(path, "emacsclient", "-e", man_page.buf, NULL);
+		execlp(path, "emacsclient", "-e", man_page.buf, (char *)NULL);
 		warning("failed to exec '%s': %s", path, strerror(errno));
 	}
 }
@@ -148,7 +148,7 @@ static void exec_man_konqueror(const char *path, const char *page)
 		} else
 			path = "kfmclient";
 		strbuf_addf(&man_page, "man:%s(1)", page);
-		execlp(path, filename, "newTab", man_page.buf, NULL);
+		execlp(path, filename, "newTab", man_page.buf, (char *)NULL);
 		warning("failed to exec '%s': %s", path, strerror(errno));
 	}
 }
@@ -157,7 +157,7 @@ static void exec_man_man(const char *path, const char *page)
 {
 	if (!path)
 		path = "man";
-	execlp(path, "man", page, NULL);
+	execlp(path, "man", page, (char *)NULL);
 	warning("failed to exec '%s': %s", path, strerror(errno));
 }
 
@@ -165,7 +165,7 @@ static void exec_man_cmd(const char *cmd, const char *page)
 {
 	struct strbuf shell_cmd = STRBUF_INIT;
 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
-	execl("/bin/sh", "sh", "-c", shell_cmd.buf, NULL);
+	execl("/bin/sh", "sh", "-c", shell_cmd.buf, (char *)NULL);
 	warning("failed to exec '%s': %s", cmd, strerror(errno));
 }
 
@@ -372,7 +372,7 @@ static void show_info_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
 	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
-	execlp("info", "info", "gitman", page, NULL);
+	execlp("info", "info", "gitman", page, (char *)NULL);
 	die("no info viewer handled the request");
 }
 
@@ -398,7 +398,7 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 #ifndef open_html
 static void open_html(const char *path)
 {
-	execl_git_cmd("web--browse", "-c", "help.browser", path, NULL);
+	execl_git_cmd("web--browse", "-c", "help.browser", path, (char *)NULL);
 }
 #endif
 
-- 
1.7.2.278.g76edd.dirty
