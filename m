From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: [RFC/PATCH] Additional fast forward strategies.
Date: Mon, 10 Mar 2008 19:04:38 -0800
Message-ID: <402c10cd0803102004x7892f01cledfef6f277fba26a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 04:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYunp-0006oD-Hw
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 04:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbYCKDEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 23:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbYCKDEm
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 23:04:42 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:2095 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbYCKDEl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 23:04:41 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2019441fkz.5
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 20:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=J9kCY+49YcbkLCTWZs1OwUrpM36LKDZCVPIiI5mWhYg=;
        b=YbTOI9ANu3Y50imK7ZaVrMeHMgyfn51aI6geRq7nXKi8AhIimev6O8bW0JOnPgoWPMrYrqdhzoX10B/+3sq+CXr3o1aDV/l6WhkQ0MvJmqa1i2hM5QvXA6mOMpSA3y2Cti9vlpMYL/er+TzGlukVGk/TB5vIbUfixIXQ9Ta/K7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M7bqpmDqp8/l1Tb2XQLfc2ryjVWt1N/xggBvjItsXR8K2LmLJsoVq33EDuIts/NWYq6zpkrmVJIxVpo9Xp7NVtBtx+jBXcTQHwP8juKYCPpj96qImLYEYgNjMCkxkMk4xU5Yvf2jJGO/Yzgy1tXUucD6+ikFK9egIPbovTH8BTs=
Received: by 10.82.115.8 with SMTP id n8mr14935672buc.28.1205204678681;
        Mon, 10 Mar 2008 20:04:38 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Mon, 10 Mar 2008 20:04:38 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76788>

>From 779142c6b22f032c877f550733e1bccc99aca761 Mon Sep 17 00:00:00 2001
From: Sverre Hvammen Johansen <hvammen@gmail.com>
Date: Sun, 9 Mar 2008 21:16:03 -0800
Subject: [PATCH] Additional fast forward strategies.

New fast forward strategies, common, fork, path, and same
is introduced.  These new fast forward strategies allows
additional work flows.

FF strategy "common" does a fast-forward to the common ancestor
of the specified heads.  The merge will fail unless HEAD is the
common ancestor or HEAD can be fast-forwarded to the common ancestor.

FF strategy "fork" does a fast-forward to the common ancestor
of the real heads.  The merge will fail unless HEAD is the
common ancestor of these heads or HEAD can be fast-forwarded
to the common ancestor of the real heads.

FF strategy "path" does a fast-forward to the first possible
branch that no other branches are ahead of.  HEAD will be
fast-forwarded to such a branch if it exist.  If no such branch
exist, HEAD is considered to be up to date.

FF strategy "same" does a fast forward where all branches are
required to point to the same commit.  HEAD will be
fast-forwarded to this branch unless it is up to date.

Signed-off-by: Sverre Hvammen Johansen <sj@black.local>
---
 Documentation/fast-forward-strategies.txt |   25 ++
 git-merge.sh                              |   53 ++++-
 t/t7601-merge-ff-strategies.sh            |  373 +++++++++++++++++++++++++++++
 3 files changed, 446 insertions(+), 5 deletions(-)

diff --git a/Documentation/fast-forward-strategies.txt
b/Documentation/fast-forward-strategies.txt
index 1d6da26..be94cfc 100644
--- a/Documentation/fast-forward-strategies.txt
+++ b/Documentation/fast-forward-strategies.txt
@@ -14,3 +14,28 @@ only::
 	Only allow a fast-forward.  The merge will fail
 	unless HEAD is up to date or the merge resolved as
         a fast-forward.
+
+common::
+	Fast-forward to the common ancestor of the specified
+	branches if possible.  The merge will fail unless
+	HEAD is the common ancestor or HEAD can be
+	fast-forwarded to the common ancestor.
+
+fork::
+	Fast-forward to the earliest fork if possible.
+	The earliest fork is defined as the common ancestor
+	of the real branches.  The merge will fail unless
+	HEAD is the earliest fork or HEAD can be
+	fast-forwarded to the earliest fork.
+
+path::
+	Fast-forward to the first possible branch that
+	no other branches are ahead of.  HEAD will be
+	fast-forwarded to such a branch if it exist.
+	If no such branch exist, HEAD is considered to be
+	up to date.
+
+same::
+	The merge will fail unless HEAD is up to date or
+	the merge resolved as a fast-forward and each
+	branch is pointing to the same commit.
diff --git a/git-merge.sh b/git-merge.sh
index 873e4cb..d474f03 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -164,21 +164,21 @@ parse_config () {
 			no_commit=t ;;
 		--ff)
 			case "$2" in
