From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v5 9/9] connect: move ssh command line preparation to a separate function
Date: Mon, 16 May 2016 09:07:40 +0900
Message-ID: <20160516000740.19042-10-mh@glandium.org>
References: <20160516000740.19042-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:08:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b264v-0002Fm-0x
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 02:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbcEPAH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 20:07:56 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34862 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbcEPAHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 20:07:47 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b264T-0004yG-0q; Mon, 16 May 2016 09:07:41 +0900
X-Mailer: git-send-email 2.8.2.411.ga331486
In-Reply-To: <20160516000740.19042-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294700>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 108 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

diff --git a/connect.c b/connect.c
index fdd40b0..ae9ef7b 100644
--- a/connect.c
+++ b/connect.c
@@ -673,6 +673,61 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_user,
 	return protocol;
 }
 
+static int prepare_ssh_command(struct argv_array *cmd, const char *user,
+			       const char *host, const char *port, int flags)
+{
+	const char *ssh;
+	int putty = 0, tortoiseplink = 0, use_shell = 1;
+	transport_check_allowed("ssh");
+
+	ssh = getenv("GIT_SSH_COMMAND");
+	if (!ssh) {
+		const char *base;
+		char *ssh_dup;
+
+		/*
+		 * GIT_SSH is the no-shell version of
+		 * GIT_SSH_COMMAND (and must remain so for
+		 * historical compatibility).
+		 */
+		use_shell = 0;
+
+		ssh = getenv("GIT_SSH");
+		if (!ssh)
+			ssh = "ssh";
+
+		ssh_dup = xstrdup(ssh);
+		base = basename(ssh_dup);
+
+		tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
+			!strcasecmp(base, "tortoiseplink.exe");
+		putty = tortoiseplink ||
+			!strcasecmp(base, "plink") ||
+			!strcasecmp(base, "plink.exe");
+
+		free(ssh_dup);
+	}
+
+	argv_array_push(cmd, ssh);
+	if (flags & CONNECT_IPV4)
+		argv_array_push(cmd, "-4");
+	else if (flags & CONNECT_IPV6)
+		argv_array_push(cmd, "-6");
+	if (tortoiseplink)
+		argv_array_push(cmd, "-batch");
+	if (port) {
+		/* P is for PuTTY, p is for OpenSSH */
+		argv_array_push(cmd, putty ? "-P" : "-p");
+		argv_array_push(cmd, port);
+	}
+	if (user)
+		argv_array_pushf(cmd, "%s@%s", user, host);
+	else
+		argv_array_push(cmd, host);
+
+	return use_shell;
+}
+
 static struct child_process no_fork = CHILD_PROCESS_INIT;
 
 /*
@@ -767,59 +822,12 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		/* remove repo-local variables from the environment */
 		conn->env = local_repo_env;
-		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
-			const char *ssh;
-			int putty = 0, tortoiseplink = 0;
-			transport_check_allowed("ssh");
-
-			ssh = getenv("GIT_SSH_COMMAND");
-			if (!ssh) {
-				const char *base;
-				char *ssh_dup;
-
-				/*
-				 * GIT_SSH is the no-shell version of
-				 * GIT_SSH_COMMAND (and must remain so for
-				 * historical compatibility).
-				 */
-				conn->use_shell = 0;
-
-				ssh = getenv("GIT_SSH");
-				if (!ssh)
-					ssh = "ssh";
-
-				ssh_dup = xstrdup(ssh);
-				base = basename(ssh_dup);
-
-				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
-					!strcasecmp(base, "tortoiseplink.exe");
-				putty = tortoiseplink ||
-					!strcasecmp(base, "plink") ||
-					!strcasecmp(base, "plink.exe");
-
-				free(ssh_dup);
-			}
-
-			argv_array_push(&conn->args, ssh);
-			if (flags & CONNECT_IPV4)
-				argv_array_push(&conn->args, "-4");
-			else if (flags & CONNECT_IPV6)
-				argv_array_push(&conn->args, "-6");
-			if (tortoiseplink)
-				argv_array_push(&conn->args, "-batch");
-			if (port) {
-				/* P is for PuTTY, p is for OpenSSH */
-				argv_array_push(&conn->args, putty ? "-P" : "-p");
-				argv_array_push(&conn->args, port);
-			}
-			if (user)
-				argv_array_pushf(&conn->args, "%s@%s",
-				                 user, host);
-			else
-				argv_array_push(&conn->args, host);
+			conn->use_shell = prepare_ssh_command(
+				&conn->args, user, host, port, flags);
 		} else {
+			conn->use_shell = 1;
 			transport_check_allowed("file");
 		}
 		argv_array_push(&conn->args, cmd.buf);
-- 
2.8.2.411.ga331486
