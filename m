From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 3/6 (v4)] support for non-commit object caching in rev-cache
Date: Mon, 19 Oct 2009 21:28:55 +0100
Message-ID: <4ADCCC07.9030808@gmail.com>
References: <op.uys3qpixtdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail
X-From: git-owner@vger.kernel.org Mon Oct 19 22:29:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzyqu-00041R-EY
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 22:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbZJSU3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 16:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbZJSU3A
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 16:29:00 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:50713 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbZJSU27 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 16:28:59 -0400
Received: by mail-fx0-f218.google.com with SMTP id 18so5542825fxm.37
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=pWFKFMzaLq/HS0o6RVNoSQ7k23H3kFNcZTEGAAu9e2Q=;
        b=b1VHsTaL7dXEW+gzNpJsdIoB6ltJeBHvSKejsxYU11d2kFL7SvWT+hHDcKNH4RRrYm
         nw3J7oT//sKOboUQI6FUvA/utHiN3IROZ9+pznrunFaUrpVXH0pNky6Jns/SqfY6fIGr
         Rmv4fEVN1Cn7crnJacEE3XcnVbw0zadpDkUv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=XOtzchoUPcmuzRtlDNJc3LNLV+x5zlMbSiqfU6tMScUuSnq2fV+ZCXACbCqJNDm2Xf
         42cGHlqx9iIoAXujS8Zo11n+wqC3k/7l0TkxtjzlzR7SsT5r+8lUOiiUpOomu8rpyaCT
         5DymNQvZVk5VHVcOqFCLSmvTJW21aLT+trEPg=
Received: by 10.103.80.20 with SMTP id h20mr2203789mul.21.1255984143608;
        Mon, 19 Oct 2009 13:29:03 -0700 (PDT)
Received: from ?172.20.56.35? (cnat210.wlan.net.ed.ac.uk [129.215.5.210])
        by mx.google.com with ESMTPS id e8sm137218muf.59.2009.10.19.13.29.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Oct 2009 13:29:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <op.uys3qpixtdk399@sirnot.private>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130737>

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
 t/t6017-rev-cache-list.sh |    6 ++
 2 files changed, 206 insertions(+), 2 deletions(-)

diff --git a/rev-cache.c b/rev-cache.c
index 8951cdf..ef6b58a 100644
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -259,6 +259,32 @@ unsigned char *get_cache_slice(struct commit *commit)
 
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
diff --git a/t/t6017-rev-cache-list.sh b/t/t6017-rev-cache-list.sh
index f59f568..dc0fc07 100755
--- a/t/t6017-rev-cache-list.sh
+++ b/t/t6017-rev-cache-list.sh
@@ -102,5 +102,11 @@ test_expect_success 'test rev-caches walker directly (unlimited)' '
 	test_cmp_sorted list proper_commit_list
 '
 
+#do the same for objects
+test_expect_success 'test rev-caches walker with objects' '
+	git-rev-cache walk --objects HEAD >list &&
+	test_cmp_sorted list proper_object_list
+'
+
 test_done
 
-- 
tg: (3bf0747..) t/revcache/objects (depends on: t/revcache/basic)
