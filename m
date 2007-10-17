From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] filter-branch: update current branch when rewritten
Date: Wed, 17 Oct 2007 03:23:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710170322400.25221@racer.site>
References: <18197.24051.863751.436705@lisa.zopyra.com>
 <Pine.LNX.4.64.0710170322000.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 04:23:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhyZe-00082y-7r
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 04:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934358AbXJQCXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 22:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbXJQCXV
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 22:23:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:34186 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965742AbXJQCXT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 22:23:19 -0400
Received: (qmail invoked by alias); 17 Oct 2007 02:23:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 17 Oct 2007 04:23:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182SSZiuDw23YQmiNhDg/nyJyvJrshh7yMwJnMfXL
	LLXNA9pPS3QJDu
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0710170322000.25221@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61316>


Earlier, "git filter-branch --<options> HEAD" would not update the
working tree after rewriting the branch.  This commit fixes it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Bill, I hope this clarifies some things for you, too...

 git-filter-branch.sh     |   15 +++++++++++++++
 t/t7003-filter-branch.sh |    4 +++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a12f6c2..ffcc408 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -94,6 +94,10 @@ USAGE="[--env-filter <command>] [--tree-filter <command>] \
 
 . git-sh-setup
 
+git diff-files --quiet &&
+	git diff-index --cached --quiet HEAD ||
+	die "Cannot rewrite branch(es) with a dirty working directory."
+
 tempdir=.git-rewrite
 filter_env=
 filter_tree=
@@ -196,6 +200,9 @@ do
 	esac
 done < "$tempdir"/backup-refs
 
+ORIG_GIT_DIR="$GIT_DIR"
+ORIG_GIT_WORK_TREE="$GIT_WORK_TREE"
+ORIG_GIT_INDEX_FILE="$GIT_INDEX_FILE"
 export GIT_DIR GIT_WORK_TREE=.
 
 # These refs should be updated if their heads were rewritten
@@ -413,4 +420,12 @@ echo
 test $count -gt 0 && echo "These refs were rewritten:"
 git show-ref | grep ^"$orig_namespace"
 
+unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
+test -z "$ORIG_GIT_DIR" || GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
+test -z "$ORIG_GIT_WORK_TREE" || GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
+	export GIT_WORK_TREE
+test -z "$ORIG_GIT_INDEX_FILE" || GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
+	export GIT_INDEX_FILE
+git read-tree -u -m HEAD
+
 exit $ret
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e935b20..2089351 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -41,7 +41,9 @@ test_expect_success 'rewrite, renaming a specific file' '
 '
 
 test_expect_success 'test that the file was renamed' '
-	test d = $(git show HEAD:doh)
+	test d = $(git show HEAD:doh) &&
+	test -f doh &&
+	test d = $(cat doh)
 '
 
 git tag oldD HEAD~4
-- 
1.5.3.4.1223.ga973c
