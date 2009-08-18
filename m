From: "Nick Edelen" <sirnot@gmail.com>
Subject: Re: [PATCH 3/6 (v4)] support for non-commit object caching in
 rev-cache
Date: Tue, 18 Aug 2009 13:51:53 +0200
Message-ID: <op.uyuwkrfntdk399@sirnot.private>
References: <op.uys3qpixtdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Nick Edelen" <sirnot@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.n
X-From: git-owner@vger.kernel.org Tue Aug 18 13:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdNEl-0007DA-2s
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 13:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758637AbZHRLwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 07:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758623AbZHRLwA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 07:52:00 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:57865 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758531AbZHRLvz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 07:51:55 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so1509359ewy.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 04:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:references:content-transfer-encoding
         :message-id:in-reply-to:user-agent;
        bh=zvtxgkXDoDWNbAfrFpj+98GNEdnqWlHrr1Qbl2YF4i4=;
        b=oc5Ui/2xcmWziKfcsQe5bMVueQXiGD0cMQ22281tCyJ60AhbsOwoND2TKsAreJlPrx
         vHdNf/dYOd7KgdYaiDjw3z9jeZluOLXQe0jCJtn2vWkwthnk6FMwUpvA1MSMGwK7tnax
         b61x7CnNeg5sjLxVOn2raulGho5f8GfcAUBIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version:references
         :content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=j+KcsymV7Ckoiglb88IpJ186W8vKqxwLwAGXVPQgjjI+49od/Aph63MJmb4JEqoqag
         eBMmiGG0XnFSBLq/4Bktiia5cV2mXDuahsgT84a4GmuQiI3Ek7wRv5t3TrkH5Hx0HC32
         7R4MOPxKZSCBeBEgALz5iyak7ReGsPQKgzaKc=
Received: by 10.216.87.209 with SMTP id y59mr1323180wee.21.1250596316746;
        Tue, 18 Aug 2009 04:51:56 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id m5sm18764413gve.18.2009.08.18.04.51.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 04:51:56 -0700 (PDT)
In-Reply-To: <op.uys3qpixtdk399@sirnot.private>
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126382>

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
 rev-cache.c               |  202 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t6015-rev-cache-list.sh |   10 ++-
 2 files changed, 209 insertions(+), 3 deletions(-)

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
index 95e00a8..dc0fc07 100755
--- a/t/t6015-rev-cache-list.sh
+++ b/t/t6015-rev-cache-list.sh
@@ -73,12 +73,13 @@ test_expect_success 'init repo' '
 
 	git checkout master &&
 	git merge -m "triple merge" b1 b11 &&
-	git rm -r d1 && 
+	git rm -r d1 &&
 	git commit -a -m "oh noes"
 '
 
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
tg: (ee3df39..) t/revcache/objects (depends on: t/revcache/basic)
