From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 1/2] rebase -i: support --root without --onto
Date: Tue, 26 Jun 2012 14:36:32 +0100
Message-ID: <bdb45972685db8899a46ebc62213e56c9a3d0c94.1340717793.git.chris@arachsys.com>
References: <20120626133339.GT9682@arachsys.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 15:36:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjVwm-0001gA-Ur
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 15:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756898Ab2FZNgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 09:36:45 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:41704 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718Ab2FZNgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 09:36:44 -0400
Received: from [81.2.114.212] (helo=miranda.home.)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjVwh-0004JU-8Y; Tue, 26 Jun 2012 14:36:44 +0100
X-Mailer: git-send-email 1.7.10
In-Reply-To: <20120626133339.GT9682@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200643>

Allow --root to be specified to rebase -i without --onto, making it
possible to edit and re-order all commits right back to the root(s).

If there is a conflict to be resolved when applying the first change,
the user will expect a sane index and working tree to get sensible
behaviour from git-diff and friends, so create a sentinel commit with an
empty tree to rebase onto. Automatically squash the sentinel with any
commits rebased directly onto it, so they end up as root commits in
their own right and retain their authorship and commit message.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 Documentation/git-rebase.txt |    9 +++++----
 git-rebase--interactive.sh   |   24 ++++++++++++++++++------
 git-rebase.sh                |   14 ++++++++++++--
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 147fa1a..85b5e44 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git rebase' [-i | --interactive] [options] [--onto <newbase>]
 	[<upstream>] [<branch>]
-'git rebase' [-i | --interactive] [options] --onto <newbase>
+'git rebase' [-i | --interactive] [options] [--onto <newbase>]
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort
 
@@ -348,10 +348,11 @@ idea unless you know what you are doing (see BUGS below).
 --root::
 	Rebase all commits reachable from <branch>, instead of
 	limiting them with an <upstream>.  This allows you to rebase
-	the root commit(s) on a branch.  Must be used with --onto, and
+	the root commit(s) on a branch.  When used with --onto, it
 	will skip changes already contained in <newbase> (instead of
-	<upstream>).  When used together with --preserve-merges, 'all'
-	root commits will be rewritten to have <newbase> as parent
+	<upstream>) whereas without --onto it will operate on every change.
+	When used together with both --onto and --preserve-merges,
+	'all' root commits will be rewritten to have <newbase> as parent
 	instead.
 
 --autosquash::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..ed5a6ba 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -417,6 +417,21 @@ record_in_rewritten() {
 	esac
 }
 
+do_pick () {
+	if test "$(git rev-parse HEAD)" = "$squash_onto"
+	then
+		git commit --allow-empty --allow-empty-message --amend \
+			   --no-post-rewrite -n -q -C $1 &&
+			pick_one -n $1 &&
+			git commit --allow-empty --allow-empty-message \
+				   --amend --no-post-rewrite -n -q -C $1 ||
+			die_with_patch $1 "Could not apply $1... $2"
+	else
+		pick_one $1 ||
+			die_with_patch $1 "Could not apply $1... $2"
+	fi
+}
+
 do_next () {
 	rm -f "$msg" "$author_script" "$amend" || exit
 	read -r command sha1 rest < "$todo"
@@ -428,16 +443,14 @@ do_next () {
 		comment_for_reflog pick
 
 		mark_action_done
-		pick_one $sha1 ||
-			die_with_patch $sha1 "Could not apply $sha1... $rest"
+		do_pick $sha1 "$rest"
 		record_in_rewritten $sha1
 		;;
 	reword|r)
 		comment_for_reflog reword
 
 		mark_action_done
-		pick_one $sha1 ||
-			die_with_patch $sha1 "Could not apply $sha1... $rest"
+		do_pick $sha1 "$rest"
 		git commit --amend --no-post-rewrite || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
 			warn "This is most likely due to an empty commit message, or the pre-commit hook"
@@ -451,8 +464,7 @@ do_next () {
 		comment_for_reflog edit
 
 		mark_action_done
-		pick_one $sha1 ||
-			die_with_patch $sha1 "Could not apply $sha1... $rest"
+		do_pick $sha1 "$rest"
 		warn "Stopped at $sha1... $rest"
 		exit_with_patch $sha1 0
 		;;
diff --git a/git-rebase.sh b/git-rebase.sh
index e616737..bde2be8 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -31,7 +31,7 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
-git rebase [-i] [options] --onto <newbase> --root [<branch>]
+git rebase [-i] [options] [--onto <newbase>] --root [<branch>]
 git-rebase [-i] --continue | --abort | --skip
 --
  Available options are
@@ -364,6 +364,11 @@ and run me again.  I am stopping in case you still have something
 valuable there.'
 fi
 
+if test -n "$rebase_root" && test -z "$onto"
+then
+	test -z "$interactive_rebase" && interactive_rebase=implied
+fi
+
 if test -n "$interactive_rebase"
 then
 	type=interactive
@@ -397,7 +402,12 @@ then
 	die "invalid upstream $upstream_name"
 	upstream_arg="$upstream_name"
 else
-	test -z "$onto" && die "You must specify --onto when using --root"
+	if test -z "$onto"
+	then
+		empty_tree=`git hash-object -t tree /dev/null`
+		onto=`git commit-tree $empty_tree </dev/null`
+		squash_onto="$onto"
+	fi
 	unset upstream_name
 	unset upstream
 	upstream_arg=--root
-- 
1.7.10