-			allow|never|only)
+			allow|never|only|common|fork|path|same)
 				fast_forward=$2 squash= no_commit= ; shift ;;
 			-*)
 				fast_forward=allow squash= no_commit= ;;
 			*)
-				die "available fast-forward strategies are: allow, newer, and only" ;;
+				die "available fast-forward strategies are: allow, newer, only,
common, path" ;;
 			esac
 			;;
 		--ff=*)
 			fast_forward=$(echo $1 |cut -d = -f 2) squash= no_commit=
 			case $fast_forward in
-			    allow|never|only)
+			    allow|never|only|common|fork|path|same)
 				;;
 			    *)
-				die "available fast-forward strategies are: allow, newer, and only" ;;
+				die "available fast-forward strategies are: allow, newer, only,
common, path" ;;
 			esac
 			;;
 		--no-ff)
@@ -374,12 +374,22 @@ find_real_parents () {
     done
 }

-if test $fast_forward = never -o
+if test $fast_forward = never -o $fast_forward = common
 then
 	real_parents="$@"
 	ff_head=$head
 else
 	find_real_parents "$@"
+	if test $fast_forward = same
+	then
+		for b in "$@"
+		do
+			if test "$b" != "$1"
+			then
+				die "Fast forward strategy same requires all heads to be the same"
+			fi
+		done
+	fi
 fi

 if test -n "$real_parents"
@@ -387,6 +397,39 @@ then
 	case $fast_forward in
 	only)
 		die "Fast forward strategy only can only handle one real parent" ;;
+	same)
+		die "Fast forward strategy same have unexpected parents" ;;
+	path)
+		echo "Ignoring branches $real_parents"
+		real_parents=
+		;;
+	common|fork)
+		if test $fast_forward = fork
+		then
+			common=$(git show-branch --merge-base $ff_head $real_parents)
+		else
+			common=$(git show-branch --merge-base $real_parents)
+		fi
+		if test -n "$common"
+		then
+			common_h=$(git show-branch --merge-base $common $head)
+			if test "$common_h" = $head
+			then
+				if test $common = $head
+				then
+					echo "Ignoring all branches"
+				else
+					echo "Ignoring all branches except for $common"
+				fi
+				ff_head=$common
+			else
+				die "HEAD is ahead of the common anchestor"
+			fi
+		else
+			die "The specified branches does not have any common anchestor"
+		fi
+		real_parents=
+		;;
 	never|allow)
 		if test $head != $ff_head
 		then
diff --git a/t/t7601-merge-ff-strategies.sh b/t/t7601-merge-ff-strategies.sh
index 6c0a91a..43cbe81 100755
--- a/t/t7601-merge-ff-strategies.sh
+++ b/t/t7601-merge-ff-strategies.sh
@@ -546,4 +546,377 @@ test_expect_success 'merge x0 with y2, c3, and c0' '

 test_debug 'gitk --all'

