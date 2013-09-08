From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/14] pack v4 support in index-pack
Date: Sun,  8 Sep 2013 14:22:26 +0700
Message-ID: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:19:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZHY-0003Wn-C7
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab3IHHTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:19:36 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:48126 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab3IHHTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:19:35 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so4836555pbc.7
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OecbLIcR570yCbFWOF3LL2ILSO96CfYRO/w5E0T4ql8=;
        b=VP3LvE81MHZefGAAqfYfVkt2CgwCyR7Kg489pfXaXwzX/ZT7+pAi/B8DMevEfzfMkr
         dqYOXID8tJMqCSX6FcuzYJY88JCZmmihq3mscSTy5ftN4jdPtww+MCvTsUpLflVGzLlq
         8jH9TajE57SrIPkrUNZU0abxN1aruplfP+iAtZCXts96QpNdF+85ndqjTP6kqDUaPbdF
         L37wzIeBoG9ncTSIVYDSYVNiCFyJIIgreFthsMZQFzK50XrSwi1KZTrLmUBMY8CmCtVK
         kI04hvYzNafHR3IrN2iANFySH9uCloM8MM5h17UCuh5FdtoODSnib2w3Z2FqrWLa8MC+
         m3Mg==
X-Received: by 10.67.22.106 with SMTP id hr10mr50995pad.155.1378624775311;
        Sun, 08 Sep 2013 00:19:35 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id ta10sm9322034pab.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:19:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:22:43 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234197>

Mostly cleanups after Nico's comments. The diff against v2 is

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4a24bc3..88340b5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -22,8 +22,8 @@ struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;
 	unsigned int hdr_size;
-	enum object_type type;
-	enum object_type real_type;
+	enum object_type type;	/* type as written in pack */
+	enum object_type real_type; /* type after delta resolving */
 	unsigned delta_depth;
 	int base_object_no;
 	int nr_bases;		/* only valid for v4 trees */
@@ -194,8 +194,10 @@ static int mark_link(struct object *obj, int type, void *data)
 	return 0;
 }
 
-/* The content of each linked object must have been checked
-   or it must be already present in the object database */
+/*
+ * The content of each linked object must have been checked or it must
+ * be already present in the object database
+ */
 static unsigned check_object(struct object *obj)
 {
 	if (!obj)
@@ -289,6 +291,19 @@ static inline void *fill_and_use(int bytes)
 	return p;
 }
 
+static void check_against_sha1table(const unsigned char *sha1)
+{
+	const unsigned char *found;
+	if (!packv4)
+		return;
+
+	found = bsearch(sha1, sha1_table, nr_objects, 20,
+			(int (*)(const void *, const void *))hashcmp);
+	if (!found)
+		die(_("object %s not found in SHA-1 table"),
+		    sha1_to_hex(sha1));
+}
+
 static NORETURN void bad_object(unsigned long offset, const char *format,
 		       ...) __attribute__((format (printf, 2, 3)));
 
@@ -325,15 +340,8 @@ static const unsigned char *read_sha1ref(void)
 static const unsigned char *read_sha1table_ref(void)
 {
 	const unsigned char *sha1 = read_sha1ref();
-	if (sha1 < sha1_table || sha1 >= sha1_table + nr_objects * 20) {
-		unsigned char *found;
-		found = bsearch(sha1, sha1_table, nr_objects, 20,
-				(int (*)(const void *, const void *))hashcmp);
-		if (!found)
-			bad_object(consumed_bytes,
-				   _("SHA-1 %s not found in SHA-1 table"),
-				   sha1_to_hex(sha1));
-	}
+	if (sha1 < sha1_table || sha1 >= sha1_table + nr_objects * 20)
+		check_against_sha1table(sha1);
 	return sha1;
 }
 
@@ -346,21 +354,6 @@ static const unsigned char *read_dictref(struct packv4_dict *dict)
 	return  dict->data + dict->offsets[index];
 }
 
