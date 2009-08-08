From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH 6/6 (v2)] support for path name caching of blobs/trees in
 rev-cache
Date: Sat, 08 Aug 2009 09:32:06 +0200
Message-ID: <op.uyb1vs0htdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmic
X-From: git-owner@vger.kernel.org Sat Aug 08 09:32:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZgPp-0007kQ-Eg
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933352AbZHHHcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933292AbZHHHcO
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:32:14 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:50170 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932620AbZHHHcM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:32:12 -0400
Received: by mail-ew0-f214.google.com with SMTP id 10so1992751ewy.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=m21dwkoGADZzJ+prckmV0i/FXsqJVl8W8zNFaTW7vL8=;
        b=Ws3r0RUTnhzl/iztUS36okAbpQBJcCPhyGzp7UenpoSc6a30b5uCIxSPATnuIvHmg1
         vjd7W9sxP3h5rs3bYhl39P+XRlLLsq3FExgne7NNKljVMUoHwhWjPy82qiI2CJa6keUA
         ajq5Vu59GxNZGLyUPay+Qk32iLxB13MuaDZIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=uVXuWvQ3CikT9qr/SD1w/YOoa8Cs0yinFU4GGV7PXr7FhLmzUB8jfpPgui4biWi9Lx
         SLBB/gSvccpCIm7iVZFTp8zWiYPhboj7sfq8R+5CBdais/J7IgiXJuHf3kcB/LZJ80a2
         8zobruFbGEOsCbcXZMR4SsEFJ/VoenievoWy0=
Received: by 10.210.52.15 with SMTP id z15mr358925ebz.36.1249716732648;
        Sat, 08 Aug 2009 00:32:12 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 5sm5054871eyf.58.2009.08.08.00.32.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 00:32:12 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125260>

An update to caching mechanism, allowing path names to be cached for blob and 
tree objects.  A list of names appearing in each cache slice is appended to the 
end of the slice, which is referenced by variable-sized indexes per entry.  
This allows pack-objects to more intelligently schedule unpacked/poorly packed 
object, and enables proper duplication of rev-list's behaivor.

The mechanism for this involves adding a 'name' field to blob and tree objects, 
mainly to facilitate reuse of caches during maintenence (like the 'unique' 
field).

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
This is a totally new patch to the series.  I had somehow missed name caching 
earlier.

 blob.h                    |    1 +
 builtin-rev-cache.c       |    3 +-
 rev-cache.c               |  293 ++++++++++++++++++++++++++++++++++++++-------
 revision.h                |    3 +-
 t/t6015-rev-cache-list.sh |    4 +-
 tree.h                    |    1 +
 6 files changed, 259 insertions(+), 46 deletions(-)

diff --git a/blob.h b/blob.h
index d8db96a..e6a46f3 100644
--- a/blob.h
+++ b/blob.h
@@ -8,6 +8,7 @@ extern const char *blob_type;
 struct blob {
 	struct object object;
 	unsigned long size;
+	char *name;
 };
 
 struct blob *lookup_blob(const unsigned char *sha1);
diff --git a/builtin-rev-cache.c b/builtin-rev-cache.c
index 4a02af6..5f88214 100755
--- a/builtin-rev-cache.c
+++ b/builtin-rev-cache.c
@@ -168,13 +168,14 @@ static int handle_walk(int argc, const char *argv[])
 	fprintf(stderr, "pending:\n");
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object *obj = revs.pending.objects[i].item;
+		char *name = revs.pending.objects[i].name;
 		
 		/* unfortunately, despite our careful generation, object duplication *is* a possibility...
 		 * (eg. same object introduced into two different branches) */
 		if (obj->flags & SEEN)
 			continue;
 		
-		printf("%s\n", sha1_to_hex(revs.pending.objects[i].item->sha1));
+		printf("%s %s\n", sha1_to_hex(revs.pending.objects[i].item->sha1), name);
 		obj->flags |= SEEN;
 	}
 	
