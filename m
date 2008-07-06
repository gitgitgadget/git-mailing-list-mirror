From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH v3] Implement "git stash branch <newbranch> <stash>"
Date: Sun, 6 Jul 2008 16:53:33 +0530
Message-ID: <20080706112333.GA6477@toroid.org>
References: <20080702195947.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0807021447200.9925@racer> <7vvdzo9kkw.fsf@gitster.siamese.dyndns.org> <20080702195401.GA17214@toroid.org> <7vprpw80bw.fsf@gitster.siamese.dyndns.org> <20080703022316.GA25433@toroid.org> <7v63rn61yj.fsf@gitster.siamese.dyndns.org> <20080703061605.GB3815@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 13:24:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFSM3-0000kb-RO
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 13:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbYGFLXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 07:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbYGFLXe
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 07:23:34 -0400
Received: from fugue.toroid.org ([85.10.196.113]:39075 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbYGFLXd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 07:23:33 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id C6BE5558314;
	Sun,  6 Jul 2008 13:23:31 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 72F95840001; Sun,  6 Jul 2008 16:53:33 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20080703061605.GB3815@toroid.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87517>

Restores the stashed state on a new branch rooted at the commit on which
the stash was originally created, so that conflicts caused by subsequent
changes on the original branch can be dealt with.

(Thanks to Junio for this nice idea.)

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---
Reposting as requested with a new test included.

 Documentation/git-stash.txt |   19 ++++++++++++++++++-
 git-stash.sh                |   21 +++++++++++++++++++++
 t/t3903-stash.sh            |   24 ++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 23ac331..a4cbd0c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -8,8 +8,11 @@ git-stash - Stash the changes in a dirty working directory away
 SYNOPSIS
 --------
 [verse]
-'git stash' (list | show [<stash>] | apply [<stash>] | clear | drop [<stash>] | pop [<stash>])
+'git stash' list
+'git stash' (show | apply | drop | pop) [<stash>]
+'git stash' branch <branchname> [<stash>]
 'git stash' [save [<message>]]
+'git stash' clear
 
 DESCRIPTION
 -----------
@@ -81,6 +84,20 @@ tree's changes, but also the index's ones. However, this can fail, when you
 have conflicts (which are stored in the index, where you therefore can no
 longer apply the changes as they were originally).
 
+branch <branchname> [<stash>]::
+
+	Creates and checks out a new branch named `<branchname>` starting from
+	the commit at which the `<stash>` was originally created, applies the
+	changes recorded in `<stash>` to the new working tree and index, then
+	drops the `<stash>` if that completes successfully. When no `<stash>`
+	is given, applies the latest one.
++
+This is useful if the branch on which you ran `git stash save` has
+changed enough that `git stash apply` fails due to conflicts. Since
+the stash is applied on top of the commit that was HEAD at the time
+`git stash` was run, it restores the originally stashed state with
+no conflicts.
+
 clear::
 	Remove all the stashed states. Note that those states will then
 	be subject to pruning, and may be difficult or impossible to recover.
diff --git a/git-stash.sh b/git-stash.sh
index 4938ade..889445c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -218,6 +218,23 @@ drop_stash () {
 	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_stash
 }
 
+apply_to_branch () {
+	have_stash || die 'Nothing to apply'
+
+	test -n "$1" || die 'No branch name specified'
+	branch=$1
+
+	if test -z "$2"
+	then
+		set x "$ref_stash@{0}"
+	fi
+	stash=$2
+
+	git-checkout -b $branch $stash^ &&
+	apply_stash --index $stash &&
+	drop_stash $stash
+}
+
 # Main command set
 case "$1" in
 list)
@@ -264,6 +281,10 @@ pop)
 		drop_stash "$@"
 	fi
 	;;
+branch)
+	shift
+	apply_to_branch "$@"
+	;;
 *)
 	if test $# -eq 0
 	then
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 54d99ed..6d89218 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -117,4 +117,28 @@ test_expect_success 'stash pop' '
 	test 0 = $(git stash list | wc -l)
 '
 
+cat > expect << EOF
+diff --git a/file b/file
+index 7601807..5716ca5 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-baz
++bar
+EOF
+
+test_expect_success 'stash apply' '
+	echo foo > file &&
+	git commit file -m first
+	echo bar > file &&
+	git stash &&
+	echo baz > file &&
+	git commit file -m second &&
+	git stash branch stashbranch &&
+	git commit file -m alternate\ second &&
+	git diff master..stashbranch > output &&
+	test_cmp output expect &&
+	test 0 = $(git stash list | wc -l)
+'
+
 test_done
-- 
1.5.6
