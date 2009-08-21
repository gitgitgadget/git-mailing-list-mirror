From: "Nick Edelen" <sirnot@gmail.com>
Subject: Re: [PATCH 3/6 (v4)] support for non-commit object caching in
 rev-cache
Date: Fri, 21 Aug 2009 06:47:54 +0200
Message-ID: <op.uyzwx4c6tdk399@sirnot>
References: <op.uys3qpixtdk399@sirnot.private>
 <op.uyuwkrfntdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Nick Edelen" <sirnot@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.n
X-From: git-owner@vger.kernel.org Fri Aug 21 07:13:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeMR0-000716-1S
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 07:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbZHUFMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 01:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbZHUFMx
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 01:12:53 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:43562 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbZHUFMw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 01:12:52 -0400
X-Greylist: delayed 1005 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2009 01:12:52 EDT
Received: by pzk32 with SMTP id 32so39605pzk.33
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 22:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:references:content-transfer-encoding
         :message-id:in-reply-to:user-agent;
        bh=KDfBNf1shXb6QiBl6lZm+y2Diil11J9YybXxz97oRcI=;
        b=XUInMmPCeEJ7/Jy7qxZH4zI2GoYwYsxx6IlKcSbD06z/PbBmDMVsB5/1gh7KfL7R8O
         f1WyGnFu/c5e1AHV7wT5Y5pCIZGHYE2oPIwo+39z2d+t4blfaRRJxPuavuaqVrpgYeLX
         bmph109pP5Uzt35PTK8k7o3ycVvoPO3fCoRzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version:references
         :content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=vE1fZH9+j3nFOIkEZ0HN34WvYFrfjGCwpC1Rl2jao8OQDyWiLtb69f4whXSeg2AwMI
         13CTc0Yp3ECCPumCylhUC1aVnlB+HkrEttwAoJkILdj7wx5C/cTGZHjH7GOEJSVEoGHa
         T5GGstV9yHeIwbb1wDj8ZDjiIK58esHHiDYIk=
Received: by 10.115.81.38 with SMTP id i38mr991003wal.55.1250830081139;
        Thu, 20 Aug 2009 21:48:01 -0700 (PDT)
Received: from sirnot ([71.32.109.42])
        by mx.google.com with ESMTPS id j15sm485500waf.16.2009.08.20.21.47.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 21:48:00 -0700 (PDT)
In-Reply-To: <op.uyuwkrfntdk399@sirnot.private>
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126676>

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
nothing new here; ensuring patchset is consistent.

 rev-cache.c               |  202 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t6015-rev-cache-list.sh |    8 ++
 2 files changed, 208 insertions(+), 2 deletions(-)

diff --git a/rev-cache.c b/rev-cache.c
index 8951cdf..8af8c85 100644
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -259,6 +259,32 @@ unsigned char *get_cache_slice(struct commit *commit)
 
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
@@ -347,9 +373,12 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
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
@@ -777,6 +806,171 @@ static void add_object_entry(const unsigned char *sha1, int type, struct rc_obje
 
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
@@ -902,6 +1096,10 @@ int make_cache_slice(struct rev_cache_info *rci,
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
index fc29311..dc0fc07 100755
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
tg: (350f6ab..) t/revcache/objects (depends on: t/revcache/basic)
