From: Thomas Quinot <thomas@quinot.org>
Subject: [PATCH v2 1/2] git_connect: set ssh shell command in GIT_SSH_CMD
Date: Sat, 8 Nov 2014 15:27:53 +0100
Message-ID: <20141108142753.GA28652@melamine.cuivre.fr.eu.org>
References: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
 <20141108110958.GB20750@peff.net>
 <20141108123554.GA90057@melamine.cuivre.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 15:28:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn6zp-0001zS-Ey
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 15:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbaKHO15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 09:27:57 -0500
Received: from houdart.cuivre.fr.eu.org ([81.57.40.110]:50627 "EHLO
	melamine.cuivre.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbaKHO14 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 09:27:56 -0500
Received: by melamine.cuivre.fr.eu.org (Postfix, from userid 1000)
	id 4E20835A33; Sat,  8 Nov 2014 15:27:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141108123554.GA90057@melamine.cuivre.fr.eu.org>
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

Signed-off-by: Thomas Quinot <thomas@quinot.org>
---

As suggested by Jeff, here is a second version introducing a GIT_SSH_CMD
variable that overrides GIT_SSH, and is processed by the shell.

Note that with this first patch only, the special processing for PuTTY/plink
looks at the whole command in that case. I deliberately left it that way,
even though one might imagine a case where this would cause a false positive,
e.g. if the user's login name includes the string 'plink':
   GIT_SSH_CMD="ssh -l fooplink"

The work-around in this case would be to write:
   GIT_SSH_CMD="ssh -l foop''link"

A second patch, coming in a followup message, pre-splits $GIT_SSH_CMD
and ensures that we look for "plink"/"tortoiseplink" only in the argv[0]
element.

Thomas.

 Documentation/git.txt | 26 ++++++++++++++------------
 connect.c             | 13 ++++++++++---
 2 files changed, 24 insertions(+), 15 deletions(-)

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
index d47d0ec..ecb1821 100644
--- a/connect.c
+++ b/connect.c
@@ -700,16 +700,23 @@ struct child_process *git_connect(int fd[2], const char *url,
 
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
+			if (ssh)
+				conn->use_shell = 1;
+			else {
+				ssh = getenv("GIT_SSH");
+				if (!ssh) ssh = "ssh";
+			}
 
 			argv_array_push(&conn->args, ssh);
+			putty = strcasestr(ssh, "plink");
 			if (putty && !strcasestr(ssh, "tortoiseplink"))
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
-- 
2.1.2
