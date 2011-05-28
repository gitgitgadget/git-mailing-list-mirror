From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] rebase: learn --discard subcommand
Date: Fri, 27 May 2011 22:58:15 -0400
Message-ID: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 04:58:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ9js-0007im-IG
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 04:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab1E1C6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 22:58:51 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60519 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab1E1C6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 22:58:50 -0400
Received: by qyg14 with SMTP id 14so1240868qyg.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 19:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=en96cMzwyp8jF9FZkvvXi/BIKWi6MxmPzGuWPFyyQ5E=;
        b=BLO+PHKl4KVq00/Wb7izHcfhdeN3+bsRDStmtVZ4JfURuZCTblkgDktoDmBLYK0jxP
         uTlEPQhoK7p7IfBIAY7aiuLXHEKy8KD5YFR0UZlRqq41YmG8/R0Bn9k6aJhpFJc05FVT
         DLCvr84sx8pDpRlc408Rb3llLwJ2A99Vr+Q4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YE0Zqm6vaBU6Ep12tj0YmCEL9huG39KxOP2P70o9doFAf5/ilNcKdIQDCipdiEfy17
         eZcPuEoXjWSMouFsCK4MQjq1uCrNjJ8ixv6Ropr4e2mXsyDhOmR3h8fv1BO3tHDryhzJ
         HY0nA6hiWobsIFfG4iSu3TyaSDXeusbktTOk0=
Received: by 10.224.188.212 with SMTP id db20mr2111024qab.141.1306551529809;
        Fri, 27 May 2011 19:58:49 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id i34sm1455748qck.31.2011.05.27.19.58.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 May 2011 19:58:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3.640.gd1066
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174655>

Teach git-rebase the --discard subcommand, which is similar to
--abort, but does not move back to the original branch. Suggest this
new subcommand to the user where we currently suggest to delete
$GIT_DIR/rebase-apply (or rebase-merge).

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

A long time ago I said I wished that 'git rebase --abort' would move
back to the where HEAD was when the rebase was initiated, instead of
moving back to the branch that was about to be rebased (which may be
different for "git rebase $upstream $branch"). I think Junio then
hinted that he sometimes wished that he could abort rebase without
moving to anywhere else at all, which is what this patch implements. I
don't feel strongly about this patch, but I would probably also use
this subcommand once in a while. However, maybe the greatest value in
it is that we don't have to tell users to mess with the .git
directory?

I used "rm -r" without -f to match how it is done in --abort, but
maybe -f should be used? That is what we recommend to the end-user to
use today.

A difference from --abort is that --discard does not clear
rerere. Need this be mentioned in the documentation?

I have not been involved in Ramkumar's work on the sequencer to know
if and how this might impact it.


 Documentation/git-rebase.txt |    5 ++++-
 git-rebase.sh                |   17 +++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a075bc..e841c21 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git rebase' [-i | --interactive] [options] --onto <newbase>
 	--root [<branch>]
 
-'git rebase' --continue | --skip | --abort
+'git rebase' --continue | --skip | --abort | --discard
 
 DESCRIPTION
 -----------
@@ -238,6 +238,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 --skip::
 	Restart the rebasing process by skipping the current patch.
 
+--discard::
+	Abort the rebase operation without restoring the original branch.
+
 -m::
 --merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
diff --git a/git-rebase.sh b/git-rebase.sh
index 7a54bfc..befee92 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -32,7 +32,7 @@ OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
 git rebase [-i] [options] --onto <newbase> --root [<branch>]
-git-rebase [-i] --continue | --abort | --skip
+git-rebase [-i] --continue | --abort | --skip | --discard
 --
  Available options are
 v,verbose!         display a diffstat of what changed upstream
@@ -60,6 +60,7 @@ C=!                passed to 'git apply'
 continue!          continue rebasing process
 abort!             abort rebasing process and restore original branch
 skip!              skip current patch and continue rebasing process
+discard!           abort rebasing process, but do not restore original branch
 "
 . git-sh-setup
 set_reflog_action rebase
@@ -93,7 +94,7 @@ in_progress=
 type=
 # One of {"$GIT_DIR"/rebase-apply, "$GIT_DIR"/rebase-merge}
 state_dir=
-# One of {'', continue, skip, abort}, as parsed from command line
+# One of {'', continue, skip, abort, discard}, as parsed from command line
 action=
 preserve_merges=
 autosquash=
@@ -206,7 +207,7 @@ do
 	--verify)
 		ok_to_skip_pre_rebase=
 		;;
-	--continue|--skip|--abort)
+	--continue|--skip|--abort|--discard)
 		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
@@ -340,6 +341,10 @@ abort)
 	rm -r "$state_dir"
 	exit
 	;;
+discard)
+	rm -r "$state_dir"
+	exit
+	;;
 esac
 
 # Make sure no rebase is in progress
@@ -349,9 +354,9 @@ then
 It seems that there is already a '"${state_dir##*/}"' directory, and
 I wonder if you are in the middle of another rebase.  If that is the
 case, please try
-	git rebase (--continue | --abort | --skip)
-If that is not the case, please
-	rm -fr '"$state_dir"'
+	git rebase (--continue | --abort | --skip | --discard)
+If that is not the case, please run
+	git rebase --discard
 and run me again.  I am stopping in case you still have something
 valuable there.'
 fi
-- 
1.7.4.79.gcbe20
