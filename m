From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 5/5] reset: update cache-tree data when appropriate
Date: Tue, 6 Dec 2011 18:43:39 +0100
Message-ID: <1385c10084ae41ae4543ef3ccaa1d6c8182b2204.1323191497.git.trast@student.ethz.ch>
References: <cover.1323191497.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 06 18:44:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXz3o-0000N4-Le
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 18:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab1LFRnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 12:43:50 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:35844 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab1LFRnr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 12:43:47 -0500
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186361>

In the case of --mixed and --hard, we throw away the old index and
rebuild everything from the tree argument (or HEAD).  So we have an
opportunity here to fill in the cache-tree data, just as read-tree
did.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin/reset.c       |    7 +++++++
 t/t0090-cache-tree.sh |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 811e8e2..8c2c1d5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -43,6 +43,7 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 	int nr = 1;
 	int newfd;
 	struct tree_desc desc[2];
+	struct tree *tree;
 	struct unpack_trees_options opts;
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 
@@ -84,6 +85,12 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 		return error(_("Failed to find tree of %s."), sha1_to_hex(sha1));
 	if (unpack_trees(nr, desc, &opts))
 		return -1;
+
+	if (reset_type == MIXED || reset_type == HARD) {
+		tree = parse_tree_indirect(sha1);
+		prime_cache_tree(&active_cache_tree, tree);
+	}
+
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock))
 		return error(_("Could not write new index file."));
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index a3527a5..f972562 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -75,13 +75,13 @@ test_expect_success 'second commit has cache-tree' '
 	test_shallow_cache_tree
 '
 
-test_expect_failure 'reset --hard gives cache-tree' '
+test_expect_success 'reset --hard gives cache-tree' '
 	test-scrap-cache-tree &&
 	git reset --hard &&
 	test_shallow_cache_tree
 '
 
-test_expect_failure 'reset --hard without index gives cache-tree' '
+test_expect_success 'reset --hard without index gives cache-tree' '
 	rm -f .git/index &&
 	git reset --hard &&
 	test_shallow_cache_tree
-- 
1.7.8.425.ga639d3
