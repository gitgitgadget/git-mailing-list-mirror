From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v8 9/9] connect: move ssh command line preparation to a separate function
Date: Fri, 27 May 2016 11:27:56 +0900
Message-ID: <20160527022756.22904-10-mh@glandium.org>
References: <20160527022756.22904-1-mh@glandium.org>
Cc: git@vger.kernel.org, tboegi@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 27 04:28:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67VY-0005DY-O1
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbcE0C2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:28:05 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40436 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231AbcE0C2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:28:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b67VF-0005yX-0V; Fri, 27 May 2016 11:27:57 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160527022756.22904-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295711>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 108 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

diff --git a/connect.c b/connect.c
index 9aea3cd..076ae09 100644
--- a/connect.c
+++ b/connect.c
@@ -684,6 +684,61 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_user,
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
@@ -780,59 +835,12 @@ struct child_process *git_connect(int fd[2], const char *url,
 
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
-						 user, host);
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
2.8.3
