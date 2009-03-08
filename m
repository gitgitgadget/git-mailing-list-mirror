From: Sam Hocevar <sam@zoy.org>
Subject: [PATCH 2/2] fast-import: treat large blobs (> 100 MiB) specially,
	by deflating them on-the-fly from stdin instead of keeping an
	entire copy in memory.
Date: Sun, 8 Mar 2009 19:40:57 +0100
Message-ID: <20090308184057.GA9606@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 19:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgO2o-0004xW-43
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 19:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbZCHSqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 14:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754211AbZCHSqk
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 14:46:40 -0400
Received: from poulet.zoy.org ([80.65.228.129]:44730 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209AbZCHSqj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 14:46:39 -0400
Received: from poukram (localhost [127.0.0.1])
	by poulet.zoy.org (Postfix) with ESMTP id 61EF4120416
	for <git@vger.kernel.org>; Sun,  8 Mar 2009 19:46:36 +0100 (CET)
Received: by poukram (Postfix, from userid 1000)
	id 6776E7F9E5; Sun,  8 Mar 2009 19:40:56 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112631>

Since deltas need no longer be computed for such files, fast-import is
now twice as fast and memory usage decreases more than threefold when
importing large files.

Signed-off-by: Sam Hocevar <sam@zoy.org>
---
 I'd like to hear any suggestions on how to improve this patch. I am
not sure all the decisions I made by trying not to refactor too much
of the code were appropriate. If at least the idea is welcome, I will
also write a proper patch to make the data size threshold a config
option.

 Here is a graph of memory usage against time for the current version
of fast-import and a patched version, when importing four 100 MiB files
filled with random data: http://zoy.org/~sam/git/git-faster-import.png

 fast-import.c |  155 +++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 112 insertions(+), 43 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6419d00..bdd40e7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1044,12 +1044,14 @@ static int store_object(
 	struct strbuf *dat,
 	struct last_object *last,
 	unsigned char *sha1,
-	uintmax_t mark)
+	uintmax_t mark,
+	int orig_bytes)
 {
 	void *out, *delta;
 	struct object_entry *e;
 	unsigned char hdr[96];
 	unsigned long hdrlen, deltalen;
+	size_t outbytes;
 	z_stream s;
 
 	e = insert_object(sha1);
@@ -1066,7 +1068,9 @@ static int store_object(
 		return 1;
 	}
 
-	if (last && last->data.buf && last->depth < max_depth) {
+	/* If orig_bytes is set, the object is already deflated and the
+	 * caller does not want us to computes delta. */
+	if (!orig_bytes && last && last->data.buf && last->depth < max_depth) {
 		delta = diff_delta(last->data.buf, last->data.len,
 			dat->buf, dat->len,
 			&deltalen, 0);
@@ -1077,24 +1081,30 @@ static int store_object(
 	} else
 		delta = NULL;
 
-	memset(&s, 0, sizeof(s));
-	deflateInit(&s, pack_compression_level);
-	if (delta) {
-		s.next_in = delta;
-		s.avail_in = deltalen;
+	if (!orig_bytes) {
+		memset(&s, 0, sizeof(s));
+		deflateInit(&s, pack_compression_level);
+		if (delta) {
+			s.next_in = delta;
+			s.avail_in = deltalen;
+		} else {
+			s.next_in = (void *)dat->buf;
+			s.avail_in = dat->len;
+		}
+		s.avail_out = deflateBound(&s, s.avail_in);
+		s.next_out = out = xmalloc(s.avail_out);
+		while (deflate(&s, Z_FINISH) == Z_OK)
+			/* nothing */;
+		deflateEnd(&s);
+		outbytes = s.total_out;
 	} else {
-		s.next_in = (void *)dat->buf;
-		s.avail_in = dat->len;
+		out = dat->buf;
+		outbytes = dat->len;
 	}
-	s.avail_out = deflateBound(&s, s.avail_in);
-	s.next_out = out = xmalloc(s.avail_out);
-	while (deflate(&s, Z_FINISH) == Z_OK)
-		/* nothing */;
-	deflateEnd(&s);
 
 	/* Determine if we should auto-checkpoint. */
-	if ((pack_size + 60 + s.total_out) > max_packsize
-		|| (pack_size + 60 + s.total_out) < pack_size) {
+	if ((pack_size + 60 + outbytes) > max_packsize
+		|| (pack_size + 60 + outbytes) < pack_size) {
 
 		/* This new object needs to *not* have the current pack_id. */
 		e->pack_id = pack_id + 1;
@@ -1141,24 +1151,27 @@ static int store_object(
 		pack_size += sizeof(hdr) - pos;
 	} else {
 		e->depth = 0;
-		hdrlen = encode_header(type, dat->len, hdr);
+		hdrlen = encode_header(type, orig_bytes ? orig_bytes
+						 : dat->len, hdr);
 		write_or_die(pack_data->pack_fd, hdr, hdrlen);
 		pack_size += hdrlen;
 	}
 
-	write_or_die(pack_data->pack_fd, out, s.total_out);
-	pack_size += s.total_out;
+	write_or_die(pack_data->pack_fd, out, outbytes);
+	pack_size += outbytes;
 
-	free(out);
 	free(delta);
-	if (last) {
-		if (last->no_swap) {
-			last->data = *dat;
-		} else {
-			strbuf_swap(&last->data, dat);
+	if (!orig_bytes) {
+		free(out);
+		if (last) {
+			if (last->no_swap) {
+				last->data = *dat;
+			} else {
+				strbuf_swap(&last->data, dat);
+			}
+			last->offset = e->offset;
+			last->depth = e->depth;
 		}
-		last->offset = e->offset;
-		last->depth = e->depth;
 	}
 	return 0;
 }
@@ -1343,7 +1356,7 @@ static void store_tree(struct tree_entry *root)
 
 	mktree(t, 1, &new_tree);
 	sha1_object(OBJ_TREE, &new_tree, root->versions[1].sha1);
-	store_object(OBJ_TREE, &new_tree, &lo, root->versions[1].sha1, 0);
+	store_object(OBJ_TREE, &new_tree, &lo, root->versions[1].sha1, 0, 0);
 
 	t->delta_depth = lo.depth;
 	for (i = 0, j = 0, del = 0; i < t->entry_count; i++) {
@@ -1711,11 +1724,15 @@ static void parse_mark(void)
 
 /* This actually parses a "data" command, with the addition that if sha1out
  * is not NULL, it will also compute the sha1 on the fly. */
-static void parse_object_data(
+static int parse_object_data(
 	enum object_type type,
 	struct strbuf *sb,
-	unsigned char *sha1out)
+	unsigned char *sha1out,
+	int candeflate)
 {
+	int orig_bytes = 0;
+	size_t n = 0, length;
+
 	strbuf_reset(sb);
 
 	if (prefixcmp(command_buf.buf, "data "))
@@ -1737,14 +1754,63 @@ static void parse_object_data(
 		}
 		free(term);
 
-		if(sha1out)
+		if (sha1out)
 			sha1_object(type, sb, sha1out);
 	}
-	else {
-		size_t n = 0, length;
+	/* TODO: make the hardcoded value a configuration option */
+	else if ((length = strtoul(command_buf.buf + 5, NULL, 10))
+			> 100 * 1024 * 1024
+		 && candeflate) {
+		/* The incoming file is really big. As it is pretty unlikely
+		 * it will give any interesting deltas, we immediately deflate
+		 * it instead of storing the original data in memory. */
+		static struct strbuf tmp = STRBUF_INIT;
+		git_SHA_CTX c;
+		z_stream zs;
+
+		if (sha1out) {
+			unsigned char hdr[96];
+			unsigned long hdrlen;
+			hdrlen = sprintf((char*)hdr,"%s %lu", typename(type),
+				(unsigned long)length) + 1;
+			git_SHA1_Init(&c);
+			git_SHA1_Update(&c, hdr, hdrlen);
+		}
+
+		memset(&zs, 0, sizeof(zs));
+		deflateInit(&zs, pack_compression_level);
+		/* TODO: ideally, this should grow dynamically while we
+		 * deflate the file. */
+		zs.avail_out = deflateBound(&zs, length);
+		strbuf_grow(sb, zs.avail_out);
+		zs.next_out = (unsigned char *)sb->buf;
 
-		length = strtoul(command_buf.buf + 5, NULL, 10);
+		while (n < length) {
+			size_t s = strbuf_fread(&tmp, length - n < 4096 ?
+						length - n : 4096, stdin);
+			if (!s && feof(stdin))
+				die("EOF in data (%lu bytes remaining)",
+					(unsigned long)(length - n));
+			if (sha1out)
+				git_SHA1_Update(&c, tmp.buf, s);
+			zs.next_in = (unsigned char *)tmp.buf;
+			zs.avail_in = s;
+			while (deflate(&zs, Z_NO_FLUSH) == Z_OK)
+				/* nothing */;
+			strbuf_reset(&tmp);
 
+			n += s;
+		}
+		deflate(&zs, Z_FINISH);
+		deflateEnd(&zs);
+		strbuf_setlen(sb, zs.total_out);
+
+		if (sha1out)
+			git_SHA1_Final(sha1out, &c);
+
+		orig_bytes = length;
+	}
+	else {
 		while (n < length) {
 			size_t s = strbuf_fread(sb, length - n, stdin);
 			if (!s && feof(stdin))
@@ -1753,16 +1819,17 @@ static void parse_object_data(
 			n += s;
 		}
 
-		if(sha1out)
+		if (sha1out)
 			sha1_object(type, sb, sha1out);
 	}
 
 	skip_optional_lf();
+	return orig_bytes;
 }
 
 static void parse_data(struct strbuf *sb)
 {
-	parse_object_data(OBJ_NONE, sb, NULL);
+	parse_object_data(OBJ_NONE, sb, NULL, 0);
 }
 
 static int validate_raw_date(const char *src, char *result, int maxlen)
@@ -1828,13 +1895,14 @@ static char *parse_ident(const char *buf)
 
 static void parse_new_blob(void)
 {
-	unsigned char sha1[20];
 	static struct strbuf buf = STRBUF_INIT;
+	unsigned char sha1[20];
+	int orig_bytes;
 
 	read_next_command();
 	parse_mark();
-	parse_object_data(OBJ_BLOB, &buf, sha1);
-	store_object(OBJ_BLOB, &buf, &last_blob, sha1, next_mark);
+	orig_bytes = parse_object_data(OBJ_BLOB, &buf, sha1, 1);
+	store_object(OBJ_BLOB, &buf, &last_blob, sha1, next_mark, orig_bytes);
 }
 
 static void unload_one_branch(void)
@@ -1946,14 +2014,15 @@ static void file_change_m(struct branch *b)
 		 */
 	} else if (inline_data) {
 		static struct strbuf buf = STRBUF_INIT;
+		int orig_bytes;
 
 		if (p != uq.buf) {
 			strbuf_addstr(&uq, p);
 			p = uq.buf;
 		}
 		read_next_command();
-		parse_object_data(OBJ_BLOB, &buf, sha1);
-		store_object(OBJ_BLOB, &buf, &last_blob, sha1, 0);
+		orig_bytes = parse_object_data(OBJ_BLOB, &buf, sha1, 1);
+		store_object(OBJ_BLOB, &buf, &last_blob, sha1, 0, orig_bytes);
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
@@ -2236,7 +2305,7 @@ static void parse_new_commit(void)
 	free(committer);
 
 	sha1_object(OBJ_COMMIT, &new_data, b->sha1);
-	if (!store_object(OBJ_COMMIT, &new_data, NULL, b->sha1, next_mark))
+	if (!store_object(OBJ_COMMIT, &new_data, NULL, b->sha1, next_mark, 0))
 		b->pack_id = pack_id;
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
@@ -2317,7 +2386,7 @@ static void parse_new_tag(void)
 	free(tagger);
 
 	sha1_object(OBJ_TAG, &new_data, t->sha1);
-	if (store_object(OBJ_TAG, &new_data, NULL, t->sha1, 0))
+	if (store_object(OBJ_TAG, &new_data, NULL, t->sha1, 0, 0))
 		t->pack_id = MAX_PACK_ID;
 	else
 		t->pack_id = pack_id;
-- 
1.6.2
