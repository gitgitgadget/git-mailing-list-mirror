From: Fabian Franz <git@fabian-franz.de>
Subject: [PATCH v4] submodule: add --use-gitmodules parameter to update command
Date: Sat, 10 Jan 2009 00:10:08 -0200
Message-ID: <1231553410-7541-3-git-send-email-git@fabian-franz.de>
References: <1231553410-7541-1-git-send-email-git@fabian-franz.de>
 <1231553410-7541-2-git-send-email-git@fabian-franz.de>
Cc: j.sixt@viscovery.net, hjemli@gmail.com, gitster@pobox.com,
	Fabian Franz <git@fabian-franz.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 03:27:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLTZ8-0000aO-4v
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 03:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbZAJCZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 21:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754273AbZAJCZo
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 21:25:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:56552 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754248AbZAJCZn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 21:25:43 -0500
Received: (qmail invoked by alias); 10 Jan 2009 02:25:41 -0000
Received: from unknown (EHLO localhost.localdomain) [200.142.84.36]
  by mail.gmx.net (mp048) with SMTP; 10 Jan 2009 03:25:41 +0100
X-Authenticated: #590723
X-Provags-ID: V01U2FsdGVkX1/h92xxCGHh7zLWgvZC0DMHaeAkC50GWhT5wo1ag1
	AP4/o3BpDS9Fb+
X-Mailer: git-send-email 1.6.1.81.g21235
In-Reply-To: <1231553410-7541-2-git-send-email-git@fabian-franz.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105068>

When -u|--use-gitmodules is given the update command uses the .gitmodules
config file instead of the .git/config file to obtain the track parameter.
This makes it for example possible to change branches for all submodules
at the same time without having to sync up .git/config first.

Signed-off-by: Fabian Franz <git@fabian-franz.de>
---
 Documentation/git-submodule.txt |    8 +++++++-
 git-submodule.sh                |    9 ++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 14c1d5c..175b4b5 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git submodule' [--quiet] add [-b branch] [-t|--track <branch>] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--] [<path>...]
+'git submodule' [--quiet] update [--init] [-N|--no-fetch] [-u|--use-gitmodules] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
 'git submodule' [--quiet] sync [--] [<path>...]
@@ -185,6 +185,12 @@ OPTIONS
 	This option is only valid for the update command.
 	Don't fetch new objects from the remote site.
 
+-u::
+--use-gitmodules::
+	This option is only valid for the update command.
+	Use the tracking information found in .gitmodules
+	(track) and ignore .git/config.
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/git-submodule.sh b/git-submodule.sh
index f66622b..81b96dd 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch] [--track|-t <branch>] <path>]|[status|init|update [-i|--init] [-N|--no-fetch]|summary [-n|--summary-limit <n>] [<commit>]] \
+[add <repo> [-b branch] [--track|-t <branch>] <path>]|[status|init|update [-i|--init] [-N|--no-fetch] [-u|--use-gitmodules]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -18,6 +18,7 @@ quiet=
 cached=
 track=
 nofetch=
+usegitmodules=
 
 #
 # print stuff on stdout unless -q was specified
@@ -318,6 +319,10 @@ cmd_update()
 			shift
 			nofetch=1
 			;;
+		-u|--use-gitmodules)
+			shift
+			usegitmodules=1
+			;;
 		--)
 			shift
 			break
@@ -347,6 +352,8 @@ cmd_update()
 		fi
 
 		track=$(git config submodule."$name".track)
+		test -n "$usegitmodules" &&
+			track=$(git config -f .gitmodules submodule."$name".track)
 		if test -n "$track"
 		then
 			git-update-index --assume-unchanged "$path"
-- 
1.5.3.6
