From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Avoid invoking diff drivers during git-stash
Date: Thu, 18 Oct 2007 21:33:50 -0400
Message-ID: <20071019013350.GA14020@spearce.org>
References: <47171A21.9030003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 03:34:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IigkX-0001PW-LI
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 03:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759767AbXJSBdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 21:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759674AbXJSBdy
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 21:33:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41670 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759470AbXJSBdy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 21:33:54 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iigk5-0004zK-LH; Thu, 18 Oct 2007 21:33:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EB0C420FBAE; Thu, 18 Oct 2007 21:33:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47171A21.9030003@viscovery.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61594>

git-stash needs to restrict itself to plumbing when running automated
diffs as part of its operation as the user may have configured a
custom diff driver that opens an interactive UI for certain/all
files.  Doing that during scripted actions is very unfriendly to
the end-user and may cause git-stash to fail to work.

Reported by Johannes Sixt

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Johannes Sixt <j.sixt@viscovery.net> wrote:
 > (1) Looking at git-stash.sh I see a few uses of 'git diff' in
 > apply_stash(). Shouldn't these use one of git-diff-{tree,index,files)? The
 > reason is that porcelain 'git diff' invokes custom diff drivers (that in my   
 > case run a UI program), whereas the plumbing does not.
 >
 > Is there a particular reason to use porcelain 'git diff'?

 Does this fix the problem?

 git-stash.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 7ba6162..def3163 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -110,7 +110,7 @@ show_stash () {
 
 	w_commit=$(git rev-parse --verify "$s") &&
 	b_commit=$(git rev-parse --verify "$s^") &&
-	git diff $flags $b_commit $w_commit
+	git diff-tree $flags $b_commit $w_commit
 }
 
 apply_stash () {
@@ -139,7 +139,7 @@ apply_stash () {
 	unstashed_index_tree=
 	if test -n "$unstash_index" && test "$b_tree" != "$i_tree"
 	then
-		git diff --binary $s^2^..$s^2 | git apply --cached
+		git diff-tree --binary $s^2^..$s^2 | git apply --cached
 		test $? -ne 0 &&
 			die 'Conflicts in index. Try without --index.'
 		unstashed_index_tree=$(git-write-tree) ||
@@ -162,7 +162,7 @@ apply_stash () {
 			git read-tree "$unstashed_index_tree"
 		else
 			a="$TMP-added" &&
-			git diff --cached --name-only --diff-filter=A $c_tree >"$a" &&
+			git diff-index --cached --name-only --diff-filter=A $c_tree >"$a" &&
 			git read-tree --reset $c_tree &&
 			git update-index --add --stdin <"$a" ||
 				die "Cannot unstage modified files"
-- 
1.5.3.4.1249.g895be
