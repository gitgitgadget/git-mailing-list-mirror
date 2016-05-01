From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 6/6] connect: move ssh command line preparation to a separate function
Date: Sun,  1 May 2016 15:02:53 +0900
Message-ID: <1462082573-17992-7-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 08:03:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awkTN-0007yr-CY
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 08:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbcEAGDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 02:03:08 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33610 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbcEAGC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 02:02:59 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1awkT0-0004hA-49; Sun, 01 May 2016 15:02:54 +0900
X-Mailer: git-send-email 2.8.1.16.g58dac65.dirty
In-Reply-To: <1462082573-17992-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293139>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 101 ++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 55 insertions(+), 46 deletions(-)

diff --git a/connect.c b/connect.c
index e2b976e..db78eb2 100644
--- a/connect.c
+++ b/connect.c
@@ -639,6 +639,58 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 
 static struct child_process no_fork = CHILD_PROCESS_INIT;
 
+static int prepare_ssh_command(struct argv_array *cmd, const char *host,
+			       const char *port, int flags)
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
+	argv_array_push(cmd, host);
+
+	return use_shell;
+}
+
 /*
  * This returns a dummy child_process if the transport protocol does not
  * need fork(2), or a struct child_process object if it does.  Once done,
@@ -717,55 +769,12 @@ struct child_process *git_connect(int fd[2], const char *url,
 
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
-			argv_array_push(&conn->args, host);
+			conn->use_shell = prepare_ssh_command(
+				&conn->args, host, port, flags);
 		} else {
+			conn->use_shell = 1;
 			transport_check_allowed("file");
 		}
 		argv_array_push(&conn->args, cmd.buf);
-- 
2.8.1.16.g58dac65.dirty
