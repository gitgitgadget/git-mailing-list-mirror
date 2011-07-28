From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/WIP 3/7] fast-import: fix a data corruption in parse_ls
Date: Thu, 28 Jul 2011 10:46:06 +0600
Message-ID: <1311828370-30477-4-git-send-email-divanorama@gmail.com>
References: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 06:43:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIRl-0004W6-3L
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407Ab1G1Enc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:43:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36852 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab1G1En3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:43:29 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so881708fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 21:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=snLZI5UsKuWHC9/luifOQavPhs0tS2EqdIsatut4bEk=;
        b=IfvQ80y6qxBBsdkC+64+NEr2q5v6Uo/PhZGkD4LODiCfOa+OFJcqjiZva1c/gjirZ2
         DOTXoAXn84tc/502imhJhloYWpOPco8bIYvPYfCktzIPaHkIjxjh8UUI7/7/RJE4739p
         GOiV7aVEJ2ezPh/QUmFjFEG8rV9mkeOEHv0MI=
Received: by 10.204.132.19 with SMTP id z19mr173141bks.289.1311828208936;
        Wed, 27 Jul 2011 21:43:28 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id r24sm146189bkr.26.2011.07.27.21.43.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 21:43:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178010>

store_tree sets versions[0] = versions[1] unconditionally. This is fine
if it is run from the very root. But if it's run for a intermediate
node in parse_ls, node's parent versions[0] can become invalid as it
references it's children versions[0].

Move dropping old version to a function and don't drop old version in
parse_ls. Also this split will allow to perform a few more fixes for
store_tree itself.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   42 ++++++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index da9cb62..d5915b8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1439,12 +1439,36 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 	}
 }
 
-static void store_tree(struct tree_entry *root)
+static void drop_old(struct tree_entry *root)
 {
 	struct tree_content *t = root->tree;
 	unsigned int i, j, del;
+
+	hashcpy(root->versions[0].sha1, root->versions[1].sha1);
+	root->versions[0].mode = root->versions[1].mode;
+
+	if (!t)
+		return;
+
+	for (i = 0, j = 0, del = 0; i < t->entry_count; i++) {
+		struct tree_entry *e = t->entries[i];
+		if (e->versions[1].mode) {
+			drop_old(e);
+			t->entries[j++] = e;
+		} else {
+			release_tree_entry(e);
+			del++;
+		}
+	}
+	t->entry_count -= del;
+}
+
+static void store_tree(struct tree_entry *root)
+{
+	struct tree_content *t = root->tree;
 	struct last_object lo = { STRBUF_INIT, 0, 0, /* no_swap */ 1 };
 	struct object_entry *le;
+	unsigned int i;
 
 	if (!is_null_sha1(root->versions[1].sha1))
 		return;
@@ -1464,20 +1488,7 @@ static void store_tree(struct tree_entry *root)
 
 	mktree(t, 1, &new_tree);
 	store_object(OBJ_TREE, &new_tree, &lo, root->versions[1].sha1, 0);
-
 	t->delta_depth = lo.depth;
-	for (i = 0, j = 0, del = 0; i < t->entry_count; i++) {
-		struct tree_entry *e = t->entries[i];
-		if (e->versions[1].mode) {
-			e->versions[0].mode = e->versions[1].mode;
-			hashcpy(e->versions[0].sha1, e->versions[1].sha1);
-			t->entries[j++] = e;
-		} else {
-			release_tree_entry(e);
-			del++;
-		}
-	}
-	t->entry_count -= del;
 }
 
 static void tree_content_replace(
@@ -2640,8 +2651,7 @@ static void parse_new_commit(void)
 
 	/* build the tree and the commit */
 	store_tree(&b->branch_tree);
-	hashcpy(b->branch_tree.versions[0].sha1,
-		b->branch_tree.versions[1].sha1);
+	drop_old(&b->branch_tree);
 
 	strbuf_reset(&new_data);
 	strbuf_addf(&new_data, "tree %s\n",
-- 
1.7.3.4