+test_expect_success 'merge y2 with x0, c3, and c0 (--ff=path)' '
+	git reset --hard y2 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=path x0 c3 c0 &&
+	verify_merge file result.1-5-13 &&
+	verify_head $y2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x0 with y2, c3, and c0 (--ff=path)' '
+	git reset --hard x0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=path y2 c3 c0 &&
+	verify_merge file result.1-5-13 &&
+	verify_head $y2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with x0, c3, and c0 (--ff=path)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=path x0 c3 c0 &&
+	verify_merge file result.1-5 &&
+	verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with y2, c3, and c0 (--ff=path)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=path y2 c3 c0 &&
+	verify_merge file result.1-5-13 &&
+	verify_head $y2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with x0, y3, and c0 (--ff=path)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=path x0 y3 c0 &&
+	verify_merge file result.1-5-13 &&
+	verify_head $y3
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with x0, c3, and y3 (--ff=path)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=path x0 c3 y3 &&
+	verify_merge file result.1-5-13 &&
+	verify_head $y3
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with y1, y2, and y3 (--ff=path)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=path y1 y2 y3 &&
+	verify_merge file result.1-5-13 &&
+	verify_head $y3
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with y1 (--ff=common)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=common y1 &&
+	verify_merge file result.1-5-13 &&
+	verify_head $y1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with y1, y2, and y3 (--ff=common)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=common y1 y2 y3 &&
+	verify_merge file result.1-5 &&
+	verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 and c2 (--ff=common)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=common c1 c2 &&
+	verify_merge file result.0 &&
+	verify_head $c0;
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with y1 and y2 (--ff=common)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=common y1 y2 &&
+	verify_merge file result.1-5 &&
+	verify_head $x0;
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with y1 and y2 (--ff=common)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=common y1 y2 &&
+	verify_merge file result.1-5 &&
+	verify_head $x0;
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with y1 and y2 c0 (--ff=common)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	if git merge --ff=common y1 y2 c0
+	then
+		false
+	else
+		verify_merge file result.1 &&
+		verify_head $c1;
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with x1 and c2 (--ff=common)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	if git merge --ff=common x1 c2
+	then
+		false
+	else
+		verify_merge file result.1 &&
+		verify_head $c1
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with x0 (--ff=fork)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=fork x0 &&
+	verify_merge file result.1-5 &&
+	verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with y1, y2, and y3 (--ff=fork)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=fork y1 y2 y3 &&
+	verify_merge file result.1-5-13 &&
+	verify_head $y3
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 and c2 (--ff=fork)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=fork c1 c2 &&
+	verify_merge file result.0 &&
+	verify_head $c0;
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with y1 and y2 (--ff=fork)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=fork y1 y2 &&
+	verify_merge file result.1-5 &&
+	verify_head $x0;
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with y1 and y2 (--ff=fork)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=fork y1 y2 &&
+	verify_merge file result.1-5 &&
+	verify_head $x0;
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with y1 and y2 c0 (--ff=fork)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=fork y1 y2 c0 &&
+	verify_merge file result.1-5 &&
+	verify_head $x0;
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with x1 and c2 (--ff=fork)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	if git merge --ff=fork x1 c2
+	then
+		false
+	else
+		verify_merge file result.1 &&
+		verify_head $c1
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with x1 (pull --ff=only)' '
+	git reset --hard c1 &&
+	test_tick &&
+	git pull --ff=only clone refs/heads/master &&
+	verify_merge file result.1-13 &&
+	verify_head $x1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x2 with x1 (pull --ff=only)' '
+	git reset --hard x2 &&
+	test_tick &&
+	if git pull --ff=only clone refs/heads/master
+	then
+		false
+	else
+		verify_merge file result.5-13 &&
+		verify_head $x2
+	fi
+'
+
+test_debug 'gitk --all'
+
+
+
+test_expect_success 'merge c1 with new repository (pull --ff=only)' '
+	git reset --hard c1 &&
+	test_tick &&
+	if git pull --ff=only new refs/heads/master
+	then
+		false
+	else
+		verify_merge file result.1 &&
+		verify_head $c1
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with new repository (pull --ff=common)' '
+	git reset --hard c1 &&
+	test_tick &&
+	if git pull --ff=common new refs/heads/master
+	then
+		false
+	else
+		verify_merge file result.1 &&
+		verify_head $c1
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with new repository (pull --ff=fork)' '
+	git reset --hard c1 &&
+	test_tick &&
+	if git pull --ff=fork new refs/heads/master
+	then
+		false
+	else
+		verify_merge file result.1 &&
+		verify_head $c1
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with new repository (pull --ff=path)' '
+	git reset --hard c1 &&
+	test_tick &&
+	git pull --ff=path new refs/heads/master &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with y1 and y1 (--ff=same)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=same y1 y1 &&
+	verify_merge file result.1-5-13 &&
+	verify_head $y1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 and c0 (--ff=same)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge --ff=same c0 c0 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x1 with c2 and c2 (--ff=same)' '
+	git reset --hard x1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	if git merge --ff=same c2 c2
+	then
+		false
+	else
+		verify_merge file result.1-13 &&
+		verify_head $x1
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge y1 with c1 and x1 (--ff=same)' '
+	git reset --hard y1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	if git merge --ff=same c1 x1
+	then
+		false
+	else
+		verify_merge file result.1-5-13 &&
+		verify_head $y1
+	fi
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.5.3.3

-- 
Sverre Hvammen Johansen
