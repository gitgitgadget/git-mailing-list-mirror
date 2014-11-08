From: Thomas Quinot <thomas@quinot.org>
Subject: [PATCH] git_connect: allow passing arguments to ssh in GIT_SSH_ARGS
Date: Sat, 8 Nov 2014 11:44:39 +0100
Message-ID: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 11:54:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn3f5-0000ln-OG
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 11:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbaKHKy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 05:54:27 -0500
Received: from houdart.cuivre.fr.eu.org ([81.57.40.110]:29772 "EHLO
	melamine.cuivre.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbaKHKyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 05:54:25 -0500
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Nov 2014 05:54:25 EST
Received: by melamine.cuivre.fr.eu.org (Postfix, from userid 1000)
	id D576033553; Sat,  8 Nov 2014 11:44:39 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It may be impractical to install a wrapper script for ssh
when additional parameters need to be passed. Provide an
alternative way of specifying these by means of the GIT_SSH_ARGS
environment variable. Arguments are whitespace delimited following
usual shell conventions; embedded whitespace can be enclosed
in quotes, or escaped with a backslash.

Signed-off-by: Thomas Quinot <thomas@quinot.org>
---

Dear fellow GIT developers,

I hope I won't stray too far away from established procedures
with my first contribution to git. This patch adds support
for a GIT_SSH_ARGS environment variable, providing a way
of specifying ssh arguments without having to create a
wrapper script.

Thomas.

 Documentation/git.txt | 11 +++++++++--
 connect.c             | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9202010..3ac7b5b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -887,13 +887,20 @@ other
 	than the default SSH port.
 +
 To pass options to the program that you want to list in GIT_SSH
-you will need to wrap the program and options into a shell script,
-then set GIT_SSH to refer to the shell script.
+you can either wrap the program and options into a shell script,
+then set GIT_SSH to refer to the shell script, or use the
+GIT_SSH_ARGS environment variable (see below).
 +
 Usually it is easier to configure any desired options through your
 personal `.ssh/config` file.  Please consult your ssh documentation
 for further details.
 
+'GIT_SSH_ARGS'::
+	This environment variables provides additional arguments to be
+	passed to GIT_SSH. Arguments are split by spaces, the usual shell
+	quoting and escaping is supported. Quote pairs or a backslash can
+	be used to quote them.
+
 'GIT_ASKPASS'::
 	If this environment variable is set, then Git commands which need to
 	acquire passwords or passphrases (e.g. for HTTP or IMAP authentication)
diff --git a/connect.c b/connect.c
index d47d0ec..3d4b182 100644
--- a/connect.c
+++ b/connect.c
@@ -701,9 +701,15 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh = getenv("GIT_SSH");
+			const char *ssh_args_env = getenv("GIT_SSH_ARGS");
+			char *ssh_args = ssh_args_env ?
+				xstrdup(ssh_args_env) : NULL;
 			int putty = ssh && strcasestr(ssh, "plink");
 			char *ssh_host = hostandport;
 			const char *port = NULL;
+			const char **argv;
+			int argc;
+
 			get_host_and_port(&ssh_host, &port);
 			port = get_port_numeric(port);
 
@@ -717,6 +723,22 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, putty ? "-P" : "-p");
 				argv_array_push(&conn->args, port);
 			}
+
+			if (ssh_args) {
+				argc = split_cmdline(ssh_args, &argv);
+				if (argc < 0) {
+					free(ssh_args);
+					die("invalid GIT_SSH_ARGS '%s': %s",
+					    ssh_args_env,
+					    split_cmdline_strerror(argc));
+				}
+
+				while (argc--)
+					argv_array_push(&conn->args, *argv++);
+				free(ssh_args);
+				free(argv);
+			}
+
 			argv_array_push(&conn->args, ssh_host);
 		} else {
 			/* remove repo-local variables from the environment */
-- 
1.9.2
