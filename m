From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] submodule update: add convenience option --init
Date: Fri, 16 May 2008 11:23:03 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161122110.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 16 12:23:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwx6O-0001mI-2K
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 12:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbYEPKXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 06:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbYEPKXA
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 06:23:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:37857 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751873AbYEPKW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 06:22:59 -0400
Received: (qmail invoked by alias); 16 May 2008 10:22:57 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp047) with SMTP; 16 May 2008 12:22:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1oPg3FB/1oGthG8lPm5K2vGpmi3rb3707t+F1VF
	0dEb0oNOciOdMf
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82267>


When a submodule is not initialized and you do not want to change the
defaults from .gitmodules anyway, you can now say

	$ git submodule update --init <name>

When "update" is called without --init on an uninitialized submodule,
a hint to use --init is printed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I know this is relatively late in the cycle, but this patch was 
	done on users' requests, and I think it is unobtrusive, yet 
	helpful.

 Documentation/git-submodule.txt |    7 ++++++-
 git-submodule.sh                |    7 ++++++-
 t/t7400-submodule-basic.sh      |   13 +++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 6ffd896..0668f29 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 [verse]
 'git-submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
 'git-submodule' [--quiet] status [--cached] [--] [<path>...]
-'git-submodule' [--quiet] [init|update] [--] [<path>...]
+'git-submodule' [--quiet] init [--] [<path>...]
+'git-submodule' [--quiet] update [--init] [--] [<path>...]
 'git-submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 
 
@@ -47,6 +48,10 @@ update::
 	Update the registered submodules, i.e. clone missing submodules and
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached.
++
+If the submodule is not yet initialized, and you just want to use the
+setting as stored in .gitmodules, you can automatically initialize the
+submodule with the --init option.
 
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
diff --git a/git-submodule.sh b/git-submodule.sh
index 67f7a28..e681818 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch]|status|init|update|summary [-n|--summary-limit <n>] [<commit>]] \
+[add <repo> [-b branch]|status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -272,6 +272,10 @@ cmd_update()
 		-q|--quiet)
 			quiet=1
 			;;
+		-i|--init)
+			shift
+			cmd_init "$@" || return
+			;;
 		--)
 			shift
 			break
@@ -297,6 +301,7 @@ cmd_update()
 			# path have been specified
 			test "$#" != "0" &&
 			say "Submodule path '$path' not initialized"
+			say "Maybe you want to use 'update --init'?"
 			continue
 		fi
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2ef85a8..6c7b902 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -196,4 +196,17 @@ test_expect_success 'apply submodule diff' '
 	test -z "$D"
 '
 
+test_expect_success 'update --init' '
+
+	mv init init2 &&
+	git config -f .gitmodules submodule.example.url "$(pwd)/init2" &&
+	git config --remove-section submodule.example
+	git submodule update init > update.out &&
+	grep "not initialized" update.out &&
+	test ! -d init/.git &&
+	git submodule update --init init &&
+	test -d init/.git
+
+'
+
 test_done
-- 
1.5.5.1.425.g5f464.dirty
