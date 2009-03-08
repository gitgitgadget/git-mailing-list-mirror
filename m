From: Sam Hocevar <sam@zoy.org>
Subject: [PATCH 1/2] fast-import: no longer compute the SHA1 data in
	store_object(). Instead, do it in the caller through the new
	sha1_object() and parse_object_data() functions.
Date: Sun, 8 Mar 2009 19:35:34 +0100
Message-ID: <20090308183533.GA9585@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 19:43:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgNxc-00037Y-Fe
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 19:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbZCHSlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 14:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbZCHSlY
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 14:41:24 -0400
Received: from poulet.zoy.org ([80.65.228.129]:53939 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbZCHSlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 14:41:23 -0400
Received: from poukram (localhost [127.0.0.1])
	by poulet.zoy.org (Postfix) with ESMTP id 39084120416
	for <git@vger.kernel.org>; Sun,  8 Mar 2009 19:41:20 +0100 (CET)
Received: by poukram (Postfix, from userid 1000)
	id 557EB7F9E5; Sun,  8 Mar 2009 19:35:33 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112629>

This is necessary if we want to send deflated data to store_object() without
keeping the original data in memory.

Signed-off-by: Sam Hocevar <sam@zoy.org>
---
 fast-import.c |   58 +++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3748ddf..6419d00 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1022,29 +1022,35 @@ static size_t encode_header(
 	return n;
 }
 
-static int store_object(
+static void sha1_object(
 	enum object_type type,
 	struct strbuf *dat,
-	struct last_object *last,
-	unsigned char *sha1out,
-	uintmax_t mark)
+	unsigned char *sha1out)
 {
-	void *out, *delta;
-	struct object_entry *e;
 	unsigned char hdr[96];
-	unsigned char sha1[20];
-	unsigned long hdrlen, deltalen;
+	unsigned long hdrlen;
 	git_SHA_CTX c;
-	z_stream s;
 
 	hdrlen = sprintf((char*)hdr,"%s %lu", typename(type),
 		(unsigned long)dat->len) + 1;
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, hdrlen);
 	git_SHA1_Update(&c, dat->buf, dat->len);
-	git_SHA1_Final(sha1, &c);
-	if (sha1out)
-		hashcpy(sha1out, sha1);
+	git_SHA1_Final(sha1out, &c);
+}
+
+static int store_object(
+	enum object_type type,
+	struct strbuf *dat,
+	struct last_object *last,
+	unsigned char *sha1,
+	uintmax_t mark)
+{
+	void *out, *delta;
+	struct object_entry *e;
+	unsigned char hdr[96];
+	unsigned long hdrlen, deltalen;
+	z_stream s;
 
 	e = insert_object(sha1);
 	if (mark)
@@ -1336,6 +1342,7 @@ static void store_tree(struct tree_entry *root)
 	}
 
 	mktree(t, 1, &new_tree);
+	sha1_object(OBJ_TREE, &new_tree, root->versions[1].sha1);
 	store_object(OBJ_TREE, &new_tree, &lo, root->versions[1].sha1, 0);
 
 	t->delta_depth = lo.depth;
@@ -1702,7 +1709,12 @@ static void parse_mark(void)
 		next_mark = 0;
 }
 
-static void parse_data(struct strbuf *sb)
+/* This actually parses a "data" command, with the addition that if sha1out
+ * is not NULL, it will also compute the sha1 on the fly. */
+static void parse_object_data(
+	enum object_type type,
+	struct strbuf *sb,
+	unsigned char *sha1out)
 {
 	strbuf_reset(sb);
 
@@ -1724,6 +1736,9 @@ static void parse_data(struct strbuf *sb)
 			strbuf_addch(sb, '\n');
 		}
 		free(term);
+
+		if(sha1out)
+			sha1_object(type, sb, sha1out);
 	}
 	else {
 		size_t n = 0, length;
@@ -1737,11 +1752,19 @@ static void parse_data(struct strbuf *sb)
 					(unsigned long)(length - n));
 			n += s;
 		}
+
+		if(sha1out)
+			sha1_object(type, sb, sha1out);
 	}
 
 	skip_optional_lf();
 }
 
+static void parse_data(struct strbuf *sb)
+{
+	parse_object_data(OBJ_NONE, sb, NULL);
+}
+
 static int validate_raw_date(const char *src, char *result, int maxlen)
 {
 	const char *orig_src = src;
@@ -1805,12 +1828,13 @@ static char *parse_ident(const char *buf)
 
 static void parse_new_blob(void)
 {
+	unsigned char sha1[20];
 	static struct strbuf buf = STRBUF_INIT;
 
 	read_next_command();
 	parse_mark();
-	parse_data(&buf);
-	store_object(OBJ_BLOB, &buf, &last_blob, NULL, next_mark);
+	parse_object_data(OBJ_BLOB, &buf, sha1);
+	store_object(OBJ_BLOB, &buf, &last_blob, sha1, next_mark);
 }
 
 static void unload_one_branch(void)
@@ -1928,7 +1952,7 @@ static void file_change_m(struct branch *b)
 			p = uq.buf;
 		}
 		read_next_command();
-		parse_data(&buf);
+		parse_object_data(OBJ_BLOB, &buf, sha1);
 		store_object(OBJ_BLOB, &buf, &last_blob, sha1, 0);
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
@@ -2211,6 +2235,7 @@ static void parse_new_commit(void)
 	free(author);
 	free(committer);
 
+	sha1_object(OBJ_COMMIT, &new_data, b->sha1);
 	if (!store_object(OBJ_COMMIT, &new_data, NULL, b->sha1, next_mark))
 		b->pack_id = pack_id;
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
@@ -2291,6 +2316,7 @@ static void parse_new_tag(void)
 	strbuf_addbuf(&new_data, &msg);
 	free(tagger);
 
+	sha1_object(OBJ_TAG, &new_data, t->sha1);
 	if (store_object(OBJ_TAG, &new_data, NULL, t->sha1, 0))
 		t->pack_id = MAX_PACK_ID;
 	else
-- 
1.6.2
