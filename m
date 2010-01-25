From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH 2/2] filter-branch: Add tests for submodules
Date: Mon, 25 Jan 2010 14:06:25 +0100
Message-ID: <1264424786-26231-3-git-send-email-sojkam1@fel.cvut.cz>
References: <1264424786-26231-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: Johannes.Schindelin@gmx.de, Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 14:07:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZOes-00066U-Gk
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 14:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab0AYNGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 08:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753541Ab0AYNGk
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 08:06:40 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:58812 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399Ab0AYNGi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 08:06:38 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id C7A6719F3392;
	Mon, 25 Jan 2010 14:06:37 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id rUPZpPzZ0bHi; Mon, 25 Jan 2010 14:06:37 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 38BF619F3381;
	Mon, 25 Jan 2010 14:06:37 +0100 (CET)
Received: from localhost.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 3103615C052;
	Mon, 25 Jan 2010 14:06:37 +0100 (CET)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1264424786-26231-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137960>

The test 'rewrite submodule with another content' passes only with the
previous patch.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 t/t7003-filter-branch.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 9503875..39d4153 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -306,4 +306,30 @@ test_expect_success '--remap-to-ancestor with filename filters' '
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
+	git commit -m "changed submodule"
+'
+
+test_expect_success 'rewrite submodule with another content' '
+	git filter-branch --tree-filter "test -d submod && {
+					 rm -rf submod &&
+					 git rm -rf --quiet submod &&
+					 mkdir submod &&
+					 : > submod/file
+					 } || :"
+'
+
 test_done
-- 
1.6.6
