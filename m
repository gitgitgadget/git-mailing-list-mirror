From: Fabian Franz <git@fabian-franz.de>
Subject: [PATCH v4] submodule: add --recursive parameter to update command
Date: Sat, 10 Jan 2009 00:10:10 -0200
Message-ID: <1231553410-7541-5-git-send-email-git@fabian-franz.de>
References: <1231553410-7541-1-git-send-email-git@fabian-franz.de>
 <1231553410-7541-2-git-send-email-git@fabian-franz.de>
 <1231553410-7541-3-git-send-email-git@fabian-franz.de>
 <1231553410-7541-4-git-send-email-git@fabian-franz.de>
Cc: j.sixt@viscovery.net, hjemli@gmail.com, gitster@pobox.com,
	Fabian Franz <git@fabian-franz.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 03:27:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLTZ9-0000aO-HE
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 03:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbZAJCZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 21:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754461AbZAJCZv
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 21:25:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:56864 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754275AbZAJCZs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 21:25:48 -0500
Received: (qmail invoked by alias); 10 Jan 2009 02:25:46 -0000
Received: from unknown (EHLO localhost.localdomain) [200.142.84.36]
  by mail.gmx.net (mp048) with SMTP; 10 Jan 2009 03:25:46 +0100
X-Authenticated: #590723
X-Provags-ID: V01U2FsdGVkX19WqmF/kRBWcsl/mV3xxQ9PTPKJozaaRNh4iMclna
	EISaXnqyyCde24
X-Mailer: git-send-email 1.6.1.81.g21235
In-Reply-To: <1231553410-7541-4-git-send-email-git@fabian-franz.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105067>

If --recursive is specified on update, then recursively check for
.gitmodules in each updated submodule and run init and update commands.
The update command is run with the same parameters as the original update
command with the exception of the path.

Signed-off-by: Fabian Franz <git@fabian-franz.de>
---
 Documentation/git-submodule.txt |    8 ++++++++
 git-submodule.sh                |   17 ++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index fbb18ee..c9adc43 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -188,6 +188,14 @@ OPTIONS
 	This option is only valid for the update command.
 	Don't fetch new objects from the remote site.
 
+-r::
+--recursive::
+	This option is only valid for the update command.
+	Recursively check for .gitmodules in each updated submodule and run
+	init and update commands. The update command is run with the same
+	parameters as the original update command with the exception of the
+	path.
+
 -u::
 --use-gitmodules::
 	This option is only valid for the update command.
diff --git a/git-submodule.sh b/git-submodule.sh
index 54b59b2..8bb00b7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch] [--track|-t <branch>] <path>]|[status|init|update [-i|--init] [-N|--no-fetch] [-u|--use-gitmodules]|summary [-n|--summary-limit <n>] [<commit>]] \
+[add <repo> [-b branch] [--track|-t <branch>] <path>]|[status|init|update [-i|--init] [-N|--no-fetch] [-r|--recursive] [-u|--use-gitmodules]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -19,6 +19,7 @@ cached=
 track=
 nofetch=
 usegitmodules=
+recursive=
 
 #
 # print stuff on stdout unless -q was specified
@@ -319,6 +320,10 @@ cmd_update()
 			shift
 			nofetch=1
 			;;
+		-r|--recursive)
+			shift
+			recursive=1
+			;;
 		-u|--use-gitmodules)
 			shift
 			usegitmodules=1
@@ -445,6 +450,16 @@ cmd_update()
 
 			say "Submodule path '$path': checked out '$sha1'${track:+ ($track)}"
 		fi
+		if test -n "$recursive" -a -f "$path/.gitmodules"
+		then
+			PARAMS="${quiet:+-q} ${nofetch:+--no-fetch} ${recursive:+-r} ${usegitmodules:+-u}"
+			say "Entering submodule path '$path'"
+			(unset GIT_DIR; cd "$path" &&
+				  git-submodule init &&
+				  git-submodule update $PARAMS) ||
+			die "Unable to run 'git-submodule update $PARAMS' in submodule path '$path'"
+			say "Leaving submodule path '$path'"
+		fi
 	done
 }
 
-- 
1.5.3.6
