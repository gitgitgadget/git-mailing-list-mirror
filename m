From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCHv5 2/2] filter-branch: Add tests for submodules in tree-filter
Date: Fri, 29 Jan 2010 16:27:05 +0100
Message-ID: <1264778825-26401-2-git-send-email-sojkam1@fel.cvut.cz>
References: <201001291620.35269.sojkam1@fel.cvut.cz>
Cc: j.sixt@viscovery.net, Johannes.Schindelin@gmx.de,
	gitster@pobox.com, Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 16:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naskp-0002T9-VJ
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 16:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985Ab0A2P1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 10:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453Ab0A2P1V
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 10:27:21 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:54429 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754302Ab0A2P1V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 10:27:21 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 0C67819F33E1;
	Fri, 29 Jan 2010 16:27:20 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id hYL2ITxdkbml; Fri, 29 Jan 2010 16:27:19 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id D6B6719F334F;
	Fri, 29 Jan 2010 16:27:19 +0100 (CET)
Received: from localhost.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id BFBA8FA004;
	Fri, 29 Jan 2010 16:27:19 +0100 (CET)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <201001291620.35269.sojkam1@fel.cvut.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138326>

Add tests to make sure:
1) a submodule can be removed and its content replaced with regular
   files ('rewrite submodule with another content'). This test passes
   only with the previous patch applied.

2) it is possible to replace submodule revision by direct index
   manipulation ('replace submodule revision'). Although it would be
   better to run such a filter in --index-filter, this test shows that
   this functionality is not broken by the previous patch. This
   succeeds both with and without the previous patch.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 t/t7003-filter-branch.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 9503875..a7f0791 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -306,4 +306,49 @@ test_expect_success '--remap-to-ancestor with filename filters' '
 	test $orig_invariant = $(git rev-parse invariant)
 '
 
+test_expect_success 'setup submodule' '
+	rm -rf ?* .git &&
+	git init &&
+	test_commit file &&
+	mkdir submod &&
+	submodurl="$PWD/submod" &&
+	( cd submod &&
+	  git init &&
+	  test_commit file-in-submod ) &&
+	git submodule add "$submodurl" &&
+	git commit -m "added submodule" &&
+	test_commit add-file &&
+	( cd submod && test_commit add-in-submodule ) &&
+	git add submod &&
+	git commit -m "changed submodule" &&
+	git branch original HEAD
+'
+
+orig_head=`git rev-parse HEAD`
+
+test_expect_success 'rewrite submodule with another content' '
+	git filter-branch --tree-filter "test -d submod && {
+					 rm -rf submod &&
+					 git rm -rf --quiet submod &&
+					 mkdir submod &&
+					 : > submod/file
+					 } || :" HEAD
+'
+test_expect_success 'test that submodule was rewritten' '
+	test -f submod/file &&
+	test $orig_head != `git rev-parse HEAD`
+'
+
+test_expect_success 'replace submodule revision' '
+	git reset --hard original &&
+	git filter-branch -f --tree-filter \
+	    "if git ls-files --error-unmatch -- submod > /dev/null 2>&1
+	     then git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 submod
+	     fi" HEAD
+'
+test_expect_success 'test that revision was replaced' '
+	test "`git ls-files --stage submod`" = "160000 0123456789012345678901234567890123456789 0	submod" &&
+	test $orig_head != `git rev-parse HEAD`
+'
+
 test_done
-- 
1.6.6
