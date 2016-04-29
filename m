From: Mike Hommey <mh@glandium.org>
Subject: [RFC PATCH 3/3] connect: move ssh command line preparation to a separate (public) function
Date: Fri, 29 Apr 2016 09:43:45 +0900
Message-ID: <1461890625-23222-3-git-send-email-mh@glandium.org>
References: <20160428232936.GA8663@glandium.org>
 <1461890625-23222-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 02:44:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avwXM-0000Q1-KC
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 02:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbcD2Any (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 20:43:54 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:41658 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbcD2Anv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 20:43:51 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1avwX3-00063K-U8; Fri, 29 Apr 2016 09:43:45 +0900
X-Mailer: git-send-email 2.8.1.8.gc23d642.dirty
In-Reply-To: <1461890625-23222-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292963>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 108 +++++++++++++++++++++++++++++++++-----------------------------
 connect.h |   2 ++
 2 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/connect.c b/connect.c
index ce216cb..c71563f 100644
--- a/connect.c
+++ b/connect.c
@@ -649,6 +649,62 @@ enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	return protocol;
 }
 
+int prepare_ssh_command(struct argv_array *cmd, char *hostandport, int flags)
+{
+	const char *ssh;
+	int putty = 0, tortoiseplink = 0, use_shell = 1;
+	char *ssh_host = hostandport;
+	const char *port = NULL;
+	get_host_and_port(&ssh_host, &port);
+
+	if (!port)
+		port = get_port(ssh_host);
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
+	argv_array_push(cmd, ssh_host);
+
+	return use_shell;
+}
+
 static struct child_process no_fork = CHILD_PROCESS_INIT;
 
 /*
@@ -738,57 +794,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
-			const char *ssh;
-			int putty = 0, tortoiseplink = 0;
-			char *ssh_host = hostandport;
-			const char *port = NULL;
 			transport_check_allowed("ssh");
-			get_host_and_port(&ssh_host, &port);
-
-			if (!port)
-				port = get_port(ssh_host);
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
-			argv_array_push(&conn->args, ssh_host);
+			conn->use_shell = prepare_ssh_command(
+				&conn->args, hostandport, flags);
 		} else {
 			transport_check_allowed("file");
 		}
diff --git a/connect.h b/connect.h
index dede6e8..5392102 100644
--- a/connect.h
+++ b/connect.h
@@ -10,6 +10,8 @@ enum protocol {
 enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 				char **ret_path);
 
+int prepare_ssh_command(struct argv_array *cmd, char *hostandport, int flags);
+
 #define CONNECT_VERBOSE       (1u << 0)
 #define CONNECT_DIAG_URL      (1u << 1)
 #define CONNECT_IPV4          (1u << 2)
-- 
2.8.1.8.gc23d642.dirty
