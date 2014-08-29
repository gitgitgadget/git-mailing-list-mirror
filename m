From: Maxim Bublis <satori@yandex-team.ru>
Subject: [PATCH v2 2/2] fast-import: fix segfault in store_tree()
Date: Fri, 29 Aug 2014 15:53:37 +0400
Message-ID: <1409313217-23198-3-git-send-email-satori@yandex-team.ru>
References: <1409313217-23198-1-git-send-email-satori@yandex-team.ru>
Cc: Junio C Hamano <gitster@pobox.com>,
	Maxim Bublis <satori@yandex-team.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 13:54:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNKkk-0006zl-0U
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 13:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbaH2Lx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 07:53:57 -0400
Received: from 95.108.175.165-red.dhcp.yndx.net ([95.108.175.165]:60399 "EHLO
	95.108.175.165-red.dhcp.yndx.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709AbaH2Lx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Aug 2014 07:53:56 -0400
Received: by 95.108.175.165-red.dhcp.yndx.net (Postfix, from userid 1533206276)
	id CCA72205B39B; Fri, 29 Aug 2014 15:53:53 +0400 (MSK)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
In-Reply-To: <1409313217-23198-1-git-send-email-satori@yandex-team.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256143>

Branch tree is NULLified by filedelete command if we are trying
to delete root tree. Add sanity check and use load_tree() in that case.

Signed-off-by: Maxim Bublis <satori@yandex-team.ru>
---
 fast-import.c          | 6 +++++-
 t/t9300-fast-import.sh | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d73f58c..e380804 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1419,7 +1419,7 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 
 static void store_tree(struct tree_entry *root)
 {
-	struct tree_content *t = root->tree;
+	struct tree_content *t;
 	unsigned int i, j, del;
 	struct last_object lo = { STRBUF_INIT, 0, 0, /* no_swap */ 1 };
 	struct object_entry *le = NULL;
@@ -1427,6 +1427,10 @@ static void store_tree(struct tree_entry *root)
 	if (!is_null_sha1(root->versions[1].sha1))
 		return;
 
+	if (!root->tree)
+		load_tree(root);
+	t = root->tree;
+
 	for (i = 0; i < t->entry_count; i++) {
 		if (t->entries[i]->tree)
 			store_tree(t->entries[i]);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 9cf5e45..d400442 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3107,7 +3107,7 @@ D ""
 
 INPUT_END
 
-test_expect_failure 'U: filedelete root succeeds' '
+test_expect_success 'U: filedelete root succeeds' '
     git fast-import <input
 '
 
@@ -3117,7 +3117,7 @@ EOF
 
 git diff-tree -M -r U^1 U >actual
 
-test_expect_failure 'U: validate root delete result' '
+test_expect_success 'U: validate root delete result' '
 	compare_diff_raw expect actual
 '
 
-- 
1.8.5.2 (Apple Git-48)
