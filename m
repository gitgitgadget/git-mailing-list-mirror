From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCHv3] filter-branch: Add tests for submodules
Date: Thu, 28 Jan 2010 00:55:47 +0100
Message-ID: <1264636547-24496-1-git-send-email-sojkam1@fel.cvut.cz>
References: <201001280041.23182.sojkam1@fel.cvut.cz>
Cc: j.sixt@viscovery.net, Johannes.Schindelin@gmx.de,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 00:56:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaHk9-0000Jn-CK
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 00:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab0A0X4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 18:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754432Ab0A0X4K
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 18:56:10 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:57596 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753902Ab0A0X4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 18:56:10 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 974B219F33B0;
	Thu, 28 Jan 2010 00:56:06 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id qlC7RZC-Vn9p; Thu, 28 Jan 2010 00:56:06 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 7660619F3399;
	Thu, 28 Jan 2010 00:56:06 +0100 (CET)
Received: from localhost.localdomain (unknown [213.29.198.144])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 3443415C052;
	Thu, 28 Jan 2010 00:56:06 +0100 (CET)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <201001280041.23182.sojkam1@fel.cvut.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138209>

There are three important tests:
1) 'rewrite submodule with another content' passes only with the
   previous patch applied.

2) 'checkout submodule during rewrite' demonstrates that it is not
   possible to replace a submodule revision in tree-filter by checking
   the submodule out and reseting the submodule's HEAD. Fails both
   with and without the previous patch. This is because filter-branch
   sets GIT_WORKING_TREE to "." which causes clone (called from
   git-submodule) to fail.

3) 'replace submodule revision' shows that replacing submodule
   revision is possible by direct index manipulation. Succeeds both
   with and without the previous patch.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 t/t7003-filter-branch.sh |   47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 9503875..fabe038 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -306,4 +306,51 @@ test_expect_success '--remap-to-ancestor with filename filters' '
 	test $orig_invariant = $(git rev-parse invariant)
 '
 
+test_expect_success 'setup submodule' '
+	rm -rf * .*
+	git init &&
+	test_commit file &&
+	mkdir submod &&
+	submodurl="$PWD/submod"
+	( cd submod &&
+	  git init &&
+	  test_commit file-in-submod ) &&
+	git submodule add "$submodurl"
+	git commit -m "added submodule" &&
+	test_commit add-file &&
+	( cd submod && test_commit add-in-submodule ) &&
+	git add submod &&
+	git commit -m "changed submodule" &&
+	git branch original HEAD
+'
+
+orig_head=`git show-ref --hash --head HEAD`
+
+test_expect_success 'rewrite submodule with another content' '
+	git filter-branch --tree-filter "test -d submod && {
+					 rm -rf submod &&
+					 git rm -rf --quiet submod &&
+					 mkdir submod &&
+					 : > submod/file
+					 } || :" HEAD &&
+	test $orig_head != `git show-ref --hash --head HEAD`
+'
+
+test_expect_failure 'checkout submodule during rewrite' '
+	git reset --hard original &&
+	git filter-branch -f --tree-filter \
+	    "git submodule update --init &&
+	     ( test -d submod && cd submod &&
+	       git reset --hard origin/master )" HEAD
+'
+
+test_expect_success 'replace submodule revision' '
+	git reset --hard original &&
+	git filter-branch -f --tree-filter \
+	    "if git ls-files --error-unmatch -- submod > /dev/null 2>&1
+	     then git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 submod
+	     fi" HEAD &&
+	test $orig_head != `git show-ref --hash --head HEAD`
+'
+
 test_done
-- 
1.6.6
