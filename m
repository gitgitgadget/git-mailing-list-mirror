From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: fix squashing corner case
Date: Thu, 23 Aug 2007 09:55:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708222334510.20400@racer.site>
References: <46CB004C.AC39D562@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:56:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO8UD-0002w1-1G
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 10:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756737AbXHWI4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 04:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757793AbXHWI4J
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 04:56:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:52230 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757772AbXHWI4H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 04:56:07 -0400
Received: (qmail invoked by alias); 23 Aug 2007 08:56:04 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp030) with SMTP; 23 Aug 2007 10:56:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LYN100xLLaAMhQ/Z90qRHaXCsHdWkb3SkxTujID
	9EfymG9aKxPOY3
X-X-Sender: gene099@racer.site
In-Reply-To: <46CB004C.AC39D562@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56476>


When squashing, rebase -i did not prevent fast forwards.  This could
happen when picking some other commit than the first one, and then
squashing the first commit.  So do not allow fast forwards when
squashing.

Noticed by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 21 Aug 2007, Johannes Sixt wrote:

	> There's a problem with rebase--interactive where I want to 
	> squash two commits and the one to squash is the first in the 
	> original series.

	Thanks.

 git-rebase--interactive.sh    |    5 +++--
 t/t3404-rebase-interactive.sh |   21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index bdec462..ec798a1 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -96,13 +96,14 @@ die_abort () {
 }
 
 pick_one () {
-	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
+	no_ff=
+	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
 		pick_one_preserving_merges "$@" && return
 	parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
 	current_sha1=$(git rev-parse --verify HEAD)
-	if test $current_sha1 = $parent_sha1; then
+	if test $no_ff$current_sha1 = $parent_sha1; then
 		output git reset --hard $sha1
 		test "a$1" = a-n && output git reset --soft $current_sha1
 		sha1=$(git rev-parse --short $sha1)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 40d6799..718c9c1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -264,6 +264,27 @@ test_expect_success 'interrupted squash works as expected' '
 	test $one = $(git rev-parse HEAD~2)
 '
 
+test_expect_success 'interrupted squash works as expected (case 2)' '
+	for n in one two three four
+	do
+		echo $n >> conflict &&
+		git add conflict &&
+		git commit -m $n
+	done &&
+	one=$(git rev-parse HEAD~3) &&
+	! FAKE_LINES="3 squash 1 2" git rebase -i HEAD~3 &&
+	(echo one; echo four) > conflict &&
+	git add conflict &&
+	! git rebase --continue &&
+	(echo one; echo two; echo four) > conflict &&
+	git add conflict &&
+	! git rebase --continue &&
+	echo resolved > conflict &&
+	git add conflict &&
+	git rebase --continue &&
+	test $one = $(git rev-parse HEAD~2)
+'
+
 test_expect_success 'ignore patch if in upstream' '
 	HEAD=$(git rev-parse HEAD) &&
 	git checkout -b has-cherry-picked HEAD^ &&
-- 
1.5.3.rc6.3.gaf460
