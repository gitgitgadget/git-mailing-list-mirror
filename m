From: Fabian Franz <git@fabian-franz.de>
Subject: [PATCH] submodule: add --no-fetch parameter to update command
Date: Thu,  5 Feb 2009 20:18:32 -0200
Message-ID: <1233872312-17781-1-git-send-email-git@fabian-franz.de>
Cc: hjemli@gmail.com, Fabian Franz <git@fabian-franz.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 23:23:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVCdU-0000IA-2V
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 23:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbZBEWW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbZBEWWZ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 17:22:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:61000 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751761AbZBEWWY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 17:22:24 -0500
Received: (qmail invoked by alias); 05 Feb 2009 22:22:22 -0000
Received: from unknown (EHLO localhost.localdomain) [200.142.84.36]
  by mail.gmx.net (mp038) with SMTP; 05 Feb 2009 23:22:22 +0100
X-Authenticated: #590723
X-Provags-ID: V01U2FsdGVkX18VATddlb0VIX1x8/vBwahqJ/S/BjMTb9ZJJeS39q
	V/KFaz7m0KaCSm
X-Mailer: git-send-email 1.6.1.2.351.gccea
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108631>

git submodule update --no-fetch makes it possible to use git submodule
update in complete offline mode by not fetching new revisions.

This does make sense in the following setup:

* There is an unstable and a stable branch in the super/master repository.
* The submodules might be at different revisions in the branches.
* You are at some place without internet connection ;)

With this patch it is now possible to change branches and update
the submodules to be at the recorded revision without online access.

Another advantage is that with -N the update operation is faster, because fetch is checking for new updates even if there was no fetch/pull on the super/master repository since the last update.

Signed-off-by: Fabian Franz <git@fabian-franz.de>
---
 Documentation/git-submodule.txt |    7 ++++++-
 git-submodule.sh                |   19 ++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2f207fb..3b8df44 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git submodule' [--quiet] add [-b branch] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [--] [<path>...]
+'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
 'git submodule' [--quiet] sync [--] [<path>...]
@@ -172,6 +172,11 @@ OPTIONS
 	(the default). This limit only applies to modified submodules. The
 	size is always limited to 1 for added/deleted/typechanged submodules.
 
+-N::
+--no-fetch::
+	This option is only valid for the update command.
+	Don't fetch new objects from the remote site.
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/git-submodule.sh b/git-submodule.sh
index 2f47e06..af8d10c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch] <path>]|[status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
+[add <repo> [-b branch] <path>]|[status|init|update [-i|--init] [-N|--no-fetch]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -16,6 +16,7 @@ command=
 branch=
 quiet=
 cached=
+nofetch=
 
 #
 # print stuff on stdout unless -q was specified
@@ -300,6 +301,10 @@ cmd_update()
 			shift
 			cmd_init "$@" || return
 			;;
+		-N|--no-fetch)
+			shift
+			nofetch=1
+			;;
 		--)
 			shift
 			break
@@ -345,8 +350,16 @@ cmd_update()
 			then
 				force="-f"
 			fi
-			(unset GIT_DIR; cd "$path" && git-fetch &&
-				git-checkout $force -q "$sha1") ||
+
+			if test -z "$nofetch"
+			then
+				(unset GIT_DIR; cd "$path" &&
+					git-fetch) ||
+				die "Unable to fetch in submodule path '$path'"
+			fi
+
+			(unset GIT_DIR; cd "$path" &&
+				  git-checkout $force -q "$sha1") ||
 			die "Unable to checkout '$sha1' in submodule path '$path'"
 
 			say "Submodule path '$path': checked out '$sha1'"
-- 
1.6.1.2.351.gccea
