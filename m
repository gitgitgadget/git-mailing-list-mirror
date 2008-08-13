From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 1/2] rebase -i -p: handle index and workdir correctly
Date: Wed, 13 Aug 2008 23:41:23 +0200
Message-ID: <f3d190b3dde04470c0f431d93cf6be6e3990c510.1218663527.git.trast@student.ethz.ch>
References: <20080813205806.GC10758@leksak.fem-net>
Cc: gitster@pobox.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 23:42:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTO6p-00023r-Jo
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 23:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYHMVlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 17:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbYHMVlU
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 17:41:20 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:27266 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242AbYHMVlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 17:41:19 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 23:41:18 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 23:41:17 +0200
X-Mailer: git-send-email 1.6.0.rc2.69.g29dd9
In-Reply-To: <20080813205806.GC10758@leksak.fem-net>
X-OriginalArrivalTime: 13 Aug 2008 21:41:17.0938 (UTC) FILETIME=[517C5D20:01C8FD8D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92278>

'git rebase -i -p' forgot to update the index and working directory
during fast forwards.  Fix this.  Makes 'GIT_EDITOR=true rebase -i -p
<ancestor>' a no-op again.

Also, it attempted to do a fast forward even if it was instructed not
to commit (via -n).  Fall back to the cherry-pick code path and let
that handle the issue for us.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Stephan Beyer <s-beyer@gmx.net> wrote:
>
> The intention of setting fast_forward=f is clear, but it is overwritten
> later on line 169 that is not shown in this patch:
[...]
> Clearly, this is due to your patch split, because after the second
> patch, this is fixed.

Indeed, thanks for catching this.

 git-rebase--interactive.sh    |   14 ++++++++++++--
 t/t3404-rebase-interactive.sh |    6 ++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4e334ba..58126bd 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -145,7 +145,16 @@ pick_one () {
 }
 
 pick_one_preserving_merges () {
-	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
+	fast_forward=t
+	case "$1" in
+	-n)
+		fast_forward=f
+		sha1=$2
+		;;
+	*)
+		sha1=$1
+		;;
+	esac
 	sha1=$(git rev-parse $sha1)
 
 	if test -f "$DOTEST"/current-commit
@@ -157,7 +166,6 @@ pick_one_preserving_merges () {
 	fi
 
 	# rewrite parents; if none were rewritten, we can fast-forward.
-	fast_forward=t
 	preserve=t
 	new_parents=
 	for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
@@ -182,6 +190,8 @@ pick_one_preserving_merges () {
 	t)
 		output warn "Fast forward to $sha1"
 		test $preserve = f || echo $sha1 > "$REWRITTEN"/$sha1
+		output git reset --hard $sha1 ||
+			die "Cannot fast forward to $sha1"
 		;;
 	f)
 		test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ffe3dd9..4d62b9a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -202,6 +202,9 @@ test_expect_success 'retain authorship when squashing' '
 test_expect_success '-p handles "no changes" gracefully' '
 	HEAD=$(git rev-parse HEAD) &&
 	git rebase -i -p HEAD^ &&
+	git update-index --refresh &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD -- &&
 	test $HEAD = $(git rev-parse HEAD)
 '
 
@@ -235,6 +238,9 @@ test_expect_success 'preserve merges with -p' '
 	git checkout -b to-be-rebased &&
 	test_tick &&
 	git rebase -i -p --onto branch1 master &&
+	git update-index --refresh &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD -- &&
 	test $(git rev-parse HEAD~6) = $(git rev-parse branch1) &&
 	test $(git rev-parse HEAD~4^2) = $(git rev-parse to-be-preserved) &&
 	test $(git rev-parse HEAD^^2^) = $(git rev-parse HEAD^^^) &&
-- 
1.6.0.rc2.69.g29dd9
