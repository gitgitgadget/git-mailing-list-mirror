From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] launch_editor(): Heed GIT_EDITOR and core.editor settings
Date: Fri, 20 Jul 2007 13:06:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707201305400.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 20 14:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBrFU-0002aW-8J
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 14:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299AbXGTMGR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 08:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbXGTMGR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 08:06:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:45568 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754005AbXGTMGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 08:06:16 -0400
Received: (qmail invoked by alias); 20 Jul 2007 12:06:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 20 Jul 2007 14:06:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KOw0oDZ9KO38ukTjXh1C/f2rlMNrJs4h0z6z4R6
	QX6XDt3cdiy22A
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53086>


In the commit 'Add GIT_EDITOR environment and core.editor
configuration variables', this was done for the shell scripts.
Port it over to builtin-tag's version of launch_editor(), which
is just about to be refactored into editor.c.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-tag.c |    6 +++++-
 cache.h       |    2 ++
 config.c      |    5 +++++
 environment.c |    1 +
 4 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 507f510..cf36def 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -24,7 +24,11 @@ static void launch_editor(const char *path, char **buffer, unsigned long *len)
 	const char *args[3];
 	int fd;
 
-	editor = getenv("VISUAL");
+	editor = getenv("GIT_EDITOR");
+	if (!editor && editor_program)
+		editor = editor_program;
+	if (!editor)
+		editor = getenv("VISUAL");
 	if (!editor)
 		editor = getenv("EDITOR");
 
diff --git a/cache.h b/cache.h
index 1b88d75..0c12ce8 100644
--- a/cache.h
+++ b/cache.h
@@ -564,6 +564,8 @@ extern char *pager_program;
 extern int pager_in_use;
 extern int pager_use_color;
 
+extern char *editor_program;
+
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
diff --git a/config.c b/config.c
index bdbfdec..9d8e9dc 100644
--- a/config.c
+++ b/config.c
@@ -431,6 +431,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.editor")) {
+		editor_program = xstrdup(value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 04d06b6..2e9d505 100644
--- a/environment.c
+++ b/environment.c
@@ -33,6 +33,7 @@ size_t delta_base_cache_limit = 16 * 1024 * 1024;
 char *pager_program;
 int pager_in_use;
 int pager_use_color = 1;
+char *editor_program;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 int show_commit_annotations;
 
-- 
1.5.3.rc1.16.g9d6f-dirty
