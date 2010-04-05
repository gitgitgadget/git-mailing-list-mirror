From: Nick Edelen <sirnot@gmail.com>
Subject: [PATCH 3/7 (v5)] support for non-commit objects
Date: Mon, 05 Apr 2010 20:58:13 +0100
Message-ID: <4BBA40D5.7040104@gmail.com>
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
	id 1NysRI-0000WJ-7g
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756386Ab0DET6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:58:19 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:33419 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab0DET6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:58:13 -0400
Received: by mail-ew0-f220.google.com with SMTP id 20so121824ewy.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=Levqq8wp0E1OWe/p7AGgeiDtgV6OAePnfoOl9aU829U=;
        b=POXobXxBzrwUUMR7xJJ8RQLJyM/NYWSSp2i/MJDMt4kjxD27WQzwwgrPKB77o4a95k
         8UR6vRF1n+TMJtYPUw09c2YgYIinxdo1hHQ6l15K+G0j2HzBCt1qhB/1QD3Z/yeWyE/N
         q5RtUUIiu+yRY9VDJSbhvGNsuRGmBnrmTDXnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=rfJjSzDCHNsZSseumhqzsFfepLgeHHPooNCdtprfLK7HhdO+C2/lbe2QIT/Jj49PSZ
         3XgU7IePvMVMg8wnT0XN7Mzd6Qbli9uPPAjGqlFPabIbeOiSoiW0LGvKp2zudjCpWyF4
         0RR2Ls2zTgoAsjY6ab31qXDAW4oBkHdAf5zeM=
Received: by 10.213.39.196 with SMTP id h4mr1634777ebe.97.1270497492501;
        Mon, 05 Apr 2010 12:58:12 -0700 (PDT)
