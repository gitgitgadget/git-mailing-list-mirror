From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Thu, 16 Apr 2009 23:10:56 +0200
Message-ID: <1239916256-10878-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 16 23:13:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuYtx-0007PF-GI
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 23:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbZDPVLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 17:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZDPVLI
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 17:11:08 -0400
Received: from vuizook.err.no ([85.19.221.46]:40003 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbZDPVLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 17:11:07 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LuYrK-0006Z8-Ma; Thu, 16 Apr 2009 23:11:01 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LuYrI-0002q1-RV; Thu, 16 Apr 2009 23:10:56 +0200
X-Mailer: git-send-email 1.6.3.rc0.1.g8bd72.dirty
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116717>

When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
variable to what would otherwise be passed to $SHELL -c. When this
variable is set, we use it instead of the contents of argv.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

I was unsure whether I needed to give more information about
forced-commands in the commit message itself, anyways, just in case
you don't know what it is:
http://oreilly.com/catalog/sshtdg/chapter/ch08.html#22858

I'm not sure if it's worth adding a check for SSH2_ORIGINAL_COMMAND.
Are people using the commercial SSH2 ?

 shell.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/shell.c b/shell.c
index e339369..14ff266 100644
--- a/shell.c
+++ b/shell.c
@@ -62,20 +62,25 @@ int main(int argc, char **argv)
 		die("opening /dev/null failed (%s)", strerror(errno));
 	close (devnull_fd);
 
-	/*
-	 * Special hack to pretend to be a CVS server
-	 */
-	if (argc == 2 && !strcmp(argv[1], "cvs server"))
-		argv--;
+	/* Use original command if we were run from a ssh forced-command */
+	prog = getenv("SSH_ORIGINAL_COMMAND");
+	if (!prog) {
+		/*
+		 * Special hack to pretend to be a CVS server
+		 */
+		if (argc == 2 && !strcmp(argv[1], "cvs server"))
+			argv--;
 
-	/*
-	 * We do not accept anything but "-c" followed by "cmd arg",
-	 * where "cmd" is a very limited subset of git commands.
-	 */
-	else if (argc != 3 || strcmp(argv[1], "-c"))
-		die("What do you think I am? A shell?");
+		/*
+		 * We do not accept anything but "-c" followed by "cmd arg",
+		 * where "cmd" is a very limited subset of git commands.
+		 */
+		else if (argc != 3 || strcmp(argv[1], "-c"))
+			die("What do you think I am? A shell?");
+
+		prog = argv[2];
+	}
 
-	prog = argv[2];
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
-- 
1.6.3.rc0.1.g8bd72.dirty
