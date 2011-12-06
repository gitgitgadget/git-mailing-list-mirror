From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/5] Test the current state of the cache-tree optimization
Date: Tue, 6 Dec 2011 18:43:36 +0100
Message-ID: <b6b5b93a136baaa59173324cac85847f49786336.1323191497.git.trast@student.ethz.ch>
References: <cover.1323191497.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 06 18:44:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXz3o-0000N4-44
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 18:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110Ab1LFRnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 12:43:45 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:35844 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854Ab1LFRno (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 12:43:44 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:43:39 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:43:41 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <cover.1323191497.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186360>

The cache-tree optimization originally helped speed up write-tree
operation.  However, many commands no longer properly maintain -- or
use an opportunity to cheaply generate -- the cache-tree data.  In
particular, this affects commit, checkout and reset.  The notable
examples that *do* write cache-tree data are read-tree and write-tree.

This sadly means most people no longer benefit from the optimization,
as they would not normally use the plumbing commands.

Document the current state of affairs in a test file, in preparation
for improvements in the area.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t0090-cache-tree.sh |   95 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100755 t/t0090-cache-tree.sh

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
new file mode 100755
index 0000000..3d0702a
--- /dev/null
+++ b/t/t0090-cache-tree.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description="Test whether cache-tree is properly updated
+
+Tests whether various commands properly update and/or rewrite the
+cache-tree extension.
+"
+ . ./test-lib.sh
+
+cmp_cache_tree () {
+	test-dump-cache-tree >actual &&
+	sed "s/$_x40/SHA/" <actual >filtered &&
+	test_cmp "$1" filtered
+}
+
+# We don't bother with actually checking the SHA1:
+# test-dump-cache-tree already verifies that all existing data is
+# correct.
+test_shallow_cache_tree () {
+	echo "SHA " \
+	    "($(git ls-files|wc -l) entries, 0 subtrees)" >expect &&
+	cmp_cache_tree expect
+}
+
+test_invalid_cache_tree () {
+	echo "invalid                                   (0 subtrees)" >expect &&
+	echo "SHA #(ref) " \
+	    "($(git ls-files|wc -l) entries, 0 subtrees)" >>expect &&
+	cmp_cache_tree expect
+}
+
+test_no_cache_tree () {
+	: >expect &&
+	cmp_cache_tree expect
+}
+
+test_expect_failure 'initial commit has cache-tree' '
+	test_commit foo &&
+	test_shallow_cache_tree
+'
+
+test_expect_success 'read-tree HEAD establishes cache-tree' '
+	git read-tree HEAD &&
+	test_shallow_cache_tree
+'
+
+test_expect_success 'git-add invalidates cache-tree' '
+	test_when_finished "git reset --hard; git read-tree HEAD" &&
+	echo "I changed this file" > foo &&
+	git add foo &&
+	test_invalid_cache_tree
+'
+
+test_expect_success 'update-index invalidates cache-tree' '
+	test_when_finished "git reset --hard; git read-tree HEAD" &&
+	echo "I changed this file" > foo &&
+	git update-index --add foo &&
+	test_invalid_cache_tree
+'
+
+test_expect_success 'write-tree establishes cache-tree' '
+	test-scrap-cache-tree &&
+	git write-tree &&
+	test_shallow_cache_tree
+'
+
+test_expect_success 'test-scrap-cache-tree works' '
+	git read-tree HEAD &&
+	test-scrap-cache-tree &&
+	test_no_cache_tree
+'
+
+test_expect_failure 'second commit has cache-tree' '
+	test_commit bar &&
+	test_shallow_cache_tree
+'
+
+test_expect_failure 'reset --hard gives cache-tree' '
+	test-scrap-cache-tree &&
+	git reset --hard &&
+	test_shallow_cache_tree
+'
+
+test_expect_failure 'reset --hard without index gives cache-tree' '
+	rm -f .git/index &&
+	git reset --hard &&
+	test_shallow_cache_tree
+'
+
+test_expect_failure 'checkout gives cache-tree' '
+	git checkout HEAD^ &&
+	test_shallow_cache_tree
+'
+
+test_done
-- 
1.7.8.425.ga639d3