Received: from [192.168.55.86] (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 14sm6532996ewy.14.2010.04.05.12.58.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 12:58:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144062>

Contains:
 - support for non-commit object caching
 - expansion of porcelain to accomodate non-commit objects
 - appropriate tests

Objects are stored relative to the commit in which they were introduced --
commits are 'diffed' against their parents.  This will eliminate the need for
tree recursion in cached commits (significantly reducing I/O), and potentially
be useful to external applications.

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
 rev-cache.c               |  214 ++++++++++++++++++++++++++++++++++++++++++++-
 rev-cache.h               |    3 +-
 t/t6019-rev-cache-list.sh |    6 ++
 3 files changed, 218 insertions(+), 5 deletions(-)

diff --git a/rev-cache.c b/rev-cache.c
index aa98585..d4b7e16 100644
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -126,7 +126,8 @@ struct rc_object_entry *from_disked_rc_object_entry(unsigned char *src, struct r
 	dst->type = *src >> 5;
 	dst->is_end = !!(*src & 0x10);
 	dst->is_start = !!(*src & 0x08);
-	dst->flag = *src & 0x07;
+	dst->has_objects = !!(*src & 0x04);
+	dst->flag = *src & 0x03;
 
 	dst->sha1 = (unsigned char *)(src + 1);
 	dst->merge_nr = *(src + 21);
@@ -158,6 +159,7 @@ unsigned char *to_disked_rc_object_entry(struct rc_object_entry *src, unsigned c
 	*dst  = (unsigned char)src->type << 5;
 	*dst |= (unsigned char)src->is_end << 4;
 	*dst |= (unsigned char)src->is_start << 3;
+	*dst |= (unsigned char)src->has_objects << 2;
 	*dst |= (unsigned char)src->flag;
 
 	if (dst + 1 != src->sha1)
@@ -317,6 +319,32 @@ unsigned char *get_cache_slice(struct commit *commit)
 
 /* traversal */
 
+static void handle_noncommit(struct rev_info *revs, unsigned char *ptr, struct rc_object_entry *entry)
+{
+	struct object *obj = 0;
+
+	switch (entry->type) {
+	case OBJ_TREE:
+		if (revs->tree_objects)
+			obj = (struct object *)lookup_tree(entry->sha1);
+		break;
+	case OBJ_BLOB:
+		if (revs->blob_objects)
+			obj = (struct object *)lookup_blob(entry->sha1);
+		break;
+	case OBJ_TAG:
+		if (revs->tag_objects)
+			obj = (struct object *)lookup_tag(entry->sha1);
+		break;
+	}
+
+	if (!obj)
+		return;
+
+	obj->flags |= FACE_VALUE;
+	add_pending_object(revs, obj, "");
+}
+
 struct entrance_point {
 	int pos;
 	char uninteresting;
@@ -432,9 +460,12 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 		i += RC_ACTUAL_OBJECT_ENTRY_SIZE(entry);
 
 		/* add extra objects if necessary */
-		if (entry->type != OBJ_COMMIT)
+		if (entry->type != OBJ_COMMIT) {
+			if (consume_children)
+				handle_noncommit(revs, map + index, entry);
+
 			continue;
-		else
+		} else
 			consume_children = 0;
 
 		if (path >= total_path_nr)
@@ -514,7 +545,9 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 		/* initialize commit */
 		if (!entry->is_end) {
 			co->date = entry->date;
-			obj->flags |= ADDED | FACE_VALUE;
+			obj->flags |= ADDED;
+			if (entry->has_objects)
+				obj->flags |= FACE_VALUE;
 		} else
 			parse_commit(co);
 
@@ -867,6 +900,172 @@ static void add_object_entry(const unsigned char *sha1, int type, struct rc_obje
 
 }
 
+/* returns non-zero to continue parsing, 0 to skip */
+typedef int (*dump_tree_fn)(const unsigned char *, const char *, unsigned int); /* sha1, path, mode */
+
+/* we need to walk the trees by hash, so unfortunately we can't use traverse_trees in tree-walk.c */
+static int dump_tree(struct tree *tree, dump_tree_fn fn)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct tree *subtree;
+	int r;
+
+	if (parse_tree(tree))
+		return -1;
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	while (tree_entry(&desc, &entry)) {
+		switch (fn(entry.sha1, entry.path, entry.mode)) {
+		case 0:
+			goto continue_loop;
+		default:
+			break;
+		}
+
+		if (S_ISDIR(entry.mode)) {
+			subtree = lookup_tree(entry.sha1);
+			if (!subtree)
+				return -2;
+
+			if ((r = dump_tree(subtree, fn)) < 0)
+				return r;
+		}
+
+continue_loop:
+		continue;
+	}
+
+	return 0;
+}
+
+static int dump_tree_callback(const unsigned char *sha1, const char *path, unsigned int mode)
+{
+	unsigned char data[21];
+
+	hashcpy(data, sha1);
+	data[20] = !!S_ISDIR(mode);
+
+	strbuf_add(acc_buffer, data, 21);
+
+	return 1;
+}
+
+static void tree_addremove(struct diff_options *options,
+	int whatnow, unsigned mode,
+	const unsigned char *sha1,
+	const char *concatpath, unsigned dirty_sub)
+{
+	unsigned char data[21];
+
+	if (whatnow != '+')
+		return;
+
+	hashcpy(data, sha1);
+	data[20] = !!S_ISDIR(mode);
+
+	strbuf_add(acc_buffer, data, 21);
+}
+
+static void tree_change(struct diff_options *options,
+	unsigned old_mode, unsigned new_mode,
+	const unsigned char *old_sha1,
+	const unsigned char *new_sha1,
+	const char *concatpath,
+	unsigned old_dirty_sub, unsigned new_dirty_sub)
+{
+	unsigned char data[21];
+
+	if (!hashcmp(old_sha1, new_sha1))
+		return;
+
+	hashcpy(data, new_sha1);
+	data[20] = !!S_ISDIR(new_mode);
+
+	strbuf_add(acc_buffer, data, 21);
+}
+
+static int sort_type_hash(const void *a, const void *b)
+{
+	const unsigned char *sa = (const unsigned char *)a,
+		*sb = (const unsigned char *)b;
+
+	if (sa[20] == sb[20])
+		return hashcmp(sa, sb);
+
+	return sa[20] > sb[20] ? -1 : 1;
+}
+
+static int add_unique_objects(struct commit *commit)
+{
+	struct commit_list *list;
+	struct strbuf os, ost, *orig_buf;
+	struct diff_options opts;
+	int i, j, next;
+	char is_first = 1;
+
+	strbuf_init(&os, 0);
+	strbuf_init(&ost, 0);
+	orig_buf = acc_buffer;
+
+	diff_setup(&opts);
+	DIFF_OPT_SET(&opts, RECURSIVE);
+	DIFF_OPT_SET(&opts, TREE_IN_RECURSIVE);
+	opts.change = tree_change;
+	opts.add_remove = tree_addremove;
+
+	/* this is only called for non-ends (ie. all parents interesting) */
+	for (list = commit->parents; list; list = list->next) {
+		if (is_first)
+			acc_buffer = &os;
+		else
+			acc_buffer = &ost;
+
+		strbuf_setlen(acc_buffer, 0);
+		diff_tree_sha1(list->item->tree->object.sha1, commit->tree->object.sha1, "", &opts);
+		qsort(acc_buffer->buf, acc_buffer->len / 21, 21, (int (*)(const void *, const void *))hashcmp);
+
+		/* take intersection */
+		if (!is_first) {
+			for (next = i = j = 0; i < os.len; i += 21) {
+				while (j < ost.len && hashcmp((unsigned char *)(ost.buf + j), (unsigned char *)(os.buf + i)) < 0)
+					j += 21;
+
+				if (j >= ost.len || hashcmp((unsigned char *)(ost.buf + j), (unsigned char *)(os.buf + i)))
+					continue;
+
+				if (next != i)
+					memcpy(os.buf + next, os.buf + i, 21);
+				next += 21;
+			}
+
+			if (next != i)
+				strbuf_setlen(&os, next);
+		} else
+			is_first = 0;
+	}
+
+	if (is_first) {
+		acc_buffer = &os;
+		dump_tree(commit->tree, dump_tree_callback);
+	}
+
+	if (os.len)
+		qsort(os.buf, os.len / 21, 21, sort_type_hash);
+
+	acc_buffer = orig_buf;
+	for (i = 0; i < os.len; i += 21)
+		add_object_entry((unsigned char *)(os.buf + i), os.buf[i + 20] ? OBJ_TREE : OBJ_BLOB, 0, 0, 0);
+
+	/* last but not least, the main tree */
+	add_object_entry(commit->tree->object.sha1, OBJ_TREE, 0, 0, 0);
+
+	strbuf_release(&ost);
+	strbuf_release(&os);
+
+	return i / 21 + 1;
+}
+
 static void init_revcache_directory(void)
 {
 	struct stat fi;
@@ -988,11 +1187,18 @@ int make_cache_slice(struct rev_cache_info *rci,
 				commit_list_insert(commit, starts);
 		}
 
+		if (rci->objects)
+			object.has_objects = 1;
+
 		commit->indegree = 0;
 
 		add_object_entry(0, 0, &object, &merge_paths, &split_paths);
 		object_nr++;
 
+		/* add all unique children for this commit */
+		if (rci->objects && !object.is_end)
+			object_nr += add_unique_objects(commit);
+
 		/* print every ~1MB or so */
 		if (buffer.len > 1000000) {
 			write_in_full(fd, buffer.buf, buffer.len);
diff --git a/rev-cache.h b/rev-cache.h
index 76f4fb4..75c3c71 100644
--- a/rev-cache.h
+++ b/rev-cache.h
@@ -66,7 +66,8 @@ struct rc_object_entry {
 	unsigned type:3;
 	unsigned is_end:1;
 	unsigned is_start:1;
-	unsigned flag:3; /* unused */
+	unsigned has_objects:1;
+	unsigned flag:2; /* unused */
 	unsigned char *sha1; /* 20 byte */
 
 	unsigned char merge_nr; /* : 7 */
diff --git a/t/t6019-rev-cache-list.sh b/t/t6019-rev-cache-list.sh
index 8017e62..b6cf6fc 100644
--- a/t/t6019-rev-cache-list.sh
+++ b/t/t6019-rev-cache-list.sh
@@ -102,5 +102,11 @@ test_expect_success 'test rev-caches walker directly (unlimited)' '
 	test_cmp_sorted list proper_commit_list
 '
 
+#do the same for objects
+test_expect_success 'test rev-caches walker with objects' '
+	git rev-cache walk --objects HEAD >list &&
+	test_cmp_sorted list proper_object_list
+'
+
 test_done
 
-- 
tg: (d461192..) t/rc/objects (depends on: t/rc/basic)
