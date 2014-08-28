From: Maxim Bublis <satori@yandex-team.ru>
Subject: [PATCH 2/2] fast-import: fix segfault in store_tree()
Date: Thu, 28 Aug 2014 18:54:34 +0400
Message-ID: <1409237674-74185-3-git-send-email-satori@yandex-team.ru>
References: <1409237674-74185-1-git-send-email-satori@yandex-team.ru>
Cc: Maxim Bublis <satori@yandex-team.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 16:55:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN16e-0005uJ-02
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 16:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbaH1OzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 10:55:01 -0400
Received: from 95.108.175.165-red.dhcp.yndx.net ([95.108.175.165]:55958 "EHLO
	95.108.175.165-red.dhcp.yndx.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750892AbaH1Oy7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 10:54:59 -0400
Received: by 95.108.175.165-red.dhcp.yndx.net (Postfix, from userid 1533206276)
	id 1CC192046B23; Thu, 28 Aug 2014 18:54:59 +0400 (MSK)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
In-Reply-To: <1409237674-74185-1-git-send-email-satori@yandex-team.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256093>

Branch tree is NULLified by filedelete command if we are trying
to delete root tree. Add sanity check and use load_tree() in that case.

Signed-off-by: Maxim Bublis <satori@yandex-team.ru>
---
 fast-import.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index d73f58c..b77f12c 100644
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
+		load_tree(root)
+	t = root->tree;
+
 	for (i = 0; i < t->entry_count; i++) {
 		if (t->entries[i]->tree)
 			store_tree(t->entries[i]);
-- 
1.8.5.2 (Apple Git-48)
