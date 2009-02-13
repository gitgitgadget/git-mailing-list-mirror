From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH v2] Teach rebase to rebase even if upstream is up to date
Date: Fri, 13 Feb 2009 23:48:01 +0100
Message-ID: <1234565281-20960-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 23:49:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY6qm-0003fd-SW
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 23:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbZBMWsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 17:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbZBMWsJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 17:48:09 -0500
Received: from mailfe05.swip.net ([212.247.154.129]:37857 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753338AbZBMWsI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 17:48:08 -0500
X-Cloudmark-Score: 0.000000 []
X-Cloudmark-Analysis: v=1.0 c=1 a=cj8Kmf7cSYoA:10 a=IAIGZxo8k7wA:10 a=avaZzRB4Cncbk6OtvmOs9w==:17 a=pGLkceISAAAA:8 a=8FTrvcJ3x6QRX-POjx0A:9 a=8Sn5svqDBwwA3Fm0dUEA:7 a=EYVx2W6NALpjh9P1yRrPeHHjlCcA:4 a=6-x43y6uxGMA:10 a=q2uTnOXaV24A:10 a=MSl-tDqOz04A:10
Received: from [87.211.114.138] (account cxu-984-6hm@tele2.nl HELO localhost.localdomain)
  by mailfe05.swip.net (CommuniGate Pro SMTP 5.2.6)
  with ESMTPA id 1093410127; Fri, 13 Feb 2009 23:48:04 +0100
X-Mailer: git-send-email 1.6.2.rc0.206.g681e7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109782>

Normally, if the current branch is up to date, the rebase is aborted.
However, it may be desirable to allow rebasing even if the current
branch is up to date. When using the '--whitespace=fix' option -f is
implied.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

Only added the 'case "$1" in...' bit since the RFC v1. I'm not sure
how to do the test-cases. Should they go into t3400-rebase.sh, and if
so, any suggesions on how to write these test cases?

 git-rebase.sh |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6d3eddb..ccfd2b9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--onto <newbase>] [<upstream>|--root] [<branch>]'
+USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--onto <newbase>] [<upstream>|--root] [<branch>]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -48,6 +48,7 @@ prec=4
 verbose=
 git_am_opt=
 rebase_root=
+force_rebase=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -294,12 +295,21 @@ do
 		;;
 	--whitespace=*)
 		git_am_opt="$git_am_opt $1"
+
+    case "$1" in
+    --whitespace=fix|--whitespace=strip)
+      force_rebase=t
+      ;;
+    esac
 		;;
 	-C*)
 		git_am_opt="$git_am_opt $1"
 		;;
 	--root)
 		rebase_root=t
+    ;;
+  -f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--force-reba|--force_rebas|--force-rebase)
+    force_rebase=t
 		;;
 	-*)
 		usage
@@ -419,10 +429,15 @@ if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
 	# linear history?
 	! (git rev-list --parents "$onto".."$branch" | grep " .* ") > /dev/null
 then
-	# Lazily switch to the target branch if needed...
-	test -z "$switch_to" || git checkout "$switch_to"
-	echo >&2 "Current branch $branch_name is up to date."
-	exit 0
+	if test -z "$force_rebase"
+	then
+		# Lazily switch to the target branch if needed...
+		test -z "$switch_to" || git checkout "$switch_to"
+		echo >&2 "Current branch $branch_name is up to date."
+		exit 0
+	else
+		echo "Current branch $branch_name is up to date, rebase forced."
+  fi
 fi
 
 if test -n "$verbose"
-- 
1.6.2.rc0.206.g681e7.dirty
