From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH 4/5] administrative functions for rev-cache, and start of
 integration into git
Date: Thu, 06 Aug 2009 11:55:43 +0200
Message-ID: <op.ux8i65metdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>, "Sam Vilain" <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearc
X-From: git-owner@vger.kernel.org Thu Aug 06 11:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYzih-0000EM-HB
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 11:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbZHFJzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 05:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbZHFJzr
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 05:55:47 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:47691 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbZHFJzp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 05:55:45 -0400
Received: by mail-ew0-f214.google.com with SMTP id 10so642311ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=zPMzOjQ4S/UpqWq7cUDRATfZvQUaWKoiLS8QmYLB+pM=;
        b=eF2pnACDRnNELcGyWz4QSZNA4ntPHemr+HDnoHfa8fKgoVqJWxGIX+ngeZt1Qk41vk
         GKENOAws6LyQIS6yYM2FTq1/EHItoJGXU+Y6ld+pp6OHhvg4oy/2dKZs8TGg326Rr5w3
         w0eQj4WfM8YxNINjYFAxtE+uFM9fkgkWmGouw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=H0uUuTKNE2smnsuwwx9sDEzTPkzs9lhNBMVMLhadx3NTuT7UgJZVlv9DhGvDqaZU2z
         e7s+RZ0gaMw6m9By7wvinkOJ3HzX8OobXcs0TJk0jWXyGp4WURZD9BrYVz72s2abtsyX
         JcF15s1jgPXOpGnPVC2aPtoSKYsuKcKpLv+TY=
Received: by 10.210.20.17 with SMTP id 17mr11806292ebt.80.1249552546154;
        Thu, 06 Aug 2009 02:55:46 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 7sm4674324eyg.15.2009.08.06.02.55.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 02:55:45 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125060>

This patch, fourth, contains miscellaneous (maintenance) features:
 - support for cache slice fusion, index regeneration and object size caching
 - extra 'size' field added to commit, tag and blob objects, initialized in 
   parse_* functions and cache traversal
 - non-commit object generation refactored to take advantage of 'size' field
 - porcelain updated to support feature additions

The beginnings of integration into git are present in this patch, mainly 
centered on caching object size; the object generation is refactored to more 
elegantly exploit this.  Fusion allows smaller (incremental) slices to be 
coagulated into a larger slice, reducing overhead, while index regeneration 
enables repair or cleaning of the cache index.

Note that tests for these features are included in the following patch, as they 
take advantage of the rev-cache's integration into the revision walker.

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
 blob.c              |    1 +
 blob.h              |    1 +
 builtin-rev-cache.c |   49 ++++++-
 commit.c            |    1 +
 commit.h            |    1 +
 rev-cache.c         |  416 ++++++++++++++++++++++++++++++++++++++++++---------
 revision.h          |    4 +-
 7 files changed, 397 insertions(+), 76 deletions(-)

diff --git a/blob.c b/blob.c
index bd7d078..e1bab3f 100644
--- a/blob.c
+++ b/blob.c
@@ -21,6 +21,7 @@ struct blob *lookup_blob(const unsigned char *sha1)
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
 {
 	item->object.parsed = 1;
+	item->size = size;
 	return 0;
 }
 
diff --git a/blob.h b/blob.h
index ea5d9e9..d8db96a 100644
--- a/blob.h
+++ b/blob.h
@@ -7,6 +7,7 @@ extern const char *blob_type;
 
 struct blob {
 	struct object object;
+	unsigned long size;
 };
 
 struct blob *lookup_blob(const unsigned char *sha1);
diff --git a/builtin-rev-cache.c b/builtin-rev-cache.c
index 2338871..44916f5 100755
--- a/builtin-rev-cache.c
+++ b/builtin-rev-cache.c
@@ -4,6 +4,8 @@
 #include "diff.h"
 #include "revision.h"
 
