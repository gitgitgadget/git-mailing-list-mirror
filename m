From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/3] fast-import optimization:
Date: Mon, 17 Sep 2007 14:00:38 +0200
Message-ID: <20070917125259.2DE83344A4A@madism.org>
References: <20070917125211.GA18176@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:53:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXG6L-0004ic-0f
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 14:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbXIQMxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 08:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbXIQMxG
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 08:53:06 -0400
Received: from pan.madism.org ([88.191.52.104]:43272 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbXIQMxA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 08:53:00 -0400
Received: from madism.org (beacon-free2.intersec.com [82.236.12.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 76A462053F;
	Mon, 17 Sep 2007 14:52:59 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2DE83344A4A; Mon, 17 Sep 2007 14:52:59 +0200 (CEST)
In-Reply-To: <20070917125211.GA18176@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58436>

Now that cmd_data acts on a strbuf, make last_object stashed buffer be a
strbuf as well. On new stash, don't free the last stashed buffer, rather
swap it with the one you will stash, this way, callers of store_object can
act on static strbufs, and at some point, fast-import won't allocate new
memory for objects buffers.
---
 fast-import.c |   52 ++++++++++++++++++++--------------------------------
 1 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index e456eab..e2a4834 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -182,11 +182,10 @@ struct mark_set
 
 struct last_object
 {
-	void *data;
-	unsigned long len;
+	struct strbuf data;
 	uint32_t offset;
 	unsigned int depth;
-	unsigned no_free:1;
+	unsigned no_swap : 1;
 };
 
 struct mem_pool
@@ -310,7 +309,7 @@ static struct mark_set *marks;
 static const char* mark_file;
 
 /* Our last blob */
-static struct last_object last_blob;
+static struct last_object last_blob = { STRBUF_INIT, 0, 0, 0 };
 
 /* Tree management */
 static unsigned int tree_entry_alloc = 1000;
@@ -950,9 +949,7 @@ static void end_packfile(void)
 	free(old_p);
 
 	/* We can't carry a delta across packfiles. */
-	free(last_blob.data);
-	last_blob.data = NULL;
-	last_blob.len = 0;
+	strbuf_release(&last_blob.data);
 	last_blob.offset = 0;
 	last_blob.depth = 0;
 }
@@ -1024,8 +1021,8 @@ static int store_object(
 		return 1;
 	}
 
-	if (last && last->data && last->depth < max_depth) {
-		delta = diff_delta(last->data, last->len,
+	if (last && last->data.buf && last->depth < max_depth) {
+		delta = diff_delta(last->data.buf, last->data.len,
 			dat->buf, dat->len,
 			&deltalen, 0);
 		if (delta && deltalen >= dat->len) {
@@ -1111,11 +1108,14 @@ static int store_object(
 	free(out);
 	free(delta);
 	if (last) {
-		if (!last->no_free)
-			free(last->data);
+		if (last->no_swap) {
+			last->data = *dat;
+		} else {
+			struct strbuf tmp = *dat;
+			*dat = last->data;
+			last->data = tmp;
+		}
 		last->offset = e->offset;
-		last->data = dat->buf;
-		last->len = dat->len;
 	}
 	return 0;
 }
@@ -1242,7 +1242,7 @@ static void store_tree(struct tree_entry *root)
 {
 	struct tree_content *t = root->tree;
 	unsigned int i, j, del;
-	struct last_object lo;
+	struct last_object lo = { STRBUF_INIT, 0, 0, /* no_swap */ 1 };
 	struct object_entry *le;
 
 	if (!is_null_sha1(root->versions[1].sha1))
@@ -1254,19 +1254,11 @@ static void store_tree(struct tree_entry *root)
 	}
 
 	le = find_object(root->versions[0].sha1);
-	if (!S_ISDIR(root->versions[0].mode)
-		|| !le
-		|| le->pack_id != pack_id) {
-		lo.data = NULL;
-		lo.depth = 0;
-		lo.no_free = 0;
-	} else {
+	if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
 		mktree(t, 0, &old_tree);
-		lo.len  = old_tree.len;
-		lo.data = old_tree.buf;
+		lo.data = old_tree;
 		lo.offset = le->offset;
 		lo.depth = t->delta_depth;
-		lo.no_free = 1;
 	}
 
 	mktree(t, 1, &new_tree);
@@ -1714,14 +1706,12 @@ static char *parse_ident(const char *buf)
 
 static void cmd_new_blob(void)
 {
-	struct strbuf buf;
+	static struct strbuf buf = STRBUF_INIT;
 
 	read_next_command();
 	cmd_mark();
-	strbuf_init(&buf, 0);
 	cmd_data(&buf);
-	if (store_object(OBJ_BLOB, &buf, &last_blob, NULL, next_mark))
-		strbuf_release(&buf);
+	store_object(OBJ_BLOB, &buf, &last_blob, NULL, next_mark);
 }
 
 static void unload_one_branch(void)
@@ -1817,15 +1807,13 @@ static void file_change_m(struct branch *b)
 	}
 
 	if (inline_data) {
-		struct strbuf buf;
+		static struct strbuf buf = STRBUF_INIT;
 
 		if (!p_uq)
 			p = p_uq = xstrdup(p);
 		read_next_command();
-		strbuf_init(&buf, 0);
 		cmd_data(&buf);
-		if (store_object(OBJ_BLOB, &buf, &last_blob, sha1, 0))
-			strbuf_release(&buf);
+		store_object(OBJ_BLOB, &buf, &last_blob, sha1, 0);
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
-- 
1.5.3.1
