From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] Implement "git stash branch <newbranch> <stash>"
Date: Thu, 3 Jul 2008 07:53:16 +0530
Message-ID: <20080703022316.GA25433@toroid.org>
References: <20080702195947.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0807021447200.9925@racer> <7vvdzo9kkw.fsf@gitster.siamese.dyndns.org> <20080702195401.GA17214@toroid.org> <7vprpw80bw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:00:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIno-0002Wt-Qe
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbYGCG7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753883AbYGCG5e
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:34 -0400
Received: from fugue.toroid.org ([85.10.196.113]:49122 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbYGCCXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 22:23:20 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 7FAC255831A;
	Thu,  3 Jul 2008 04:23:16 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 1F4ECADC305; Thu,  3 Jul 2008 07:53:16 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vprpw80bw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87224>

Restores the stashed state on a new branch rooted at the commit on which
the stash was originally created, so that conflicts caused by subsequent
changes on the original branch can be dealt with.

(Thanks to Junio for this nice idea.)
---
 Documentation/git-stash.txt |   19 ++++++++++++++++++-
 git-stash.sh                |   21 +++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 23ac331..cfc1c28 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -8,8 +8,11 @@ git-stash - Stash the changes in a dirty working directory away
 SYNOPSIS
 --------
 [verse]
-'git stash' (list | show [<stash>] | apply [<stash>] | clear | drop [<stash>] | pop [<stash>])
+'git stash' list
+'git stash' (show | apply | drop | pop ) [<stash>]
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
+	changes recorded in `<stash>` to the new working tree, and drops the
+	`<stash>` if that completes successfully. When no `<stash>` is given,
+	applies the latest one.
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
index 4938ade..8e50b03 100755
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
+	apply_stash $stash &&
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
-- 
1.5.6