+#define DEFAULT_IGNORE_SLICE_SIZE		5000000 /* in bytes */
+
 /* porcelain for rev-cache.c */
 static int handle_add(int argc, const char *argv[]) /* args beyond this command */
 {
@@ -21,7 +23,7 @@ static int handle_add(int argc, const char *argv[]) /* args beyond this command
 		if (!strcmp(argv[i], "--stdin"))
 			dostdin = 1;
 		else if (!strcmp(argv[i], "--fresh"))
-			starts_from_slices(&revs, UNINTERESTING);
+			starts_from_slices(&revs, UNINTERESTING, 0, 0);
 		else if (!strcmp(argv[i], "--not"))
 			flags ^= UNINTERESTING;
 		else if (!strcmp(argv[i], "--legs"))
@@ -141,6 +143,47 @@ static int handle_walk(int argc, const char *argv[])
 	return 0;
 }
 
+static int handle_fuse(int argc, const char *argv[])
+{
+	struct rev_info revs;
+	struct rev_cache_info rci;
+	const char *args[5];
+	int i, argn = 0;
+	char add_all = 0;
+	
+	init_revisions(&revs, 0);
+	init_rci(&rci);
+	args[argn++] = "rev-list";
+	
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--all")) {
+			args[argn++] = "--all";
+			setup_revisions(argn, args, &revs, 0);
+			add_all = 1;
+		} else if (!strcmp(argv[i], "--noobjects")) 
+			rci.objects = 0;
+		else if (!strncmp(argv[i], "--ignore-size", 13)) {
+			int sz = DEFAULT_IGNORE_SLICE_SIZE;
+			
+			if (argv[i][13] == '=')
+				sz = atoi(argv[i] + 14);
+			
+			rci.ignore_size = sz;
+		} else 
+			continue;
+	}
+	
+	if (!add_all)
+		starts_from_slices(&revs, 0, 0, 0);
+	
+	return coagulate_cache_slices(&rci, &revs);
+}
+
+static int handle_index(int argc, const char *argv[])
+{
+	return regenerate_cache_index(0);
+}
+
 static int handle_help(void)
 {
 	char *usage = "\
@@ -186,8 +229,12 @@ int cmd_rev_cache(int argc, const char *argv[], const char *prefix)
 	argv += 2;
 	if (!strcmp(arg, "add"))
 		r = handle_add(argc, argv);
+	else if (!strcmp(arg, "fuse"))
+		r = handle_fuse(argc, argv);
 	else if (!strcmp(arg, "walk"))
 		r = handle_walk(argc, argv);
+	else if (!strcmp(arg, "index"))
+		r = handle_index(argc, argv);
 	else
 		return handle_help();
 	
diff --git a/commit.c b/commit.c
index 65d223e..afe504f 100644
--- a/commit.c
+++ b/commit.c
@@ -243,6 +243,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 	if (item->object.parsed)
 		return 0;
 	item->object.parsed = 1;
+	item->size = size;
 	tail += size;
 	if (tail <= bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45] != '\n')
 		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
diff --git a/commit.h b/commit.h
index ba9f638..0529fcf 100644
--- a/commit.h
+++ b/commit.h
@@ -19,6 +19,7 @@ struct commit {
 	struct commit_list *parents;
 	struct tree *tree;
 	char *buffer;
+	unsigned long size;
 };
 
 extern int save_commit_buffer;
diff --git a/rev-cache.c b/rev-cache.c
index cd618cf..4cda858 100755
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -8,6 +8,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "run-command.h"
+#include "string-list.h"
 
 
 /* single index maps objects to cache files */
@@ -88,6 +89,7 @@ static struct strbuf *g_buffer;
 #define IE_CAST(p)	((struct index_entry *)(p))
 
 #define ACTUAL_OBJECT_ENTRY_SIZE(e)		(OE_SIZE + PATH_SIZE((e)->merge_nr + (e)->split_nr) + (e)->size_size)
+#define ENTRY_SIZE_OFFSET(e)			(ACTUAL_OBJECT_ENTRY_SIZE(e) - (e)->size_size)
 
 #define SLOP		5
 
@@ -219,7 +221,6 @@ unsigned char *get_cache_slice(struct commit *commit)
 		return 0;
 	
 	ie = search_index(commit->object.sha1);
-	
 	if (ie && ie->cache_index < idx_head.cache_nr)
 		return idx_caches + ie->cache_index * 20;
 	
@@ -229,27 +230,46 @@ unsigned char *get_cache_slice(struct commit *commit)
 
 /* traversal */
 
-static void handle_noncommit(struct rev_info *revs, struct object_entry *entry)
+static unsigned long decode_size(unsigned char *str, int len);
+
+static void handle_noncommit(struct rev_info *revs, struct commit *commit, struct object_entry *entry)
 {
-	struct object *obj = 0;
+	struct blob *blob;
+	struct tree *tree;
+	struct object *obj;
+	unsigned long size;
 	
+	size = decode_size((unsigned char *)entry + ENTRY_SIZE_OFFSET(entry), entry->size_size);
 	switch (entry->type) {
 	case OBJ_TREE : 
-		if (revs->tree_objects)
-			obj = (struct object *)lookup_tree(entry->sha1);
+		if (!revs->tree_objects)
+			return;
+		
+		tree = lookup_tree(entry->sha1);
+		if (!tree)
+			return;
+		
+		tree->size = size;
+		commit->tree = tree;
+		obj = (struct object *)tree;
 		break;
+	
 	case OBJ_BLOB : 
-		if (revs->blob_objects)
-			obj = (struct object *)lookup_blob(entry->sha1);
-		break;
-	case OBJ_TAG : 
-		if (revs->tag_objects)
-			obj = (struct object *)lookup_tag(entry->sha1);
+		if (!revs->blob_objects)
+			return;
+		
+		blob = lookup_blob(entry->sha1);
+		if (!blob)
+			return;
+		
+		blob->size = size;
+		obj = (struct object *)blob;
 		break;
-	}
-	
-	if (!obj)
+		
+	default : 
+		/* tag objects aren't really supposed to be here */
 		return;
+	}
 	
 	obj->flags |= FACE_VALUE;
 	add_pending_object(revs, obj, "");
@@ -262,7 +282,6 @@ static int setup_traversal(struct cache_slice_header *head, unsigned char *map,
 	struct commit_list *prev, *wp, **wpp;
 	int retval;
 	
-	/* printf("adding %s\n", sha1_to_hex(commit->object.sha1)); */
 	iep = search_index(commit->object.sha1);
 	oep = OE_CAST(map + ntohl(iep->pos));
 	oep->include = 1;
@@ -338,7 +357,7 @@ static int traverse_cache_slice_1(struct cache_slice_header *head, unsigned char
 		/* add extra objects if necessary */
 		if (entry->type != OBJ_COMMIT) {
 			if (consume_children)
-				handle_noncommit(revs, entry);
+				handle_noncommit(revs, co, entry);
 			
 			continue;
 		} else
@@ -372,6 +391,8 @@ static int traverse_cache_slice_1(struct cache_slice_header *head, unsigned char
 			if (last_objects[path]) {
 				parse_commit(last_objects[path]);
 				
+				/* we needn't worry about the unique field; that will be valid as 
+				 * long as we're not a end entry */
 				last_objects[path]->object.flags &= ~FACE_VALUE;
 				last_objects[path] = 0;
 			}
@@ -554,6 +575,68 @@ end:
 
 /* generation */
 
+static int is_endpoint(struct commit *commit)
+{
+	struct commit_list *list = commit->parents;
+	
+	while (list) {
+		if (!(list->item->object.flags & UNINTERESTING))
+			return 0;
+		
+		list = list->next;
+	}
+	
+	return 1;
+}
+
+/* ensures branch is self-contained: parents are either all interesting or all uninteresting */
+static void make_legs(struct rev_info *revs)
+{
+	struct commit_list *list, **plist;
+	int total = 0;
+	
+	/* attach plist to end of commits list */
+	list = revs->commits;
+	while (list && list->next)
+		list = list->next;
+	
+	if (list)
+		plist = &list->next;
+	else
+		return;
+	
+	/* duplicates don't matter, as get_revision() ignores them */
+	for (list = revs->commits; list; list = list->next) {
+		struct commit *item = list->item;
+		struct commit_list *parents = item->parents;
+		
+		if (item->object.flags & UNINTERESTING)
+			continue;
+		if (is_endpoint(item))
+			continue;
+		
+		while (parents) {
+			struct commit *p = parents->item;
+			parents = parents->next;
+			
+			if (!(p->object.flags & UNINTERESTING))
+				continue;
+			
+			p->object.flags &= ~UNINTERESTING;
+			parse_commit(p);
+			plist = &commit_list_insert(p, plist)->next;
+			
+			if (!(p->object.flags & SEEN))
+				total++;
+		}
+	}
+	
+	if (total)
+		sort_in_topological_order(&revs->commits, 1);
+	
+}
+
+
 struct path_track {
 	struct commit *commit;
 	int path; /* for decrementing paths */
@@ -768,31 +851,97 @@ static void handle_paths(struct commit *commit, struct object_entry *object, str
 }
 
 
-static void add_object_entry(const unsigned char *sha1, int type, struct object_entry *nothisone, 
+static int encode_size(unsigned long size, unsigned char *out)
+{
+	int len = 0;
+	
+	while (size) {
+		*out++ = (unsigned char)(size & 0xff);
+		size >>= 8;
+		len++;
+	}
+	
+	return len;
+}
+
+static unsigned long decode_size(unsigned char *str, int len)
+{
+	unsigned long size = 0;
+	int shift = 0;
+	
+	while (len--) {
+		size |= (unsigned long)*str << shift;
+		shift += 8;
+		str++;
+	}
+	
+	return size;
+}
+
+static void add_object_entry(const unsigned char *sha1, struct object_entry *entryp, 
 	struct strbuf *merge_str, struct strbuf *split_str)
 {
-	struct object_entry object;
+	struct object_entry entry;
+	struct object *obj;
+	unsigned char size_str[7];
+	unsigned long size;
+	enum object_type type;
+	
+	if (entryp)
+		sha1 = entryp->sha1;
+	
+	obj = lookup_object(sha1);
+	if (obj) {
+		/* it'd be smoother to have the size in the object... */
+		switch (obj->type) {
+		case OBJ_COMMIT : 
+			size = ((struct commit *)obj)->size;
+			break;
+		case OBJ_TREE : 
+			size = ((struct tree *)obj)->size;
+			break;
+		case OBJ_BLOB : 
+			size = ((struct blob *)obj)->size;
+			break;
+		default : 
+			/* tags are potentially dynamic metadata; they don't really belong here */
+			return;
+		}
+		
+		type = obj->type;
+	}
 	
-	if (!nothisone) {
-		memset(&object, 0, sizeof(object));
-		hashcpy(object.sha1, sha1);
-		object.type = type;
+	if (!obj || !size) {
+		void *data = read_sha1_file(sha1, &type, &size);
+		
+		if (data)
+			free(data);
+	}
+	
+	if (!entryp) {
+		memset(&entry, 0, sizeof(entry));
+		hashcpy(entry.sha1, sha1);
+		entry.type = type;
 		
 		if (merge_str)
-			object.merge_nr = merge_str->len / PATH_WIDTH;
+			entry.merge_nr = merge_str->len / PATH_WIDTH;
 		if (split_str)
-			object.split_nr = split_str->len / PATH_WIDTH;
+			entry.split_nr = split_str->len / PATH_WIDTH;
 		
-		nothisone = &object;
+		entryp = &entry;
 	}
 	
-	strbuf_add(g_buffer, nothisone, sizeof(object));
+	entryp->size_size = encode_size(size, size_str);
+	
+	/* write the muvabitch */
+	strbuf_add(g_buffer, entryp, sizeof(entry));
 	
-	if (merge_str && merge_str->len)
+	if (merge_str)
 		strbuf_add(g_buffer, merge_str->buf, merge_str->len);
-	if (split_str && split_str->len)
+	if (split_str)
 		strbuf_add(g_buffer, split_str->buf, split_str->len);
 	
+	strbuf_add(g_buffer, size_str, entryp->size_size);
 }
 
 /* returns non-zero to continue parsing, 0 to skip */
@@ -836,12 +985,7 @@ continue_loop:
 
 static int dump_tree_callback(const unsigned char *sha1, const char *path, unsigned int mode)
 {
-	unsigned char data[21];
-	
-	hashcpy(data, sha1);
-	data[20] = !!S_ISDIR(mode);
-	
-	strbuf_add(g_buffer, data, 21);
+	strbuf_add(g_buffer, sha1, 20);
 	
 	return 1;
 }
@@ -851,15 +995,10 @@ static void tree_addremove(struct diff_options *options,
 	const unsigned char *sha1,
 	const char *concatpath)
 {
-	unsigned char data[21];
-	
 	if (whatnow != '+')
 		return;
 	
-	hashcpy(data, sha1);
-	data[20] = !!S_ISDIR(mode);
-	
-	strbuf_add(g_buffer, data, 21);
+	strbuf_add(g_buffer, sha1, 20);
 }
 
 static void tree_change(struct diff_options *options,
@@ -868,26 +1007,10 @@ static void tree_change(struct diff_options *options,
 	const unsigned char *new_sha1,
 	const char *concatpath)
 {
-	unsigned char data[21];
-	
 	if (!hashcmp(old_sha1, new_sha1))
 		return;
 	
-	hashcpy(data, new_sha1);
-	data[20] = !!S_ISDIR(new_mode);
-	
-	strbuf_add(g_buffer, data, 21);
-}
-
-static int sort_type_hash(const void *a, const void *b)
-{
-	const unsigned char *sa = (const unsigned char *)a, 
-		*sb = (const unsigned char *)b;
-	
-	if (sa[20] == sb[20])
-		return hashcmp(sa, sb);
-	
-	return sa[20] > sb[20] ? -1 : 1;
+	strbuf_add(g_buffer, new_sha1, 20);
 }
 
 static int add_unique_objects(struct commit *commit)
@@ -898,6 +1021,7 @@ static int add_unique_objects(struct commit *commit)
 	int i, j, next;
 	char is_first = 1;
 	
+	/* ...no, calculate unique objects */
 	strbuf_init(&os, 0);
 	strbuf_init(&ost, 0);
 	orig_buf = g_buffer;
@@ -917,20 +1041,20 @@ static int add_unique_objects(struct commit *commit)
 		
 		strbuf_setlen(g_buffer, 0);
 		diff_tree_sha1(list->item->tree->object.sha1, commit->tree->object.sha1, "", &opts);
-		qsort(g_buffer->buf, g_buffer->len / 21, 21, (int (*)(const void *, const void *))hashcmp);
+		qsort(g_buffer->buf, g_buffer->len / 20, 20, (int (*)(const void *, const void *))hashcmp);
 		
 		/* take intersection */
 		if (!is_first) {
-			for (next = i = j = 0; i < os.len; i += 21) {
+			for (next = i = j = 0; i < os.len; i += 20) {
 				while (j < ost.len && hashcmp((unsigned char *)(ost.buf + j), (unsigned char *)(os.buf + i)) < 0)
-					j += 21;
+					j += 20;
 				
 				if (j >= ost.len || hashcmp((unsigned char *)(ost.buf + j), (unsigned char *)(os.buf + i)))
 					continue;
 				
 				if (next != i)
-					memcpy(os.buf + next, os.buf + i, 21);
-				next += 21;
+					memcpy(os.buf + next, os.buf + i, 20);
+				next += 20;
 			}
 			
 			if (next != i)
@@ -939,22 +1063,21 @@ static int add_unique_objects(struct commit *commit)
 			is_first = 0;
 	}
 	
+	/* no parents (!) */
 	if (is_first) {
 		g_buffer = &os;
 		dump_tree(commit->tree, dump_tree_callback);
 	}
 	
-	if (os.len)
-		qsort(os.buf, os.len / 21, 21, sort_type_hash);
-	
+	/* the ordering of non-commit objects dosn't really matter, so we're not gonna bother */
 	g_buffer = orig_buf;
-	for (i = 0; i < os.len; i += 21)
-		add_object_entry((unsigned char *)(os.buf + i), os.buf[i + 20] ? OBJ_TREE : OBJ_BLOB, 0, 0, 0);
+	for (i = 0; i < os.len; i += 20)
+		add_object_entry((unsigned char *)(os.buf + i), 0, 0, 0);
 	
 	strbuf_release(&ost);
 	strbuf_release(&os);
 	
-	return 0;
+	return i / 20;
 }
 
 static void init_revcache_directory(void)
@@ -1046,6 +1169,9 @@ int make_cache_slice(struct rev_cache_info *rci,
 	if (prepare_revision_walk(revs))
 		die("died preparing revision walk");
 	
+	if (rci->legs)
+		make_legs(revs);
+	
 	object_nr = total_sz = 0;
 	while ((commit = get_revision(revs)) != 0) {
 		struct object_entry object;
@@ -1067,12 +1193,12 @@ int make_cache_slice(struct rev_cache_info *rci,
 		
 		commit->indegree = 0;
 		
-		add_object_entry(0, 0, &object, &merge_paths, &split_paths);
+		add_object_entry(0, &object, &merge_paths, &split_paths);
 		object_nr++;
 		
-		if (!(commit->object.flags & TREESAME)) {
+		if (rci->objects && !(commit->object.flags & TREESAME)) {
 			/* add all unique children for this commit */
-			add_object_entry(commit->tree->object.sha1, OBJ_TREE, 0, 0, 0);
+			add_object_entry(commit->tree->object.sha1, 0, 0, 0);
 			object_nr++;
 			
 			if (!object.is_end)
@@ -1260,7 +1386,7 @@ int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1,
 		 * should we allow more intelligent overriding? */
 		date = ntohl(object_entry->date);
 		if (date > idx_head.max_date) {
- 			entry = 0;
+			entry = 0;
 			if (date > max_date)
 				max_date = date;
 		} else
@@ -1316,8 +1442,7 @@ int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1,
 }
 
 
-/* add start-commits from each cache slice (uninterestingness will be propogated) */
-void starts_from_slices(struct rev_info *revs, unsigned int flags)
+void starts_from_slices(struct rev_info *revs, unsigned int flags, unsigned char *which, int n)
 {
 	struct commit *commit;
 	int i;
@@ -1334,6 +1459,18 @@ void starts_from_slices(struct rev_info *revs, unsigned int flags)
 		if (!entry->is_start)
 			continue;
 		
+		/* only include entries in 'which' slices */
+		if (n) {
+			int j;
+			
+			for (j = 0; j < n; j++)
+				if (!hashcmp(idx_caches + entry->cache_index * 20, which + j * 20))
+					break;
+			
+			if (j == n)
+				continue;
+		}
+		
 		commit = lookup_commit(entry->sha1);
 		if (!commit)
 			continue;
@@ -1343,3 +1480,134 @@ void starts_from_slices(struct rev_info *revs, unsigned int flags)
 	}
 	
 }
+
+
+/* the most work-intensive attributes in the cache are the unique objects and size, both 
+ * of which can be re-used.  although path structures will be isomorphic, path generation is 
+ * not particularly expensive, and at any rate we need to re-sort the commits */
+int coagulate_cache_slices(struct rev_cache_info *rci, struct rev_info *revs)
+{
+	unsigned char cache_sha1[20];
+	char base[PATH_MAX];
+	int fd, baselen, i;
+	struct stat fi;
+	struct string_list files = {0, 0, 0, 1}; /* dup */
+	struct strbuf ignore;
+	DIR *dirh;
+	
+	strbuf_init(&ignore, 0);
+	strncpy(base, git_path("rev-cache"), sizeof(base));
+	baselen = strlen(base);
+	
+	/* enumerate files */
+	dirh = opendir(base);
+	if (dirh) {
+		struct dirent *de;
+		
+		while ((de = readdir(dirh))) {
+			if (de->d_name[0] == '.')
+				continue;
+			
+			base[baselen] = '/';
+			strncpy(base + baselen + 1, de->d_name, sizeof(base) - baselen - 1);
+			
+			/* _theoretically_ it is possible a slice < ignore_size to map objects not covered by, yet reachable from, 
+			 * a slice >= ignore_size, meaning that we could potentially delete an 'unfused' slice; but if that 
+			 * ever *did* happen their cache structure'd be so fucked up they might as well refuse the entire thing.
+			 * and at any rate the worst it'd do is make rev-list revert to standard walking in that (small) bit.
+			 */
+			if (rci->ignore_size) {
+				unsigned char sha1[20];
+				
+				if (stat(base, &fi))
+					warning("can't query file %s\n", base);
+				else if (fi.st_size >= rci->ignore_size && !get_sha1_hex(de->d_name, sha1)) {
+					strbuf_add(&ignore, sha1, 20);
+					continue;
+				}
+			}
+			
+			string_list_insert(base, &files);
+		}
+		
+		closedir(dirh);
+	}
+	
+	if (ignore.len) {
+		starts_from_slices(revs, UNINTERESTING, (unsigned char *)ignore.buf, ignore.len / 20);
+		strbuf_release(&ignore);
+	}
+	
+	rci->make_index = 0;
+	if (make_cache_slice(rci, revs, 0, 0, cache_sha1) < 0)
+		die("can't make cache slice");
+	
+	/* clean up time! */
+	cleanup_cache_slices();
+	
+	for (i = 0; i < files.nr; i++) {
+		char *name = files.items[i].string;
+		
+		fprintf(stderr, "removing %s\n", name);
+		unlink_or_warn(name);
+	}
+	
+	string_list_clear(&files, 0);
+	
+	fd = open(git_path("rev-cache/%s", sha1_to_hex(cache_sha1)), O_RDWR);
+	if (fd < 0 || fstat(fd, &fi))
+		die("what?  I can't open/query the cache I just generated");
+	
+	if (make_cache_index(rci, cache_sha1, fd, fi.st_size) < 0)
+		die("can't make new index");
+	
+	close(fd);
+	
+	return 0;
+}
+
+int regenerate_cache_index(struct rev_cache_info *rci)
+{
+	DIR *dirh;
+	char base[PATH_MAX];
+	int baselen;
+	
+	/* first remove old index if it exists */
+	unlink_or_warn(git_path("rev-cache/index"));
+	
+	strncpy(base, git_path("rev-cache"), sizeof(base));
+	baselen = strlen(base);
+	
+	dirh = opendir(base);
+	if (dirh) {
+		struct dirent *de;
+		struct stat fi;
+		int fd;
+		unsigned char sha1[20];
+		
+		while ((de = readdir(dirh))) {
+			if (de->d_name[0] == '.')
+				continue;
+			
+			if (get_sha1_hex(de->d_name, sha1))
+				continue;
+			
+			base[baselen] = '/';
+			strncpy(base + baselen + 1, de->d_name, sizeof(base) - baselen - 1);
+			
+			/* open with RDWR because of mmap call in make_cache_index() */
+			fd = open(base, O_RDWR);
+			if (fd < 0 || fstat(fd, &fi))
+				warning("bad cache found [%s]; fuse recommended", de->d_name);
+			
+			if (make_cache_index(rci, sha1, fd, fi.st_size) < 0)
+				die("error writing cache");
+			
+			close(fd);
+		}
+		
+		closedir(dirh);
+	}
+	
+	return 0;
+}
\ No newline at end of file
diff --git a/revision.h b/revision.h
index 200042a..d97ac8c 100644
--- a/revision.h
+++ b/revision.h
@@ -207,6 +207,8 @@ extern int make_cache_slice(struct rev_cache_info *rci,
 extern int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1, 
 	int fd, unsigned int size);
 
-extern void starts_from_slices(struct rev_info *revs, unsigned int flags);
+extern void starts_from_slices(struct rev_info *revs, unsigned int flags, unsigned char *which, int n);
+extern int coagulate_cache_slices(struct rev_cache_info *rci, struct rev_info *revs);
+extern int regenerate_cache_index(struct rev_cache_info *rci);
 
 #endif
-- 
