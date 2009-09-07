From: "Nick Edelen" <sirnot@gmail.com>
Subject: Re: [PATCH 6/6 (v4)] support for path name caching in rev-cache
Date: Mon, 07 Sep 2009 16:11:06 +0200
Message-ID: <op.uzv4cs0rtdk399@sirnot.private>
References: <op.uys3qwlmtdk399@sirnot.private>
 <op.uyuwkwjotdk399@sirnot.private> <op.uyzwyho5tdk399@sirnot>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Nick Edelen" <sirnot@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.n
X-From: git-owner@vger.kernel.org Mon Sep 07 16:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkewP-0002vs-AI
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 16:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbZIGOLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 10:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbZIGOLP
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 10:11:15 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:51136 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbZIGOLN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 10:11:13 -0400
Received: by mail-fx0-f217.google.com with SMTP id 17so2011808fxm.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:references:content-transfer-encoding
         :message-id:in-reply-to:user-agent;
        bh=HS2BTxHRbCufS3A3wQKAYJ38KQ7BuWAcGM3kj0ungU0=;
        b=HjZFhA5zBp67E82VFfTov5oxEq5cNL3NiCc7i+00OZXotr/47khnTJdNPqtdKE3iBa
         fyoXCOO/74Z6KxAaTA4wRElK03A0rL1Xf6xp5fr3OFIgsdSwJHZgCPxDUZ+YOA3HVs1m
         7jCwtfNzonkOPI+yo7IT3HoCUDAxTpicat/GE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version:references
         :content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=ny6/4k+2XX0zWod1OQMSx22s9n/UI++sS7pcCW1LOmaoFDE6cYozfiBwtDRv4S/Uui
         kt7BqUPBhn45mfNDN81wDLEl0hYiOW1cxP9z7iK6VGF5p9l5Tz1wtAAq01lWY3Isb6id
         E2M/dizQjUjD8TFsbThif1KNFk3UAJeDVPN1Q=
Received: by 10.103.144.22 with SMTP id w22mr6191727mun.52.1252332671475;
        Mon, 07 Sep 2009 07:11:11 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id u26sm11807271mug.53.2009.09.07.07.11.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Sep 2009 07:11:08 -0700 (PDT)
In-Reply-To: <op.uyzwyho5tdk399@sirnot>
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127930>

An update to caching mechanism, allowing path names to be cached for blob and 
tree objects.  A list of names appearing in each cache slice is appended to the 
end of the slice, which is referenced by variable-sized indexes per entry.  
This allows pack-objects to more intelligently schedule unpacked/poorly packed 
object, and enables proper duplication of rev-list's behaivor.

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
 builtin-rev-cache.c       |    3 +-
 rev-cache.c               |  331 +++++++++++++++++++++++++++++++++++++--------
 rev-cache.h               |   16 ++-
 revision.h                |    6 +-
 t/t6017-rev-cache-list.sh |    8 +-
 5 files changed, 299 insertions(+), 65 deletions(-)

diff --git a/builtin-rev-cache.c b/builtin-rev-cache.c
index 8f41123..4c1766d 100644
--- a/builtin-rev-cache.c
+++ b/builtin-rev-cache.c
@@ -177,13 +177,14 @@ static int handle_walk(int argc, const char *argv[])
 	fprintf(stderr, "pending:\n");
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object *obj = revs.pending.objects[i].item;
+		const char *name = revs.pending.objects[i].name;
 
 		/* unfortunately, despite our careful generation, object duplication *is* a possibility...
 		 * (eg. same object introduced into two different branches) */
 		if (obj->flags & SEEN)
 			continue;
 
-		printf("%s\n", sha1_to_hex(revs.pending.objects[i].item->sha1));
+		printf("%s %s\n", sha1_to_hex(revs.pending.objects[i].item->sha1), name);
 		obj->flags |= SEEN;
 	}
 
diff --git a/rev-cache.c b/rev-cache.c
index 6becd4b..3595f66 100644
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -17,6 +17,14 @@ struct bad_slice {
 	struct bad_slice *next;
 };
 
