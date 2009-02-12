From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH] Teach rebase to rebase even if upstream is up to date with -f
Date: Thu, 12 Feb 2009 20:47:41 +0100
Message-ID: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git Mailinglist" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Eric Wong" <normalperson@yhbt.net>,
	"Shawn O. Pear
X-From: git-owner@vger.kernel.org Thu Feb 12 21:49:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiUh-0002YO-Lt
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 21:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759265AbZBLUro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 15:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758877AbZBLUro
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 15:47:44 -0500
Received: from mailfe02.swip.net ([212.247.154.33]:49753 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756803AbZBLUrn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 15:47:43 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2009 15:47:42 EST
X-Cloudmark-Score: 0.000000 []
X-Cloudmark-Analysis: v=1.0 c=1 a=qcNUXQMlgSoA:10 a=AuLA5bxsci4A:10 a=avaZzRB4Cncbk6OtvmOs9w==:17 a=pGLkceISAAAA:8 a=aIiMzlGB2fuCSw1kD_kA:9 a=arlT5cztHxP4oFm9-KMA:7 a=7GrRcjFo6DRoRTZ6MGGYyXV8-vQA:4 a=6-x43y6uxGMA:10 a=q2uTnOXaV24A:10 a=MSl-tDqOz04A:10
Received: from [87.211.114.138] (account cxu-984-6hm@tele2.nl HELO localhost.localdomain)
  by mailfe02.swip.net (CommuniGate Pro SMTP 5.2.6)
  with ESMTPA id 1198339859; Thu, 12 Feb 2009 20:47:39 +0100
X-Mailer: git-send-email 1.6.2.rc0.205.g53b19b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109648>

Normally, if the current branch is up to date, the rebase is aborted.
However, it may be desirable to allow rebasing even if the current
branch is up to date, when using '-f' in combination with the
'--whitespace=fix' option for example.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

Say I have a bunch of new commits ready to submit to origin, but I want to fix
some whitespace damage, I could do something like this:

$ git checkout master
$ git branch -b rebase-me
$ git reset --hard origin/master
$ git commit --allow-empty "force rebase"
$ git checkout rebase-me
$ git rebase --whitespace=fix master
$ git rebase -i master # kick out the 'force rebase' commit
$ git checkout master
$ git reset --hard rebase-me
$ git branch -d rebase-me

The result would be that all commits in origin/master..master have any
whitespace errors fixed, but it seems a bit clumsy. That is, the need to create
a commit on master so that 'git rebase' won't bail out early makes the whole
process a lot more involved. This patch addresses simplifies the above process
to the following:

$ git rebase -f --whitespace=fix origin/master

That's a reduction of 9 commands, not too bad at all.

No tests included yet, will add them if there is any interest in the patch
from the list, otherwise I'll just keep it around locally :).

 git-rebase.sh |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6d3eddb..55d0f63 100755
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
@@ -300,6 +301,9 @@ do
 		;;
 	--root)
 		rebase_root=t
+    ;;
+  -f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--force-reba|--force_rebas|--force-rebase)
+    force_rebase=t
 		;;
 	-*)
 		usage
@@ -419,10 +423,15 @@ if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
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
1.6.2.rc0.205.g53b19b.dirty
