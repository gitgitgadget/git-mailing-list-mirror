From: Thomas Quinot <thomas@quinot.org>
Subject: [PATCH v3] git_connect: set ssh shell command in GIT_SSH_CMD
Date: Sun, 9 Nov 2014 14:24:13 +0100
Message-ID: <20141109132413.GA53369@melamine.cuivre.fr.eu.org>
References: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
 <20141108110958.GB20750@peff.net>
 <20141108123554.GA90057@melamine.cuivre.fr.eu.org>
 <20141108142753.GA28652@melamine.cuivre.fr.eu.org>
 <20141109095155.GB17369@peff.net>
 <20141109123934.GA50956@melamine.cuivre.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 14:24:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnSTe-00041o-I6
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 14:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbaKINYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 08:24:18 -0500
Received: from houdart.cuivre.fr.eu.org ([81.57.40.110]:60494 "EHLO
	melamine.cuivre.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbaKINYR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 08:24:17 -0500
Received: by melamine.cuivre.fr.eu.org (Postfix, from userid 1000)
	id B899835E5B; Sun,  9 Nov 2014 14:24:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141109123934.GA50956@melamine.cuivre.fr.eu.org>
X-message-flag: WARNING! Using Outlook can damage your computer.
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It may be impractical to install a wrapper script for GIT_SSH
when additional parameters need to be passed. Provide an alternative
way of specifying a shell command to be run, including command line
arguments, by means of the GIT_SSH_CMD environment variable, which
behaves like GIT_SSH but is passed to the shell.

The special circuitry to modify parameters in the case of using
PuTTY's plink/tortoiseplink is activated only when using GIT_SSH;
in the case of using GIT_SSH_CMD, it is deliberately left up to the
user to make any required adaptation before calling the underlying
ssh implementation.

Signed-off-by: Thomas Quinot <thomas@quinot.org>
---
Third version: disabling the complicated plink circuitry altogether
when using GIT_SSH_CMD, as discussed. This keeps the change
very simple, which is nice.

Keepin GIT_SSH_CMD for the variable name for the time being, as
I'm not very enthusiastic with GIT_SSH_SHELLCMD (more explicit,
but too long for my taste). No strong opinion on that point
though.

Thomas.

 Documentation/git.txt | 26 ++++++++++++++------------
 connect.c             | 14 +++++++++++---
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9202010..519711d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -876,19 +876,21 @@ other
 	and the `core.editor` option in linkgit:git-config[1].
 
 'GIT_SSH'::
-	If this environment variable is set then 'git fetch'
-	and 'git push' will use this command instead
-	of 'ssh' when they need to connect to a remote system.
-	The '$GIT_SSH' command will be given exactly two or
-	four arguments: the 'username@host' (or just 'host')
-	from the URL and the shell command to execute on that
-	remote system, optionally preceded by '-p' (literally) and
-	the 'port' from the URL when it specifies something other
-	than the default SSH port.
+'GIT_SSH_CMD'::
+	If either of these environment variables is set then 'git fetch'
+	and 'git push' will use the specified command instead of 'ssh'
+	when they need to connect to a remote system.
+	The command will be given exactly two or four arguments: the
+	'username@host' (or just 'host') from the URL and the shell
+	command to execute on that remote system, optionally preceded by
+	'-p' (literally) and the 'port' from the URL when it specifies
+	something other than the default SSH port.
 +
-To pass options to the program that you want to list in GIT_SSH
-you will need to wrap the program and options into a shell script,
-then set GIT_SSH to refer to the shell script.
+`$GIT_SSH_CMD` takes precedence over `$GIT_SSH`, and is interpreted
+by the shell, which allows additional arguments to be included.
+`$GIT_SSH` on the other hand must be just the path to a program
+(which can be a wrapper shell script, if additional arguments are
+needed).
 +
 Usually it is easier to configure any desired options through your
 personal `.ssh/config` file.  Please consult your ssh documentation
diff --git a/connect.c b/connect.c
index d47d0ec..7fe5268 100644
--- a/connect.c
+++ b/connect.c
@@ -700,14 +700,22 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
-			const char *ssh = getenv("GIT_SSH");
-			int putty = ssh && strcasestr(ssh, "plink");
+			const char *ssh;
+			int putty;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			get_host_and_port(&ssh_host, &port);
 			port = get_port_numeric(port);
 
-			if (!ssh) ssh = "ssh";
+			ssh = getenv("GIT_SSH_CMD");
+			if (ssh) {
+				conn->use_shell = 1;
+				putty = 0;
+			} else {
+				ssh = getenv("GIT_SSH");
+				if (!ssh) ssh = "ssh";
+				putty = strcasestr(ssh, "plink") != NULL;
+			}
 
 			argv_array_push(&conn->args, ssh);
 			if (putty && !strcasestr(ssh, "tortoiseplink"))
-- 
2.1.2
