From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Set up argv0_path correctly, even when argv[0] is just the
 basename
Date: Sat, 26 Jul 2008 16:14:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 16:14:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMkXY-0001Da-Ou
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 16:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbYGZONd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 10:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbYGZONd
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 10:13:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:58225 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751866AbYGZONc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 10:13:32 -0400
Received: (qmail invoked by alias); 26 Jul 2008 14:13:29 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp064) with SMTP; 26 Jul 2008 16:13:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VkqgiPG/VmlbxnyBKsR99m+97FgAr/SLC3oiF43
	EGDAxr7U7z2PBw
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1217065304-27815-1-git-send-email-prohaska@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90225>


When the program 'git' is in the PATH, the argv[0] is set to the basename.
However, argv0_path needs the full path, so add a function to discover the
program by traversing the PATH manually.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	So it is not easily possible to reuse this function in 
	compat/mingw.c, as Junio said that compat/ should not depend
	(at least too much) on libgit.a.

	Of course, we could try to follow a symlinked git, too, but I 
	think this is overkill until someone proves me wrong.

 exec_cmd.c |   22 ++++++++++++++++++++++
 exec_cmd.h |    1 +
 git.c      |    6 ++++++
 3 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 0ed768d..048f3ca 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -125,3 +125,25 @@ int execl_git_cmd(const char *cmd,...)
 	argv[argc] = NULL;
 	return execv_git_cmd(argv);
 }
+
+char *lookup_program_in_path(const char *program)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *path = getenv("PATH");
+
+	if (!path || !*path)
+		return NULL;
+
+	for (;;) {
+		const char *colon = strchrnul(path, PATH_SEP);
+
+		strbuf_setlen(&buf, 0);
+		strbuf_addf(&buf, "%.*s/%s",
+				(int)(colon - path), path, program);
+		if (!access(buf.buf, X_OK))
+			return strbuf_detach(&buf, NULL);
+		if (!*colon)
+			return NULL;
+		path = colon + 1;
+	}
+}
diff --git a/exec_cmd.h b/exec_cmd.h
index 0c46cd5..4548390 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -8,5 +8,6 @@ extern void setup_path(void);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
 extern const char *system_path(const char *path);
+extern char *lookup_program_in_path(const char *program);
 
 #endif /* GIT_EXEC_CMD_H */
diff --git a/git.c b/git.c
index 54c5bfa..0ec8ee1 100644
--- a/git.c
+++ b/git.c
@@ -428,6 +428,12 @@ int main(int argc, const char **argv)
 	do
 		--slash;
 	while (cmd <= slash && !is_dir_sep(*slash));
+	if (slash < cmd) {
+		cmd = lookup_program_in_path(cmd);
+		for (slash = (char *)cmd + strlen(cmd) - 1;
+				cmd <= slash && !is_dir_sep(*slash); slash--)
+			; /* do nothing */
+	}
 	if (cmd <= slash) {
 		*slash++ = 0;
 		git_set_argv0_path(cmd);
-- 
1.5.6.2.516.g22071
