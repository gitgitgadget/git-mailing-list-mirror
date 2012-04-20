From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] rebase -i: avoid checking out $branch when possible
Date: Fri, 20 Apr 2012 17:05:10 +0200
Message-ID: <fee3225e29915e1b61e29a5d2fe37db20fa4b596.1334933837.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Shezan Baig <shezbaig.wk@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 20 17:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLFOk-0001x7-9l
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 17:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756992Ab2DTPFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 11:05:16 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:38014 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754265Ab2DTPFP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 11:05:15 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Fri, 20 Apr
 2012 17:05:12 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 20 Apr
 2012 17:05:12 +0200
X-Mailer: git-send-email 1.7.10.323.g7b65b
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196002>

The command

  git rebase [-i] [--onto $onto] $base $branch

is defined to be equivalent to

  git checkout $branch && git rebase [-i] [--onto $onto] $base

However, we do not have to actually perform the checkout.  The rebase
starts building on top of $base (or $onto, if given).  The tree
_state_ (not diff) of $branch is irrelevant.  Actually performing the
checkout has some downsides: $branch may potentially be way out of
touch with HEAD, and thus e.g. trigger a full rebuild in a timestamp-
based build system, even if $base..$branch only edits the README.

In the event that $branch is already up-to-date w.r.t. $base, we still
have to check out, however.  git-rebase.sh has had the corresponding
lazy-checkout logic since approximately forever (0cb0664, rebase
[--onto O] A B: omit needless checkout, 2008-03-15).

This logic has also been used for interactive since Martin's
refactoring around cc1453e (rebase: factor out call to pre-rebase
hook, 2011-02-06).  However, an unconditional checkout was carried
over into the new interactive rebase code.  Remove it.  HEAD is only
used in the rev-parse invocation immediately after, which is easy
enough to fix.

Note that this does change the state of the repository if something
bad happens and we 'die'.  Noninteractive rebase already behaves the
same way.  The catch here is that "there is nothing to rebase", as
well as "the user cleared the TODO file", both go through an error
path.  We need to ensure that a checkout happens in these cases, to
keep it equivalent to checkout&&rebase.

Noticed-by: Shezan Baig <shezbaig.wk@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I was a bit torn on whether I should abort with checkout, or without
it.  The manual clearly states that rebase "will perform an automatic
git checkout <branch> before doing anything else", which mandates at
least *trying* the checkout in the error path, hence this version.

However, in contrived cases this can lead to strange behavior.  For
example, a checkout conflict with a file in the worktree may prevent
the abort path from working correctly, even though going through with
the rebase itself may succeed.

 git-rebase--interactive.sh |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2e13258..3b40c2a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -163,6 +163,15 @@ die_abort () {
 	die "$1"
 }
 
+die_abort_with_checkout () {
+	if test -n "$switch_to"
+	then
+		git checkout "$switch_to" -- ||
+			die_abort "$1, and failed to check out $switch_to"
+	fi
+	die_abort "$1"
+}
+
 has_action () {
 	sane_grep '^[^#]' "$1" >/dev/null
 }
@@ -728,13 +737,7 @@ git var GIT_COMMITTER_IDENT >/dev/null ||
 
 comment_for_reflog start
 
-if test ! -z "$switch_to"
-then
-	output git checkout "$switch_to" -- ||
-		die "Could not checkout $switch_to"
-fi
-
-orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
+orig_head=$(git rev-parse --verify "${switch_to:-HEAD}") || die "No HEAD?"
 mkdir "$state_dir" || die "Could not create temporary $state_dir"
 
 : > "$state_dir"/interactive || die "Could not mark as interactive"
@@ -854,14 +857,14 @@ cat >> "$todo" << EOF
 EOF
 
 has_action "$todo" ||
-	die_abort "Nothing to do"
+	die_abort_with_checkout "Nothing to do"
 
 cp "$todo" "$todo".backup
 git_sequence_editor "$todo" ||
-	die_abort "Could not execute editor"
+	die_abort_with_checkout "Could not execute editor"
 
 has_action "$todo" ||
-	die_abort "Nothing to do"
+	die_abort_with_checkout "Nothing to do"
 
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
-- 
1.7.10.323.g7b65b