+struct name_list {
+	unsigned char sha1[20];
+	unsigned int len;
+	struct name_list *next;
+
+	char buf[FLEX_ARRAY];
+};
+
 struct cache_slice_pointer {
 	char signature[8]; /* REVCOPTR */
 	char version;
@@ -29,10 +37,13 @@ static uint32_t fanout[0xff + 2];
 static unsigned char *idx_map;
 static int idx_size;
 static struct rc_index_header idx_head;
-static char no_idx, add_to_pending;
-static struct bad_slice *bad_slices;
+static char no_idx, add_to_pending, add_names;
 static unsigned char *idx_caches;
 
+static struct bad_slice *bad_slices;
+static struct name_list *name_lists, *cur_name_list;
+
+static struct strbuf *acc_name_buffer;
 static struct strbuf *acc_buffer;
 
 #define SLOP			5
@@ -79,7 +90,7 @@ struct rc_object_entry *from_disked_rc_object_entry(struct rc_object_entry_ondis
 	if (!dst)
 		dst = &entry[cur++ & 0x3];
 
-	dst->type = src->flags >> 5;
+	dst->type = src->flags >> 5 & 0x03;
 	dst->is_end = !!(src->flags & 0x10);
 	dst->is_start = !!(src->flags & 0x08);
 	dst->uninteresting = !!(src->flags & 0x04);
@@ -90,8 +101,9 @@ struct rc_object_entry *from_disked_rc_object_entry(struct rc_object_entry_ondis
 	dst->merge_nr = src->merge_nr;
 	dst->split_nr = src->split_nr;
 
-	dst->size_size = src->sizes >> 5;
-	dst->padding = src->sizes & 0x1f;
+	dst->size_size = src->sizes >> 5 & 0x03;
+	dst->name_size = src->sizes >> 2 & 0x03;
+	dst->padding = src->sizes & 0x02;
 
 	dst->date = ntohl(src->date);
 	dst->path = ntohs(src->path);
@@ -120,6 +132,7 @@ struct rc_object_entry_ondisk *to_disked_rc_object_entry(struct rc_object_entry
 	dst->split_nr = src->split_nr;
 
 	dst->sizes  = (unsigned char)src->size_size << 5;
+	dst->sizes |= (unsigned char)src->name_size << 2;
 	dst->sizes |= (unsigned char)src->padding;
 
 	dst->date = htonl(src->date);
@@ -192,6 +205,12 @@ static void cleanup_cache_slices(void)
 		idx_map = 0;
 	}
 
+	while (name_lists) {
+		struct name_list *nl = name_lists->next;
+		free(name_lists);
+		name_lists = nl;
+	}
+
 }
 
 static int init_index(void)
@@ -324,7 +343,7 @@ static void handle_noncommit(struct rev_info *revs, struct commit *commit, unsig
 	struct blob *blob;
 	struct tree *tree;
 	struct object *obj;
-	unsigned long size;
+	unsigned long size, name_index;
 
 	size = decode_size(ptr + RC_ENTRY_SIZE_OFFSET(entry), entry->size_size);
 	switch (entry->type) {
@@ -357,9 +376,22 @@ static void handle_noncommit(struct rev_info *revs, struct commit *commit, unsig
 		return;
 	}
 
+	if (add_names && cur_name_list) {
+		name_index = decode_size(ptr + RC_ENTRY_NAME_OFFSET(entry), entry->name_size);
+
+		if (name_index >= cur_name_list->len)
+			name_index = 0;
+	} else name_index = 0;
+
 	obj->flags |= FACE_VALUE;
-	if (add_to_pending)
-		add_pending_object(revs, obj, "");
+	if (add_to_pending) {
+		char *name = "";
+
+		if (name_index)
+			name = cur_name_list->buf + name_index;
+
+		add_pending_object(revs, obj, name);
+	}
 }
 
 static int setup_traversal(struct rc_slice_header *head, unsigned char *map, struct commit *commit, struct commit_list **work,
@@ -714,15 +746,44 @@ end:
 	return retval;
 }
 
-static int get_cache_slice_header(unsigned char *cache_sha1, unsigned char *map, int len, struct rc_slice_header *head)
+static struct name_list *get_cache_slice_name_list(struct rc_slice_header *head, int fd)
+{
+	struct name_list *nl = name_lists;
+
+	while (nl) {
+		if (!hashcmp(nl->sha1, head->sha1))
+			break;
+		nl = nl->next;
+	}
+
+	if (nl)
+		return nl;
+
+	nl = xcalloc(1, sizeof(struct name_list) + head->name_size);
+	nl->len = head->name_size;
+	hashcpy(nl->sha1, head->sha1);
+
+	lseek(fd, head->size, SEEK_SET);
+	read_in_full(fd, nl->buf, head->name_size);
+
+	nl->next = name_lists;
+	name_lists = nl;
+
+	return nl;
+}
+
+static int get_cache_slice_header(int fd, unsigned char *cache_sha1, int len, struct rc_slice_header *head)
 {
 	int t;
 
-	memcpy(head, map, sizeof(struct rc_slice_header));
+	if (xread(fd, head, sizeof(struct rc_slice_header)) != sizeof(struct rc_slice_header))
+		return -1;
+
 	head->ofs_objects = ntohl(head->ofs_objects);
 	head->object_nr = ntohl(head->object_nr);
 	head->size = ntohl(head->size);
 	head->path_nr = ntohs(head->path_nr);
+	head->name_size = ntohl(head->name_size);
 
 	if (memcmp(head->signature, "REVCACHE", 8))
 		return -1;
@@ -731,10 +792,10 @@ static int get_cache_slice_header(unsigned char *cache_sha1, unsigned char *map,
 	if (hashcmp(head->sha1, cache_sha1))
 		return -3;
 	t = sizeof(struct rc_slice_header);
-	if (t != head->ofs_objects || t >= len)
+	if (t != head->ofs_objects)
 		return -4;
-
-	head->size = len;
+	if (head->size + head->name_size != len)
+		return -5;
 
 	return 0;
 }
@@ -786,7 +847,7 @@ int traverse_cache_slice(struct rev_info *revs,
 	unsigned long *date_so_far, int *slop_so_far,
 	struct commit_list ***queue, struct commit_list **work)
 {
-	int fd = -1, retval = -3;
+	int fd = -1, t, retval;
 	struct stat fi;
 	struct rc_slice_header head;
 	struct rev_cache_info *rci;
@@ -802,26 +863,31 @@ int traverse_cache_slice(struct rev_info *revs,
 	/* load options */
 	rci = &revs->rev_cache_info;
 	add_to_pending = rci->add_to_pending;
+	add_names = rci->add_names;
 
 	memset(&head, 0, sizeof(struct rc_slice_header));
+#	define ERROR(x)		do { retval = (x); goto end; } while (0);
 
 	fd = open_cache_slice(cache_sha1, O_RDONLY);
 	if (fd == -1)
-		goto end;
+		ERROR(-1);
 	if (fstat(fd, &fi) || fi.st_size < sizeof(struct rc_slice_header))
-		goto end;
+		ERROR(-2);
+
+	if ((t = get_cache_slice_header(fd, cache_sha1, fi.st_size, &head)) < 0)
+		ERROR(-t);
+	if (add_names)
+		cur_name_list = get_cache_slice_name_list(&head, fd);
 
-	map = xmmap(0, fi.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	map = xmmap(0, head.size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (map == MAP_FAILED)
-		goto end;
-	if (get_cache_slice_header(cache_sha1, map, fi.st_size, &head))
-		goto end;
+		ERROR(-3);
 
 	retval = traverse_cache_slice_1(&head, map, revs, commit, date_so_far, slop_so_far, queue, work);
 
 end:
 	if (map != MAP_FAILED)
-		munmap(map, fi.st_size);
+		munmap(map, head.size);
 	if (fd != -1)
 		close(fd);
 
@@ -829,6 +895,7 @@ end:
 	if (retval)
 		mark_bad_slice(cache_sha1);
 
+#	undef ERROR
 	return retval;
 }
 
@@ -1113,23 +1180,110 @@ static unsigned long decode_size(unsigned char *str, int len)
 	return size;
 }
 
+
+#define NL_HASH_TABLE_SIZE		(0xffff + 1)
+#define NL_HASH_NUMBER			(NL_HASH_TABLE_SIZE >> 3)
+
+struct name_list_hash {
+	int ind;
+	struct name_list_hash *next;
+};
+
+static struct name_list_hash **nl_hash_table;
+static unsigned char *nl_hashes;
+
+/* FNV-1a hash */
+static unsigned int hash_name(const char *name)
+{
+	unsigned int hash = 2166136261ul;
+	const char *p = name;
+
+	while (*p) {
+		hash ^= *p++;
+		hash *= 16777619ul;
+	}
+
+	return hash & 0xffff;
+}
+
+static int name_in_list(const char *name)
+{
+	unsigned int h = hash_name(name);
+	struct name_list_hash *entry = nl_hash_table[h];
+
+	while (entry && strcmp(acc_name_buffer->buf + entry->ind, name))
+		entry = entry->next;
+
+	if (entry)
+		return entry->ind;
+
+	/* add name to buffer and create hash reference */
+	entry = xcalloc(1, sizeof(struct name_list_hash));
+	entry->ind = acc_name_buffer->len;
+	strbuf_add(acc_name_buffer, name, strlen(name) + 1);
+
+	entry->next = nl_hash_table[h];
+	nl_hash_table[h] = entry;
+
+	nl_hashes[h / 8] |= h % 8;
+
+	return entry->ind;
+}
+
+static void init_name_list_hash(void)
+{
+	nl_hash_table = xcalloc(NL_HASH_TABLE_SIZE, sizeof(struct name_list_hash));
+	nl_hashes = xcalloc(NL_HASH_NUMBER, 1);
+}
+
+static void cleanup_name_list_hash(void)
+{
+	int i;
+
+	for (i = 0; i < NL_HASH_NUMBER; i++) {
+		int j, ind = nl_hashes[i];
+
+		if (!ind)
+			continue;
+
+		for (j = 0; j < 8; j++) {
+			struct name_list_hash **entryp;
+
+			if (!(ind & 1 << j))
+				continue;
+
+			entryp = &nl_hash_table[i * 8 + j];
+			while (*entryp) {
+				struct name_list_hash *t = (*entryp)->next;
+
+				free(*entryp);
+				*entryp = t;
+			}
+		}
+	} /* code overhang! */
+
+	free(nl_hashes);
+	free(nl_hash_table);
+}
+
 static void add_object_entry(const unsigned char *sha1, struct rc_object_entry *entryp,
-	struct strbuf *merge_str, struct strbuf *split_str)
+	struct strbuf *merge_str, struct strbuf *split_str, char *name, unsigned long size)
 {
 	struct rc_object_entry entry;
-	unsigned char size_str[7];
-	unsigned long size;
+	unsigned char size_str[7], name_str[7];
 	enum object_type type;
 	void *data;
 
 	if (entryp)
 		sha1 = entryp->sha1;
 
-	/* retrieve size data */
-	data = read_sha1_file(sha1, &type, &size);
+	if (!size) {
+		/* retrieve size data */
+		data = read_sha1_file(sha1, &type, &size);
 
-	if (data)
-		free(data);
+		if (data)
+			free(data);
+	}
 
 	/* initialize! */
 	if (!entryp) {
@@ -1147,6 +1301,9 @@ static void add_object_entry(const unsigned char *sha1, struct rc_object_entry *
 
 	entryp->size_size = encode_size(size, size_str);
 
+	if (name)
+		entryp->name_size = encode_size(name_in_list(name), name_str);
+
 	/* write the muvabitch */
 	strbuf_add(acc_buffer, to_disked_rc_object_entry(entryp, 0), sizeof(struct rc_object_entry_ondisk));
 
@@ -1156,25 +1313,36 @@ static void add_object_entry(const unsigned char *sha1, struct rc_object_entry *
 		strbuf_add(acc_buffer, split_str->buf, split_str->len);
 
 	strbuf_add(acc_buffer, size_str, entryp->size_size);
+
+	if (name)
+		strbuf_add(acc_buffer, name_str, entryp->name_size);
 }
 
 /* returns non-zero to continue parsing, 0 to skip */
 typedef int (*dump_tree_fn)(const unsigned char *, const char *, unsigned int); /* sha1, path, mode */
 
 /* we need to walk the trees by hash, so unfortunately we can't use traverse_trees in tree-walk.c */
-static int dump_tree(struct tree *tree, dump_tree_fn fn)
+static int dump_tree(struct tree *tree, dump_tree_fn fn, char *base)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct tree *subtree;
-	int r;
+	char concatpath[PATH_MAX];
+	int r, baselen;
 
 	if (parse_tree(tree))
 		return -1;
 
+	baselen = strlen(base);
+	strcpy(concatpath, base);
+
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
-		switch (fn(entry.sha1, entry.path, entry.mode)) {
+		if (baselen + strlen(entry.path) + 1 >= PATH_MAX)
+			die("we have a problem: %s%s is too big for me to handle", base, entry.path);
+		strcpy(concatpath + baselen, entry.path);
+
+		switch (fn(entry.sha1, concatpath, entry.mode)) {
 		case 0 :
 			goto continue_loop;
 		default :
@@ -1186,7 +1354,8 @@ static int dump_tree(struct tree *tree, dump_tree_fn fn)
 			if (!subtree)
 				return -2;
 
-			if ((r = dump_tree(subtree, fn)) < 0)
+			strcat(concatpath, "/");
+			if ((r = dump_tree(subtree, fn, concatpath)) < 0)
 				return r;
 		}
 
@@ -1200,6 +1369,9 @@ continue_loop:
 static int dump_tree_callback(const unsigned char *sha1, const char *path, unsigned int mode)
 {
 	strbuf_add(acc_buffer, sha1, 20);
+	strbuf_add(acc_buffer, (char *)&acc_name_buffer->len, sizeof(size_t));
+
+	strbuf_add(acc_name_buffer, path, strlen(path) + 1);
 
 	return 1;
 }
@@ -1213,6 +1385,9 @@ static void tree_addremove(struct diff_options *options,
 		return;
 
 	strbuf_add(acc_buffer, sha1, 20);
+	strbuf_add(acc_buffer, (char *)&acc_name_buffer->len, sizeof(size_t));
+
+	strbuf_add(acc_name_buffer, concatpath, strlen(concatpath) + 1);
 }
 
 static void tree_change(struct diff_options *options,
@@ -1225,12 +1400,15 @@ static void tree_change(struct diff_options *options,
 		return;
 
 	strbuf_add(acc_buffer, new_sha1, 20);
+	strbuf_add(acc_buffer, (char *)&acc_name_buffer->len, sizeof(size_t));
+
+	strbuf_add(acc_name_buffer, concatpath, strlen(concatpath) + 1);
 }
 
 static int add_unique_objects(struct commit *commit)
 {
 	struct commit_list *list;
-	struct strbuf os, ost, *orig_buf;
+	struct strbuf os, ost, names, *orig_name_buf, *orig_buf;
 	struct diff_options opts;
 	int i, j, next;
 	char is_first = 1;
@@ -1238,13 +1416,17 @@ static int add_unique_objects(struct commit *commit)
 	/* ...no, calculate unique objects */
 	strbuf_init(&os, 0);
 	strbuf_init(&ost, 0);
+	strbuf_init(&names, 0);
 	orig_buf = acc_buffer;
+	orig_name_buf = acc_name_buffer;
+	acc_name_buffer = &names;
 
 	diff_setup(&opts);
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	DIFF_OPT_SET(&opts, TREE_IN_RECURSIVE);
 	opts.change = tree_change;
 	opts.add_remove = tree_addremove;
+#	define ENTRY_SIZE (20 + sizeof(size_t))
 
 	/* this is only called for non-ends (ie. all parents interesting) */
 	for (list = commit->parents; list; list = list->next) {
@@ -1255,20 +1437,20 @@ static int add_unique_objects(struct commit *commit)
 
 		strbuf_setlen(acc_buffer, 0);
 		diff_tree_sha1(list->item->tree->object.sha1, commit->tree->object.sha1, "", &opts);
-		qsort(acc_buffer->buf, acc_buffer->len / 20, 20, (int (*)(const void *, const void *))hashcmp);
+		qsort(acc_buffer->buf, acc_buffer->len / ENTRY_SIZE, ENTRY_SIZE, (int (*)(const void *, const void *))hashcmp);
 
 		/* take intersection */
 		if (!is_first) {
-			for (next = i = j = 0; i < os.len; i += 20) {
+			for (next = i = j = 0; i < os.len; i += ENTRY_SIZE) {
 				while (j < ost.len && hashcmp((unsigned char *)(ost.buf + j), (unsigned char *)(os.buf + i)) < 0)
-					j += 20;
+					j += ENTRY_SIZE;
 
 				if (j >= ost.len || hashcmp((unsigned char *)(ost.buf + j), (unsigned char *)(os.buf + i)))
 					continue;
 
 				if (next != i)
-					memcpy(os.buf + next, os.buf + i, 20);
-				next += 20;
+					memcpy(os.buf + next, os.buf + i, ENTRY_SIZE);
+				next += ENTRY_SIZE;
 			}
 
 			if (next != i)
@@ -1280,29 +1462,37 @@ static int add_unique_objects(struct commit *commit)
 	/* no parents (!) */
 	if (is_first) {
 		acc_buffer = &os;
-		dump_tree(commit->tree, dump_tree_callback);
+		dump_tree(commit->tree, dump_tree_callback, "");
 	}
 
 	/* the ordering of non-commit objects dosn't really matter, so we're not gonna bother */
 	acc_buffer = orig_buf;
-	for (i = 0; i < os.len; i += 20)
-		add_object_entry((unsigned char *)(os.buf + i), 0, 0, 0);
+	acc_name_buffer = orig_name_buf;
+	for (i = 0; i < os.len; i += ENTRY_SIZE)
+		add_object_entry((unsigned char *)(os.buf + i), 0, 0, 0, names.buf + *(size_t *)(os.buf + i + 20), 0);
 
 	/* last but not least, the main tree */
-	add_object_entry(commit->tree->object.sha1, 0, 0, 0);
+	add_object_entry(commit->tree->object.sha1, 0, 0, 0, 0, 0);
 
-	return i / 20 + 1;
+	strbuf_release(&ost);
+	strbuf_release(&os);
+	strbuf_release(&names);
+
+	return i / ENTRY_SIZE + 1;
+#	undef ENTRY_SIZE
 }
 
 static int add_objects_verbatim_1(struct rev_cache_slice_map *mapping, int *index)
 {
-	unsigned char *map = mapping->map;
 	int i = *index, object_nr = 0;
+	unsigned char *map = mapping->map;
 	struct rc_object_entry *entry = RC_OBTAIN_OBJECT_ENTRY(map + i);
+	unsigned long size;
 
 	i += RC_ACTUAL_OBJECT_ENTRY_SIZE(entry);
 	while (i < mapping->size) {
-		int pos = i;
+		char *name;
+		int name_index, pos = i;
 
 		entry = RC_OBTAIN_OBJECT_ENTRY(map + i);
 		i += RC_ACTUAL_OBJECT_ENTRY_SIZE(entry);
@@ -1312,7 +1502,15 @@ static int add_objects_verbatim_1(struct rev_cache_slice_map *mapping, int *inde
 			return object_nr;
 		}
 
-		strbuf_add(acc_buffer, map + pos, i - pos);
+		name_index = decode_size(map + pos + RC_ENTRY_NAME_OFFSET(entry), entry->name_size);
+		if (name_index && name_index < mapping->name_size)
+			name = mapping->names + name_index;
+		else
+			name = 0;
+
+		size = decode_size(map + pos + RC_ENTRY_SIZE_OFFSET(entry), entry->size_size);
+
+		add_object_entry(0, entry, 0, 0, name, size);
 		object_nr++;
 	}
 
@@ -1397,6 +1595,7 @@ void init_rev_cache_info(struct rev_cache_info *rci)
 	rci->overwrite_all = 0;
 
 	rci->add_to_pending = 1;
+	rci->add_names = 1;
 
 	rci->ignore_size = 0;
 }
@@ -1421,9 +1620,9 @@ int make_cache_slice(struct rev_cache_info *rci,
 	struct rc_slice_header head;
 	struct commit *commit;
 	unsigned char sha1[20];
-	struct strbuf merge_paths, split_paths;
+	struct strbuf merge_paths, split_paths, namelist;
 	int object_nr, total_sz, fd;
-	char file[PATH_MAX], *newfile;
+	char file[PATH_MAX], null, *newfile;
 	struct rev_cache_info *trci;
 	git_SHA_CTX ctx;
 
@@ -1438,7 +1637,13 @@ int make_cache_slice(struct rev_cache_info *rci,
 	strbuf_init(&endlist, 0);
 	strbuf_init(&merge_paths, 0);
 	strbuf_init(&split_paths, 0);
+	strbuf_init(&namelist, 0);
 	acc_buffer = &buffer;
+	acc_name_buffer = &namelist;
+
+	null = 0;
+	strbuf_add(&namelist, &null, 1);
+	init_name_list_hash();
 
 	if (!revs) {
 		revs = &therevs;
@@ -1469,6 +1674,7 @@ int make_cache_slice(struct rev_cache_info *rci,
 	trci = &revs->rev_cache_info;
 	init_rev_cache_info(trci);
 	trci->add_to_pending = 0;
+	trci->add_names = 0;
 
 	setup_revisions(0, 0, revs, 0);
 	if (prepare_revision_walk(revs))
@@ -1506,7 +1712,7 @@ int make_cache_slice(struct rev_cache_info *rci,
 
 		commit->indegree = 0;
 
-		add_object_entry(0, &object, &merge_paths, &split_paths);
+		add_object_entry(0, &object, &merge_paths, &split_paths, 0, 0);
 		object_nr++;
 
 		if (rci->objects && !object.is_end) {
@@ -1532,10 +1738,16 @@ int make_cache_slice(struct rev_cache_info *rci,
 		total_sz += buffer.len;
 	}
 
+	/* write path name lookup list */
+	head.name_size = htonl(namelist.len);
+	write_in_full(fd, namelist.buf, namelist.len);
+
 	/* go ahead a free some stuff... */
 	strbuf_release(&buffer);
 	strbuf_release(&merge_paths);
 	strbuf_release(&split_paths);
+	strbuf_release(&namelist);
+	cleanup_name_list_hash();
 	if (path_sz)
 		free(paths);
 	while (path_track_alloc)
@@ -1993,6 +2205,7 @@ int fuse_cache_slices(struct rev_cache_info *rci, struct rev_info *revs)
 	for (i = idx_head.cache_nr - 1; i >= 0; i--) {
 		struct rev_cache_slice_map *map = rci->maps + i;
 		struct stat fi;
+		struct rc_slice_header head;
 		int fd;
 
 		if (!map->size)
@@ -2005,13 +2218,20 @@ int fuse_cache_slices(struct rev_cache_info *rci, struct rev_info *revs)
 			continue;
 		if (fi.st_size < sizeof(struct rc_slice_header))
 			continue;
+		if (get_cache_slice_header(fd, idx_caches + i * 20, fi.st_size, &head))
+			continue;
 
-		map->map = xmmap(0, fi.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		map->map = xmmap(0, head.size, PROT_READ, MAP_PRIVATE, fd, 0);
 		if (map->map == MAP_FAILED)
 			continue;
 
+		lseek(fd, head.size, SEEK_SET);
+		map->names = xcalloc(head.name_size, 1);
+		read_in_full(fd, map->names, head.name_size);
+
 		close(fd);
-		map->size = fi.st_size;
+		map->size = head.size;
+		map->name_size = head.name_size;
 	}
 
 	rci->make_index = 0;
@@ -2028,6 +2248,7 @@ int fuse_cache_slices(struct rev_cache_info *rci, struct rev_info *revs)
 		if (!map->size)
 			continue;
 
+		free(map->names);
 		munmap(map->map, map->size);
 	}
 	free(rci->maps);
@@ -2049,7 +2270,6 @@ static int verify_cache_slice(const char *slice_path, unsigned char *sha1)
 {
 	struct rc_slice_header head;
 	int fd, len, retval = -1;
-	unsigned char *map = MAP_FAILED;
 	struct stat fi;
 
 	len = strlen(slice_path);
@@ -2064,17 +2284,12 @@ static int verify_cache_slice(const char *slice_path, unsigned char *sha1)
 	if (fstat(fd, &fi) || fi.st_size < sizeof(head))
 		goto end;
 
-	map = xmmap(0, sizeof(head), PROT_READ, MAP_PRIVATE, fd, 0);
-	if (map == MAP_FAILED)
-		goto end;
-	if (get_cache_slice_header(sha1, map, fi.st_size, &head))
+	if (get_cache_slice_header(fd, sha1, fi.st_size, &head))
 		goto end;
 
 	retval = 0;
 
 end:
-	if (map != MAP_FAILED)
-		munmap(map, sizeof(head));
 	if (fd > 0)
 		close(fd);
 
diff --git a/rev-cache.h b/rev-cache.h
index 14437d8..c88ceae 100644
--- a/rev-cache.h
+++ b/rev-cache.h
@@ -10,8 +10,14 @@
 #define RC_OBTAIN_OBJECT_ENTRY(p)			from_disked_rc_object_entry((struct rc_object_entry_ondisk *)(p), 0)
 #define RC_OBTAIN_INDEX_ENTRY(p)			from_disked_rc_index_entry((struct rc_index_entry_ondisk *)(p), 0)
 
-#define RC_ACTUAL_OBJECT_ENTRY_SIZE(e)		(sizeof(struct rc_object_entry_ondisk) + RC_PATH_SIZE((e)->merge_nr + (e)->split_nr) + (e)->size_size)
-#define RC_ENTRY_SIZE_OFFSET(e)				(RC_ACTUAL_OBJECT_ENTRY_SIZE(e) - (e)->size_size)
+#define RC_ACTUAL_OBJECT_ENTRY_SIZE(e)	(\
+	sizeof(struct rc_object_entry_ondisk) + \
+	RC_PATH_SIZE((e)->merge_nr + (e)->split_nr) + \
+	(e)->size_size + \
+	(e)->name_size\
+)
+#define RC_ENTRY_SIZE_OFFSET(e)			(RC_ACTUAL_OBJECT_ENTRY_SIZE(e) - (e)->name_size - (e)->size_size)
+#define RC_ENTRY_NAME_OFFSET(e)			(RC_ACTUAL_OBJECT_ENTRY_SIZE(e) - (e)->name_size)
 
 /* single index maps objects to cache files */
 struct rc_index_header {
@@ -50,6 +56,8 @@ struct rc_slice_header {
 	uint32_t size;
 
 	unsigned char sha1[20];
+
+	uint32_t name_size;
 };
 
 struct rc_object_entry_ondisk {
@@ -76,7 +84,8 @@ struct rc_object_entry {
 	unsigned char merge_nr; /* : 7 */
 	unsigned char split_nr; /* : 7 */
 	unsigned size_size : 3;
-	unsigned padding : 5;
+	unsigned name_size : 3;
+	unsigned padding : 2;
 
 	uint32_t date;
 	uint16_t path;
@@ -84,6 +93,7 @@ struct rc_object_entry {
 	/* merge paths */
 	/* split paths */
 	/* size */
+	/* name id */
 };
 
 struct rc_index_entry *from_disked_rc_index_entry(struct rc_index_entry_ondisk *src, struct rc_index_entry *dst);
diff --git a/revision.h b/revision.h
index cc5c259..c62e85b 100644
--- a/revision.h
+++ b/revision.h
@@ -26,6 +26,9 @@ struct rev_cache_slice_map {
 	unsigned char *map;
 	int size;
 	int last_index;
+
+	char *names;
+	int name_size;
 };
 
 struct rev_cache_info {
@@ -39,7 +42,8 @@ struct rev_cache_info {
 	unsigned overwrite_all : 1;
 
 	/* traversal flags */
-	unsigned add_to_pending : 1;
+	unsigned add_to_pending : 1,
+		add_names : 1;
 
 	/* fuse options */
 	unsigned int ignore_size;
diff --git a/t/t6017-rev-cache-list.sh b/t/t6017-rev-cache-list.sh
index f2e34b1..3286560 100755
--- a/t/t6017-rev-cache-list.sh
+++ b/t/t6017-rev-cache-list.sh
@@ -4,8 +4,10 @@ test_description='git rev-cache tests'
 . ./test-lib.sh
 
 test_cmp_sorted() {
-	grep -io "[a-f0-9]*" $1 | sort >.tmpfile1 &&
-	grep -io "[a-f0-9]*" $2 | sort >.tmpfile2 &&
+# note that we're tip-toeing around the corner case of two objects/names
+# for the same SHA-1 => discrepencies between cached and non-cached walks
+	sort $1 >.tmpfile1 &&
+	sort $2 >.tmpfile2 &&
 	test_cmp .tmpfile1 .tmpfile2
 }
 
@@ -15,6 +17,8 @@ test_cmp_sorted() {
 # reuse
 test_expect_success 'init repo' '
 	echo bla >file &&
+	mkdir amaindir &&
+	echo watskeburt >amaindir/file &&
 	git add . &&
 	git commit -m "bla" &&
 
-- 
tg: (716470e..) t/revcache/names (depends on: t/revcache/docs)
