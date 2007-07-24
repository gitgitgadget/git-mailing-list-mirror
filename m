From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [REVISED PATCH] filter-branch: rewrite only unexcluded refs
Date: Tue, 24 Jul 2007 14:42:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241442040.14781@racer.site>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>  
 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241205480.14781@racer.site>
  <46A5E136.D413D3B7@eudaptics.com> <Pine.LNX.4.64.0707241229170.14781@racer.site>
 <46A5FF69.F5D75C9E@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:43:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDKfQ-0000Wk-9V
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbXGXNnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbXGXNnI
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:43:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:53399 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750942AbXGXNnH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 09:43:07 -0400
Received: (qmail invoked by alias); 24 Jul 2007 13:43:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 24 Jul 2007 15:43:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NtwRkUVoNc28PAcx86A6qrAwTgC5KtZf1p3wyKu
	qgZPKUeUaaB8gn
X-X-Sender: gene099@racer.site
In-Reply-To: <46A5FF69.F5D75C9E@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53592>


The rev-list options can exclude some -- or all -- refs:

	git filter-branch <some-filter> master ^master

Without this patch, these refs are assumed to be deleted, or worse, they
are rewritten to some bogus merge bases.

So really exclude excluded refs from being rewritten.  This also allows
you to safely call

	git filter-branch <some-filter> --all <rev-list options>

to rewrite _all_ branches and tags.

Thanks go to Johannes Sixt for help on the implementation and for testing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh     |   16 +++++++++++++++-
 t/t7003-filter-branch.sh |    9 +++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 4fb3abe..3fa2f63 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -181,6 +181,14 @@ export GIT_DIR GIT_WORK_TREE=.
 
 # These refs should be updated if their heads were rewritten
 
+negatives="`git rev-parse "$@" | while read line
+	do
+		case "$line" in
+		$_x40) ;;
+		*) echo "$line";;
+		esac
+	done`"
+
 git rev-parse --revs-only --symbolic "$@" |
 while read ref
 do
@@ -196,7 +204,13 @@ do
 			grep -e "^refs/heads/$ref$" -e "^refs/tags/$ref$")"
 	esac
 
-	git check-ref-format "$ref" && echo "$ref"
+	# make sure we have a valid ref
+	git check-ref-format "$ref" || continue
+
+	# if the ref has been excluded by the other options, skip it
+	test -z "$(git rev-list -1 "$ref" $negatives --topo-order)" && continue
+
+	echo "$ref"
 done > "$tempdir"/heads
 
 test -s "$tempdir"/heads ||
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index c9a820d..667eda7 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -164,4 +164,13 @@ test_expect_success 'only dwim refs/heads/$ref or refs/tags/$ref' '
 	git filter-branch -f master
 '
 
+test_expect_success 'do not update uninteresting refs' '
+	branch=$(git rev-parse branch) &&
+	master=$(git rev-parse master) &&
+	git filter-branch -f --env-filter "GIT_AUTHOR_EMAIL=xy@probl.em" \
+		master ^removed-author branch &&
+	test $branch = $(git rev-parse branch) &&
+	test $master != $(git rev-parse master)
+'
+
 test_done
-- 
1.5.3.rc2.32.g35c5b-dirty
