From: Mike Lundy <mike@fluffypenguin.org>
Subject: [PATCH] Support merge strategy options in rebase
Date: Sat, 27 Feb 2010 20:43:27 -0800
Message-ID: <1267332207-22675-1-git-send-email-mike@fluffypenguin.org>
Cc: gitster@pobox.com, mike@fluffypenguin.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 05:43:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nlb0L-0000b2-R6
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 05:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031388Ab0B1Eni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 23:43:38 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52008 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031375Ab0B1Enb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 23:43:31 -0500
Received: by gyh20 with SMTP id 20so676653gyh.19
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 20:43:30 -0800 (PST)
Received: by 10.101.195.29 with SMTP id x29mr3598072anp.93.1267332210652;
        Sat, 27 Feb 2010 20:43:30 -0800 (PST)
Received: from localhost (adsl-69-228-190-230.dsl.snfc21.pacbell.net [69.228.190.230])
        by mx.google.com with ESMTPS id 21sm628214yxe.56.2010.02.27.20.43.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Feb 2010 20:43:30 -0800 (PST)
X-Mailer: git-send-email 1.7.0.95.g91ec93
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141242>

The manpage says that git-rebase supports merge strategies, but the rebase
command doesn't know about -X, and gives the usage when presented with it.

Signed-off-by: Mike Lundy <mike@fluffypenguin.org>
---

 My test modification only makes sure that the argument is accepted; it assumes
 merge strategies are already tested and they won't actually be needed, because
 there's no conflict.

 git-rebase.sh           |   15 ++++++++++++++-
 t/t3402-rebase-merge.sh |    3 ++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index fb4fef7..c2a92af 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -44,6 +44,7 @@ To restore the original branch and stop rebasing run \"git rebase --abort\".
 "
 unset newbase
 strategy=recursive
+strategy_opts=
 do_merge=
 dotest="$GIT_DIR"/rebase-merge
 prec=4
@@ -111,7 +112,7 @@ call_merge () {
 	then
 		export GIT_MERGE_VERBOSITY=1
 	fi
-	git-merge-$strategy "$cmt^" -- "$hd" "$cmt"
+	git-merge-$strategy $strategy_opts "$cmt^" -- "$hd" "$cmt"
 	rv=$?
 	case "$rv" in
 	0)
@@ -295,6 +296,18 @@ do
 	-M|-m|--m|--me|--mer|--merg|--merge)
 		do_merge=t
 		;;
+	-X*|--strategy-option*)
+		case "$#,$1" in
+		*,*=*)
+			strategy_opts="$strategy_opts --`expr "z$1" : 'z-[^=]*=\(.*\)'`" ;;
+		1,*)
+			usage ;;
+		*)
+			strategy_opts="$strategy_opts --$2"
+			shift ;;
+		esac
+		do_merge=t
+		;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 7b7d072..f273a37 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -51,7 +51,8 @@ test_expect_success 'reference merge' '
 PRE_REBASE=$(git rev-parse test-rebase)
 test_expect_success rebase '
 	git checkout test-rebase &&
-	GIT_TRACE=1 git rebase --merge master
+	GIT_TRACE=1 git rebase --merge master &&
+	GIT_TRACE=1 git rebase --merge -X theirs master
 '
 
 test_expect_success 'test-rebase@{1} is pre rebase' '
-- 
1.7.0.95.g91ec93
