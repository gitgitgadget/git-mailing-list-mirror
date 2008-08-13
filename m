From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] rebase -i -p: handle index and workdir correctly
Date: Wed, 13 Aug 2008 12:04:16 +0200
Message-ID: <8bbecf58e7fba14497720afe5cdaf52fec6bcb40.1218621695.git.trast@student.ethz.ch>
References: <200808121116.41535.trast@student.ethz.ch>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 12:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTDED-00035o-6S
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 12:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbYHMKEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 06:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYHMKEN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 06:04:13 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:27550 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbYHMKEN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 06:04:13 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 12:04:11 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 12:04:10 +0200
X-Mailer: git-send-email 1.6.0.rc2.37.g65932
In-Reply-To: <200808121116.41535.trast@student.ethz.ch>
X-OriginalArrivalTime: 13 Aug 2008 10:04:10.0919 (UTC) FILETIME=[EEA3C370:01C8FD2B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92202>

'git rebase -i -p' forgot to update the index and working directory
during fast forwards.  Fix this.  Restores plain 'git rebase -i -p' to
be a no-op.

Also, it attempted to do a fast forward even if it was instructed not
to commit (via -n).  Fall back to the cherry-pick code path and let
that handle the issue for us.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-rebase--interactive.sh    |   14 ++++++++++++--
 t/t3404-rebase-interactive.sh |    6 ++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4e334ba..51a6147 100755
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
@@ -181,7 +190,8 @@ pick_one_preserving_merges () {
 	case $fast_forward in
 	t)
 		output warn "Fast forward to $sha1"
-		test $preserve = f || echo $sha1 > "$REWRITTEN"/$sha1
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
1.6.0.rc2.38.g33ece.dirty
