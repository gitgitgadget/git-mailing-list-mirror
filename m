From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Get rid of the last remnants of GIT_CONFIG_LOCAL
Date: Sun, 14 Dec 2008 23:10:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812142310210.25197@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Dec 14 23:13:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBzCy-00043X-TS
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 23:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbYLNWLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 17:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbYLNWLq
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 17:11:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:49977 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751738AbYLNWLp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 17:11:45 -0500
Received: (qmail invoked by alias); 14 Dec 2008 22:11:43 -0000
Received: from pD9EB4001.dip0.t-ipconnect.de (EHLO noname) [217.235.64.1]
  by mail.gmx.net (mp070) with SMTP; 14 Dec 2008 23:11:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18yFMcvSrAyxK8+30eIGWrUHxNtJuHaePpdZ+z70n
	SafcsXpZ2TSXjH
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103100>


In dc871831(Only use GIT_CONFIG in "git config", not other programs),
GIT_CONFIG_LOCAL was rested in peace, in favor of not reading
/etc/gitconfig and $HOME/.gitconfig at all when GIT_CONFIG is set.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c             |    5 +----
 git-svn.perl         |    3 +--
 t/t5400-send-pack.sh |    2 +-
 t/test-lib.sh        |    1 -
 4 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index 8bd6106..8ff2b4b 100644
--- a/config.c
+++ b/config.c
@@ -640,10 +640,7 @@ int git_config(config_fn_t fn, void *data)
 	char *repo_config = NULL;
 	const char *home = NULL;
 
-	/* $GIT_CONFIG makes git read _only_ the given config file,
-	 * $GIT_CONFIG_LOCAL will make it process it in addition to the
-	 * global config file, the same way it would the per-repository
-	 * config file otherwise. */
+	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
 	if (config_exclusive_filename)
 		return git_config_from_file(fn, config_exclusive_filename, data);
 	if (git_config_system() && !access(git_etc_gitconfig(), R_OK))
diff --git a/git-svn.perl b/git-svn.perl
index 914c707..efda5c1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5007,8 +5007,7 @@ sub minimize_connections {
 		}
 	}
 	if (@emptied) {
-		my $file = $ENV{GIT_CONFIG} || $ENV{GIT_CONFIG_LOCAL} ||
-		           "$ENV{GIT_DIR}/config";
+		my $file = $ENV{GIT_CONFIG} || "$ENV{GIT_DIR}/config";
 		print STDERR <<EOF;
 The following [svn-remote] sections in your config file ($file) are empty
 and can be safely removed:
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index da69f08..b21317d 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -99,7 +99,7 @@ test_expect_success \
 	! test -f victim/.git/refs/heads/extra
 '
 
-unset GIT_CONFIG GIT_CONFIG_LOCAL
+unset GIT_CONFIG
 HOME=`pwd`/no-such-directory
 export HOME ;# this way we force the victim/.git/config to be used.
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8936173..22ed448 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -471,7 +471,6 @@ PATH=$TEST_DIRECTORY/..:$PATH
 GIT_EXEC_PATH=$(pwd)/..
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 unset GIT_CONFIG
-unset GIT_CONFIG_LOCAL
 GIT_CONFIG_NOSYSTEM=1
 GIT_CONFIG_NOGLOBAL=1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
-- 
1.6.0.4.1189.g8876f
