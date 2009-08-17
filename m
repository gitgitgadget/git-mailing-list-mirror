From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH 4/6 (v4)] administrative functions for rev-cache, start of
 integration into git
Date: Mon, 17 Aug 2009 14:31:29 +0200
Message-ID: <op.uys3qryitdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmic
X-From: git-owner@vger.kernel.org Mon Aug 17 14:32:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md1OM-0002Yp-70
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 14:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbZHQMbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 08:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbZHQMbf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 08:31:35 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:13995 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbZHQMbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 08:31:32 -0400
Received: by ey-out-2122.google.com with SMTP id 22so666995eye.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=mbt4vwjRwfi9DfGY23a/+aYBFW5uZ+HsDQZ3+YEQ4hc=;
        b=L1VeuOKjuNU9yS+Ro1lBh1elQEsv4OII/DgG/IRL1f7xuUSDoPV3Q9BC/1B70ncqwG
         zczlkzrSnFspm1aTlyJw1vlY72XLdJUs2ei4idQHrqcdnvPbqv2tdZgxd0wWfzUcTuj9
         T/IWEoEh+VrZ/OZWeu3tnp7PM6ATYrLWjCwEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=lA1ryK7c86rpXbGZUFydT3f3g9nvl1x7oNSTdUygrQP2tkgHsW6SgWmxcPZpmoDrKA
         svcrAWJGAGZQvEPIszyeGSRneala/HiknA5t1V2CpXJAzHQj1rkXTAeRsibOXwBC/t+p
         MTBbiGF7VRhAPDSJhUcyL9/BGY7pV/bDeM2Is=
Received: by 10.210.118.14 with SMTP id q14mr6937078ebc.31.1250512293072;
        Mon, 17 Aug 2009 05:31:33 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 5sm9548232eyh.56.2009.08.17.05.31.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 05:31:32 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126169>

From: Nick Edelen <sirnot@gmail.com>
Subject: [PATCH] t/revcache/misc

This patch, fourth, contains miscellaneous (maintenance) features:
 - support for cache slice fusion, index regeneration and object size caching
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
 builtin-gc.c        |    9 +
 builtin-rev-cache.c |   77 ++++++-
 rev-cache.c         |  717 +++++++++++++++++++++++++++++++++++++++++++++------
 rev-cache.h         |    9 +-
 revision.h          |   16 +-
 5 files changed, 749 insertions(+), 79 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 7d3e9cc..c92511a 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -22,6 +22,7 @@ static const char * const builtin_gc_usage[] = {
 	NULL
 };
 
+static char do_rev_cache = 0;
 static int pack_refs = 1;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
