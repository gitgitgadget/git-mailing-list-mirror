From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v2] Allow git-shell to be used as a ssh forced-command
Date: Tue, 21 Apr 2009 07:43:06 +0200
Message-ID: <1240292586-28192-1-git-send-email-mh@glandium.org>
References: <20090418063100.GA18568@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 21 07:44:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw8mo-0000No-EC
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 07:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbZDUFnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 01:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbZDUFnP
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 01:43:15 -0400
Received: from vuizook.err.no ([85.19.221.46]:46414 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbZDUFnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 01:43:15 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Lw8l8-0002Su-LJ; Tue, 21 Apr 2009 07:43:10 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Lw8l8-0007LH-B6; Tue, 21 Apr 2009 07:43:06 +0200
X-Mailer: git-send-email 1.6.3.rc0.54.g1042b
In-Reply-To: <20090418063100.GA18568@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117090>

When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
variable to what would otherwise be passed to $SHELL -c. When this
variable is set and git-shell was given no argument, we use it.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 shell.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/shell.c b/shell.c
index b968be7..86c9273 100644
--- a/shell.c
+++ b/shell.c
@@ -72,11 +72,16 @@ int main(int argc, char **argv)
 	/*
 	 * We do not accept anything but "-c" followed by "cmd arg",
 	 * where "cmd" is a very limited subset of git commands.
+	 * If no argument is given at all, see whether we were run from
+	 * a ssh forced-command and use the original command if so.
 	 */
 	else if (argc != 3 || strcmp(argv[1], "-c"))
-		die("What do you think I am? A shell?");
+		if (argc != 1 || !(prog = getenv("SSH_ORIGINAL_COMMAND")))
+			die("What do you think I am? A shell?");
+
+	if (!prog)
+		prog = argv[2];
 
-	prog = argv[2];
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
-- 
1.6.3.rc0.54.g1042b
