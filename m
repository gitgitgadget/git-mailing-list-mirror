From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/3] fast-import was using dbuf's, replace them with strbuf's.
Date: Mon, 17 Sep 2007 13:48:17 +0200
Message-ID: <20070917125258.2521C344A4A@madism.org>
References: <20070917125211.GA18176@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:53:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXG65-0004d1-PL
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 14:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbXIQMxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 08:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbXIQMxC
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 08:53:02 -0400
Received: from pan.madism.org ([88.191.52.104]:43270 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbXIQMw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 08:52:59 -0400
Received: from madism.org (beacon-free2.intersec.com [82.236.12.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6DCB92053E;
	Mon, 17 Sep 2007 14:52:58 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2521C344A4A; Mon, 17 Sep 2007 14:52:58 +0200 (CEST)
In-Reply-To: <20070917125211.GA18176@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58435>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 fast-import.c |  177 ++++++++++++++++++++++-----------------------------------
 1 files changed, 68 insertions(+), 109 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index da04566..e456eab 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -250,12 +250,6 @@ struct tag
 	unsigned char sha1[20];
 };
 
-struct dbuf
-{
-	void *buffer;
-	size_t capacity;
-};
-
 struct hash_list
 {
 	struct hash_list *next;
@@ -323,8 +317,8 @@ static unsigned int tree_entry_alloc = 1000;
 static void *avail_tree_entry;
 static unsigned int avail_tree_table_sz = 100;
 static struct avail_tree_content **avail_tree_table;
-static struct dbuf old_tree;
-static struct dbuf new_tree;
+static struct strbuf old_tree = STRBUF_INIT;
+static struct strbuf new_tree = STRBUF_INIT;
 
 /* Branch data */
 static unsigned long max_active_branches = 5;
@@ -346,7 +340,7 @@ static struct recent_command *cmd_tail = &cmd_hist;
 static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
-static struct dbuf new_data;
+static struct strbuf new_data = STRBUF_INIT;
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -566,17 +560,6 @@ static char *pool_strdup(const char *s)
 	return r;
 }
 
-static void size_dbuf(struct dbuf *b, size_t maxlen)
-{
-	if (b->buffer) {
-		if (b->capacity >= maxlen)
-			return;
-		free(b->buffer);
-	}
-	b->capacity = ((maxlen / 1024) + 1) * 1024;
-	b->buffer = xmalloc(b->capacity);
-}
-
 static void insert_mark(uintmax_t idnum, struct object_entry *oe)
 {
 	struct mark_set *s = marks;
@@ -1005,8 +988,7 @@ static size_t encode_header(
 
 static int store_object(
 	enum object_type type,
-	void *dat,
-	size_t datlen,
+	struct strbuf *dat,
 	struct last_object *last,
 	unsigned char *sha1out,
 	uintmax_t mark)
@@ -1020,10 +1002,10 @@ static int store_object(
 	z_stream s;
 
 	hdrlen = sprintf((char*)hdr,"%s %lu", typename(type),
-		(unsigned long)datlen) + 1;
+		(unsigned long)dat->len) + 1;
 	SHA1_Init(&c);
 	SHA1_Update(&c, hdr, hdrlen);
-	SHA1_Update(&c, dat, datlen);
+	SHA1_Update(&c, dat->buf, dat->len);
 	SHA1_Final(sha1, &c);
 	if (sha1out)
 		hashcpy(sha1out, sha1);
@@ -1044,9 +1026,9 @@ static int store_object(
 
 	if (last && last->data && last->depth < max_depth) {
 		delta = diff_delta(last->data, last->len,
-			dat, datlen,
+			dat->buf, dat->len,
 			&deltalen, 0);
-		if (delta && deltalen >= datlen) {
+		if (delta && deltalen >= dat->len) {
 			free(delta);
 			delta = NULL;
 		}
@@ -1059,8 +1041,8 @@ static int store_object(
 		s.next_in = delta;
 		s.avail_in = deltalen;
 	} else {
-		s.next_in = dat;
-		s.avail_in = datlen;
+		s.next_in = (void *)dat->buf;
+		s.avail_in = dat->len;
 	}
 	s.avail_out = deflateBound(&s, s.avail_in);
 	s.next_out = out = xmalloc(s.avail_out);
@@ -1083,8 +1065,8 @@ static int store_object(
 
 			memset(&s, 0, sizeof(s));
 			deflateInit(&s, zlib_compression_level);
-			s.next_in = dat;
-			s.avail_in = datlen;
+			s.next_in = (void *)dat->buf;
+			s.avail_in = dat->len;
 			s.avail_out = deflateBound(&s, s.avail_in);
 			s.next_out = out = xrealloc(out, s.avail_out);
 			while (deflate(&s, Z_FINISH) == Z_OK)
@@ -1118,7 +1100,7 @@ static int store_object(
 	} else {
 		if (last)
 			last->depth = 0;
-		hdrlen = encode_header(type, datlen, hdr);
+		hdrlen = encode_header(type, dat->len, hdr);
 		write_or_die(pack_data->pack_fd, hdr, hdrlen);
 		pack_size += hdrlen;
 	}
@@ -1131,9 +1113,9 @@ static int store_object(
 	if (last) {
 		if (!last->no_free)
 			free(last->data);
-		last->data = dat;
 		last->offset = e->offset;
-		last->len = datlen;
+		last->data = dat->buf;
+		last->len = dat->len;
 	}
 	return 0;
 }
@@ -1229,14 +1211,10 @@ static int tecmp1 (const void *_a, const void *_b)
 		b->name->str_dat, b->name->str_len, b->versions[1].mode);
 }
 
-static void mktree(struct tree_content *t,
-	int v,
-	unsigned long *szp,
-	struct dbuf *b)
+static void mktree(struct tree_content *t, int v, struct strbuf *b)
 {
 	size_t maxlen = 0;
 	unsigned int i;
-	char *c;
 
 	if (!v)
 		qsort(t->entries,t->entry_count,sizeof(t->entries[0]),tecmp0);
@@ -1248,27 +1226,22 @@ static void mktree(struct tree_content *t,
 			maxlen += t->entries[i]->name->str_len + 34;
 	}
 
-	size_dbuf(b, maxlen);
-	c = b->buffer;
+	strbuf_reset(b);
+	strbuf_grow(b, maxlen);
 	for (i = 0; i < t->entry_count; i++) {
 		struct tree_entry *e = t->entries[i];
 		if (!e->versions[v].mode)
 			continue;
-		c += sprintf(c, "%o", (unsigned int)e->versions[v].mode);
-		*c++ = ' ';
-		strcpy(c, e->name->str_dat);
-		c += e->name->str_len + 1;
-		hashcpy((unsigned char*)c, e->versions[v].sha1);
-		c += 20;
+		strbuf_addf(b, "%o %s%c", (unsigned int)e->versions[v].mode,
+					e->name->str_dat, '\0');
+		strbuf_add(b, e->versions[v].sha1, 20);
 	}
-	*szp = c - (char*)b->buffer;
 }
 
 static void store_tree(struct tree_entry *root)
 {
 	struct tree_content *t = root->tree;
 	unsigned int i, j, del;
-	unsigned long new_len;
 	struct last_object lo;
 	struct object_entry *le;
 
@@ -1288,16 +1261,16 @@ static void store_tree(struct tree_entry *root)
 		lo.depth = 0;
 		lo.no_free = 0;
 	} else {
-		mktree(t, 0, &lo.len, &old_tree);
-		lo.data = old_tree.buffer;
+		mktree(t, 0, &old_tree);
+		lo.len  = old_tree.len;
+		lo.data = old_tree.buf;
 		lo.offset = le->offset;
 		lo.depth = t->delta_depth;
 		lo.no_free = 1;
 	}
 
-	mktree(t, 1, &new_len, &new_tree);
-	store_object(OBJ_TREE, new_tree.buffer, new_len,
-		&lo, root->versions[1].sha1, 0);
+	mktree(t, 1, &new_tree);
+	store_object(OBJ_TREE, &new_tree, &lo, root->versions[1].sha1, 0);
 
 	t->delta_depth = lo.depth;
 	for (i = 0, j = 0, del = 0; i < t->entry_count; i++) {
@@ -1642,11 +1615,10 @@ static void cmd_mark(void)
 		next_mark = 0;
 }
 
-static void *cmd_data (size_t *size)
+static void cmd_data(struct strbuf *sb)
 {
-	struct strbuf buffer;
+	strbuf_reset(sb);
 
-	strbuf_init(&buffer, 0);
 	if (prefixcmp(command_buf.buf, "data "))
 		die("Expected 'data n' command, found: %s", command_buf.buf);
 
@@ -1660,8 +1632,8 @@ static void *cmd_data (size_t *size)
 			if (term_len == command_buf.len
 				&& !strcmp(term, command_buf.buf))
 				break;
-			strbuf_addbuf(&buffer, &command_buf);
-			strbuf_addch(&buffer, '\n');
+			strbuf_addbuf(sb, &command_buf);
+			strbuf_addch(sb, '\n');
 		}
 		free(term);
 	}
@@ -1671,7 +1643,7 @@ static void *cmd_data (size_t *size)
 		length = strtoul(command_buf.buf + 5, NULL, 10);
 
 		while (n < length) {
-			size_t s = strbuf_fread(&buffer, length - n, stdin);
+			size_t s = strbuf_fread(sb, length - n, stdin);
 			if (!s && feof(stdin))
 				die("EOF in data (%lu bytes remaining)",
 					(unsigned long)(length - n));
@@ -1680,8 +1652,6 @@ static void *cmd_data (size_t *size)
 	}
 
 	skip_optional_lf();
-	*size = buffer.len;
-	return strbuf_detach(&buffer);
 }
 
 static int validate_raw_date(const char *src, char *result, int maxlen)
@@ -1744,15 +1714,14 @@ static char *parse_ident(const char *buf)
 
 static void cmd_new_blob(void)
 {
-	size_t l;
-	void *d;
+	struct strbuf buf;
 
 	read_next_command();
 	cmd_mark();
-	d = cmd_data(&l);
-
-	if (store_object(OBJ_BLOB, d, l, &last_blob, NULL, next_mark))
-		free(d);
+	strbuf_init(&buf, 0);
+	cmd_data(&buf);
+	if (store_object(OBJ_BLOB, &buf, &last_blob, NULL, next_mark))
+		strbuf_release(&buf);
 }
 
 static void unload_one_branch(void)
@@ -1848,14 +1817,15 @@ static void file_change_m(struct branch *b)
 	}
 
 	if (inline_data) {
-		size_t l;
-		void *d;
+		struct strbuf buf;
+
 		if (!p_uq)
 			p = p_uq = xstrdup(p);
 		read_next_command();
-		d = cmd_data(&l);
-		if (store_object(OBJ_BLOB, d, l, &last_blob, sha1, 0))
-			free(d);
+		strbuf_init(&buf, 0);
+		cmd_data(&buf);
+		if (store_object(OBJ_BLOB, &buf, &last_blob, sha1, 0))
+			strbuf_release(&buf);
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
@@ -2062,9 +2032,8 @@ static struct hash_list *cmd_merge(unsigned int *count)
 
 static void cmd_new_commit(void)
 {
+	static struct strbuf msg = STRBUF_INIT;
 	struct branch *b;
-	void *msg;
-	size_t msglen;
 	char *sp;
 	char *author = NULL;
 	char *committer = NULL;
@@ -2089,7 +2058,7 @@ static void cmd_new_commit(void)
 	}
 	if (!committer)
 		die("Expected committer but didn't get one");
-	msg = cmd_data(&msglen);
+	cmd_data(&msg);
 	read_next_command();
 	cmd_from(b);
 	merge_list = cmd_merge(&merge_count);
@@ -2124,46 +2093,39 @@ static void cmd_new_commit(void)
 	store_tree(&b->branch_tree);
 	hashcpy(b->branch_tree.versions[0].sha1,
 		b->branch_tree.versions[1].sha1);
-	size_dbuf(&new_data, 114 + msglen
-		+ merge_count * 49
-		+ (author
-			? strlen(author) + strlen(committer)
-			: 2 * strlen(committer)));
-	sp = new_data.buffer;
-	sp += sprintf(sp, "tree %s\n",
+
+	strbuf_reset(&new_data);
+	strbuf_addf(&new_data, "tree %s\n",
 		sha1_to_hex(b->branch_tree.versions[1].sha1));
 	if (!is_null_sha1(b->sha1))
-		sp += sprintf(sp, "parent %s\n", sha1_to_hex(b->sha1));
+		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(b->sha1));
 	while (merge_list) {
 		struct hash_list *next = merge_list->next;
-		sp += sprintf(sp, "parent %s\n", sha1_to_hex(merge_list->sha1));
+		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(merge_list->sha1));
 		free(merge_list);
 		merge_list = next;
 	}
-	sp += sprintf(sp, "author %s\n", author ? author : committer);
-	sp += sprintf(sp, "committer %s\n", committer);
-	*sp++ = '\n';
-	memcpy(sp, msg, msglen);
-	sp += msglen;
+	strbuf_addf(&new_data,
+		"author %s\n"
+		"committer %s\n"
+		"\n",
+		author ? author : committer, committer);
+	strbuf_addbuf(&new_data, &msg);
 	free(author);
 	free(committer);
-	free(msg);
 
-	if (!store_object(OBJ_COMMIT,
-		new_data.buffer, sp - (char*)new_data.buffer,
-		NULL, b->sha1, next_mark))
+	if (!store_object(OBJ_COMMIT, &new_data, NULL, b->sha1, next_mark))
 		b->pack_id = pack_id;
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
 
 static void cmd_new_tag(void)
 {
+	static struct strbuf msg = STRBUF_INIT;
 	char *sp;
 	const char *from;
 	char *tagger;
 	struct branch *s;
-	void *msg;
-	size_t msglen;
 	struct tag *t;
 	uintmax_t from_mark = 0;
 	unsigned char sha1[20];
@@ -2214,24 +2176,21 @@ static void cmd_new_tag(void)
 
 	/* tag payload/message */
 	read_next_command();
-	msg = cmd_data(&msglen);
+	cmd_data(&msg);
 
 	/* build the tag object */
-	size_dbuf(&new_data, 67+strlen(t->name)+strlen(tagger)+msglen);
-	sp = new_data.buffer;
-	sp += sprintf(sp, "object %s\n", sha1_to_hex(sha1));
-	sp += sprintf(sp, "type %s\n", commit_type);
-	sp += sprintf(sp, "tag %s\n", t->name);
-	sp += sprintf(sp, "tagger %s\n", tagger);
-	*sp++ = '\n';
-	memcpy(sp, msg, msglen);
-	sp += msglen;
+	strbuf_reset(&new_data);
+	strbuf_addf(&new_data,
+		"object %s\n"
+		"type %s\n"
+		"tag %s\n"
+		"tagger %s\n"
+		"\n",
+		sha1_to_hex(sha1), commit_type, t->name, tagger);
+	strbuf_addbuf(&new_data, &msg);
 	free(tagger);
-	free(msg);
 
-	if (store_object(OBJ_TAG, new_data.buffer,
-		sp - (char*)new_data.buffer,
-		NULL, t->sha1, 0))
+	if (store_object(OBJ_TAG, &new_data, NULL, t->sha1, 0))
 		t->pack_id = MAX_PACK_ID;
 	else
 		t->pack_id = pack_id;
-- 
1.5.3.1