@@ -34,9 +35,14 @@ static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
 static const char *argv_repack[MAX_ADD] = {"repack", "-d", "-l", NULL};
 static const char *argv_prune[] = {"prune", "--expire", NULL, NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
+static const char *argv_rev_cache[] = {"rev-cache", "fuse", "--all", "--ignore-size", NULL};
 
 static int gc_config(const char *var, const char *value, void *cb)
 {
+	if (!strcmp(var, "gc.revcache")) {
+		do_rev_cache = 1;
+		return 0;
+	}
 	if (!strcmp(var, "gc.packrefs")) {
 		if (value && !strcmp(value, "notbare"))
 			pack_refs = -1;
@@ -244,6 +250,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(argv_rerere, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_rerere[0]);
 
+	if (do_rev_cache && run_command_v_opt(argv_rev_cache, RUN_GIT_CMD))
+		return error(FAILED_RUN, argv_rev_cache[0]);
+
 	if (auto_gc && too_many_loose_objects())
 		warning("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them.");
diff --git a/builtin-rev-cache.c b/builtin-rev-cache.c
index c27e0f3..7ca39c4 100644
--- a/builtin-rev-cache.c
+++ b/builtin-rev-cache.c
@@ -5,6 +5,8 @@
 #include "revision.h"
 #include "rev-cache.h"
 
+unsigned long default_ignore_size = 50 * 1024 * 1024; /* 50mb */
+
 /* porcelain for rev-cache.c */
 static int handle_add(int argc, const char *argv[]) /* args beyond this command */
 {
@@ -24,7 +26,7 @@ static int handle_add(int argc, const char *argv[]) /* args beyond this command
 		if (!strcmp(argv[i], "--stdin"))
 			dostdin = 1;
 		else if (!strcmp(argv[i], "--fresh"))
-			starts_from_slices(&revs, UNINTERESTING);
+			starts_from_slices(&revs, UNINTERESTING, 0, 0);
 		else if (!strcmp(argv[i], "--not"))
 			flags ^= UNINTERESTING;
 		else if (!strcmp(argv[i], "--legs"))
@@ -150,6 +152,57 @@ static int handle_walk(int argc, const char *argv[])
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
+	init_rev_cache_info(&rci);
+	args[argn++] = "rev-list";
+
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--all")) {
+			args[argn++] = "--all";
+			setup_revisions(argn, args, &revs, 0);
+			add_all = 1;
+		} else if (!strcmp(argv[i], "--no-objects"))
+			rci.objects = 0;
+		else if (!strncmp(argv[i], "--ignore-size", 13)) {
+			unsigned long sz;
+
+			if (argv[i][13] == '=')
+				git_parse_ulong(argv[i] + 14, &sz);
+			else
+				sz = default_ignore_size;
+
+			rci.ignore_size = sz;
+		} else
+			continue;
+	}
+
+	if (!add_all)
+		starts_from_slices(&revs, 0, 0, 0);
+
+	return fuse_cache_slices(&rci, &revs);
+}
+
+static int handle_index(int argc, const char *argv[])
+{
+	return regenerate_cache_index(0);
+}
+
+static int handle_alt(int argc, const char *argv[])
+{
+	if (argc < 1)
+		return -1;
+
+	return make_cache_slice_pointer(0, argv[0]);
+}
+
 static int handle_help(void)
 {
 	char *usage = "\
@@ -179,12 +232,28 @@ commands:\n\
 	return 0;
 }
 
+static int rev_cache_config(const char *k, const char *v, void *cb)
+{
+	/* this could potentially be related to pack.windowmemory, but we want a max around 50mb,
+	 * and .windowmemory is often >700mb, with *large* variations */
+	if (!strcmp(k, "revcache.ignoresize")) {
+		int t;
+
+		t = git_config_ulong(k, v);
+		if (t)
+			default_ignore_size = t;
+	}
+
+	return 0;
+}
+
 int cmd_rev_cache(int argc, const char *argv[], const char *prefix)
 {
 	const char *arg;
 	int r;
 
 	git_config(git_default_config, NULL);
+	git_config(rev_cache_config, NULL);
 
 	if (argc > 1)
 		arg = argv[1];
@@ -195,8 +264,14 @@ int cmd_rev_cache(int argc, const char *argv[], const char *prefix)
 	argv += 2;
 	if (!strcmp(arg, "add"))
 		r = handle_add(argc, argv);
+	else if (!strcmp(arg, "fuse"))
+		r = handle_fuse(argc, argv);
 	else if (!strcmp(arg, "walk"))
 		r = handle_walk(argc, argv);
+	else if (!strcmp(arg, "index"))
+		r = handle_index(argc, argv);
+	else if (!strcmp(arg, "alt"))
+		r = handle_alt(argc, argv);
 	else
 		return handle_help();
 
diff --git a/rev-cache.c b/rev-cache.c
index ddcc596..8eac1f0 100644
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -9,6 +9,13 @@
 #include "revision.h"
 #include "rev-cache.h"
 #include "run-command.h"
+#include "string-list.h"
+
+struct cache_slice_pointer {
+	char signature[8]; /* REVCOPTR */
+	char version;
+	char path[PATH_MAX + 1];
+};
 
 /* list resembles pack index format */
 static uint32_t fanout[0xff + 2];
@@ -257,27 +264,45 @@ unsigned char *get_cache_slice(struct commit *commit)
 
 /* traversal */
 
-static void handle_noncommit(struct rev_info *revs, unsigned char *ptr, struct rc_object_entry *entry)
+static unsigned long decode_size(unsigned char *str, int len);
+
+static void handle_noncommit(struct rev_info *revs, struct commit *commit, unsigned char *ptr, struct rc_object_entry *entry)
 {
-	struct object *obj = 0;
+	struct blob *blob;
+	struct tree *tree;
+	struct object *obj;
+	unsigned long size;
 
+	size = decode_size(ptr + RC_ENTRY_SIZE_OFFSET(entry), entry->size_size);
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
+		obj = (struct object *)blob;
 		break;
-	}
 
-	if (!obj)
+	default :
+		/* tag objects aren't really supposed to be here */
 		return;
+	}
 
 	obj->flags |= FACE_VALUE;
 	add_pending_object(revs, obj, "");
@@ -373,7 +398,7 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 		/* add extra objects if necessary */
 		if (entry->type != OBJ_COMMIT) {
 			if (consume_children)
-				handle_noncommit(revs, map + index, entry);
+				handle_noncommit(revs, co, map + index, entry);
 
 			continue;
 		} else
@@ -407,6 +432,8 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 			if (last_objects[path]) {
 				parse_commit(last_objects[path]);
 
+				/* we needn't worry about the unique field; that will be valid as
+				 * long as we're not a end entry */
 				last_objects[path]->object.flags &= ~FACE_VALUE;
 				last_objects[path] = 0;
 			}
@@ -539,6 +566,48 @@ static int get_cache_slice_header(unsigned char *cache_sha1, unsigned char *map,
 	return 0;
 }
 
+int open_cache_slice(unsigned char *sha1, int flags)
+{
+	int fd;
+	char signature[8];
+
+	fd = open(git_path("rev-cache/%s", sha1_to_hex(sha1)), flags);
+	if (fd <= 0)
+		goto end;
+
+	if (read(fd, signature, 8) != 8)
+		goto end;
+
+	/* a normal revision slice */
+	if (!memcmp(signature, "REVCACHE", 8)) {
+		lseek(fd, 0, SEEK_SET);
+		return fd;
+	}
+
+	/* slice pointer */
+	if (!memcmp(signature, "REVCOPTR", 8)) {
+		struct cache_slice_pointer ptr;
+
+		lseek(fd, 0, SEEK_SET);
+		if (read_in_full(fd, &ptr, sizeof(ptr)) != sizeof(ptr))
+			goto end;
+
+		if (ptr.version != SUPPORTED_REVCOPTR_VERSION)
+			goto end;
+
+		close(fd);
+		fd = open(ptr.path, flags);
+
+		return fd;
+	}
+
+end:
+	if (fd > 0)
+		close(fd);
+
+	return -1;
+}
+
 int traverse_cache_slice(struct rev_info *revs,
 	unsigned char *cache_sha1, struct commit *commit,
 	unsigned long *date_so_far, int *slop_so_far,
@@ -562,7 +631,7 @@ int traverse_cache_slice(struct rev_info *revs,
 
 	memset(&head, 0, sizeof(struct rc_slice_header));
 
-	fd = open(git_path("rev-cache/%s", sha1_to_hex(cache_sha1)), O_RDONLY);
+	fd = open_cache_slice(cache_sha1, O_RDONLY);
 	if (fd == -1)
 		goto end;
 	if (fstat(fd, &fi) || fi.st_size < sizeof(struct rc_slice_header))
@@ -589,6 +658,68 @@ end:
 
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
 	int path; /* for keeping track of children */
@@ -777,31 +908,76 @@ static void handle_paths(struct commit *commit, struct rc_object_entry *object,
 }
 
 
-static void add_object_entry(const unsigned char *sha1, int type, struct rc_object_entry *nothisone,
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
+static void add_object_entry(const unsigned char *sha1, struct rc_object_entry *entryp,
 	struct strbuf *merge_str, struct strbuf *split_str)
 {
-	struct rc_object_entry object;
+	struct rc_object_entry entry;
+	unsigned char size_str[7];
+	unsigned long size;
+	enum object_type type;
+	void *data;
 
-	if (!nothisone) {
-		memset(&object, 0, sizeof(object));
-		object.sha1 = (unsigned char *)sha1;
-		object.type = type;
+	if (entryp)
+		sha1 = entryp->sha1;
+
+	/* retrieve size data */
+	data = read_sha1_file(sha1, &type, &size);
+
+	if (data)
+		free(data);
+
+	/* initialize! */
+	if (!entryp) {
+		memset(&entry, 0, sizeof(entry));
+		entry.sha1 = (unsigned char *)sha1;
+		entry.type = type;
 
 		if (merge_str)
-			object.merge_nr = merge_str->len / sizeof(uint16_t);
+			entry.merge_nr = merge_str->len / sizeof(uint16_t);
 		if (split_str)
-			object.split_nr = split_str->len / sizeof(uint16_t);
+			entry.split_nr = split_str->len / sizeof(uint16_t);
 
-		nothisone = &object;
+		entryp = &entry;
 	}
 
-	strbuf_add(acc_buffer, to_disked_rc_object_entry(nothisone, 0), sizeof(struct rc_object_entry_ondisk));
+	entryp->size_size = encode_size(size, size_str);
 
-	if (merge_str && merge_str->len)
+	/* write the muvabitch */
+	strbuf_add(acc_buffer, to_disked_rc_object_entry(entryp, 0), sizeof(struct rc_object_entry_ondisk));
+
+	if (merge_str)
 		strbuf_add(acc_buffer, merge_str->buf, merge_str->len);
-	if (split_str && split_str->len)
+	if (split_str)
 		strbuf_add(acc_buffer, split_str->buf, split_str->len);
 
+	strbuf_add(acc_buffer, size_str, entryp->size_size);
 }
 
 /* returns non-zero to continue parsing, 0 to skip */
@@ -845,12 +1021,7 @@ continue_loop:
 
 static int dump_tree_callback(const unsigned char *sha1, const char *path, unsigned int mode)
 {
-	unsigned char data[21];
-
-	hashcpy(data, sha1);
-	data[20] = !!S_ISDIR(mode);
-
-	strbuf_add(acc_buffer, data, 21);
+	strbuf_add(acc_buffer, sha1, 20);
 
 	return 1;
 }
@@ -860,15 +1031,10 @@ static void tree_addremove(struct diff_options *options,
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
-	strbuf_add(acc_buffer, data, 21);
+	strbuf_add(acc_buffer, sha1, 20);
 }
 
 static void tree_change(struct diff_options *options,
@@ -877,26 +1043,10 @@ static void tree_change(struct diff_options *options,
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
-	strbuf_add(acc_buffer, data, 21);
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
+	strbuf_add(acc_buffer, new_sha1, 20);
 }
 
 static int add_unique_objects(struct commit *commit)
@@ -907,6 +1057,7 @@ static int add_unique_objects(struct commit *commit)
 	int i, j, next;
 	char is_first = 1;
 
+	/* ...no, calculate unique objects */
 	strbuf_init(&os, 0);
 	strbuf_init(&ost, 0);
 	orig_buf = acc_buffer;
@@ -926,20 +1077,20 @@ static int add_unique_objects(struct commit *commit)
 
 		strbuf_setlen(acc_buffer, 0);
 		diff_tree_sha1(list->item->tree->object.sha1, commit->tree->object.sha1, "", &opts);
-		qsort(acc_buffer->buf, acc_buffer->len / 21, 21, (int (*)(const void *, const void *))hashcmp);
+		qsort(acc_buffer->buf, acc_buffer->len / 20, 20, (int (*)(const void *, const void *))hashcmp);
 
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
@@ -948,25 +1099,102 @@ static int add_unique_objects(struct commit *commit)
 			is_first = 0;
 	}
 
+	/* no parents (!) */
 	if (is_first) {
 		acc_buffer = &os;
 		dump_tree(commit->tree, dump_tree_callback);
 	}
 
-	if (os.len)
-		qsort(os.buf, os.len / 21, 21, sort_type_hash);
-
+	/* the ordering of non-commit objects dosn't really matter, so we're not gonna bother */
 	acc_buffer = orig_buf;
-	for (i = 0; i < os.len; i += 21)
-		add_object_entry((unsigned char *)(os.buf + i), os.buf[i + 20] ? OBJ_TREE : OBJ_BLOB, 0, 0, 0);
+	for (i = 0; i < os.len; i += 20)
+		add_object_entry((unsigned char *)(os.buf + i), 0, 0, 0);
 
 	/* last but not least, the main tree */
-	add_object_entry(commit->tree->object.sha1, OBJ_TREE, 0, 0, 0);
+	add_object_entry(commit->tree->object.sha1, 0, 0, 0);
+
+	return i / 20 + 1;
+}
+
+static int add_objects_verbatim_1(struct rev_cache_slice_map *mapping, int *index)
+{
+	unsigned char *map = mapping->map;
+	int i = *index, object_nr = 0;
+	struct rc_object_entry *entry = RC_OBTAIN_OBJECT_ENTRY(map + i);
+
+	i += RC_ACTUAL_OBJECT_ENTRY_SIZE(entry);
+	while (i < mapping->size) {
+		int pos = i;
 
-	strbuf_release(&ost);
-	strbuf_release(&os);
+		entry = RC_OBTAIN_OBJECT_ENTRY(map + i;
+		i += RC_ACTUAL_OBJECT_ENTRY_SIZE(entry);
+
+		if (entry->type == OBJ_COMMIT) {
+			*index = pos;
+			return object_nr;
+		}
 
-	return i / 21 + 1;
+		strbuf_add(acc_buffer, map + pos, i - pos);
+		object_nr++;
+	}
+
+	*index = 0;
+	return object_nr;
+}
+
+static int add_objects_verbatim(struct rev_cache_info *rci, struct commit *commit)
+{
+	struct rev_cache_slice_map *map;
+	char found = 0;
+	struct rc_index_entry *ie;
+	struct rc_object_entry *entry;
+	int object_nr, i;
+
+	if (!rci->maps)
+		return -1;
+
+	/* check if we can continue where we left off */
+	map = rci->last_map;
+	if (!map)
+		goto search_me;
+
+	i = map->last_index;
+	entry = RC_OBTAIN_OBJECT_ENTRY(map->map + i);
+	if (hashcmp(entry->sha1, commit->object.sha1))
+		goto search_me;
+
+	found = 1;
+
+search_me:
+	if (!found) {
+		ie = search_index(commit->object.sha1);
+		if (!ie || ie->cache_index >= idx_head.cache_nr)
+			return -2;
+
+		map = rci->maps + ie->cache_index;
+		if (!map->size)
+			return -3;
+
+		i = ie->pos;
+		entry = RC_OBTAIN_OBJECT_ENTRY(map->map + i);
+		if (entry->type != OBJ_COMMIT || hashcmp(entry->sha1, commit->object.sha1))
+			return -4;
+	}
+
+	/* can't handle end commits */
+	if (entry->is_end)
+		return -5;
+
+	object_nr = add_objects_verbatim_1(map, &i);
+
+	/* remember this */
+	if (i) {
+		rci->last_map = map;
+		map->last_index = i;
+	} else
+		rci->last_map = 0;
+
+	return object_nr;
 }
 
 static void init_revcache_directory(void)
@@ -981,9 +1209,14 @@ static void init_revcache_directory(void)
 
 void init_rev_cache_info(struct rev_cache_info *rci)
 {
+	memset(rci, 0, sizeof(struct rev_cache_info));
+
 	rci->objects = 1;
 	rci->legs = 0;
 	rci->make_index = 1;
+	rci->fuse_me = 0;
+
+	rci->overwrite_all = 0;
 
 	rci->add_to_pending = 1;
 
@@ -1063,9 +1296,13 @@ int make_cache_slice(struct rev_cache_info *rci,
 	if (prepare_revision_walk(revs))
 		die("died preparing revision walk");
 
+	if (rci->legs)
+		make_legs(revs);
+
 	object_nr = total_sz = 0;
 	while ((commit = get_revision(revs)) != 0) {
 		struct rc_object_entry object;
+		int t;
 
 		strbuf_setlen(&merge_paths, 0);
 		strbuf_setlen(&split_paths, 0);
@@ -1091,12 +1328,17 @@ int make_cache_slice(struct rev_cache_info *rci,
 
 		commit->indegree = 0;
 
-		add_object_entry(0, 0, &object, &merge_paths, &split_paths);
+		add_object_entry(0, &object, &merge_paths, &split_paths);
 		object_nr++;
 
-		/* add all unique children for this commit */
-		if (rci->objects && !object.is_end)
-			object_nr += add_unique_objects(commit);
+		if (rci->objects && !object.is_end) {
+			if (rci->fuse_me && (t = add_objects_verbatim(rci, commit)) >= 0)
+				/* yay!  we did it! */
+				object_nr += t;
+			else
+				/* add all unique children for this commit */
+				object_nr += add_unique_objects(commit);
+		}
 
 		/* print every ~1MB or so */
 		if (buffer.len > 1000000) {
@@ -1221,6 +1463,8 @@ int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1,
 	unsigned char *map;
 	unsigned long max_date;
 
+	maybe_fill_with_defaults(rci);
+
 	if (!idx_map)
 		init_index();
 
@@ -1285,7 +1529,7 @@ int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1,
 		} else
 			disked_entry = search_index_1(object_entry->sha1);
 
-		if (disked_entry && !object_entry->is_start)
+		if (disked_entry && !object_entry->is_start && !rci->overwrite_all)
 			continue;
 		else if (disked_entry) {
 			/* mmm, pointer arithmetic... tasty */  /* (entry - idx_map = offset, so cast is valid) */
@@ -1339,8 +1583,7 @@ int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1,
 }
 
 
-/* add start-commits from each cache slice (uninterestingness will be propogated) */
-void starts_from_slices(struct rev_info *revs, unsigned int flags)
+void starts_from_slices(struct rev_info *revs, unsigned int flags, unsigned char *which, int n)
 {
 	struct commit *commit;
 	int i;
@@ -1356,6 +1599,18 @@ void starts_from_slices(struct rev_info *revs, unsigned int flags)
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
@@ -1365,3 +1620,313 @@ void starts_from_slices(struct rev_info *revs, unsigned int flags)
 	}
 
 }
+
+
+struct slice_fd_time {
+	unsigned char sha1[20];
+	int fd;
+	struct stat fi;
+};
+
+int slice_time_sort(const void *a, const void *b)
+{
+	unsigned long at, bt;
+
+	at = ((struct slice_fd_time *)a)->fi.st_ctime;
+	bt = ((struct slice_fd_time *)b)->fi.st_ctime;
+
+	if (at == bt)
+		return 0;
+
+	return at > bt ? 1 : -1;
+}
+
+int regenerate_cache_index(struct rev_cache_info *rci)
+{
+	DIR *dirh;
+	int i;
+	struct slice_fd_time info;
+	struct strbuf slices;
+
+	/* first remove old index if it exists */
+	unlink_or_warn(git_path("rev-cache/index"));
+
+	strbuf_init(&slices, 0);
+
+	dirh = opendir(git_path("rev-cache"));
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
+			/* open with RDWR because of mmap call in make_cache_index() */
+			fd = open_cache_slice(sha1, O_RDONLY);
+			if (fd < 0 || fstat(fd, &fi)) {
+				warning("bad cache found [%s]; fuse recommended", de->d_name);
+				if (fd > 0)
+					close(fd);
+				continue;
+			}
+
+			hashcpy(info.sha1, sha1);
+			info.fd = fd;
+			memcpy(&info.fi, &fi, sizeof(struct stat));
+
+			strbuf_add(&slices, &info, sizeof(info));
+		}
+
+		closedir(dirh);
+	}
+
+	/* we want oldest first -> upon overlap, older slices are more likely to have a larger section,
+	 * as of the overlapped commit */
+	qsort(slices.buf, slices.len / sizeof(info), sizeof(info), slice_time_sort);
+
+	for (i = 0; i < slices.len; i += sizeof(info)) {
+		struct slice_fd_time *infop = (struct slice_fd_time *)(slices.buf + i);
+		struct stat *fip = &infop->fi;
+		int fd = infop->fd;
+
+		if (make_cache_index(rci, infop->sha1, fd, fip->st_size) < 0)
+			die("error writing cache");
+
+		close(fd);
+	}
+
+	strbuf_release(&slices);
+
+	return 0;
+}
+
+static int add_slices_for_fuse(struct rev_cache_info *rci, struct string_list *files, struct strbuf *ignore)
+{
+	unsigned char sha1[20];
+	char base[PATH_MAX];
+	int baselen, i, slice_nr = 0;
+	struct stat fi;
+	DIR *dirh;
+	struct dirent *de;
+
+	strncpy(base, git_path("rev-cache"), sizeof(base));
+	baselen = strlen(base);
+
+	dirh = opendir(base);
+	if (!dirh)
+		return 0;
+
+	while ((de = readdir(dirh))) {
+		if (de->d_name[0] == '.')
+			continue;
+
+		base[baselen] = '/';
+		strncpy(base + baselen + 1, de->d_name, sizeof(base) - baselen - 1);
+
+		if (get_sha1_hex(de->d_name, sha1)) {
+			/* whatever it is, we don't need it... */
+			string_list_insert(base, files);
+			continue;
+		}
+
+		/* _theoretically_ it is possible a slice < ignore_size to map objects not covered by, yet reachable from,
+		 * a slice >= ignore_size, meaning that we could potentially delete an 'unfused' slice; but if that
+		 * ever *did* happen their cache structure'd be so fucked up they might as well refuse the entire thing.
+		 * and at any rate the worst it'd do is make rev-list revert to standard walking in that (small) bit.
+		 */
+		if (rci->ignore_size) {
+			if (stat(base, &fi))
+				warning("can't query file %s\n", base);
+			else if (fi.st_size >= rci->ignore_size) {
+				strbuf_add(ignore, sha1, 20);
+				continue;
+			}
+		} else {
+			/* check if a pointer */
+			struct cache_slice_pointer ptr;
+			int fd = open(base, O_RDONLY);
+
+			if (fd < 0)
+				goto dont_save;
+			if (sizeof(ptr) != read_in_full(fd, &ptr, sizeof(ptr)))
+				goto dont_save;
+
+			close(fd);
+			if (!strcmp(ptr.signature, "REVCOPTR")) {
+				strbuf_add(ignore, sha1, 20);
+				continue;
+			}
+		}
+
+dont_save:
+		for (i = idx_head.cache_nr - 1; i >= 0; i--) {
+			if (!hashcmp(idx_caches + i * 20, sha1))
+				break;
+		}
+
+		if (i >= 0)
+			rci->maps[i].size = 1;
+
+		string_list_insert(base, files);
+		slice_nr++;
+	}
+
+	closedir(dirh);
+
+	return slice_nr;
+}
+
+/* the most work-intensive attributes in the cache are the unique objects and size, both
+ * of which can be re-used.  although path structures will be isomorphic, path generation is
+ * not particularly expensive, and at any rate we need to re-sort the commits */
+int fuse_cache_slices(struct rev_cache_info *rci, struct rev_info *revs)
+{
+	unsigned char cache_sha1[20];
+	struct string_list files = {0, 0, 0, 1}; /* dup */
+	struct strbuf ignore;
+	int i;
+
+	maybe_fill_with_defaults(rci);
+
+	if (!idx_map)
+		init_index();
+	if (!idx_map)
+		return -1;
+
+	strbuf_init(&ignore, 0);
+	rci->maps = xcalloc(idx_head.cache_nr, sizeof(struct rev_cache_slice_map));
+	if (add_slices_for_fuse(rci, &files, &ignore) <= 1) {
+		printf("nothing to fuse\n");
+		return 1;
+	}
+
+	if (ignore.len) {
+		starts_from_slices(revs, UNINTERESTING, (unsigned char *)ignore.buf, ignore.len / 20);
+		strbuf_release(&ignore);
+	}
+
+	/* initialize mappings */
+	for (i = idx_head.cache_nr - 1; i >= 0; i--) {
+		struct rev_cache_slice_map *map = rci->maps + i;
+		struct stat fi;
+		int fd;
+
+		if (!map->size)
+			continue;
+		map->size = 0;
+
+		/* pointers are never fused, so we can use open directly */
+		fd = open(git_path("rev-cache/%s", sha1_to_hex(idx_caches + i * 20)), O_RDONLY);
+		if (fd <= 0 || fstat(fd, &fi))
+			continue;
+		if (fi.st_size < sizeof(struct rc_slice_header))
+			continue;
+
+		map->map = xmmap(0, fi.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (map->map == MAP_FAILED)
+			continue;
+
+		close(fd);
+		map->size = fi.st_size;
+	}
+
+	rci->make_index = 0;
+	rci->fuse_me = 1;
+	if (make_cache_slice(rci, revs, 0, 0, cache_sha1) < 0)
+		die("can't make cache slice");
+
+	printf("%s\n", sha1_to_hex(cache_sha1));
+
+	/* clean up time! */
+	for (i = idx_head.cache_nr - 1; i >= 0; i--) {
+		struct rev_cache_slice_map *map = rci->maps + i;
+
+		if (!map->size)
+			continue;
+
+		munmap(map->map, map->size);
+	}
+	free(rci->maps);
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
+	return regenerate_cache_index(rci);
+}
+
+static int verify_cache_slice(const char *slice_path, unsigned char *sha1)
+{
+	struct rc_slice_header head;
+	int fd, len, retval = -1;
+	unsigned char *map = MAP_FAILED;
+	struct stat fi;
+
+	len = strlen(slice_path);
+	if (len < 40)
+		return -2;
+	if (get_sha1_hex(slice_path + len - 40, sha1))
+		return -3;
+
+	fd = open(slice_path, O_RDONLY);
+	if (fd == -1)
+		goto end;
+	if (fstat(fd, &fi) || fi.st_size < sizeof(head))
+		goto end;
+
+	map = xmmap(0, sizeof(head), PROT_READ, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED)
+		goto end;
+	if (get_cache_slice_header(sha1, map, fi.st_size, &head))
+		goto end;
+
+	retval = 0;
+
+end:
+	if (map != MAP_FAILED)
+		munmap(map, sizeof(head));
+	if (fd > 0)
+		close(fd);
+
+	return retval;
+}
+
+int make_cache_slice_pointer(struct rev_cache_info *rci, const char *slice_path)
+{
+	struct cache_slice_pointer ptr;
+	int fd;
+	unsigned char sha1[20];
+
+	maybe_fill_with_defaults(rci);
+	rci->overwrite_all = 1;
+
+	if (verify_cache_slice(slice_path, sha1) < 0)
+		return -1;
+
+	strcpy(ptr.signature, "REVCOPTR");
+	ptr.version = SUPPORTED_REVCOPTR_VERSION;
+	strcpy(ptr.path, make_nonrelative_path(slice_path));
+
+	fd = open(git_path("rev-cache/%s", sha1_to_hex(sha1)), O_RDWR | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0)
+		return -2;
+
+	write_in_full(fd, &ptr, sizeof(ptr));
+	make_cache_index(rci, sha1, fd, sizeof(ptr));
+
+	close(fd);
+
+	return 0;
+}
diff --git a/rev-cache.h b/rev-cache.h
index a471fbf..14437d8 100644
--- a/rev-cache.h
+++ b/rev-cache.h
@@ -3,6 +3,7 @@
 
 #define SUPPORTED_REVCACHE_VERSION 		1
 #define SUPPORTED_REVINDEX_VERSION		1
+#define SUPPORTED_REVCOPTR_VERSION		1
 
 #define RC_PATH_SIZE(x)	(sizeof(uint16_t) * (x))
 
@@ -10,6 +11,7 @@
 #define RC_OBTAIN_INDEX_ENTRY(p)			from_disked_rc_index_entry((struct rc_index_entry_ondisk *)(p), 0)
 
 #define RC_ACTUAL_OBJECT_ENTRY_SIZE(e)		(sizeof(struct rc_object_entry_ondisk) + RC_PATH_SIZE((e)->merge_nr + (e)->split_nr) + (e)->size_size)
+#define RC_ENTRY_SIZE_OFFSET(e)				(RC_ACTUAL_OBJECT_ENTRY_SIZE(e) - (e)->size_size)
 
 /* single index maps objects to cache files */
 struct rc_index_header {
@@ -90,6 +92,7 @@ struct rc_object_entry *from_disked_rc_object_entry(struct rc_object_entry_ondis
 struct rc_object_entry_ondisk *to_disked_rc_object_entry(struct rc_object_entry *src, struct rc_object_entry_ondisk *dst);
 
 extern unsigned char *get_cache_slice(struct commit *commit);
+extern int open_cache_slice(unsigned char *sha1, int flags);
 extern int traverse_cache_slice(struct rev_info *revs,
 	unsigned char *cache_sha1, struct commit *commit,
 	unsigned long *date_so_far, int *slop_so_far,
@@ -102,6 +105,10 @@ extern int make_cache_slice(struct rev_cache_info *rci,
 extern int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1,
 	int fd, unsigned int size);
 
-extern void starts_from_slices(struct rev_info *revs, unsigned int flags);
+extern void starts_from_slices(struct rev_info *revs, unsigned int flags, unsigned char *which, int n);
+extern int fuse_cache_slices(struct rev_cache_info *rci, struct rev_info *revs);
+extern int regenerate_cache_index(struct rev_cache_info *rci);
+extern int make_cache_slice_pointer(struct rev_cache_info *rci, const char *slice_path);
 
 #endif
+
diff --git a/revision.h b/revision.h
index e767a43..c3ec1b3 100644
--- a/revision.h
+++ b/revision.h
@@ -19,17 +19,31 @@
 struct rev_info;
 struct log_info;
 
+struct rev_cache_slice_map {
+	unsigned char *map;
+	int size;
+	int last_index;
+};
+
 struct rev_cache_info {
 	/* generation flags */
 	unsigned objects : 1,
 		legs : 1,
-		make_index : 1;
+		make_index : 1,
+		fuse_me : 1;
+
+	/* index inclusion */
+	unsigned overwrite_all : 1;
 
 	/* traversal flags */
 	unsigned add_to_pending : 1;
 
 	/* fuse options */
 	unsigned int ignore_size;
+
+	/* reserved */
+	struct rev_cache_slice_map *maps,
+		*last_map;
 };
 
 struct rev_info {
-- 
tg: (a3c9f24..) t/revcache/misc (depends on: t/revcache/objects)
