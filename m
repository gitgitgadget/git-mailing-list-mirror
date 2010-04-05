From: Nick Edelen <sirnot@gmail.com>
Subject: [PATCH 4/7 (v5)] administrative api and tools
Date: Mon, 05 Apr 2010 20:58:22 +0100
Message-ID: <4BBA40DE.1090102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail
X-From: git-owner@vger.kernel.org Mon Apr 05 21:58:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NysRJ-0000WJ-0M
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400Ab0DET6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:58:25 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:33419 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392Ab0DET6W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:58:22 -0400
Received: by mail-ew0-f220.google.com with SMTP id 20so121824ewy.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=MplfHNzlvqTAEv5TG6Zab0+sz9+4q7AbQPdNJmT0vTE=;
        b=UrmmDP5ky8DIMmtP623A6mVLlXJ/gb8Hb7ymopGaaDApT64YY2MGv3jDIEJYP5nvAF
         Ej1iIvdiVo5m8DBrwqLTzbSG2o14cPnxI3lEbLmN5NhGhR/0nXG1DdtNWg9ZG13kAum4
         jamIkHeA1AHqqVATzz1WCEbzfK2TFsoRzBcPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=vggWVFHGS7ATg7wU1LJMvEUOJN86gP7f2uXNYW4fbpETlow/YO4UFKQOv+NVpfr3WS
         lPM9JMRVpKb/pftP1kMJqOiIR/Xi4f3GXEaO9VQh4zHBTeAUp+vfMecghC5mJvvr7PQa
         ffU6zf+uJUzG5yzM4ERaHz90KsBVD01yLmIOU=
Received: by 10.213.63.75 with SMTP id a11mr1642787ebi.9.1270497501971;
        Mon, 05 Apr 2010 12:58:21 -0700 (PDT)
Received: from [192.168.55.86] (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 15sm6472368ewy.12.2010.04.05.12.58.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 12:58:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144061>

Contains miscellaneous (maintenance) features:
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
 builtin/gc.c        |    9 +
 builtin/rev-cache.c |   80 ++++++-
 rev-cache.c         |  725 +++++++++++++++++++++++++++++++++++++++++++++------
 rev-cache.h         |    9 +-
 revision.h          |   18 ++-
 5 files changed, 755 insertions(+), 86 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c304638..8e0e748 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
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
@@ -247,6 +253,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(argv_rerere, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_rerere[0]);
 
+	if (do_rev_cache && run_command_v_opt(argv_rev_cache, RUN_GIT_CMD))
+		return error(FAILED_RUN, argv_rev_cache[0]);
+
 	if (auto_gc && too_many_loose_objects())
 		warning("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them.");
diff --git a/builtin/rev-cache.c b/builtin/rev-cache.c
index e322467..d6cd57b 100644
--- a/builtin/rev-cache.c
+++ b/builtin/rev-cache.c
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
 		else if (!strcmp(argv[i], "--fresh") || !strcmp(argv[i], "--incremental"))
-			starts_from_slices(&revs, UNINTERESTING);
+			starts_from_slices(&revs, UNINTERESTING, 0, 0);
 		else if (!strcmp(argv[i], "--not"))
 			flags ^= UNINTERESTING;
 		else if (!strcmp(argv[i], "--legs") || !strcmp(argv[i], "--close"))
@@ -151,6 +153,60 @@ static int handle_walk(int argc, const char *argv[])
 	return 0;
 }
 
