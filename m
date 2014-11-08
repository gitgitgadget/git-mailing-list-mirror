From: Thomas Quinot <thomas@quinot.org>
Subject: [PATCH v2 2/2] git_connect: when using GIT_SSH_CMD, check for plink
 in argv[0] only
Date: Sat, 8 Nov 2014 15:29:40 +0100
Message-ID: <20141108142940.GB28652@melamine.cuivre.fr.eu.org>
References: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
 <20141108110958.GB20750@peff.net>
 <20141108123554.GA90057@melamine.cuivre.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 15:29:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn71O-0003ZP-Gr
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 15:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbaKHO3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 09:29:42 -0500
Received: from houdart.cuivre.fr.eu.org ([81.57.40.110]:26019 "EHLO
	melamine.cuivre.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbaKHO3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 09:29:42 -0500
Received: by melamine.cuivre.fr.eu.org (Postfix, from userid 1000)
	id E961D35A35; Sat,  8 Nov 2014 15:29:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141108123554.GA90057@melamine.cuivre.fr.eu.org>
X-message-flag: WARNING! Using Outlook can damage your computer.
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git_connect includes circuitry to use specific command line arguments
when using PuTTY's plink. This circuitry is enabled based on the
presence of the "plink" and "tortoiseplink" substrings in the name
of the SSH program to use. When using GIT_SSH_CMD to specify a complete
shell command to run for ssh connections, look for these substrings only
in the program name (not in subsequent arguments).

Signed-off-by: Thomas Quinot <thomas@quinot.org>
---
 connect.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index ecb1821..fcb928a 100644
--- a/connect.c
+++ b/connect.c
@@ -700,22 +700,42 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
-			const char *ssh;
-			int putty;
+			const char *ssh_cmd, *ssh;
+			char *ssh_cmd_var = NULL;
+			char *putty;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			get_host_and_port(&ssh_host, &port);
 			port = get_port_numeric(port);
 
-			ssh = getenv("GIT_SSH_CMD");
-			if (ssh)
+			ssh_cmd = getenv("GIT_SSH_CMD");
+			if (ssh_cmd) {
+				/*
+				 * Split command line to check for plink in
+				 * ssh_argv[0].
+				 */
+				const char **ssh_argv;
+				ssh_cmd_var = xstrdup(ssh_cmd);
+				int ssh_argc =
+				    split_cmdline(ssh_cmd_var, &ssh_argv);
+				if (ssh_argv < 0) {
+					free(ssh_argv);
+					free(ssh_cmd_var);
+					die("invalid GIT_SSH_CMD '%s': %s",
+					    ssh,
+					    split_cmdline_strerror(ssh_argc));
+				}
+				ssh = ssh_argv[0];
+				free(ssh_argv);
+
 				conn->use_shell = 1;
-			else {
+				argv_array_push(&conn->args, ssh_cmd);
+			} else {
 				ssh = getenv("GIT_SSH");
 				if (!ssh) ssh = "ssh";
+				argv_array_push(&conn->args, ssh);
 			}
 
-			argv_array_push(&conn->args, ssh);
 			putty = strcasestr(ssh, "plink");
 			if (putty && !strcasestr(ssh, "tortoiseplink"))
 				argv_array_push(&conn->args, "-batch");
@@ -725,6 +745,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, port);
 			}
 			argv_array_push(&conn->args, ssh_host);
+			if (ssh_cmd_var) free(ssh_cmd_var);
 		} else {
 			/* remove repo-local variables from the environment */
 			conn->env = local_repo_env;
-- 
2.1.2
