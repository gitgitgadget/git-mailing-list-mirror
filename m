From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v4.1 11/11] connect: move ssh command line preparation to a separate function
Date: Tue,  3 May 2016 21:30:15 +0900
Message-ID: <1462278615-5925-1-git-send-email-mh@glandium.org>
References: <1462265452-32360-12-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:30:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZT9-0001Lf-DU
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbcECMaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 08:30:23 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:59808 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbcECMaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:30:23 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1axZSx-0001YF-Ps; Tue, 03 May 2016 21:30:15 +0900
X-Mailer: git-send-email 2.8.1.18.gbe709d1.dirty
In-Reply-To: <1462265452-32360-12-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293395>

---
 connect.c | 109 ++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 59 insertions(+), 50 deletions(-)

Err, I had forgotten to commit --amend to add a missing argument.

diff --git a/connect.c b/connect.c
index 215d6d9..5f86983 100644
--- a/connect.c
+++ b/connect.c
@@ -673,6 +673,62 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_user,
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
+	if (user) {
+		argv_array_push(cmd, "-l");
+		argv_array_push(cmd, user);
+	}
+	argv_array_push(cmd, host);
+
+	return use_shell;
+}
+
 static struct child_process no_fork = CHILD_PROCESS_INIT;
 
 /*
@@ -767,59 +823,12 @@ struct child_process *git_connect(int fd[2], const char *url,
 
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
-			if (user) {
-				argv_array_push(&conn->args, "-l");
-				argv_array_push(&conn->args, user);
-			}
-			argv_array_push(&conn->args, host);
+			conn->use_shell = prepare_ssh_command(
+				&conn->args, user, host, port, flags);
 		} else {
+			conn->use_shell = 1;
 			transport_check_allowed("file");
 		}
 		argv_array_push(&conn->args, cmd.buf);
-- 
2.8.1.18.gbe709d1.dirty