+static int handle_fuse(int argc, const char *argv[])
+{
+	struct rev_info revs;
+	struct rev_cache_info rci;
+	const char *args[5];
+	int t, i, argn = 0;
+	char add_all = 0;
+
+	init_revisions(&revs, 0);
+	init_rev_cache_info(&rci);
+	args[argn++] = "rev-list";
+
+	for (i = 0; i < argc; i++) {
+		t = 1;
+		if (!strcmp(argv[i], "--all")) {
+			args[argn++] = "--all";
+			setup_revisions(argn, args, &revs, 0);
+			add_all = 1;
+		} else if (!strcmp(argv[i], "--no-objects"))
+			rci.objects = 0;
+		else if (!strncmp(argv[i], "--ignore-size", 13) ||
+			(t = !strncmp(argv[i], "--keep-size", 11))) {
+			unsigned long sz;
+
+			t = t ? 13 : 11;
+			if (argv[i][t] == '=')
+				git_parse_ulong(argv[i] + t + 1, &sz);
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
@@ -183,12 +239,28 @@ commands:\n\
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
@@ -199,8 +271,14 @@ int cmd_rev_cache(int argc, const char *argv[], const char *prefix)
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
index d4b7e16..27e3b40 100644
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
@@ -319,27 +326,45 @@ unsigned char *get_cache_slice(struct commit *commit)
 
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
 	case OBJ_TREE:
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
 	case OBJ_BLOB:
-		if (revs->blob_objects)
-			obj = (struct object *)lookup_blob(entry->sha1);
-		break;
-	case OBJ_TAG:
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
+	default:
+		/* tag objects aren't really supposed to be here */
 		return;
+	}
 
 	obj->flags |= FACE_VALUE;
 	add_pending_object(revs, obj, "");
@@ -462,7 +487,7 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 		/* add extra objects if necessary */
 		if (entry->type != OBJ_COMMIT) {
 			if (consume_children)
-				handle_noncommit(revs, map + index, entry);
+				handle_noncommit(revs, co, map + index, entry);
 
 			continue;
 		} else
@@ -496,6 +521,8 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 			if (last_objects[path]) {
 				parse_commit(last_objects[path]);
 
+				/* we needn't worry about the unique field; that will be valid as
+				 * long as we're not a end entry */
 				last_objects[path]->object.flags &= ~FACE_VALUE;
 				last_objects[path] = 0;
 			}
@@ -635,6 +662,47 @@ static int get_cache_slice_header(unsigned char *cache_sha1, unsigned char *map,
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
+		if (read(fd, &ptr.version, 1) != 1 || ptr.version > SUPPORTED_REVCOPTR_VERSION)
+			goto end;
+
+		if (read_in_full(fd, ptr.path, sizeof(ptr.path)) != sizeof(ptr.path))
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
@@ -658,7 +726,7 @@ int traverse_cache_slice(struct rev_info *revs,
 
 	memset(&head, 0, sizeof(struct rc_slice_header));
 
-	fd = open(git_path("rev-cache/%s", sha1_to_hex(cache_sha1)), O_RDONLY);
+	fd = open_cache_slice(cache_sha1, O_RDONLY);
 	if (fd == -1)
 		goto end;
 	if (fstat(fd, &fi) || fi.st_size < SLICE_HEADER_SIZE)
@@ -685,6 +753,68 @@ end:
 
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
@@ -873,31 +1003,76 @@ static void handle_paths(struct commit *commit, struct rc_object_entry *object,
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
 
-	strbuf_add(acc_buffer, to_disked_rc_object_entry(nothisone, 0), OBJECT_ENTRY_SIZE);
+	entryp->size_size = encode_size(size, size_str);
+
+	/* write the muvabitch */
+	strbuf_add(acc_buffer, to_disked_rc_object_entry(entryp, 0), OBJECT_ENTRY_SIZE);
 
-	if (merge_str && merge_str->len)
+	if (merge_str)
 		strbuf_add(acc_buffer, merge_str->buf, merge_str->len);
-	if (split_str && split_str->len)
+	if (split_str)
 		strbuf_add(acc_buffer, split_str->buf, split_str->len);
 
+	strbuf_add(acc_buffer, size_str, entryp->size_size);
 }
 
 /* returns non-zero to continue parsing, 0 to skip */
@@ -941,12 +1116,7 @@ continue_loop:
 
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
@@ -956,15 +1126,7 @@ static void tree_addremove(struct diff_options *options,
 	const unsigned char *sha1,
 	const char *concatpath, unsigned dirty_sub)
 {
-	unsigned char data[21];
-
-	if (whatnow != '+')
-		return;
-
-	hashcpy(data, sha1);
-	data[20] = !!S_ISDIR(mode);
-
-	strbuf_add(acc_buffer, data, 21);
+	strbuf_add(acc_buffer, sha1, 20);
 }
 
 static void tree_change(struct diff_options *options,
@@ -974,26 +1136,7 @@ static void tree_change(struct diff_options *options,
 	const char *concatpath,
 	unsigned old_dirty_sub, unsigned new_dirty_sub)
 {
-	unsigned char data[21];
-
-	if (!hashcmp(old_sha1, new_sha1))
-		return;
-
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
@@ -1004,6 +1147,7 @@ static int add_unique_objects(struct commit *commit)
 	int i, j, next;
 	char is_first = 1;
 
+	/* ...no, calculate unique objects */
 	strbuf_init(&os, 0);
 	strbuf_init(&ost, 0);
 	orig_buf = acc_buffer;
@@ -1023,20 +1167,20 @@ static int add_unique_objects(struct commit *commit)
 
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
@@ -1045,25 +1189,102 @@ static int add_unique_objects(struct commit *commit)
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
 
-	strbuf_release(&ost);
-	strbuf_release(&os);
+static int add_objects_verbatim_1(struct rev_cache_slice_map *mapping, int *index)
+{
+	unsigned char *map = mapping->map;
+	int i = *index, object_nr = 0;
+	struct rc_object_entry *entry = RC_OBTAIN_OBJECT_ENTRY(map + i);
+
+	i += RC_ACTUAL_OBJECT_ENTRY_SIZE(entry);
+	while (i < mapping->size) {
+		int pos = i;
+
+		entry = RC_OBTAIN_OBJECT_ENTRY(map + i);
+		i += RC_ACTUAL_OBJECT_ENTRY_SIZE(entry);
+
+		if (entry->type == OBJ_COMMIT) {
+			*index = pos;
+			return object_nr;
+		}
+
+		strbuf_add(acc_buffer, map + pos, i - pos);
+		object_nr++;
+	}
 
-	return i / 21 + 1;
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
@@ -1078,9 +1299,14 @@ static void init_revcache_directory(void)
 
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
 
@@ -1161,9 +1387,13 @@ int make_cache_slice(struct rev_cache_info *rci,
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
@@ -1192,12 +1422,17 @@ int make_cache_slice(struct rev_cache_info *rci,
 
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
@@ -1332,6 +1567,8 @@ int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1,
 	unsigned char *map;
 	unsigned long max_date;
 
+	maybe_fill_with_defaults(rci);
+
 	if (!idx_map)
 		init_index();
 
@@ -1397,7 +1634,7 @@ int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1,
 		} else
 			disked_entry = search_index_1(object_entry->sha1);
 
-		if (disked_entry && !object_entry->is_start)
+		if (disked_entry && !object_entry->is_start && !rci->overwrite_all)
 			continue;
 		else if (disked_entry) {
 			/* mmm, pointer arithmetic... tasty */  /* (entry - idx_map = offset, so cast is valid) */
@@ -1451,8 +1688,7 @@ int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1,
 }
 
 
-/* add start-commits from each cache slice (uninterestingness will be propogated) */
-void starts_from_slices(struct rev_info *revs, unsigned int flags)
+void starts_from_slices(struct rev_info *revs, unsigned int flags, unsigned char *which, int n)
 {
 	struct commit *commit;
 	int i;
@@ -1468,6 +1704,18 @@ void starts_from_slices(struct rev_info *revs, unsigned int flags)
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
@@ -1477,3 +1725,316 @@ void starts_from_slices(struct rev_info *revs, unsigned int flags)
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
+	/* tread carefully with structures... */
+	write(fd, ptr.signature, sizeof(ptr.signature));
+	write(fd, &ptr.version, 1);
+	write_in_full(fd, ptr.path, sizeof(ptr.path));
+	make_cache_index(rci, sha1, fd, sizeof(ptr));
+
+	close(fd);
+
+	return 0;
+}
diff --git a/rev-cache.h b/rev-cache.h
index 75c3c71..6e3a895 100644
--- a/rev-cache.h
+++ b/rev-cache.h
@@ -3,6 +3,7 @@
 
 #define SUPPORTED_REVCACHE_VERSION 		1
 #define SUPPORTED_REVINDEX_VERSION		1
+#define SUPPORTED_REVCOPTR_VERSION		1
 
 #define RC_PATH_SIZE(x)	(2 * (x))
 
@@ -10,6 +11,7 @@
 #define RC_OBTAIN_INDEX_ENTRY(p)			from_disked_rc_index_entry((unsigned char *)(p), 0)
 
 #define RC_ACTUAL_OBJECT_ENTRY_SIZE(e)		(OBJECT_ENTRY_SIZE + RC_PATH_SIZE((e)->merge_nr + (e)->split_nr) + (e)->size_size)
+#define RC_ENTRY_SIZE_OFFSET(e)				(RC_ACTUAL_OBJECT_ENTRY_SIZE(e) - (e)->size_size)
 
 /* single index maps objects to cache files */
 struct rc_index_header {
@@ -89,6 +91,7 @@ struct rc_object_entry *from_disked_rc_object_entry(unsigned char *src, struct r
 unsigned char *to_disked_rc_object_entry(struct rc_object_entry *src, unsigned char **dst);
 
 extern unsigned char *get_cache_slice(struct commit *commit);
+extern int open_cache_slice(unsigned char *sha1, int flags);
 extern int traverse_cache_slice(struct rev_info *revs,
 	unsigned char *cache_sha1, struct commit *commit,
 	unsigned long *date_so_far, int *slop_so_far,
@@ -101,6 +104,10 @@ extern int make_cache_slice(struct rev_cache_info *rci,
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
index 0662c8c..825a9dd 100644
--- a/revision.h
+++ b/revision.h
@@ -24,17 +24,31 @@ struct rev_info;
 struct log_info;
 struct string_list;
 
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
@@ -149,7 +163,7 @@ struct rev_info {
 
 	/* notes-specific options: which refs to show */
 	struct display_notes_opt notes_opt;
-	
+
 	/* caching info, used ONLY by traverse_cache_slice */
 	struct rev_cache_info rev_cache_info;
 };
-- 
tg: (00928d8..) t/rc/misc (depends on: t/rc/objects)
