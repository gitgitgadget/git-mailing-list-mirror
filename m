From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH 3/6 (v4)] support for non-commit object caching in rev-cache
Date: Mon, 17 Aug 2009 14:31:27 +0200
Message-ID: <op.uys3qpixtdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmic
X-From: git-owner@vger.kernel.org Mon Aug 17 14:32:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md1OL-0002Yp-FK
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 14:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbZHQMbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 08:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbZHQMbc
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 08:31:32 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:60896 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbZHQMba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 08:31:30 -0400
Received: by ey-out-2122.google.com with SMTP id 22so667005eye.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=lXynYiQ8RJIV7jCCr808l19rISRPyzkgpKsdZ2c1/g0=;
        b=F+0I1m24e/qfqaRPBs9u96q9uugMD6DUZ9ByIM8FZ7ixQGmeoXoj3stdpuBsyWi6Om
         Uh3tENfVcQq7gb4mXq4uZzvlIkgs86mhVcXVUCBnFX1nsxhMHpmY3agHhH6jdvFHBEoq
         jGCvmYMQPkKvzvsM92pCtunHFITa9BOiFmC7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=wmOsTfYC9jKdkd+bK7dPTK6KhZc6VFMTWo8xbsG1tIPLFvuZLaQxoPIu078Q1iiuCd
         tFi+dEr8fmXuX2YUDVd/u6KTGJAJZOOVVQDHpFyTdGcTUULvafpukCI6asRLuq4+Zdc1
         1dQRPxzjk6U7EG0GOkxgOGJk45TOWE+kB8aYg=
Received: by 10.210.20.10 with SMTP id 10mr3160634ebt.72.1250512290781;
        Mon, 17 Aug 2009 05:31:30 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 28sm33325eye.24.2009.08.17.05.31.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 05:31:30 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126166>

Summarized, this third patch contains:
 - support for non-commit object caching
 - expansion of porcelain to accomodate non-commit objects
 - appropriate tests

Objects are stored relative to the commit in which they were introduced -- 
commits are 'diffed' against their parents.  This will eliminate the need for 
tree recursion in cached commits (significantly reducing I/O), and potentially 
be useful to external applications.

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
 rev-cache.c               |  204 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t6015-rev-cache-list.sh |    8 ++
 2 files changed, 209 insertions(+), 3 deletions(-)

diff --git a/rev-cache.c b/rev-cache.c
index a01db87..ddcc596 100644
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -257,6 +257,32 @@ unsigned char *get_cache_slice(struct commit *commit)
 
 /* traversal */
 
+static void handle_noncommit(struct rev_info *revs, unsigned char *ptr, struct rc_object_entry *entry)
+{
+	struct object *obj = 0;
+
+	switch (entry->type) {
+	case OBJ_TREE :
+		if (revs->tree_objects)
+			obj = (struct object *)lookup_tree(entry->sha1);
+		break;
+	case OBJ_BLOB :
+		if (revs->blob_objects)
+			obj = (struct object *)lookup_blob(entry->sha1);
+		break;
+	case OBJ_TAG :
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
 static int setup_traversal(struct rc_slice_header *head, unsigned char *map, struct commit *commit, struct commit_list **work)
 {
 	struct rc_index_entry *iep;
@@ -293,7 +319,7 @@ static int setup_traversal(struct rc_slice_header *head, unsigned char *map, str
 
 		if (iep->pos < retval)
 			retval = iep->pos;
-	
+
 		oep = RC_OBTAIN_OBJECT_ENTRY(map + iep->pos);
 
 		/* mark this for later */
@@ -345,9 +371,12 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
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
@@ -775,6 +804,171 @@ static void add_object_entry(const unsigned char *sha1, int type, struct rc_obje
 
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
+		case 0 :
+			goto continue_loop;
+		default :
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
+	const char *concatpath)
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
+	const char *concatpath)
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
@@ -900,6 +1094,10 @@ int make_cache_slice(struct rev_cache_info *rci,
 		add_object_entry(0, 0, &object, &merge_paths, &split_paths);
 		object_nr++;
 
+		/* add all unique children for this commit */
+		if (rci->objects && !object.is_end)
+			object_nr += add_unique_objects(commit);
+
 		/* print every ~1MB or so */
 		if (buffer.len > 1000000) {
 			write_in_full(fd, buffer.buf, buffer.len);
diff --git a/t/t6015-rev-cache-list.sh b/t/t6015-rev-cache-list.sh
index e7474fd..afa0303 100755
--- a/t/t6015-rev-cache-list.sh
+++ b/t/t6015-rev-cache-list.sh
@@ -79,6 +79,7 @@ test_expect_success 'init repo' '
 
 git-rev-list HEAD --not HEAD~3 >proper_commit_list_limited
 git-rev-list HEAD >proper_commit_list
+git-rev-list HEAD --objects >proper_object_list
 
 test_expect_success 'make cache slice' '
 	git-rev-cache add HEAD 2>output.err && 
@@ -101,4 +102,11 @@ test_expect_success 'test rev-caches walker directly (unlimited)' '
 	test_cmp_sorted list proper_commit_list
 '
 
+#do the same for objects
+test_expect_success 'test rev-caches walker with objects' '
+	git-rev-cache walk --objects HEAD >list && 
+	test_cmp_sorted list proper_object_list
+'
+
 test_done
+
-- 
tg: (212c9b6..) t/revcache/objects (depends on: t/revcache/basic)