diff --git a/rev-cache.c b/rev-cache.c
index e6808e7..347e005 100755
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -42,6 +42,8 @@ struct cache_slice_header {
 	uint32_t size;
 	
 	unsigned char sha1[20];
+	
+	uint32_t name_size;
 };
 
 struct object_entry {
@@ -56,6 +58,8 @@ struct object_entry {
 	unsigned merge_nr : 6;
 	unsigned split_nr : 7;
 	unsigned size_size : 3;
+	unsigned name_size : 3;
+	unsigned what_to_do : 5; /* unused */
 	
 	uint32_t date;
 	uint16_t path;
@@ -63,6 +67,7 @@ struct object_entry {
 	/* merge paths */
 	/* split paths */
 	/* size */
+	/* name id */
 };
 
 struct bad_slice {
@@ -70,16 +75,27 @@ struct bad_slice {
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
 /* list resembles pack index format */
 static uint32_t fanout[0xff + 2];
 
 static unsigned char *idx_map;
 static int idx_size;
 static struct index_header idx_head;
-static char no_idx, save_unique, add_to_pending;
-static struct bad_slice *bad_slices;
+static char no_idx, save_unique, add_to_pending, add_names;
 static unsigned char *idx_caches;
 
+static struct bad_slice *bad_slices;
+static struct name_list *name_lists, *cur_name_list;
+
+static struct strbuf *g_name_buffer;
 static struct strbuf *g_buffer;
 
 #define SUPPORTED_REVCACHE_VERSION 		1
@@ -94,8 +110,9 @@ static struct strbuf *g_buffer;
 #define OE_CAST(p)	((struct object_entry *)(p))
 #define IE_CAST(p)	((struct index_entry *)(p))
 
-#define ACTUAL_OBJECT_ENTRY_SIZE(e)		(OE_SIZE + PATH_SIZE((e)->merge_nr + (e)->split_nr) + (e)->size_size)
-#define ENTRY_SIZE_OFFSET(e)			(ACTUAL_OBJECT_ENTRY_SIZE(e) - (e)->size_size)
+#define ACTUAL_OBJECT_ENTRY_SIZE(e)		(OE_SIZE + PATH_SIZE((e)->merge_nr + (e)->split_nr) + (e)->size_size + (e)->name_size)
+#define ENTRY_NAME_OFFSET(e)			(ACTUAL_OBJECT_ENTRY_SIZE(e) - (e)->name_size)
+#define ENTRY_SIZE_OFFSET(e)			(ENTRY_NAME_OFFSET(e) - (e)->size_size)
 
 #define SLOP			5
 
@@ -167,6 +184,12 @@ static void cleanup_cache_slices(void)
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
@@ -296,7 +319,8 @@ static void handle_noncommit(struct rev_info *revs, struct commit *commit, struc
 	struct blob *blob;
 	struct tree *tree;
 	struct object *obj;
-	unsigned long size;
+	unsigned long size, name_index;
+	char **namep = 0;
 	
 	size = decode_size((unsigned char *)entry + ENTRY_SIZE_OFFSET(entry), entry->size_size);
 	switch (entry->type) {
@@ -309,6 +333,7 @@ static void handle_noncommit(struct rev_info *revs, struct commit *commit, struc
 			return;
 		
 		tree->size = size;
+		namep = &tree->name;
 		commit->tree = tree;
 		obj = (struct object *)tree;
 		break;
@@ -322,6 +347,7 @@ static void handle_noncommit(struct rev_info *revs, struct commit *commit, struc
 			return;
 		
 		blob->size = size;
+		namep = &blob->name;
 		obj = (struct object *)blob;
 		break;
 		
@@ -330,6 +356,13 @@ static void handle_noncommit(struct rev_info *revs, struct commit *commit, struc
 		return;
 	}
 	
+	if (add_names && cur_name_list) {
+		name_index = decode_size((unsigned char *)entry + ENTRY_NAME_OFFSET(entry), entry->name_size);
+		
+		if (name_index >= cur_name_list->len)
+			name_index = 0;
+	} else name_index = 0;
+	
 	/* add to unique list if we're not an end */
 	if (save_unique && (commit->object.flags & FACE_VALUE)) {
 		if (last_commit != commit) {
@@ -344,9 +377,20 @@ static void handle_noncommit(struct rev_info *revs, struct commit *commit, struc
 		last_unique = &(*last_unique)->next;
 	}
 	
+	/* add cached name */
+	if (name_index && namep) {
+		*namep = cur_name_list->buf + name_index;
+	}
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
 
 static int setup_traversal(struct cache_slice_header *head, unsigned char *map, struct commit *commit, struct commit_list **work, 
@@ -696,15 +740,44 @@ end:
 	return retval;
 }
 
-static int get_cache_slice_header(unsigned char *cache_sha1, unsigned char *map, int len, struct cache_slice_header *head)
+static struct name_list *get_cache_slice_name_list(struct cache_slice_header *head, int fd)
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
+static int get_cache_slice_header(int fd, unsigned char *cache_sha1, int len, struct cache_slice_header *head)
 {
 	int t;
 	
-	memcpy(head, map, sizeof(struct cache_slice_header));
+	if (xread(fd, head, sizeof(struct cache_slice_header)) != sizeof(struct cache_slice_header))
+		return -1;
+	
 	head->ofs_objects = ntohl(head->ofs_objects);
 	head->object_nr = ntohl(head->object_nr);
 	head->size = ntohl(head->size);
 	head->path_nr = ntohs(head->path_nr);
+	head->name_size = ntohl(head->name_size);
 	
 	if (memcmp(head->signature, "REVCACHE", 8))
 		return -1;
@@ -713,10 +786,10 @@ static int get_cache_slice_header(unsigned char *cache_sha1, unsigned char *map,
 	if (hashcmp(head->sha1, cache_sha1))
 		return -3;
 	t = sizeof(struct cache_slice_header);
-	if (t != head->ofs_objects || t >= len)
+	if (t != head->ofs_objects)
 		return -4;
-	
-	head->size = len;
+	if (head->size + head->name_size != len)
+		return -5;
 	
 	return 0;
 }
@@ -726,7 +799,7 @@ int traverse_cache_slice(struct rev_info *revs,
 	unsigned long *date_so_far, int *slop_so_far, 
 	struct commit_list ***queue, struct commit_list **work)
 {
-	int fd = -1, retval = -3;
+	int fd = -1, t, retval;
 	struct stat fi;
 	struct cache_slice_header head;
 	struct rev_cache_info *rci;
@@ -743,26 +816,31 @@ int traverse_cache_slice(struct rev_info *revs,
 	rci = &revs->rev_cache_info;
 	save_unique = rci->save_unique;
 	add_to_pending = rci->add_to_pending;
+	add_names = rci->add_names;
 	
 	memset(&head, 0, sizeof(struct cache_slice_header));
+#	define ERROR(x)		do { retval = (x); goto end; } while (0);
 	
 	fd = open(git_path("rev-cache/%s", sha1_to_hex(cache_sha1)), O_RDONLY);
 	if (fd == -1)
-		goto end;
+		ERROR(-1);
 	if (fstat(fd, &fi) || fi.st_size < sizeof(struct cache_slice_header))
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
 	
@@ -770,6 +848,7 @@ end:
 	if (retval)
 		mark_bad_slice(cache_sha1);
 	
+#	undef ERROR
 	return retval;
 }
 
@@ -1081,12 +1160,100 @@ static unsigned long decode_size(unsigned char *str, int len)
 	return size;
 }
 
+#define NL_HASH_TABLE_SIZE		(0xffff + 1)
+#define NL_HASH_NUMBER			(NL_HASH_TABLE_SIZE >> 3)
+
+struct name_list_hash {
+	char *ptr;
+	int ind;
+	struct name_list_hash *next;
+};
+
+static struct name_list_hash **nl_hash_table;
+static unsigned char *nl_hashes;
+
+/* FNV-1a hash */
+static unsigned int hash_name(char *name)
+{
+	unsigned int hash = 2166136261ul;
+	char *p = name;
+	
+	while (*p) {
+		hash ^= *p++;
+		hash *= 16777619ul;
+	}
+	
+	return hash & 0xffff;
+}
+
+static int name_in_list(char *name)
+{
+	unsigned int h = hash_name(name);
+	struct name_list_hash *entry = nl_hash_table[h];
+	
+	while (entry && strcmp(entry->ptr, name))
+		entry = entry->next;
+	
+	if (entry)
+		return entry->ind;
+	
+	/* add name to buffer and create hash reference */
+	entry = xcalloc(1, sizeof(struct name_list_hash));
+	entry->ind = g_name_buffer->len;
+	
+	strbuf_add(g_name_buffer, name, strlen(name) + 1);
+	entry->ptr = g_name_buffer->buf + entry->ind;
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
 static void add_object_entry(const unsigned char *sha1, struct object_entry *entryp, 
-	struct strbuf *merge_str, struct strbuf *split_str)
+	struct strbuf *merge_str, struct strbuf *split_str, char *name)
 {
 	struct object_entry entry;
 	struct object *obj;
-	unsigned char size_str[7];
+	unsigned char size_str[7], name_str[7];
 	unsigned long size;
 	enum object_type type;
 	
@@ -1100,12 +1267,18 @@ static void add_object_entry(const unsigned char *sha1, struct object_entry *ent
 		case OBJ_COMMIT : 
 			size = ((struct commit *)obj)->size;
 			break;
-		case OBJ_TREE : 
-			size = ((struct tree *)obj)->size;
-			break;
-		case OBJ_BLOB : 
-			size = ((struct blob *)obj)->size;
-			break;
+		case OBJ_TREE : {
+			struct tree *tree = (struct tree *)obj;
+			size = tree->size;
+			if (!name)
+				name = tree->name;
+		} break;
+		case OBJ_BLOB : {
+			struct blob *blob = (struct blob *)obj;
+			size = blob->size;
+			if (!name)
+				name = blob->name;
+		} break;
 		default : 
 			/* tags are potentially dynamic metadata; they don't really belong here */
 			return;
@@ -1136,6 +1309,9 @@ static void add_object_entry(const unsigned char *sha1, struct object_entry *ent
 	
 	entryp->size_size = encode_size(size, size_str);
 	
+	if (name)
+		entryp->name_size = encode_size(name_in_list(name), name_str);
+	
 	/* write the muvabitch */
 	strbuf_add(g_buffer, entryp, sizeof(entry));
 	
@@ -1145,6 +1321,9 @@ static void add_object_entry(const unsigned char *sha1, struct object_entry *ent
 		strbuf_add(g_buffer, split_str->buf, split_str->len);
 	
 	strbuf_add(g_buffer, size_str, entryp->size_size);
+	
+	if (name)
+		strbuf_add(g_buffer, name_str, entryp->name_size);
 }
 
 /* returns non-zero to continue parsing, 0 to skip */
@@ -1189,6 +1368,9 @@ continue_loop:
 static int dump_tree_callback(const unsigned char *sha1, const char *path, unsigned int mode)
 {
 	strbuf_add(g_buffer, sha1, 20);
+	strbuf_add(g_buffer, (char *)&g_name_buffer->len, sizeof(size_t));
+	
+	strbuf_add(g_name_buffer, path, strlen(path) + 1);
 	
 	return 1;
 }
@@ -1202,6 +1384,9 @@ static void tree_addremove(struct diff_options *options,
 		return;
 	
 	strbuf_add(g_buffer, sha1, 20);
+	strbuf_add(g_buffer, (char *)&g_name_buffer->len, sizeof(size_t));
+	
+	strbuf_add(g_name_buffer, concatpath, strlen(concatpath) + 1);
 }
 
 static void tree_change(struct diff_options *options,
@@ -1214,12 +1399,15 @@ static void tree_change(struct diff_options *options,
 		return;
 	
 	strbuf_add(g_buffer, new_sha1, 20);
+	strbuf_add(g_buffer, (char *)&g_name_buffer->len, sizeof(size_t));
+	
+	strbuf_add(g_name_buffer, concatpath, strlen(concatpath) + 1);
 }
 
 static int add_unique_objects(struct commit *commit)
 {
 	struct commit_list *list;
-	struct strbuf os, ost, *orig_buf;
+	struct strbuf os, ost, names, *orig_name_buf, *orig_buf;
 	struct diff_options opts;
 	int i, j, next;
 	char is_first = 1;
@@ -1231,7 +1419,7 @@ static int add_unique_objects(struct commit *commit)
 		olist = commit->unique;
 		i = 0;
 		while (olist) {
-			add_object_entry(olist->item->sha1, 0, 0, 0);
+			add_object_entry(olist->item->sha1, 0, 0, 0, 0 /* retrieved with size in function */);
 			i++;
 			olist = olist->next;
 		}
@@ -1242,13 +1430,17 @@ static int add_unique_objects(struct commit *commit)
 	/* ...no, calculate unique objects */
 	strbuf_init(&os, 0);
 	strbuf_init(&ost, 0);
+	strbuf_init(&names, 0);
 	orig_buf = g_buffer;
+	orig_name_buf = g_name_buffer;
+	g_name_buffer = &names;
 	
 	diff_setup(&opts);
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	DIFF_OPT_SET(&opts, TREE_IN_RECURSIVE);
 	opts.change = tree_change;
 	opts.add_remove = tree_addremove;
+#	define ENTRY_SIZE (20 + sizeof(size_t))
 	
 	/* this is only called for non-ends (ie. all parents interesting) */
 	for (list = commit->parents; list; list = list->next) {
@@ -1259,20 +1451,20 @@ static int add_unique_objects(struct commit *commit)
 		
 		strbuf_setlen(g_buffer, 0);
 		diff_tree_sha1(list->item->tree->object.sha1, commit->tree->object.sha1, "", &opts);
-		qsort(g_buffer->buf, g_buffer->len / 20, 20, (int (*)(const void *, const void *))hashcmp);
+		qsort(g_buffer->buf, g_buffer->len / ENTRY_SIZE, ENTRY_SIZE, (int (*)(const void *, const void *))hashcmp);
 		
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
@@ -1289,16 +1481,19 @@ static int add_unique_objects(struct commit *commit)
 	
 	/* the ordering of non-commit objects dosn't really matter, so we're not gonna bother */
 	g_buffer = orig_buf;
-	for (i = 0; i < os.len; i += 20)
-		add_object_entry((unsigned char *)(os.buf + i), 0, 0, 0);
+	g_name_buffer = orig_name_buf;
+	for (i = 0; i < os.len; i += ENTRY_SIZE)
+		add_object_entry((unsigned char *)(os.buf + i), 0, 0, 0, names.buf + *(size_t *)(os.buf + i + 20));
 	
 	/* last but not least, the main tree */
-	add_object_entry(commit->tree->object.sha1, 0, 0, 0);
+	add_object_entry(commit->tree->object.sha1, 0, 0, 0, 0);
 	
 	strbuf_release(&ost);
 	strbuf_release(&os);
+	strbuf_release(&names);
 	
-	return i / 20 + 1;
+	return i / ENTRY_SIZE + 1;
+#	undef ENTRY_SIZE
 }
 
 static void init_revcache_directory(void)
@@ -1319,6 +1514,7 @@ void init_rci(struct rev_cache_info *rci)
 	
 	rci->save_unique = 0;
 	rci->add_to_pending = 1;
+	rci->add_names = 1;
 	
 	rci->ignore_size = 0;
 }
@@ -1333,9 +1529,9 @@ int make_cache_slice(struct rev_cache_info *rci,
 	struct cache_slice_header head;
 	struct commit *commit;
 	unsigned char sha1[20];
-	struct strbuf merge_paths, split_paths;
+	struct strbuf merge_paths, split_paths, namelist;
 	int object_nr, total_sz, fd;
-	char file[PATH_MAX], *newfile;
+	char file[PATH_MAX], *newfile, null;
 	struct rev_cache_info *trci, def_rci;
 	git_SHA_CTX ctx;
 	
@@ -1353,7 +1549,13 @@ int make_cache_slice(struct rev_cache_info *rci,
 	strbuf_init(&endlist, 0);
 	strbuf_init(&merge_paths, 0);
 	strbuf_init(&split_paths, 0);
+	strbuf_init(&namelist, 0);
 	g_buffer = &buffer;
+	g_name_buffer = &namelist;
+	
+	null = 0;
+	strbuf_add(&namelist, &null, 1);
+	init_name_list_hash();
 	
 	if (!revs) {
 		revs = &therevs;
@@ -1384,6 +1586,7 @@ int make_cache_slice(struct rev_cache_info *rci,
 	trci = &revs->rev_cache_info;
 	init_rci(trci);
 	trci->save_unique = 1;
+	trci->add_names = 1;
 	trci->add_to_pending = 0;
 	
 	setup_revisions(0, 0, revs, 0);
@@ -1414,7 +1617,7 @@ int make_cache_slice(struct rev_cache_info *rci,
 		
 		commit->indegree = 0;
 		
-		add_object_entry(0, &object, &merge_paths, &split_paths);
+		add_object_entry(0, &object, &merge_paths, &split_paths, 0);
 		object_nr++;
 		
 		if (rci->objects && !(commit->object.flags & TREESAME) && !object.is_end)
@@ -1434,10 +1637,16 @@ int make_cache_slice(struct rev_cache_info *rci,
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
diff --git a/revision.h b/revision.h
index d97ac8c..5114208 100644
--- a/revision.h
+++ b/revision.h
@@ -27,7 +27,8 @@ struct rev_cache_info {
 	
 	/* traversal flags */
 	unsigned save_unique : 1, 
-		add_to_pending : 1;
+		add_to_pending : 1, 
+		add_names : 1;
 	
 	/* fuse options */
 	unsigned int ignore_size;
diff --git a/t/t6015-rev-cache-list.sh b/t/t6015-rev-cache-list.sh
index 561810f..3836596 100755
--- a/t/t6015-rev-cache-list.sh
+++ b/t/t6015-rev-cache-list.sh
@@ -4,8 +4,8 @@ test_description='git rev-cache tests'
 . ./test-lib.sh
 
 test_cmp_sorted() {
-	grep -io "[a-f0-9]*" $1 | sort >.tmpfile1 && 
-	grep -io "[a-f0-9]*" $2 | sort >.tmpfile2 && 
+	sort $1 >.tmpfile1 && 
+	sort $2 >.tmpfile2 && 
 	test_cmp .tmpfile1 .tmpfile2
 }
 
diff --git a/tree.h b/tree.h
index 2ff01a4..6eb0cd0 100644
--- a/tree.h
+++ b/tree.h
@@ -9,6 +9,7 @@ struct tree {
 	struct object object;
 	void *buffer;
 	unsigned long size;
+	char *name;
 };
 
 struct tree *lookup_tree(const unsigned char *sha1);
-- 
tg: (c47593c..) t/revcache/names (depends on: t/revcache/docs)