-static void *read_data(int size)
-{
-	const int max = sizeof(input_buffer);
-	void *buf;
-	char *p;
-	p = buf = xmalloc(size);
-	while (size) {
-		int to_fill = size > max ? max : size;
-		memcpy(p, fill_and_use(to_fill), to_fill);
-		p += to_fill;
-		size -= to_fill;
-	}
-	return buf;
-}
-
 static const char *open_pack_file(const char *pack_name)
 {
 	if (from_stdin) {
@@ -532,8 +525,7 @@ static void read_and_inflate(unsigned long offset,
 		git_SHA1_Final(sha1, ctx);
 }
 
-static void *unpack_commit_v4(unsigned int offset,
-			      unsigned long size,
+static void *unpack_commit_v4(unsigned int offset, unsigned long size,
 			      unsigned char *sha1)
 {
 	unsigned int nb_parents;
@@ -622,7 +614,8 @@ static void add_tree_delta_base(struct object_entry *obj,
  * v4 trees are actually kind of deltas and we don't do delta in the
  * first pass. This function only walks through a tree object to find
  * the end offset, register object dependencies and performs limited
- * validation.
+ * validation. For v4 trees that have no dependencies, we do
+ * uncompress and calculate their SHA-1.
  */
 static void *unpack_tree_v4(struct object_entry *obj,
 			    unsigned int offset, unsigned long size,
@@ -641,9 +634,9 @@ static void *unpack_tree_v4(struct object_entry *obj,
 				add_tree_delta_base(obj, last_base, delta_start);
 			} else if (!last_base)
 				bad_object(offset,
-					   _("bad copy count index in unpack_tree_v4"));
+					   _("missing delta base unpack_tree_v4"));
 			copy_count >>= 1;
-			if (!copy_count)
+			if (!copy_count || copy_count > nr)
 				bad_object(offset,
 					   _("bad copy count index in unpack_tree_v4"));
 			nr -= copy_count;
@@ -657,6 +650,13 @@ static void *unpack_tree_v4(struct object_entry *obj,
 			entry_sha1 = read_sha1ref();
 			nr--;
 
+			/*
+			 * Attempt to rebuild a canonical (base) tree.
+			 * If last_base is set, this tree depends on
+			 * another tree, which we have no access at this
+			 * stage, so reconstruction must be delayed until
+			 * the second pass.
+			 */
 			if (!last_base) {
 				const unsigned char *path;
 				unsigned mode;
@@ -694,6 +694,11 @@ static void *unpack_tree_v4(struct object_entry *obj,
 	}
 }
 
+/*
+ * Unpack an entry data in the streamed pack, calculate the object
+ * SHA-1 if it's not a large blob. Otherwise just try to inflate the
+ * object to /dev/null to determine the end of the entry in the pack.
+ */
 static void *unpack_entry_data(struct object_entry *obj, unsigned char *sha1)
 {
 	static char fixed_buf[8192];
@@ -799,19 +804,23 @@ static void *unpack_raw_entry(struct object_entry *obj,
 	return data;
 }
 
+/*
+ * Some checks are skipped because they are already done by
+ * unpack_tree_v4() in the first pass.
+ */
 static void *patch_one_base_tree(const struct object_entry *src,
 				 const unsigned char *src_buf,
 				 const unsigned char *delta_buf,
 				 unsigned long delta_size,
 				 unsigned long *dst_size)
 {
-	unsigned int nr;
+	int nr;
 	const unsigned char *last_base = NULL;
 	struct strbuf sb = STRBUF_INIT;
 	const unsigned char *p = delta_buf;
 
 	nr = decode_varint(&p);
-	while (nr && p < delta_buf + delta_size) {
+	while (nr > 0 && p < delta_buf + delta_size) {
 		unsigned int copy_start_or_path = decode_varint(&p);
 		if (copy_start_or_path & 1) { /* copy_start */
 			struct tree_desc desc;
@@ -829,11 +838,9 @@ static void *patch_one_base_tree(const struct object_entry *src,
 					last_base = sha1_table + (id - 1) * 20;
 				if (hashcmp(last_base, src->idx.sha1))
 					die(_("bad tree base in patch_one_base_tree"));
-			} else if (!last_base)
-				die(_("bad copy count index in patch_one_base_tree"));
+			}
+
 			copy_count >>= 1;
-			if (!copy_count)
-				die(_("bad copy count index in patch_one_base_tree"));
 			nr -= copy_count;
 
 			init_tree_desc(&desc, src_buf, src->size);
@@ -841,7 +848,8 @@ static void *patch_one_base_tree(const struct object_entry *src,
 				if (copy_start)
 					copy_start--;
 				else if (copy_count) {
-					strbuf_addf(&sb, "%o %s%c", entry.mode, entry.path, '\0');
+					strbuf_addf(&sb, "%o %s%c",
+						    entry.mode, entry.path, '\0');
 					strbuf_add(&sb, entry.sha1, 20);
 					copy_count--;
 				} else
@@ -854,8 +862,6 @@ static void *patch_one_base_tree(const struct object_entry *src,
 			unsigned int id;
 			const unsigned char *entry_sha1;
 
-			if (path_idx >= path_dict->nb_entries)
-				die(_("bad path index in unpack_tree_v4"));
 			id = decode_varint(&p);
 			if (!id) {
 				entry_sha1 = p;
@@ -876,6 +882,11 @@ static void *patch_one_base_tree(const struct object_entry *src,
 	return sb.buf;
 }
 
+/*
+ * Unpack entry data in the second pass when the pack is already
+ * stored on disk. consume call back is used for large-blob case. Must
+ * be thread safe.
+ */
 static void *unpack_data(struct object_entry *obj,
 			 int (*consume)(const unsigned char *, unsigned long, void *),
 			 void *cb_data)
@@ -1079,19 +1090,6 @@ static int check_collison(struct object_entry *entry)
 	return 0;
 }
 
-static void check_against_sha1table(struct object_entry *obj)
-{
-	const unsigned char *found;
-	if (!packv4)
-		return;
-
-	found = bsearch(obj->idx.sha1, sha1_table, nr_objects, 20,
-			(int (*)(const void *, const void *))hashcmp);
-	if (!found)
-		die(_("object %s not found in SHA-1 table"),
-		    sha1_to_hex(obj->idx.sha1));
-}
-
 static void sha1_object(const void *data, struct object_entry *obj_entry,
 			unsigned long size, enum object_type type,
 			const unsigned char *sha1)
@@ -1288,7 +1286,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_sha1_file(result->data, result->size,
 		       typename(delta_obj->real_type), delta_obj->idx.sha1);
-	check_against_sha1table(delta_obj);
+	check_against_sha1table(delta_obj->idx.sha1);
 	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
 		    delta_obj->idx.sha1);
 	counter_lock();
@@ -1296,6 +1294,11 @@ static void resolve_delta(struct object_entry *delta_obj,
 	counter_unlock();
 }
 
+/*
+ * Given a base object, search for all objects depending on the base,
+ * try to unpack one of those object. The function will be called
+ * repeatedly until all objects are unpacked.
+ */
 static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 						  struct base_data *prev_base)
 {
@@ -1408,6 +1411,10 @@ static int compare_delta_entry(const void *a, const void *b)
 				   objects[delta_b->obj_no].type);
 }
 
+/*
+ * Unpack all objects depending directly or indirectly on the given
+ * object
+ */
 static void resolve_base(struct object_entry *obj)
 {
 	struct base_data *base_obj = alloc_base_data();
@@ -1417,6 +1424,7 @@ static void resolve_base(struct object_entry *obj)
 }
 
 #ifndef NO_PTHREADS
+/* Call resolve_base() in multiple threads */
 static void *threaded_second_pass(void *data)
 {
 	set_thread_data(data);
@@ -1460,10 +1468,19 @@ static struct packv4_dict *read_dict(void)
 
 static void parse_dictionaries(void)
 {
+	int i;
 	if (!packv4)
 		return;
 
-	sha1_table = read_data(20 * nr_objects);
+	sha1_table = xmalloc(20 * nr_objects);
+	hashcpy(sha1_table, fill_and_use(20));
+	for (i = 1; i < nr_objects; i++) {
+		unsigned char *p = sha1_table + i * 20;
+		hashcpy(p, fill_and_use(20));
+		if (hashcmp(p - 20, p) >= 0)
+			die(_("wrong order in SHA-1 table at entry %d"), i);
+	}
+
 	name_dict = read_dict();
 	path_dict = read_dict();
 }
@@ -1492,9 +1509,9 @@ static void parse_pack_objects(unsigned char *sha1)
 			/* large blobs, check later */
 			obj->real_type = OBJ_BAD;
 			nr_delays++;
-			check_against_sha1table(obj);
+			check_against_sha1table(obj->idx.sha1);
 		} else {
-			check_against_sha1table(obj);
+			check_against_sha1table(obj->idx.sha1);
 			sha1_object(data, NULL, obj->size, obj->real_type,
 				    obj->idx.sha1);
 		}
@@ -2137,14 +2154,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	free(index_name_buf);
 	free(keep_name_buf);
 	free(sha1_table);
-	if (name_dict) {
-		free((void*)name_dict->data);
-		free(name_dict);
-	}
-	if (path_dict) {
-		free((void*)path_dict->data);
-		free(path_dict);
-	}
+	pv4_free_dict(name_dict);
+	pv4_free_dict(path_dict);
 	if (pack_name == NULL)
 		free((void *) curr_pack);
 	if (index_name == NULL)
diff --git a/packv4-parse.c b/packv4-parse.c
index 82661ba..d515bb9 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -63,6 +63,14 @@ struct packv4_dict *pv4_create_dict(const unsigned char *data, int dict_size)
 	return dict;
 }
 
+void pv4_free_dict(struct packv4_dict *dict)
+{
+	if (dict) {
+		free((void*)dict->data);
+		free(dict);
+	}
+}
+
 static struct packv4_dict *load_dict(struct packed_git *p, off_t *offset)
 {
 	struct pack_window *w_curs = NULL;
diff --git a/packv4-parse.h b/packv4-parse.h
index 0b2405a..e6719f6 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -8,6 +8,7 @@ struct packv4_dict {
 };
 
 struct packv4_dict *pv4_create_dict(const unsigned char *data, int dict_size);
+void pv4_free_dict(struct packv4_dict *dict);
 
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 		     off_t offset, unsigned long size);
diff --git a/sha1_file.c b/sha1_file.c
index c7bf677..1528e28 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -763,6 +763,8 @@ void free_pack_by_name(const char *pack_name)
 			}
 			close_pack_index(p);
 			free(p->bad_object_sha1);
+			pv4_free_dict(p->ident_dict);
+			pv4_free_dict(p->path_dict);
 			*pp = p->next;
 			if (last_found_pack == p)
 				last_found_pack = NULL;
