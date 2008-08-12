From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/3] filter-branch: Extend test to show rewriting bug
Date: Tue, 12 Aug 2008 10:45:57 +0200
Message-ID: <b6bda5e5028aea161e5d18e0c70c45d5a94dac82.1218529494.git.trast@student.ethz.ch>
References: <cover.1218529494.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 10:46:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSpWs-0002ix-VP
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 10:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbYHLIp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 04:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbYHLIp5
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 04:45:57 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:33951 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbYHLIpz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 04:45:55 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 10:45:53 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 10:45:53 +0200
X-Mailer: git-send-email 1.6.0.rc2.30.gb6bda
In-Reply-To: <cover.1218529494.git.trast@student.ethz.ch>
In-Reply-To: <7vsktara5n.fsf@gitster.siamese.dyndns.org>
References: <7vsktara5n.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Aug 2008 08:45:53.0521 (UTC) FILETIME=[D45BF610:01C8FC57]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92078>

This extends the --subdirectory-filter test in t7003 to demonstrate a
rewriting bug: when rewriting two refs A and B such that B is an
ancestor of A, it fails to rewrite B.

The underlying issue is that the rev-list invocation at
git-filter-branch.sh:332 more or less boils down to

  git rev-list B --boundary ^A

which outputs nothing because B is an ancestor of A.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t7003-filter-branch.sh |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index a0ab096..4382baa 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -96,13 +96,17 @@ test_expect_success 'filter subdirectory only' '
 	test_tick &&
 	git commit -m "again not subdir" &&
 	git branch sub &&
-	git-filter-branch -f --subdirectory-filter subdir refs/heads/sub
+	git branch sub-earlier HEAD~2 &&
+	git-filter-branch -f --subdirectory-filter subdir \
+		refs/heads/sub refs/heads/sub-earlier
 '
 
-test_expect_success 'subdirectory filter result looks okay' '
+test_expect_failure 'subdirectory filter result looks okay' '
 	test 2 = $(git rev-list sub | wc -l) &&
 	git show sub:new &&
-	test_must_fail git show sub:subdir
+	test_must_fail git show sub:subdir &&
+	git show sub-earlier:new &&
+	test_must_fail git show sub-earlier:subdir
 '
 
 test_expect_success 'more setup' '
-- 
1.6.0.rc2.30.gb6bda
