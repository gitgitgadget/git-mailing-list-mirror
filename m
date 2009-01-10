From: Fabian Franz <git@fabian-franz.de>
Subject: [PATCH v4] submodule: add --no-fetch parameter to update command
Date: Sat, 10 Jan 2009 00:10:07 -0200
Message-ID: <1231553410-7541-2-git-send-email-git@fabian-franz.de>
References: <1231553410-7541-1-git-send-email-git@fabian-franz.de>
Cc: j.sixt@viscovery.net, hjemli@gmail.com, gitster@pobox.com,
	Fabian Franz <git@fabian-franz.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 03:27:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLTZ7-0000aO-FZ
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 03:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbZAJCZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 21:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbZAJCZm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 21:25:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:56439 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754027AbZAJCZk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 21:25:40 -0500
Received: (qmail invoked by alias); 10 Jan 2009 02:25:38 -0000
Received: from unknown (EHLO localhost.localdomain) [200.142.84.36]
  by mail.gmx.net (mp048) with SMTP; 10 Jan 2009 03:25:38 +0100
X-Authenticated: #590723
X-Provags-ID: V01U2FsdGVkX19oVj0c6Spobq/lvdSfWdidGRBgP2p8jtF9hMNVT3
	FMRC9AdugJmwFE
X-Mailer: git-send-email 1.6.1.81.g21235
In-Reply-To: <1231553410-7541-1-git-send-email-git@fabian-franz.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105064>

git submodule update --no-fetch makes it possible to use git submodule
update in complete offline mode by not fetching new revisions.

Signed-off-by: Fabian Franz <git@fabian-franz.de>
---
 Documentation/git-submodule.txt |    7 ++++++-
 git-submodule.sh                |   16 ++++++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 232697d..14c1d5c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git submodule' [--quiet] add [-b branch] [-t|--track <branch>] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [--] [<path>...]
+'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
 'git submodule' [--quiet] sync [--] [<path>...]
@@ -180,6 +180,11 @@ OPTIONS
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
index 6af3d96..f66622b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch] [--track|-t <branch>] <path>]|[status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
+[add <repo> [-b branch] [--track|-t <branch>] <path>]|[status|init|update [-i|--init] [-N|--no-fetch]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -17,6 +17,7 @@ branch=
 quiet=
 cached=
 track=
+nofetch=
 
 #
 # print stuff on stdout unless -q was specified
@@ -313,6 +314,10 @@ cmd_update()
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
@@ -370,9 +375,12 @@ cmd_update()
 
 			# First fetch ...
 
-			(unset GIT_DIR; cd "$path" &&
-				git-fetch) ||
-			die "Unable to fetch in submodule path '$path'"
+			if test -z "$nofetch"
+			then
+				(unset GIT_DIR; cd "$path" &&
+					git-fetch) ||
+				die "Unable to fetch in submodule path '$path'"
+			fi
 
 			if test "$sha1" = "NULL"
 			then
-- 
1.5.3.6
