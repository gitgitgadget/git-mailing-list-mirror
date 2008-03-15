From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rebase [--onto O] A B: omit needless checkout
Date: Sat, 15 Mar 2008 13:42:11 -0700
Message-ID: <7vk5k3n2ho.fsf_-_@gitster.siamese.dyndns.org>
References: <20080312191041.GF3198@ins.uni-bonn.de>
 <47D8D5B8.70809@viscovery.net> <20080315103954.GD14769@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 21:43:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JadDi-00050u-OF
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 21:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbYCOUmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 16:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbYCOUmb
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 16:42:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbYCOUma (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 16:42:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0BABD1599;
	Sat, 15 Mar 2008 16:42:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0DB6F1597; Sat, 15 Mar 2008 16:42:21 -0400 (EDT)
In-Reply-To: <20080315103954.GD14769@ins.uni-bonn.de> (Ralf Wildenhues's
 message of "Sat, 15 Mar 2008 11:39:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77340>

This teaches "git rebase [--onto O] A B" to omit an unnecessary checkout
of branch B before it goes on.

"git-rebase" originally was about rebasing the current branch to somewhere
else, and when the extra parameter to name which branch to rebase was
added, it defined the semantics to the safest but stupid "first switch to
the named branch and then operate exactly the same way as if we were
already on that branch".

But the first thing the real part of "rebase" does is to reset the work
tree and the index to the "onto" commit.  Which means the "rebase that
branch" form switched the work tree to the tip of the branch only to
immediately switch again to another commit.  This was wasteful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Almost untested as I do not use this form very often.  Feedback would
   be good.

 git-rebase.sh |   51 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index ff66af3..9273852 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -309,22 +309,41 @@ then
 	}
 fi
 
-# If the branch to rebase is given, first switch to it.
+# If the branch to rebase is given, that is the branch we will rebase
+# $branch_name -- branch being rebased, or HEAD (already detached)
+# $orig_head -- commit object name of tip of the branch before rebasing
+# $head_name -- refs/heads/<that-branch> or "detached HEAD"
+switch_to=
 case "$#" in
 2)
+	# Is it "rebase other $branchname" or "rebase other $commit"?
 	branch_name="$2"
-	git-checkout "$2" || usage
+	switch_to="$2"
+
+	if branch=$(git rev-parse --verify "refs/heads/$2" 2>/dev/null)
+	then
+		head_name="refs/heads/$2"
+	elif branch=$(git rev-parse --verify "$2" 2>/dev/null)
+	then
+		head_name="detached HEAD"
+	else
+		usage
+	fi
 	;;
 *)
+	# Do not need to switch branches, we are already on it.
 	if branch_name=`git symbolic-ref -q HEAD`
 	then
+		head_name=$branch_name
 		branch_name=`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
 	else
+		head_name="detached HEAD"
 		branch_name=HEAD ;# detached
 	fi
+	branch=$(git rev-parse --verify "${branch_name}^0") || exit
 	;;
 esac
-branch=$(git rev-parse --verify "${branch_name}^0") || exit
+orig_head=$branch
 
 # Now we are rebasing commits $upstream..$branch on top of $onto
 
@@ -335,6 +354,8 @@ if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
 	# linear history?
 	! git rev-list --parents "$onto".."$branch" | grep " .* " > /dev/null
 then
+	# Lazily switch to the target branch if needed...
+	test -z "$switch_to" || git checkout "$switch_to"
 	echo >&2 "Current branch $branch_name is up to date."
 	exit 0
 fi
@@ -346,22 +367,11 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
-# move to a detached HEAD
-orig_head=$(git rev-parse HEAD^0)
-head_name=$(git symbolic-ref HEAD 2> /dev/null)
-case "$head_name" in
-'')
-	head_name="detached HEAD"
-	;;
-*)
-	git checkout "$orig_head" > /dev/null 2>&1 ||
-		die "could not detach HEAD"
-	;;
-esac
-
-# Rewind the head to "$onto"; this saves our current head in ORIG_HEAD.
+# Detach HEAD and reset the tree
 echo "First, rewinding head to replay your work on top of it..."
-git-reset --hard "$onto"
+git checkout "$onto^0" >/dev/null 2>&1 ||
+	die "could not detach HEAD"
+# git reset --hard "$onto^0"
 
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast forwarded.
@@ -374,7 +384,8 @@ fi
 
 if test -z "$do_merge"
 then
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream "$upstream"..ORIG_HEAD |
+	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+		"$upstream..$orig_head" |
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
@@ -397,7 +408,7 @@ echo "$orig_head" > "$dotest/orig-head"
 echo "$head_name" > "$dotest/head-name"
 
 msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$upstream"..ORIG_HEAD`
+for cmt in `git rev-list --reverse --no-merges "$upstream..$orig_head"`
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"
-- 
1.5.4.4.718.ga6ccf
