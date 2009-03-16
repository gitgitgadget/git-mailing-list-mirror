From: pi song <pi.songs@gmail.com>
Subject: [PATCH2/2]  Libify blame
Date: Tue, 17 Mar 2009 00:30:14 +1100
Message-ID: <49BE5466.5050202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 16 14:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjCvd-0006jX-7l
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 14:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbZCPNae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 09:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbZCPNac
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 09:30:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:61927 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760248AbZCPNaX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 09:30:23 -0400
Received: by wa-out-1112.google.com with SMTP id v33so1779573wah.21
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=1vJoeC2z0rS8XcnDq2I2IbNogGZHUpin74s1w8F8Kg4=;
        b=Wi0B/zPN0VeU7Jn65i3a2dGvLVo45TvPrJA9pAQxt0/PW3MsRNm+RjPxYwS+Us3CcU
         sWkgjuf3uDhS2QDSMKePuxsMPeXagoc0XPRwSaWhi6GzPJ2G71OboHDnhT/cmCeNOACh
         +hHHUUR++H7PsnMGAlcIUVHyl/IkFf5Dj0Ec0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=s0iOzfrTrO9Z50XOQgnwyiA15iFCWxiIOxTKDCe5JU5OiaxRkTN5AFRSJoJHw5RjEB
         QbepITgLUAOyxIVe9GwPLlBRWwNJkGbN1dFahTlTRdTb7JDSQ4dKAVIT1bmP+qwt6uml
         iFD2cl7hGylWb0aHLcjyS40cAy1I/3AfKw0qQ=
Received: by 10.114.211.2 with SMTP id j2mr3333170wag.139.1237210220397;
        Mon, 16 Mar 2009 06:30:20 -0700 (PDT)
Received: from ?192.168.0.5? (203-219-184-102.static.tpgi.com.au [203.219.184.102])
        by mx.google.com with ESMTPS id m29sm16312356poh.20.2009.03.16.06.30.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Mar 2009 06:30:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113323>

This looks like a very HUGE patch but it does merely splitting the current builtin-blame.c into smaller blame.c without changing any logic.
This is still WIP. The next patch will organize functions more appropriately.


Signed-off-by: Pi Song <pi.songs@gmail.com>
---
 Makefile        |    1 +
 blame.c         | 1744 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 blame.h         |   21 +
 builtin-blame.c | 1703 -----------------------------------------------------
 4 files changed, 1766 insertions(+), 1703 deletions(-)
 create mode 100644 blame.c

diff --git a/Makefile b/Makefile
index cc0fb5a..ac438a5 100644
--- a/Makefile
+++ b/Makefile
@@ -423,6 +423,7 @@ LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
+LIB_OBJS += blame.o
 LIB_OBJS += blob.o
 LIB_OBJS += branch.o
 LIB_OBJS += bundle.o
diff --git a/blame.c b/blame.c
new file mode 100644
index 0000000..f408581
--- /dev/null
+++ b/blame.c
@@ -0,0 +1,1744 @@
+/*
+ * Blame
+ *
+ * Copyright (c) 2006, Junio C Hamano
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "blob.h"
+#include "commit.h"
+#include "tag.h"
+#include "tree-walk.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
+#include "quote.h"
+#include "xdiff-interface.h"
+#include "cache-tree.h"
+#include "string-list.h"
+#include "mailmap.h"
+#include "parse-options.h"
+#include "utf8.h"
+#include "blame.h"
+
+static char blame_usage[] = "git blame [options] [rev-opts] [rev] [--] file";
+
+static const char *blame_opt_usage[] = {
+	blame_usage,
+	"",
+	"[rev-opts] are documented in git-rev-list(1)",
+	NULL
+};
+
+/* only use for command line parameter parsing */
+static unsigned opt_blame_move_score;
+static unsigned opt_blame_copy_score;
+
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+/*
+ * Given an origin, prepare mmfile_t structure to be used by the
+ * diff machinery
+ */
+static void fill_origin_blob(struct blame_info *ssb, struct origin *o, mmfile_t *file)
+{
+	if (!o->file.ptr) {
+		enum object_type type;
+		ssb->stat->num_read_blob++;
+		file->ptr = read_sha1_file(o->blob_sha1, &type,
+					   (unsigned long *)(&(file->size)));
+		if (!file->ptr)
+			die("Cannot read blob %s for path %s",
+			    sha1_to_hex(o->blob_sha1),
+			    o->path);
+		o->file = *file;
+	}
+	else
+		*file = o->file;
+}
+
+/*
+ * Origin is refcounted and usually we keep the blob contents to be
+ * reused.
+ */
+static inline struct origin *origin_incref(struct origin *o)
+{
+	if (o)
+		o->refcnt++;
+	return o;
+}
+
+static void origin_decref(struct origin *o)
+{
+	if (o && --o->refcnt <= 0) {
+		if (o->previous)
+			origin_decref(o->previous);
+		free(o->file.ptr);
+		free(o);
+	}
+}
+
+static void drop_origin_blob(struct origin *o)
+{
+	if (o->file.ptr) {
+		free(o->file.ptr);
+		o->file.ptr = NULL;
+	}
+}
+
+static inline int same_suspect(struct origin *a, struct origin *b)
+{
+	if (a == b)
+		return 1;
+	if (a->commit != b->commit)
+		return 0;
+	return !strcmp(a->path, b->path);
+}
+
+static void sanity_check_refcnt(struct blame_scoreboard *);
+
+/*
+ * If two blame entries that are next to each other came from
+ * contiguous lines in the same origin (i.e. <commit, path> pair),
+ * merge them together.
+ */
+void coalesce(struct blame_scoreboard *sb)
+{
+	struct blame_entry *ent, *next;
+
+	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
+		if (same_suspect(ent->suspect, next->suspect) &&
+		    ent->guilty == next->guilty &&
+		    ent->s_lno + ent->num_lines == next->s_lno) {
+			ent->num_lines += next->num_lines;
+			ent->next = next->next;
+			if (ent->next)
+				ent->next->prev = ent;
+			origin_decref(next->suspect);
+			free(next);
+			ent->score = 0;
+			next = ent; /* again */
+		}
+	}
+
+	if (DEBUG) /* sanity */
+		sanity_check_refcnt(sb);
+}
+
+/*
+ * Given a commit and a path in it, create a new origin structure.
+ * The callers that add blame to the scoreboard should use
+ * get_origin() to obtain shared, refcounted copy instead of calling
+ * this function directly.
+ */
+struct origin *make_origin(struct commit *commit, const char *path)
+{
+	struct origin *o;
+	o = xcalloc(1, sizeof(*o) + strlen(path) + 1);
+	o->commit = commit;
+	o->refcnt = 1;
+	strcpy(o->path, path);
+	return o;
+}
+
+/*
+ * Locate an existing origin or create a new one.
+ */
+struct origin *get_origin(struct blame_scoreboard *sb,
+	 		  struct commit *commit,
+			  const char *path)
+{
+	struct blame_entry *e;
+
+	for (e = sb->ent; e; e = e->next) {
+		if (e->suspect->commit == commit &&
+		    !strcmp(e->suspect->path, path))
+			return origin_incref(e->suspect);
+	}
+	return make_origin(commit, path);
+}
+
+/*
+ * Fill the blob_sha1 field of an origin if it hasn't, so that later
+ * call to fill_origin_blob() can use it to locate the data.  blob_sha1
+ * for an origin is also used to pass the blame for the entire file to
+ * the parent to detect the case where a child's blob is identical to
+ * that of its parent's.
+ */
+int fill_blob_sha1(struct origin *origin)
+{
+	unsigned mode;
+
+	if (!is_null_sha1(origin->blob_sha1))
+		return 0;
+	if (get_tree_entry(origin->commit->object.sha1,
+			   origin->path,
+			   origin->blob_sha1, &mode))
+		goto error_out;
+	if (sha1_object_info(origin->blob_sha1, NULL) != OBJ_BLOB)
+		goto error_out;
+	return 0;
+ error_out:
+	hashclr(origin->blob_sha1);
+	return -1;
+}
+
+/*
+ * We have an origin -- check if the same path exists in the
+ * parent and return an origin structure to represent it.
+ */
+static struct origin *find_origin(struct blame_scoreboard *sb,
+				  struct commit *parent,
+				  struct origin *origin)
+{
+	struct origin *porigin = NULL;
+	struct diff_options diff_opts;
+	const char *paths[2];
+
+	if (parent->util) {
+		/*
+		 * Each commit object can cache one origin in that
+		 * commit.  This is a freestanding copy of origin and
+		 * not refcounted.
+		 */
+		struct origin *cached = parent->util;
+		if (!strcmp(cached->path, origin->path)) {
+			/*
+			 * The same path between origin and its parent
+			 * without renaming -- the most common case.
+			 */
+			porigin = get_origin(sb, parent, cached->path);
+
+			/*
+			 * If the origin was newly created (i.e. get_origin
+			 * would call make_origin if none is found in the
+			 * scoreboard), it does not know the blob_sha1,
+			 * so copy it.  Otherwise porigin was in the
+			 * scoreboard and already knows blob_sha1.
+			 */
+			if (porigin->refcnt == 1)
+				hashcpy(porigin->blob_sha1, cached->blob_sha1);
+			return porigin;
+		}
+		/* otherwise it was not very useful; free it */
+		free(parent->util);
+		parent->util = NULL;
+	}
+
+	/* See if the origin->path is different between parent
+	 * and origin first.  Most of the time they are the
+	 * same and diff-tree is fairly efficient about this.
+	 */
+	diff_setup(&diff_opts);
+	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	diff_opts.detect_rename = 0;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	paths[0] = origin->path;
+	paths[1] = NULL;
+
+	diff_tree_setup_paths(paths, &diff_opts);
+	if (diff_setup_done(&diff_opts) < 0)
+		die("diff-setup");
+
+	if (is_null_sha1(origin->commit->object.sha1))
+		do_diff_cache(parent->tree->object.sha1, &diff_opts);
+	else
+		diff_tree_sha1(parent->tree->object.sha1,
+			       origin->commit->tree->object.sha1,
+			       "", &diff_opts);
+	diffcore_std(&diff_opts);
+
+	/* It is either one entry that says "modified", or "created",
+	 * or nothing.
+	 */
+	if (!diff_queued_diff.nr) {
+		/* The path is the same as parent */
+		porigin = get_origin(sb, parent, origin->path);
+		hashcpy(porigin->blob_sha1, origin->blob_sha1);
+	}
+	else if (diff_queued_diff.nr != 1)
+		die("internal error in blame::find_origin");
+	else {
+		struct diff_filepair *p = diff_queued_diff.queue[0];
+		switch (p->status) {
+		default:
+			die("internal error in blame::find_origin (%c)",
+			    p->status);
+		case 'M':
+			porigin = get_origin(sb, parent, origin->path);
+			hashcpy(porigin->blob_sha1, p->one->sha1);
+			break;
+		case 'A':
+		case 'T':
+			/* Did not exist in parent, or type changed */
+			break;
+		}
+	}
+	diff_flush(&diff_opts);
+	diff_tree_release_paths(&diff_opts);
+	if (porigin) {
+		/*
+		 * Create a freestanding copy that is not part of
+		 * the refcounted origin found in the scoreboard, and
+		 * cache it in the commit.
+		 */
+		struct origin *cached;
+
+		cached = make_origin(porigin->commit, porigin->path);
+		hashcpy(cached->blob_sha1, porigin->blob_sha1);
+		parent->util = cached;
+	}
+	return porigin;
+}
+
+/*
+ * We have an origin -- find the path that corresponds to it in its
+ * parent and return an origin structure to represent it.
+ */
+static struct origin *find_rename(struct blame_scoreboard *sb,
+				  struct commit *parent,
+				  struct origin *origin)
+{
+	struct origin *porigin = NULL;
+	struct diff_options diff_opts;
+	int i;
+	const char *paths[2];
+
+	diff_setup(&diff_opts);
+	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	diff_opts.detect_rename = DIFF_DETECT_RENAME;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.single_follow = origin->path;
+	paths[0] = NULL;
+	diff_tree_setup_paths(paths, &diff_opts);
+	if (diff_setup_done(&diff_opts) < 0)
+		die("diff-setup");
+
+	if (is_null_sha1(origin->commit->object.sha1))
+		do_diff_cache(parent->tree->object.sha1, &diff_opts);
+	else
+		diff_tree_sha1(parent->tree->object.sha1,
+			       origin->commit->tree->object.sha1,
+			       "", &diff_opts);
+	diffcore_std(&diff_opts);
+
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+		if ((p->status == 'R' || p->status == 'C') &&
+		    !strcmp(p->two->path, origin->path)) {
+			porigin = get_origin(sb, parent, p->one->path);
+			hashcpy(porigin->blob_sha1, p->one->sha1);
+			break;
+		}
+	}
+	diff_flush(&diff_opts);
+	diff_tree_release_paths(&diff_opts);
+	return porigin;
+}
+
+/*
+ * Link in a new blame entry to the scoreboard.  Entries that cover the
+ * same line range have been removed from the scoreboard previously.
+ */
+static void add_blame_entry(struct blame_scoreboard *sb, struct blame_entry *e)
+{
+	struct blame_entry *ent, *prev = NULL;
+
+	origin_incref(e->suspect);
+
+	for (ent = sb->ent; ent && ent->lno < e->lno; ent = ent->next)
+		prev = ent;
+
+	/* prev, if not NULL, is the last one that is below e */
+	e->prev = prev;
+	if (prev) {
+		e->next = prev->next;
+		prev->next = e;
+	}
+	else {
+		e->next = sb->ent;
+		sb->ent = e;
+	}
+	if (e->next)
+		e->next->prev = e;
+}
+
+/*
+ * src typically is on-stack; we want to copy the information in it to
+ * a malloced blame_entry that is already on the linked list of the
+ * scoreboard.  The origin of dst loses a refcnt while the origin of src
+ * gains one.
+ */
+static void dup_entry(struct blame_entry *dst, struct blame_entry *src)
+{
+	struct blame_entry *p, *n;
+
+	p = dst->prev;
+	n = dst->next;
+	origin_incref(src->suspect);
+	origin_decref(dst->suspect);
+	memcpy(dst, src, sizeof(*src));
+	dst->prev = p;
+	dst->next = n;
+	dst->score = 0;
+}
+
+const char *nth_line(struct blame_scoreboard *sb, int lno)
+{
+	return sb->final_buf + sb->lineno[lno];
+}
+
+/*
+ * It is known that lines between tlno to same came from parent, and e
+ * has an overlap with that range.  it also is known that parent's
+ * line plno corresponds to e's line tlno.
+ *
+ *                <---- e ----->
+ *                   <------>
+ *                   <------------>
+ *             <------------>
+ *             <------------------>
+ *
+ * Split e into potentially three parts; before this chunk, the chunk
+ * to be blamed for the parent, and after that portion.
+ */
+static void split_overlap(struct blame_entry *split,
+			  struct blame_entry *e,
+			  int tlno, int plno, int same,
+			  struct origin *parent)
+{
+	int chunk_end_lno;
+	memset(split, 0, sizeof(struct blame_entry [3]));
+
+	if (e->s_lno < tlno) {
+		/* there is a pre-chunk part not blamed on parent */
+		split[0].suspect = origin_incref(e->suspect);
+		split[0].lno = e->lno;
+		split[0].s_lno = e->s_lno;
+		split[0].num_lines = tlno - e->s_lno;
+		split[1].lno = e->lno + tlno - e->s_lno;
+		split[1].s_lno = plno;
+	}
+	else {
+		split[1].lno = e->lno;
+		split[1].s_lno = plno + (e->s_lno - tlno);
+	}
+
+	if (same < e->s_lno + e->num_lines) {
+		/* there is a post-chunk part not blamed on parent */
+		split[2].suspect = origin_incref(e->suspect);
+		split[2].lno = e->lno + (same - e->s_lno);
+		split[2].s_lno = e->s_lno + (same - e->s_lno);
+		split[2].num_lines = e->s_lno + e->num_lines - same;
+		chunk_end_lno = split[2].lno;
+	}
+	else
+		chunk_end_lno = e->lno + e->num_lines;
+	split[1].num_lines = chunk_end_lno - split[1].lno;
+
+	/*
+	 * if it turns out there is nothing to blame the parent for,
+	 * forget about the splitting.  !split[1].suspect signals this.
+	 */
+	if (split[1].num_lines < 1)
+		return;
+	split[1].suspect = origin_incref(parent);
+}
+
+/*
+ * split_overlap() divided an existing blame e into up to three parts
+ * in split.  Adjust the linked list of blames in the scoreboard to
+ * reflect the split.
+ */
+static void split_blame(struct blame_scoreboard *sb,
+			struct blame_entry *split,
+			struct blame_entry *e)
+{
+	struct blame_entry *new_entry;
+
+	if (split[0].suspect && split[2].suspect) {
+		/* The first part (reuse storage for the existing entry e) */
+		dup_entry(e, &split[0]);
+
+		/* The last part -- me */
+		new_entry = xmalloc(sizeof(*new_entry));
+		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
+		add_blame_entry(sb, new_entry);
+
+		/* ... and the middle part -- parent */
+		new_entry = xmalloc(sizeof(*new_entry));
+		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
+		add_blame_entry(sb, new_entry);
+	}
+	else if (!split[0].suspect && !split[2].suspect)
+		/*
+		 * The parent covers the entire area; reuse storage for
+		 * e and replace it with the parent.
+		 */
+		dup_entry(e, &split[1]);
+	else if (split[0].suspect) {
+		/* me and then parent */
+		dup_entry(e, &split[0]);
+
+		new_entry = xmalloc(sizeof(*new_entry));
+		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
+		add_blame_entry(sb, new_entry);
+	}
+	else {
+		/* parent and then me */
+		dup_entry(e, &split[1]);
+
+		new_entry = xmalloc(sizeof(*new_entry));
+		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
+		add_blame_entry(sb, new_entry);
+	}
+
+	if (DEBUG) { /* sanity */
+		struct blame_entry *ent;
+		int lno = sb->ent->lno, corrupt = 0;
+
+		for (ent = sb->ent; ent; ent = ent->next) {
+			if (lno != ent->lno)
+				corrupt = 1;
+			if (ent->s_lno < 0)
+				corrupt = 1;
+			lno += ent->num_lines;
+		}
+		if (corrupt) {
+			lno = sb->ent->lno;
+			for (ent = sb->ent; ent; ent = ent->next) {
+				printf("L %8d l %8d n %8d\n",
+				       lno, ent->lno, ent->num_lines);
+				lno = ent->lno + ent->num_lines;
+			}
+			die("oops");
+		}
+	}
+}
+
+/*
+ * After splitting the blame, the origins used by the
+ * on-stack blame_entry should lose one refcnt each.
+ */
+static void decref_split(struct blame_entry *split)
+{
+	int i;
+
+	for (i = 0; i < 3; i++)
+		origin_decref(split[i].suspect);
+}
+
+/*
+ * Helper for blame_chunk().  blame_entry e is known to overlap with
+ * the patch hunk; split it and pass blame to the parent.
+ */
+static void blame_overlap(struct blame_scoreboard *sb, struct blame_entry *e,
+			  int tlno, int plno, int same,
+			  struct origin *parent)
+{
+	struct blame_entry split[3];
+
+	split_overlap(split, e, tlno, plno, same, parent);
+	if (split[1].suspect)
+		split_blame(sb, split, e);
+	decref_split(split);
+}
+
+/*
+ * Find the line number of the last line the target is suspected for.
+ */
+static int find_last_in_target(struct blame_scoreboard *sb, struct origin *target)
+{
+	struct blame_entry *e;
+	int last_in_target = -1;
+
+	for (e = sb->ent; e; e = e->next) {
+		if (e->guilty || !same_suspect(e->suspect, target))
+			continue;
+		if (last_in_target < e->s_lno + e->num_lines)
+			last_in_target = e->s_lno + e->num_lines;
+	}
+	return last_in_target;
+}
+
+/*
+ * Process one hunk from the patch between the current suspect for
+ * blame_entry e and its parent.  Find and split the overlap, and
+ * pass blame to the overlapping part to the parent.
+ */
+static void blame_chunk(struct blame_scoreboard *sb,
+			int tlno, int plno, int same,
+			struct origin *target, struct origin *parent)
+{
+	struct blame_entry *e;
+
+	for (e = sb->ent; e; e = e->next) {
+		if (e->guilty || !same_suspect(e->suspect, target))
+			continue;
+		if (same <= e->s_lno)
+			continue;
+		if (tlno < e->s_lno + e->num_lines)
+			blame_overlap(sb, e, tlno, plno, same, parent);
+	}
+}
+
+struct blame_chunk_cb_data {
+	struct blame_scoreboard *sb;
+	struct origin *target;
+	struct origin *parent;
+	long plno;
+	long tlno;
+};
+
+static void blame_chunk_cb(void *data, long same, long p_next, long t_next)
+{
+	struct blame_chunk_cb_data *d = data;
+	blame_chunk(d->sb, d->tlno, d->plno, same, d->target, d->parent);
+	d->plno = p_next;
+	d->tlno = t_next;
+}
+
+/*
+ * We are looking at the origin 'target' and aiming to pass blame
+ * for the lines it is suspected to its parent.  Run diff to find
+ * which lines came from parent and pass blame for them.
+ */
+static int pass_blame_to_parent(struct blame_scoreboard *sb,
+				struct origin *target,
+				struct origin *parent)
+{
+	int last_in_target;
+	mmfile_t file_p, file_o;
+	struct blame_chunk_cb_data d = { sb, target, parent, 0, 0 };
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+
+	last_in_target = find_last_in_target(sb, target);
+	if (last_in_target < 0)
+		return 1; /* nothing remains for this target */
+
+	fill_origin_blob(sb->ssb, parent, &file_p);
+	fill_origin_blob(sb->ssb, target, &file_o);
+	sb->ssb->stat->num_get_patch++;
+
+	memset(&xpp, 0, sizeof(xpp));
+	xpp.flags = sb->ssb->xdl_opts;
+	memset(&xecfg, 0, sizeof(xecfg));
+	xecfg.ctxlen = 0;
+	xdi_diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, &xpp, &xecfg);
+	/* The rest (i.e. anything after tlno) are the same as the parent */
+	blame_chunk(sb, d.tlno, d.plno, last_in_target, target, parent);
+
+	return 0;
+}
+
+/*
+ * The lines in blame_entry after splitting blames many times can become
+ * very small and trivial, and at some point it becomes pointless to
+ * blame the parents.  E.g. "\t\t}\n\t}\n\n" appears everywhere in any
+ * ordinary C program, and it is not worth to say it was copied from
+ * totally unrelated file in the parent.
+ *
+ * Compute how trivial the lines in the blame_entry are.
+ */
+static unsigned ent_score(struct blame_scoreboard *sb, struct blame_entry *e)
+{
+	unsigned score;
+	const char *cp, *ep;
+
+	if (e->score)
+		return e->score;
+
+	score = 1;
+	cp = nth_line(sb, e->lno);
+	ep = nth_line(sb, e->lno + e->num_lines);
+	while (cp < ep) {
+		unsigned ch = *((unsigned char *)cp);
+		if (isalnum(ch))
+			score++;
+		cp++;
+	}
+	e->score = score;
+	return score;
+}
+
+/*
+ * best_so_far[] and this[] are both a split of an existing blame_entry
+ * that passes blame to the parent.  Maintain best_so_far the best split
+ * so far, by comparing this and best_so_far and copying this into
+ * bst_so_far as needed.
+ */
+static void copy_split_if_better(struct blame_scoreboard *sb,
+				 struct blame_entry *best_so_far,
+				 struct blame_entry *this)
+{
+	int i;
+
+	if (!this[1].suspect)
+		return;
+	if (best_so_far[1].suspect) {
+		if (ent_score(sb, &this[1]) < ent_score(sb, &best_so_far[1]))
+			return;
+	}
+
+	for (i = 0; i < 3; i++)
+		origin_incref(this[i].suspect);
+	decref_split(best_so_far);
+	memcpy(best_so_far, this, sizeof(struct blame_entry [3]));
+}
+
+/*
+ * We are looking at a part of the final image represented by
+ * ent (tlno and same are offset by ent->s_lno).
+ * tlno is where we are looking at in the final image.
+ * up to (but not including) same match preimage.
+ * plno is where we are looking at in the preimage.
+ *
+ * <-------------- final image ---------------------->
+ *       <------ent------>
+ *         ^tlno ^same
+ *    <---------preimage----->
+ *         ^plno
+ *
+ * All line numbers are 0-based.
+ */
+static void handle_split(struct blame_scoreboard *sb,
+			 struct blame_entry *ent,
+			 int tlno, int plno, int same,
+			 struct origin *parent,
+			 struct blame_entry *split)
+{
+	if (ent->num_lines <= tlno)
+		return;
+	if (tlno < same) {
+		struct blame_entry this[3];
+		tlno += ent->s_lno;
+		same += ent->s_lno;
+		split_overlap(this, ent, tlno, plno, same, parent);
+		copy_split_if_better(sb, split, this);
+		decref_split(this);
+	}
+}
+
+struct handle_split_cb_data {
+	struct blame_scoreboard *sb;
+	struct blame_entry *ent;
+	struct origin *parent;
+	struct blame_entry *split;
+	long plno;
+	long tlno;
+};
+
+static void handle_split_cb(void *data, long same, long p_next, long t_next)
+{
+	struct handle_split_cb_data *d = data;
+	handle_split(d->sb, d->ent, d->tlno, d->plno, same, d->parent, d->split);
+	d->plno = p_next;
+	d->tlno = t_next;
+}
+
+/*
+ * Find the lines from parent that are the same as ent so that
+ * we can pass blames to it.  file_p has the blob contents for
+ * the parent.
+ */
+static void find_copy_in_blob(struct blame_scoreboard *sb,
+			      struct blame_entry *ent,
+			      struct origin *parent,
+			      struct blame_entry *split,
+			      mmfile_t *file_p)
+{
+	const char *cp;
+	int cnt;
+	mmfile_t file_o;
+	struct handle_split_cb_data d = { sb, ent, parent, split, 0, 0 };
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+
+	/*
+	 * Prepare mmfile that contains only the lines in ent.
+	 */
+	cp = nth_line(sb, ent->lno);
+	file_o.ptr = (char*) cp;
+	cnt = ent->num_lines;
+
+	while (cnt && cp < sb->final_buf + sb->final_buf_size) {
+		if (*cp++ == '\n')
+			cnt--;
+	}
+	file_o.size = cp - file_o.ptr;
+
+	/*
+	 * file_o is a part of final image we are annotating.
+	 * file_p partially may match that image.
+	 */
+	memset(&xpp, 0, sizeof(xpp));
+	xpp.flags = sb->ssb->xdl_opts;
+	memset(&xecfg, 0, sizeof(xecfg));
+	xecfg.ctxlen = 1;
+	memset(split, 0, sizeof(struct blame_entry [3]));
+	xdi_diff_hunks(file_p, &file_o, handle_split_cb, &d, &xpp, &xecfg);
+	/* remainder, if any, all match the preimage */
+	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
+}
+
+/*
+ * See if lines currently target is suspected for can be attributed to
+ * parent.
+ */
+static int find_move_in_parent(struct blame_scoreboard *sb,
+			       struct origin *target,
+			       struct origin *parent)
+{
+	int last_in_target, made_progress;
+	struct blame_entry *e, split[3];
+	mmfile_t file_p;
+
+	last_in_target = find_last_in_target(sb, target);
+	if (last_in_target < 0)
+		return 1; /* nothing remains for this target */
+
+	fill_origin_blob(sb->ssb, parent, &file_p);
+	if (!file_p.ptr)
+		return 0;
+
+	made_progress = 1;
+	while (made_progress) {
+		made_progress = 0;
+		for (e = sb->ent; e; e = e->next) {
+			if (e->guilty || !same_suspect(e->suspect, target) ||
+			    ent_score(sb, e) < sb->ssb->blame_move_score)
+				continue;
+			find_copy_in_blob(sb, e, parent, split, &file_p);
+			if (split[1].suspect &&
+			    sb->ssb->blame_move_score < ent_score(sb, &split[1])) {
+				split_blame(sb, split, e);
+				made_progress = 1;
+			}
+			decref_split(split);
+		}
+	}
+	return 0;
+}
+
+struct blame_list {
+	struct blame_entry *ent;
+	struct blame_entry split[3];
+};
+
+/*
+ * Count the number of entries the target is suspected for,
+ * and prepare a list of entry and the best split.
+ */
+static struct blame_list *setup_blame_list(struct blame_scoreboard *sb,
+					   struct origin *target,
+					   int min_score,
+					   int *num_ents_p)
+{
+	struct blame_entry *e;
+	int num_ents, i;
+	struct blame_list *blame_list = NULL;
+
+	for (e = sb->ent, num_ents = 0; e; e = e->next)
+		if (!e->scanned && !e->guilty &&
+		    same_suspect(e->suspect, target) &&
+		    min_score < ent_score(sb, e))
+			num_ents++;
+	if (num_ents) {
+		blame_list = xcalloc(num_ents, sizeof(struct blame_list));
+		for (e = sb->ent, i = 0; e; e = e->next)
+			if (!e->scanned && !e->guilty &&
+			    same_suspect(e->suspect, target) &&
+			    min_score < ent_score(sb, e))
+				blame_list[i++].ent = e;
+	}
+	*num_ents_p = num_ents;
+	return blame_list;
+}
+
+/*
+ * Reset the scanned status on all entries.
+ */
+static void reset_scanned_flag(struct blame_scoreboard *sb)
+{
+	struct blame_entry *e;
+	for (e = sb->ent; e; e = e->next)
+		e->scanned = 0;
+}
+
+/*
+ * For lines target is suspected for, see if we can find code movement
+ * across file boundary from the parent commit.  porigin is the path
+ * in the parent we already tried.
+ */
+static int find_copy_in_parent(struct blame_scoreboard *sb,
+			       struct origin *target,
+			       struct commit *parent,
+			       struct origin *porigin,
+			       int opt)
+{
+	struct diff_options diff_opts;
+	const char *paths[1];
+	int i, j;
+	int retval;
+	struct blame_list *blame_list;
+	int num_ents;
+
+	blame_list = setup_blame_list(sb, target, sb->ssb->blame_copy_score, &num_ents);
+	if (!blame_list)
+		return 1; /* nothing remains for this target */
+
+	diff_setup(&diff_opts);
+	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+
+	paths[0] = NULL;
+	diff_tree_setup_paths(paths, &diff_opts);
+	if (diff_setup_done(&diff_opts) < 0)
+		die("diff-setup");
+
+	/* Try "find copies harder" on new path if requested;
+	 * we do not want to use diffcore_rename() actually to
+	 * match things up; find_copies_harder is set only to
+	 * force diff_tree_sha1() to feed all filepairs to diff_queue,
+	 * and this code needs to be after diff_setup_done(), which
+	 * usually makes find-copies-harder imply copy detection.
+	 */
+	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
+	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
+		&& (!porigin || strcmp(target->path, porigin->path))))
+		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
+
+	if (is_null_sha1(target->commit->object.sha1))
+		do_diff_cache(parent->tree->object.sha1, &diff_opts);
+	else
+		diff_tree_sha1(parent->tree->object.sha1,
+			       target->commit->tree->object.sha1,
+			       "", &diff_opts);
+
+	if (!DIFF_OPT_TST(&diff_opts, FIND_COPIES_HARDER))
+		diffcore_std(&diff_opts);
+
+	retval = 0;
+	while (1) {
+		int made_progress = 0;
+
+		for (i = 0; i < diff_queued_diff.nr; i++) {
+			struct diff_filepair *p = diff_queued_diff.queue[i];
+			struct origin *norigin;
+			mmfile_t file_p;
+			struct blame_entry this[3];
+
+			if (!DIFF_FILE_VALID(p->one))
+				continue; /* does not exist in parent */
+			if (S_ISGITLINK(p->one->mode))
+				continue; /* ignore git links */
+			if (porigin && !strcmp(p->one->path, porigin->path))
+				/* find_move already dealt with this path */
+				continue;
+
+			norigin = get_origin(sb, parent, p->one->path);
+			hashcpy(norigin->blob_sha1, p->one->sha1);
+			fill_origin_blob(sb->ssb, norigin, &file_p);
+			if (!file_p.ptr)
+				continue;
+
+			for (j = 0; j < num_ents; j++) {
+				find_copy_in_blob(sb, blame_list[j].ent,
+						  norigin, this, &file_p);
+				copy_split_if_better(sb, blame_list[j].split,
+						     this);
+				decref_split(this);
+			}
+			origin_decref(norigin);
+		}
+
+		for (j = 0; j < num_ents; j++) {
+			struct blame_entry *split = blame_list[j].split;
+			if (split[1].suspect &&
+			    sb->ssb->blame_copy_score < ent_score(sb, &split[1])) {
+				split_blame(sb, split, blame_list[j].ent);
+				made_progress = 1;
+			}
+			else
+				blame_list[j].ent->scanned = 1;
+			decref_split(split);
+		}
+		free(blame_list);
+
+		if (!made_progress)
+			break;
+		blame_list = setup_blame_list(sb, target, sb->ssb->blame_copy_score, &num_ents);
+		if (!blame_list) {
+			retval = 1;
+			break;
+		}
+	}
+	reset_scanned_flag(sb);
+	diff_flush(&diff_opts);
+	diff_tree_release_paths(&diff_opts);
+	return retval;
+}
+
+/*
+ * The blobs of origin and porigin exactly match, so everything
+ * origin is suspected for can be blamed on the parent.
+ */
+static void pass_whole_blame(struct blame_scoreboard *sb,
+			     struct origin *origin, struct origin *porigin)
+{
+	struct blame_entry *e;
+
+	if (!porigin->file.ptr && origin->file.ptr) {
+		/* Steal its file */
+		porigin->file = origin->file;
+		origin->file.ptr = NULL;
+	}
+	for (e = sb->ent; e; e = e->next) {
+		if (!same_suspect(e->suspect, origin))
+			continue;
+		origin_incref(porigin);
+		origin_decref(e->suspect);
+		e->suspect = porigin;
+	}
+}
+
+/*
+ * We pass blame from the current commit to its parents.  We keep saying
+ * "parent" (and "porigin"), but what we mean is to find scapegoat to
+ * exonerate ourselves.
+ */
+static struct commit_list *first_scapegoat(struct blame_info *ssb,
+					   struct rev_info *revs,
+					   struct commit *commit)
+{
+	if (!ssb->reverse)
+		return commit->parents;
+	return lookup_decoration(&revs->children, &commit->object);
+}
+
+static int num_scapegoats(struct blame_info *ssb,
+			  struct rev_info *revs,
+			  struct commit *commit)
+{
+	int cnt;
+	struct commit_list *l = first_scapegoat(ssb, revs, commit);
+	for (cnt = 0; l; l = l->next)
+		cnt++;
+	return cnt;
+}
+
+#define MAXSG 16
+
+static void pass_blame(struct blame_scoreboard *sb, struct origin *origin, int opt)
+{
+	struct rev_info *revs = sb->revs;
+	int i, pass, num_sg;
+	struct commit *commit = origin->commit;
+	struct commit_list *sg;
+	struct origin *sg_buf[MAXSG];
+	struct origin *porigin, **sg_origin = sg_buf;
+
+	num_sg = num_scapegoats(sb->ssb, revs, commit);
+	if (!num_sg)
+		goto finish;
+	else if (num_sg < ARRAY_SIZE(sg_buf))
+		memset(sg_buf, 0, sizeof(sg_buf));
+	else
+		sg_origin = xcalloc(num_sg, sizeof(*sg_origin));
+
+	/*
+	 * The first pass looks for unrenamed path to optimize for
+	 * common cases, then we look for renames in the second pass.
+	 */
+	for (pass = 0; pass < 2; pass++) {
+		struct origin *(*find)(struct blame_scoreboard *,
+				       struct commit *, struct origin *);
+		find = pass ? find_rename : find_origin;
+
+		for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
+		     i < num_sg && sg;
+		     sg = sg->next, i++) {
+			struct commit *p = sg->item;
+			int j, same;
+
+			if (sg_origin[i])
+				continue;
+			if (parse_commit(p))
+				continue;
+			porigin = find(sb, p, origin);
+			if (!porigin)
+				continue;
+			if (!hashcmp(porigin->blob_sha1, origin->blob_sha1)) {
+				pass_whole_blame(sb, origin, porigin);
+				origin_decref(porigin);
+				goto finish;
+			}
+			for (j = same = 0; j < i; j++)
+				if (sg_origin[j] &&
+				    !hashcmp(sg_origin[j]->blob_sha1,
+					     porigin->blob_sha1)) {
+					same = 1;
+					break;
+				}
+			if (!same)
+				sg_origin[i] = porigin;
+			else
+				origin_decref(porigin);
+		}
+	}
+
+	sb->ssb->stat->num_commits++;
+	for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
+	     i < num_sg && sg;
+	     sg = sg->next, i++) {
+		struct origin *porigin = sg_origin[i];
+		if (!porigin)
+			continue;
+		if (!origin->previous) {
+			origin_incref(porigin);
+			origin->previous = porigin;
+		}
+		if (pass_blame_to_parent(sb, origin, porigin))
+			goto finish;
+	}
+
+	/*
+	 * Optionally find moves in parents' files.
+	 */
+	if (opt & PICKAXE_BLAME_MOVE)
+		for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
+		     i < num_sg && sg;
+		     sg = sg->next, i++) {
+			struct origin *porigin = sg_origin[i];
+			if (!porigin)
+				continue;
+			if (find_move_in_parent(sb, origin, porigin))
+				goto finish;
+		}
+
+	/*
+	 * Optionally find copies from parents' files.
+	 */
+	if (opt & PICKAXE_BLAME_COPY)
+		for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
+		     i < num_sg && sg;
+		     sg = sg->next, i++) {
+			struct origin *porigin = sg_origin[i];
+			if (find_copy_in_parent(sb, origin, sg->item,
+						porigin, opt))
+				goto finish;
+		}
+
+ finish:
+	for (i = 0; i < num_sg; i++) {
+		if (sg_origin[i]) {
+			drop_origin_blob(sg_origin[i]);
+			origin_decref(sg_origin[i]);
+		}
+	}
+	drop_origin_blob(origin);
+	if (sg_buf != sg_origin)
+		free(sg_origin);
+}
+
+/*
+ * Information on commits, used for output.
+ */
+struct commit_info
+{
+	const char *author;
+	const char *author_mail;
+	unsigned long author_time;
+	const char *author_tz;
+
+	/* filled only when asked for details */
+	const char *committer;
+	const char *committer_mail;
+	unsigned long committer_time;
+	const char *committer_tz;
+
+	const char *summary;
+};
+
+/*
+ * Parse author/committer line in the commit object buffer
+ */
+static void get_ac_line(struct string_list *mailmap, const char *inbuf,
+			const char *what, int person_len, char *person,
+			int mail_len, char *mail,
+			unsigned long *time, const char **tz)
+{
+	int len, tzlen, maillen;
+	char *tmp, *endp, *timepos, *mailpos;
+
+	tmp = strstr(inbuf, what);
+	if (!tmp)
+		goto error_out;
+	tmp += strlen(what);
+	endp = strchr(tmp, '\n');
+	if (!endp)
+		len = strlen(tmp);
+	else
+		len = endp - tmp;
+	if (person_len <= len) {
+	error_out:
+		/* Ugh */
+		*tz = "(unknown)";
+		strcpy(mail, *tz);
+		*time = 0;
+		return;
+	}
+	memcpy(person, tmp, len);
+
+	tmp = person;
+	tmp += len;
+	*tmp = 0;
+	while (*tmp != ' ')
+		tmp--;
+	*tz = tmp+1;
+	tzlen = (person+len)-(tmp+1);
+
+	*tmp = 0;
+	while (*tmp != ' ')
+		tmp--;
+	*time = strtoul(tmp, NULL, 10);
+	timepos = tmp;
+
+	*tmp = 0;
+	while (*tmp != ' ')
+		tmp--;
+	mailpos = tmp + 1;
+	*tmp = 0;
+	maillen = timepos - tmp;
+	memcpy(mail, mailpos, maillen);
+
+	if (!mailmap->nr)
+		return;
+
+	/*
+	 * mailmap expansion may make the name longer.
+	 * make room by pushing stuff down.
+	 */
+	tmp = person + person_len - (tzlen + 1);
+	memmove(tmp, *tz, tzlen);
+	tmp[tzlen] = 0;
+	*tz = tmp;
+
+	/*
+	 * Now, convert both name and e-mail using mailmap
+	 */
+	if (map_user(mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
+		/* Add a trailing '>' to email, since map_user returns plain emails
+		   Note: It already has '<', since we replace from mail+1 */
+		mailpos = memchr(mail, '\0', mail_len);
+		if (mailpos && mailpos-mail < mail_len - 1) {
+			*mailpos = '>';
+			*(mailpos+1) = '\0';
+		}
+	}
+}
+
+static void get_commit_info(struct string_list *mailmap,
+			    struct commit *commit,
+			    struct commit_info *ret,
+			    int detailed)
+{
+	int len;
+	char *tmp, *endp, *reencoded, *message;
+	static char author_name[1024];
+	static char author_mail[1024];
+	static char committer_name[1024];
+	static char committer_mail[1024];
+	static char summary_buf[1024];
+
+	/*
+	 * We've operated without save_commit_buffer, so
+	 * we now need to populate them for output.
+	 */
+	if (!commit->buffer) {
+		enum object_type type;
+		unsigned long size;
+		commit->buffer =
+			read_sha1_file(commit->object.sha1, &type, &size);
+		if (!commit->buffer)
+			die("Cannot read commit %s",
+			    sha1_to_hex(commit->object.sha1));
+	}
+	reencoded = reencode_commit_message(commit, NULL);
+	message   = reencoded ? reencoded : commit->buffer;
+	ret->author = author_name;
+	ret->author_mail = author_mail;
+	get_ac_line(mailmap, message, "\nauthor ",
+		    sizeof(author_name), author_name,
+		    sizeof(author_mail), author_mail,
+		    &ret->author_time, &ret->author_tz);
+
+	if (!detailed) {
+		free(reencoded);
+		return;
+	}
+
+	ret->committer = committer_name;
+	ret->committer_mail = committer_mail;
+	get_ac_line(mailmap, message, "\ncommitter ",
+		    sizeof(committer_name), committer_name,
+		    sizeof(committer_mail), committer_mail,
+		    &ret->committer_time, &ret->committer_tz);
+
+	ret->summary = summary_buf;
+	tmp = strstr(message, "\n\n");
+	if (!tmp) {
+	error_out:
+		sprintf(summary_buf, "(%s)", sha1_to_hex(commit->object.sha1));
+		free(reencoded);
+		return;
+	}
+	tmp += 2;
+	endp = strchr(tmp, '\n');
+	if (!endp)
+		endp = tmp + strlen(tmp);
+	len = endp - tmp;
+	if (len >= sizeof(summary_buf) || len == 0)
+		goto error_out;
+	memcpy(summary_buf, tmp, len);
+	summary_buf[len] = 0;
+	free(reencoded);
+}
+
+/*
+ * To allow LF and other nonportable characters in pathnames,
+ * they are c-style quoted as needed.
+ */
+static void write_filename_info(const char *path)
+{
+	printf("filename ");
+	write_name_quoted(path, stdout, '\n');
+}
+
+/*
+ * Porcelain/Incremental format wants to show a lot of details per
+ * commit.  Instead of repeating this every line, emit it only once,
+ * the first time each commit appears in the output.
+ */
+static int emit_one_suspect_detail(struct string_list *mailmap,
+				   struct origin *suspect)
+{
+	struct commit_info ci;
+
+	if (suspect->commit->object.flags & METAINFO_SHOWN)
+		return 0;
+
+	suspect->commit->object.flags |= METAINFO_SHOWN;
+	get_commit_info(mailmap, suspect->commit, &ci, 1);
+	printf("author %s\n", ci.author);
+	printf("author-mail %s\n", ci.author_mail);
+	printf("author-time %lu\n", ci.author_time);
+	printf("author-tz %s\n", ci.author_tz);
+	printf("committer %s\n", ci.committer);
+	printf("committer-mail %s\n", ci.committer_mail);
+	printf("committer-time %lu\n", ci.committer_time);
+	printf("committer-tz %s\n", ci.committer_tz);
+	printf("summary %s\n", ci.summary);
+	if (suspect->commit->object.flags & UNINTERESTING)
+		printf("boundary\n");
+	if (suspect->previous) {
+		struct origin *prev = suspect->previous;
+		printf("previous %s ", sha1_to_hex(prev->commit->object.sha1));
+		write_name_quoted(prev->path, stdout, '\n');
+	}
+	return 1;
+}
+
+/*
+ * The blame_entry is found to be guilty for the range.  Mark it
+ * as such, and show it in incremental output.
+ */
+static void found_guilty_entry(struct blame_info *ssb, struct blame_entry *ent)
+{
+	if (ent->guilty)
+		return;
+	ent->guilty = 1;
+	if (ssb->incremental) {
+		struct origin *suspect = ent->suspect;
+
+		printf("%s %d %d %d\n",
+		       sha1_to_hex(suspect->commit->object.sha1),
+		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
+		emit_one_suspect_detail(&ssb->mailmap, suspect);
+		write_filename_info(suspect->path);
+		maybe_flush_or_die(stdout, "stdout");
+	}
+}
+
+/*
+ * The main loop -- while the scoreboard has lines whose true origin
+ * is still unknown, pick one blame_entry, and allow its current
+ * suspect to pass blames to its parents.
+ */
+void assign_blame(struct blame_scoreboard *sb, int opt)
+{
+	struct rev_info *revs = sb->revs;
+
+	while (1) {
+		struct blame_entry *ent;
+		struct commit *commit;
+		struct origin *suspect = NULL;
+
+		/* find one suspect to break down */
+		for (ent = sb->ent; !suspect && ent; ent = ent->next)
+			if (!ent->guilty)
+				suspect = ent->suspect;
+		if (!suspect)
+			return; /* all done */
+
+		/*
+		 * We will use this suspect later in the loop,
+		 * so hold onto it in the meantime.
+		 */
+		origin_incref(suspect);
+		commit = suspect->commit;
+		if (!commit->object.parsed)
+			parse_commit(commit);
+		if (sb->ssb->reverse ||
+		    (!(commit->object.flags & UNINTERESTING) &&
+		     !(revs->max_age != -1 && commit->date < revs->max_age)))
+			pass_blame(sb, suspect, opt);
+		else {
+			commit->object.flags |= UNINTERESTING;
+			if (commit->object.parsed)
+				mark_parents_uninteresting(commit);
+		}
+		/* treat root commit as boundary */
+		if (!commit->parents && !sb->ssb->show_root)
+			commit->object.flags |= UNINTERESTING;
+
+		/* Take responsibility for the remaining entries */
+		for (ent = sb->ent; ent; ent = ent->next)
+			if (same_suspect(ent->suspect, suspect))
+				found_guilty_entry(sb->ssb, ent);
+		origin_decref(suspect);
+
+		if (DEBUG) /* sanity */
+			sanity_check_refcnt(sb);
+	}
+}
+
+static const char *format_time(struct blame_info *ssb, unsigned long time,
+			       const char *tz_str, int show_raw_time)
+{
+	static char time_buf[128];
+	const char *time_str;
+	int time_len;
+	int tz;
+
+	if (show_raw_time) {
+		sprintf(time_buf, "%lu %s", time, tz_str);
+	}
+	else {
+		tz = atoi(tz_str);
+		time_str = show_date(time, tz, ssb->blame_date_mode);
+		time_len = strlen(time_str);
+		memcpy(time_buf, time_str, time_len);
+		memset(time_buf + time_len, ' ', ssb->blame_date_width - time_len);
+	}
+	return time_buf;
+}
+
+#define OUTPUT_ANNOTATE_COMPAT	001
+#define OUTPUT_LONG_OBJECT_NAME	002
+#define OUTPUT_RAW_TIMESTAMP	004
+#define OUTPUT_PORCELAIN	010
+#define OUTPUT_SHOW_NAME	020
+#define OUTPUT_SHOW_NUMBER	040
+#define OUTPUT_SHOW_SCORE      0100
+#define OUTPUT_NO_AUTHOR       0200
+
+static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent)
+{
+	int cnt;
+	const char *cp;
+	struct origin *suspect = ent->suspect;
+	char hex[41];
+
+	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
+	printf("%s%c%d %d %d\n",
+	       hex,
+	       ent->guilty ? ' ' : '*', // purely for debugging
+	       ent->s_lno + 1,
+	       ent->lno + 1,
+	       ent->num_lines);
+	if (emit_one_suspect_detail(&sb->ssb->mailmap, suspect) ||
+	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
+		write_filename_info(suspect->path);
+
+	cp = nth_line(sb, ent->lno);
+	for (cnt = 0; cnt < ent->num_lines; cnt++) {
+		char ch;
+		if (cnt)
+			printf("%s %d %d\n", hex,
+			       ent->s_lno + 1 + cnt,
+			       ent->lno + 1 + cnt);
+		putchar('\t');
+		do {
+			ch = *cp++;
+			putchar(ch);
+		} while (ch != '\n' &&
+			 cp < sb->final_buf + sb->final_buf_size);
+	}
+}
+
+static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
+{
+	int cnt;
+	const char *cp;
+	struct origin *suspect = ent->suspect;
+	struct commit_info ci;
+	char hex[41];
+	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+
+	get_commit_info(&sb->ssb->mailmap, suspect->commit, &ci, 1);
+	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
+
+	cp = nth_line(sb, ent->lno);
+	for (cnt = 0; cnt < ent->num_lines; cnt++) {
+		char ch;
+		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
+
+		if (suspect->commit->object.flags & UNINTERESTING) {
+			if (sb->ssb->blank_boundary)
+				memset(hex, ' ', length);
+			else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
+				length--;
+				putchar('^');
+			}
+		}
+
+		printf("%.*s", length, hex);
+		if (opt & OUTPUT_ANNOTATE_COMPAT)
+			printf("\t(%10s\t%10s\t%d)", ci.author,
+			       format_time(sb->ssb, ci.author_time,
+					   ci.author_tz, show_raw_time),
+			       ent->lno + 1 + cnt);
+		else {
+			if (opt & OUTPUT_SHOW_SCORE)
+				printf(" %*d %02d",
+				       sb->ssb->max_score_digits, ent->score,
+				       ent->suspect->refcnt);
+			if (opt & OUTPUT_SHOW_NAME)
+				printf(" %-*.*s", sb->ssb->longest_file,
+						  sb->ssb->longest_file, suspect->path);
+			if (opt & OUTPUT_SHOW_NUMBER)
+				printf(" %*d", sb->ssb->max_orig_digits,
+				       ent->s_lno + 1 + cnt);
+
+			if (!(opt & OUTPUT_NO_AUTHOR)) {
+				int pad = sb->ssb->longest_author - utf8_strwidth(ci.author);
+				printf(" (%s%*s %10s",
+				       ci.author, pad, "",
+				       format_time(sb->ssb, ci.author_time,
+						   ci.author_tz,
+						   show_raw_time));
+			}
+			printf(" %*d) ",
+			       sb->ssb->max_digits, ent->lno + 1 + cnt);
+		}
+		do {
+			ch = *cp++;
+			putchar(ch);
+		} while (ch != '\n' &&
+			 cp < sb->final_buf + sb->final_buf_size);
+	}
+}
+
+void output(struct blame_scoreboard *sb, int option)
+{
+	struct blame_entry *ent;
+
+	if (option & OUTPUT_PORCELAIN) {
+		for (ent = sb->ent; ent; ent = ent->next) {
+			struct blame_entry *oth;
+			struct origin *suspect = ent->suspect;
+			struct commit *commit = suspect->commit;
+			if (commit->object.flags & MORE_THAN_ONE_PATH)
+				continue;
+			for (oth = ent->next; oth; oth = oth->next) {
+				if ((oth->suspect->commit != commit) ||
+				    !strcmp(oth->suspect->path, suspect->path))
+					continue;
+				commit->object.flags |= MORE_THAN_ONE_PATH;
+				break;
+			}
+		}
+	}
+
+	for (ent = sb->ent; ent; ent = ent->next) {
+		if (option & OUTPUT_PORCELAIN)
+			emit_porcelain(sb, ent);
+		else {
+			emit_other(sb, ent, option);
+		}
+	}
+}
+
+/*
+ * To allow quick access to the contents of nth line in the
+ * final image, prepare an index in the scoreboard.
+ */
+int prepare_lines(struct blame_scoreboard *sb)
+{
+	const char *buf = sb->final_buf;
+	unsigned long len = sb->final_buf_size;
+	int num = 0, incomplete = 0, bol = 1;
+
+	if (len && buf[len-1] != '\n')
+		incomplete++; /* incomplete line at the end */
+	while (len--) {
+		if (bol) {
+			sb->lineno = xrealloc(sb->lineno,
+					      sizeof(int* ) * (num + 1));
+			sb->lineno[num] = buf - sb->final_buf;
+			bol = 0;
+		}
+		if (*buf++ == '\n') {
+			num++;
+			bol = 1;
+		}
+	}
+	sb->lineno = xrealloc(sb->lineno,
+			      sizeof(int* ) * (num + incomplete + 1));
+	sb->lineno[num + incomplete] = buf - sb->final_buf;
+	sb->num_lines = num + incomplete;
+	return sb->num_lines;
+}
+
+/*
+ * Add phony grafts for use with -S; this is primarily to
+ * support git's cvsserver that wants to give a linear history
+ * to its clients.
+ */
+int read_ancestry(const char *graft_file)
+{
+	FILE *fp = fopen(graft_file, "r");
+	char buf[1024];
+	if (!fp)
+		return -1;
+	while (fgets(buf, sizeof(buf), fp)) {
+		/* The format is just "Commit Parent1 Parent2 ...\n" */
+		int len = strlen(buf);
+		struct commit_graft *graft = read_graft_line(buf, len);
+		if (graft)
+			register_commit_graft(graft, 0);
+	}
+	fclose(fp);
+	return 0;
+}
+
+/*
+ * How many columns do we need to show line numbers in decimal?
+ */
+static int lineno_width(int lines)
+{
+	int i, width;
+
+	for (width = 1, i = 10; i <= lines + 1; width++)
+		i *= 10;
+	return width;
+}
+
+/*
+ * How many columns do we need to show line numbers, authors,
+ * and filenames?
+ */
+void find_alignment(struct blame_scoreboard *sb, int *option)
+{
+	int longest_src_lines = 0;
+	int longest_dst_lines = 0;
+	unsigned largest_score = 0;
+	struct blame_entry *e;
+
+	for (e = sb->ent; e; e = e->next) {
+		struct origin *suspect = e->suspect;
+		struct commit_info ci;
+		int num;
+
+		if (strcmp(suspect->path, sb->path))
+			*option |= OUTPUT_SHOW_NAME;
+		num = strlen(suspect->path);
+		if (sb->ssb->longest_file < num)
+			sb->ssb->longest_file = num;
+		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
+			suspect->commit->object.flags |= METAINFO_SHOWN;
+			get_commit_info(&sb->ssb->mailmap, suspect->commit, &ci, 1);
+			num = utf8_strwidth(ci.author);
+			if (sb->ssb->longest_author < num)
+				sb->ssb->longest_author = num;
+		}
+		num = e->s_lno + e->num_lines;
+		if (longest_src_lines < num)
+			longest_src_lines = num;
+		num = e->lno + e->num_lines;
+		if (longest_dst_lines < num)
+			longest_dst_lines = num;
+		if (largest_score < ent_score(sb, e))
+			largest_score = ent_score(sb, e);
+	}
+	sb->ssb->max_orig_digits = lineno_width(longest_src_lines);
+	sb->ssb->max_digits = lineno_width(longest_dst_lines);
+	sb->ssb->max_score_digits = lineno_width(largest_score);
+}
+
+/*
+ * For debugging -- origin is refcounted, and this asserts that
+ * we do not underflow.
+ */
+static void sanity_check_refcnt(struct blame_scoreboard *sb)
+{
+	int baa = 0;
+	struct blame_entry *ent;
+
+	for (ent = sb->ent; ent; ent = ent->next) {
+		/* Nobody should have zero or negative refcnt */
+		if (ent->suspect->refcnt <= 0) {
+			fprintf(stderr, "%s in %s has negative refcnt %d\n",
+				ent->suspect->path,
+				sha1_to_hex(ent->suspect->commit->object.sha1),
+				ent->suspect->refcnt);
+			baa = 1;
+		}
+	}
+	if (baa) {
+		int opt = 0160;
+		find_alignment(sb, &opt);
+		output(sb, opt);
+		die("Baa %d!", baa);
+	}
+}
+
+/*
+ * Used for the command line parsing; check if the path exists
+ * in the working tree.
+ */
+int has_string_in_work_tree(const char *path)
+{
+	struct stat st;
+	return !lstat(path, &st);
+}
+
+unsigned parse_score(const char *arg)
+{
+	char *end;
+	unsigned long score = strtoul(arg, &end, 10);
+	if (*end)
+		return 0;
+	return score;
+}
+
+const char *add_prefix(const char *prefix, const char *path)
+{
+	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
+}
+
diff --git a/blame.h b/blame.h
index 72d1e2a..37318b5 100644
--- a/blame.h
+++ b/blame.h
@@ -161,6 +161,27 @@ struct blame_scoreboard {
 	struct blame_info *ssb;
 };
 
+/* these will be reorganized again */
+extern const char *nth_line(struct blame_scoreboard *sb, int lno) ;
+extern struct origin *make_origin(struct commit *commit, const char *path) ;
+extern const char *add_prefix(const char *prefix, const char *path) ;
+extern struct origin *get_origin(struct blame_scoreboard *sb,
+				 struct commit *commit,
+			 	 const char *path) ;
+
+extern unsigned parse_score(const char *arg) ;
+
+extern int has_string_in_work_tree(const char *path) ;
+extern int fill_blob_sha1(struct origin *origin) ;
+extern int prepare_lines(struct blame_scoreboard *sb) ;
+
+extern int read_ancestry(const char *graft_file) ;
+
+extern void output(struct blame_scoreboard *sb, int option) ;
+
+extern void find_alignment(struct blame_scoreboard *sb, int *option) ;
+
 extern void assign_blame(struct blame_scoreboard *sb, int opt) ;
+extern void coalesce(struct blame_scoreboard *sb) ;
 
 #endif
diff --git a/builtin-blame.c b/builtin-blame.c
index d4f812b..59e6461 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -40,1709 +40,6 @@ static unsigned opt_blame_copy_score;
 #endif
 
 /*
- * Given an origin, prepare mmfile_t structure to be used by the
- * diff machinery
- */
-static void fill_origin_blob(struct blame_info *ssb, struct origin *o, mmfile_t *file)
-{
-	if (!o->file.ptr) {
-		enum object_type type;
-		ssb->stat->num_read_blob++;
-		file->ptr = read_sha1_file(o->blob_sha1, &type,
-					   (unsigned long *)(&(file->size)));
-		if (!file->ptr)
-			die("Cannot read blob %s for path %s",
-			    sha1_to_hex(o->blob_sha1),
-			    o->path);
-		o->file = *file;
-	}
-	else
-		*file = o->file;
-}
-
-/*
- * Origin is refcounted and usually we keep the blob contents to be
- * reused.
- */
-static inline struct origin *origin_incref(struct origin *o)
-{
-	if (o)
-		o->refcnt++;
-	return o;
-}
-
-static void origin_decref(struct origin *o)
-{
-	if (o && --o->refcnt <= 0) {
-		if (o->previous)
-			origin_decref(o->previous);
-		free(o->file.ptr);
-		free(o);
-	}
-}
-
-static void drop_origin_blob(struct origin *o)
-{
-	if (o->file.ptr) {
-		free(o->file.ptr);
-		o->file.ptr = NULL;
-	}
-}
-
-static inline int same_suspect(struct origin *a, struct origin *b)
-{
-	if (a == b)
-		return 1;
-	if (a->commit != b->commit)
-		return 0;
-	return !strcmp(a->path, b->path);
-}
-
-static void sanity_check_refcnt(struct blame_scoreboard *);
-
-/*
- * If two blame entries that are next to each other came from
- * contiguous lines in the same origin (i.e. <commit, path> pair),
- * merge them together.
- */
-static void coalesce(struct blame_scoreboard *sb)
-{
-	struct blame_entry *ent, *next;
-
-	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
-		if (same_suspect(ent->suspect, next->suspect) &&
-		    ent->guilty == next->guilty &&
-		    ent->s_lno + ent->num_lines == next->s_lno) {
-			ent->num_lines += next->num_lines;
-			ent->next = next->next;
-			if (ent->next)
-				ent->next->prev = ent;
-			origin_decref(next->suspect);
-			free(next);
-			ent->score = 0;
-			next = ent; /* again */
-		}
-	}
-
-	if (DEBUG) /* sanity */
-		sanity_check_refcnt(sb);
-}
-
-/*
- * Given a commit and a path in it, create a new origin structure.
- * The callers that add blame to the scoreboard should use
- * get_origin() to obtain shared, refcounted copy instead of calling
- * this function directly.
- */
-static struct origin *make_origin(struct commit *commit, const char *path)
-{
-	struct origin *o;
-	o = xcalloc(1, sizeof(*o) + strlen(path) + 1);
-	o->commit = commit;
-	o->refcnt = 1;
-	strcpy(o->path, path);
-	return o;
-}
-
-/*
- * Locate an existing origin or create a new one.
- */
-static struct origin *get_origin(struct blame_scoreboard *sb,
-				 struct commit *commit,
-				 const char *path)
-{
-	struct blame_entry *e;
-
-	for (e = sb->ent; e; e = e->next) {
-		if (e->suspect->commit == commit &&
-		    !strcmp(e->suspect->path, path))
-			return origin_incref(e->suspect);
-	}
-	return make_origin(commit, path);
-}
-
-/*
- * Fill the blob_sha1 field of an origin if it hasn't, so that later
- * call to fill_origin_blob() can use it to locate the data.  blob_sha1
- * for an origin is also used to pass the blame for the entire file to
- * the parent to detect the case where a child's blob is identical to
- * that of its parent's.
- */
-static int fill_blob_sha1(struct origin *origin)
-{
-	unsigned mode;
-
-	if (!is_null_sha1(origin->blob_sha1))
-		return 0;
-	if (get_tree_entry(origin->commit->object.sha1,
-			   origin->path,
-			   origin->blob_sha1, &mode))
-		goto error_out;
-	if (sha1_object_info(origin->blob_sha1, NULL) != OBJ_BLOB)
-		goto error_out;
-	return 0;
- error_out:
-	hashclr(origin->blob_sha1);
-	return -1;
-}
-
-/*
- * We have an origin -- check if the same path exists in the
- * parent and return an origin structure to represent it.
- */
-static struct origin *find_origin(struct blame_scoreboard *sb,
-				  struct commit *parent,
-				  struct origin *origin)
-{
-	struct origin *porigin = NULL;
-	struct diff_options diff_opts;
-	const char *paths[2];
-
-	if (parent->util) {
-		/*
-		 * Each commit object can cache one origin in that
-		 * commit.  This is a freestanding copy of origin and
-		 * not refcounted.
-		 */
-		struct origin *cached = parent->util;
-		if (!strcmp(cached->path, origin->path)) {
-			/*
-			 * The same path between origin and its parent
-			 * without renaming -- the most common case.
-			 */
-			porigin = get_origin(sb, parent, cached->path);
-
-			/*
-			 * If the origin was newly created (i.e. get_origin
-			 * would call make_origin if none is found in the
-			 * scoreboard), it does not know the blob_sha1,
-			 * so copy it.  Otherwise porigin was in the
-			 * scoreboard and already knows blob_sha1.
-			 */
-			if (porigin->refcnt == 1)
-				hashcpy(porigin->blob_sha1, cached->blob_sha1);
-			return porigin;
-		}
-		/* otherwise it was not very useful; free it */
-		free(parent->util);
-		parent->util = NULL;
-	}
-
-	/* See if the origin->path is different between parent
-	 * and origin first.  Most of the time they are the
-	 * same and diff-tree is fairly efficient about this.
-	 */
-	diff_setup(&diff_opts);
-	DIFF_OPT_SET(&diff_opts, RECURSIVE);
-	diff_opts.detect_rename = 0;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	paths[0] = origin->path;
-	paths[1] = NULL;
-
-	diff_tree_setup_paths(paths, &diff_opts);
-	if (diff_setup_done(&diff_opts) < 0)
-		die("diff-setup");
-
-	if (is_null_sha1(origin->commit->object.sha1))
-		do_diff_cache(parent->tree->object.sha1, &diff_opts);
-	else
-		diff_tree_sha1(parent->tree->object.sha1,
-			       origin->commit->tree->object.sha1,
-			       "", &diff_opts);
-	diffcore_std(&diff_opts);
-
-	/* It is either one entry that says "modified", or "created",
-	 * or nothing.
-	 */
-	if (!diff_queued_diff.nr) {
-		/* The path is the same as parent */
-		porigin = get_origin(sb, parent, origin->path);
-		hashcpy(porigin->blob_sha1, origin->blob_sha1);
-	}
-	else if (diff_queued_diff.nr != 1)
-		die("internal error in blame::find_origin");
-	else {
-		struct diff_filepair *p = diff_queued_diff.queue[0];
-		switch (p->status) {
-		default:
-			die("internal error in blame::find_origin (%c)",
-			    p->status);
-		case 'M':
-			porigin = get_origin(sb, parent, origin->path);
-			hashcpy(porigin->blob_sha1, p->one->sha1);
-			break;
-		case 'A':
-		case 'T':
-			/* Did not exist in parent, or type changed */
-			break;
-		}
-	}
-	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
-	if (porigin) {
-		/*
-		 * Create a freestanding copy that is not part of
-		 * the refcounted origin found in the scoreboard, and
-		 * cache it in the commit.
-		 */
-		struct origin *cached;
-
-		cached = make_origin(porigin->commit, porigin->path);
-		hashcpy(cached->blob_sha1, porigin->blob_sha1);
-		parent->util = cached;
-	}
-	return porigin;
-}
-
-/*
- * We have an origin -- find the path that corresponds to it in its
- * parent and return an origin structure to represent it.
- */
-static struct origin *find_rename(struct blame_scoreboard *sb,
-				  struct commit *parent,
-				  struct origin *origin)
-{
-	struct origin *porigin = NULL;
-	struct diff_options diff_opts;
-	int i;
-	const char *paths[2];
-
-	diff_setup(&diff_opts);
-	DIFF_OPT_SET(&diff_opts, RECURSIVE);
-	diff_opts.detect_rename = DIFF_DETECT_RENAME;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_opts.single_follow = origin->path;
-	paths[0] = NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
-	if (diff_setup_done(&diff_opts) < 0)
-		die("diff-setup");
-
-	if (is_null_sha1(origin->commit->object.sha1))
-		do_diff_cache(parent->tree->object.sha1, &diff_opts);
-	else
-		diff_tree_sha1(parent->tree->object.sha1,
-			       origin->commit->tree->object.sha1,
-			       "", &diff_opts);
-	diffcore_std(&diff_opts);
-
-	for (i = 0; i < diff_queued_diff.nr; i++) {
-		struct diff_filepair *p = diff_queued_diff.queue[i];
-		if ((p->status == 'R' || p->status == 'C') &&
-		    !strcmp(p->two->path, origin->path)) {
-			porigin = get_origin(sb, parent, p->one->path);
-			hashcpy(porigin->blob_sha1, p->one->sha1);
-			break;
-		}
-	}
-	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
-	return porigin;
-}
-
-/*
- * Link in a new blame entry to the scoreboard.  Entries that cover the
- * same line range have been removed from the scoreboard previously.
- */
-static void add_blame_entry(struct blame_scoreboard *sb, struct blame_entry *e)
-{
-	struct blame_entry *ent, *prev = NULL;
-
-	origin_incref(e->suspect);
-
-	for (ent = sb->ent; ent && ent->lno < e->lno; ent = ent->next)
-		prev = ent;
-
-	/* prev, if not NULL, is the last one that is below e */
-	e->prev = prev;
-	if (prev) {
-		e->next = prev->next;
-		prev->next = e;
-	}
-	else {
-		e->next = sb->ent;
-		sb->ent = e;
-	}
-	if (e->next)
-		e->next->prev = e;
-}
-
-/*
- * src typically is on-stack; we want to copy the information in it to
- * a malloced blame_entry that is already on the linked list of the
- * scoreboard.  The origin of dst loses a refcnt while the origin of src
- * gains one.
- */
-static void dup_entry(struct blame_entry *dst, struct blame_entry *src)
-{
-	struct blame_entry *p, *n;
-
-	p = dst->prev;
-	n = dst->next;
-	origin_incref(src->suspect);
-	origin_decref(dst->suspect);
-	memcpy(dst, src, sizeof(*src));
-	dst->prev = p;
-	dst->next = n;
-	dst->score = 0;
-}
-
-static const char *nth_line(struct blame_scoreboard *sb, int lno)
-{
-	return sb->final_buf + sb->lineno[lno];
-}
-
-/*
- * It is known that lines between tlno to same came from parent, and e
- * has an overlap with that range.  it also is known that parent's
- * line plno corresponds to e's line tlno.
- *
- *                <---- e ----->
- *                   <------>
- *                   <------------>
- *             <------------>
- *             <------------------>
- *
- * Split e into potentially three parts; before this chunk, the chunk
- * to be blamed for the parent, and after that portion.
- */
-static void split_overlap(struct blame_entry *split,
-			  struct blame_entry *e,
-			  int tlno, int plno, int same,
-			  struct origin *parent)
-{
-	int chunk_end_lno;
-	memset(split, 0, sizeof(struct blame_entry [3]));
-
-	if (e->s_lno < tlno) {
-		/* there is a pre-chunk part not blamed on parent */
-		split[0].suspect = origin_incref(e->suspect);
-		split[0].lno = e->lno;
-		split[0].s_lno = e->s_lno;
-		split[0].num_lines = tlno - e->s_lno;
-		split[1].lno = e->lno + tlno - e->s_lno;
-		split[1].s_lno = plno;
-	}
-	else {
-		split[1].lno = e->lno;
-		split[1].s_lno = plno + (e->s_lno - tlno);
-	}
-
-	if (same < e->s_lno + e->num_lines) {
-		/* there is a post-chunk part not blamed on parent */
-		split[2].suspect = origin_incref(e->suspect);
-		split[2].lno = e->lno + (same - e->s_lno);
-		split[2].s_lno = e->s_lno + (same - e->s_lno);
-		split[2].num_lines = e->s_lno + e->num_lines - same;
-		chunk_end_lno = split[2].lno;
-	}
-	else
-		chunk_end_lno = e->lno + e->num_lines;
-	split[1].num_lines = chunk_end_lno - split[1].lno;
-
-	/*
-	 * if it turns out there is nothing to blame the parent for,
-	 * forget about the splitting.  !split[1].suspect signals this.
-	 */
-	if (split[1].num_lines < 1)
-		return;
-	split[1].suspect = origin_incref(parent);
-}
-
-/*
- * split_overlap() divided an existing blame e into up to three parts
- * in split.  Adjust the linked list of blames in the scoreboard to
- * reflect the split.
- */
-static void split_blame(struct blame_scoreboard *sb,
-			struct blame_entry *split,
-			struct blame_entry *e)
-{
-	struct blame_entry *new_entry;
-
-	if (split[0].suspect && split[2].suspect) {
-		/* The first part (reuse storage for the existing entry e) */
-		dup_entry(e, &split[0]);
-
-		/* The last part -- me */
-		new_entry = xmalloc(sizeof(*new_entry));
-		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
-
-		/* ... and the middle part -- parent */
-		new_entry = xmalloc(sizeof(*new_entry));
-		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
-	}
-	else if (!split[0].suspect && !split[2].suspect)
-		/*
-		 * The parent covers the entire area; reuse storage for
-		 * e and replace it with the parent.
-		 */
-		dup_entry(e, &split[1]);
-	else if (split[0].suspect) {
-		/* me and then parent */
-		dup_entry(e, &split[0]);
-
-		new_entry = xmalloc(sizeof(*new_entry));
-		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
-	}
-	else {
-		/* parent and then me */
-		dup_entry(e, &split[1]);
-
-		new_entry = xmalloc(sizeof(*new_entry));
-		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
-		add_blame_entry(sb, new_entry);
-	}
-
-	if (DEBUG) { /* sanity */
-		struct blame_entry *ent;
-		int lno = sb->ent->lno, corrupt = 0;
-
-		for (ent = sb->ent; ent; ent = ent->next) {
-			if (lno != ent->lno)
-				corrupt = 1;
-			if (ent->s_lno < 0)
-				corrupt = 1;
-			lno += ent->num_lines;
-		}
-		if (corrupt) {
-			lno = sb->ent->lno;
-			for (ent = sb->ent; ent; ent = ent->next) {
-				printf("L %8d l %8d n %8d\n",
-				       lno, ent->lno, ent->num_lines);
-				lno = ent->lno + ent->num_lines;
-			}
-			die("oops");
-		}
-	}
-}
-
-/*
- * After splitting the blame, the origins used by the
- * on-stack blame_entry should lose one refcnt each.
- */
-static void decref_split(struct blame_entry *split)
-{
-	int i;
-
-	for (i = 0; i < 3; i++)
-		origin_decref(split[i].suspect);
-}
-
-/*
- * Helper for blame_chunk().  blame_entry e is known to overlap with
- * the patch hunk; split it and pass blame to the parent.
- */
-static void blame_overlap(struct blame_scoreboard *sb, struct blame_entry *e,
-			  int tlno, int plno, int same,
-			  struct origin *parent)
-{
-	struct blame_entry split[3];
-
-	split_overlap(split, e, tlno, plno, same, parent);
-	if (split[1].suspect)
-		split_blame(sb, split, e);
-	decref_split(split);
-}
-
-/*
- * Find the line number of the last line the target is suspected for.
- */
-static int find_last_in_target(struct blame_scoreboard *sb, struct origin *target)
-{
-	struct blame_entry *e;
-	int last_in_target = -1;
-
-	for (e = sb->ent; e; e = e->next) {
-		if (e->guilty || !same_suspect(e->suspect, target))
-			continue;
-		if (last_in_target < e->s_lno + e->num_lines)
-			last_in_target = e->s_lno + e->num_lines;
-	}
-	return last_in_target;
-}
-
-/*
- * Process one hunk from the patch between the current suspect for
- * blame_entry e and its parent.  Find and split the overlap, and
- * pass blame to the overlapping part to the parent.
- */
-static void blame_chunk(struct blame_scoreboard *sb,
-			int tlno, int plno, int same,
-			struct origin *target, struct origin *parent)
-{
-	struct blame_entry *e;
-
-	for (e = sb->ent; e; e = e->next) {
-		if (e->guilty || !same_suspect(e->suspect, target))
-			continue;
-		if (same <= e->s_lno)
-			continue;
-		if (tlno < e->s_lno + e->num_lines)
-			blame_overlap(sb, e, tlno, plno, same, parent);
-	}
-}
-
-struct blame_chunk_cb_data {
-	struct blame_scoreboard *sb;
-	struct origin *target;
-	struct origin *parent;
-	long plno;
-	long tlno;
-};
-
-static void blame_chunk_cb(void *data, long same, long p_next, long t_next)
-{
-	struct blame_chunk_cb_data *d = data;
-	blame_chunk(d->sb, d->tlno, d->plno, same, d->target, d->parent);
-	d->plno = p_next;
-	d->tlno = t_next;
-}
-
-/*
- * We are looking at the origin 'target' and aiming to pass blame
- * for the lines it is suspected to its parent.  Run diff to find
- * which lines came from parent and pass blame for them.
- */
-static int pass_blame_to_parent(struct blame_scoreboard *sb,
-				struct origin *target,
-				struct origin *parent)
-{
-	int last_in_target;
-	mmfile_t file_p, file_o;
-	struct blame_chunk_cb_data d = { sb, target, parent, 0, 0 };
-	xpparam_t xpp;
-	xdemitconf_t xecfg;
-
-	last_in_target = find_last_in_target(sb, target);
-	if (last_in_target < 0)
-		return 1; /* nothing remains for this target */
-
-	fill_origin_blob(sb->ssb, parent, &file_p);
-	fill_origin_blob(sb->ssb, target, &file_o);
-	sb->ssb->stat->num_get_patch++;
-
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = sb->ssb->xdl_opts;
-	memset(&xecfg, 0, sizeof(xecfg));
-	xecfg.ctxlen = 0;
-	xdi_diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, &xpp, &xecfg);
-	/* The rest (i.e. anything after tlno) are the same as the parent */
-	blame_chunk(sb, d.tlno, d.plno, last_in_target, target, parent);
-
-	return 0;
-}
-
-/*
- * The lines in blame_entry after splitting blames many times can become
- * very small and trivial, and at some point it becomes pointless to
- * blame the parents.  E.g. "\t\t}\n\t}\n\n" appears everywhere in any
- * ordinary C program, and it is not worth to say it was copied from
- * totally unrelated file in the parent.
- *
- * Compute how trivial the lines in the blame_entry are.
- */
-static unsigned ent_score(struct blame_scoreboard *sb, struct blame_entry *e)
-{
-	unsigned score;
-	const char *cp, *ep;
-
-	if (e->score)
-		return e->score;
-
-	score = 1;
-	cp = nth_line(sb, e->lno);
-	ep = nth_line(sb, e->lno + e->num_lines);
-	while (cp < ep) {
-		unsigned ch = *((unsigned char *)cp);
-		if (isalnum(ch))
-			score++;
-		cp++;
-	}
-	e->score = score;
-	return score;
-}
-
-/*
- * best_so_far[] and this[] are both a split of an existing blame_entry
- * that passes blame to the parent.  Maintain best_so_far the best split
- * so far, by comparing this and best_so_far and copying this into
- * bst_so_far as needed.
- */
-static void copy_split_if_better(struct blame_scoreboard *sb,
-				 struct blame_entry *best_so_far,
-				 struct blame_entry *this)
-{
-	int i;
-
-	if (!this[1].suspect)
-		return;
-	if (best_so_far[1].suspect) {
-		if (ent_score(sb, &this[1]) < ent_score(sb, &best_so_far[1]))
-			return;
-	}
-
-	for (i = 0; i < 3; i++)
-		origin_incref(this[i].suspect);
-	decref_split(best_so_far);
-	memcpy(best_so_far, this, sizeof(struct blame_entry [3]));
-}
-
-/*
- * We are looking at a part of the final image represented by
- * ent (tlno and same are offset by ent->s_lno).
- * tlno is where we are looking at in the final image.
- * up to (but not including) same match preimage.
- * plno is where we are looking at in the preimage.
- *
- * <-------------- final image ---------------------->
- *       <------ent------>
- *         ^tlno ^same
- *    <---------preimage----->
- *         ^plno
- *
- * All line numbers are 0-based.
- */
-static void handle_split(struct blame_scoreboard *sb,
-			 struct blame_entry *ent,
-			 int tlno, int plno, int same,
-			 struct origin *parent,
-			 struct blame_entry *split)
-{
-	if (ent->num_lines <= tlno)
-		return;
-	if (tlno < same) {
-		struct blame_entry this[3];
-		tlno += ent->s_lno;
-		same += ent->s_lno;
-		split_overlap(this, ent, tlno, plno, same, parent);
-		copy_split_if_better(sb, split, this);
-		decref_split(this);
-	}
-}
-
-struct handle_split_cb_data {
-	struct blame_scoreboard *sb;
-	struct blame_entry *ent;
-	struct origin *parent;
-	struct blame_entry *split;
-	long plno;
-	long tlno;
-};
-
-static void handle_split_cb(void *data, long same, long p_next, long t_next)
-{
-	struct handle_split_cb_data *d = data;
-	handle_split(d->sb, d->ent, d->tlno, d->plno, same, d->parent, d->split);
-	d->plno = p_next;
-	d->tlno = t_next;
-}
-
-/*
- * Find the lines from parent that are the same as ent so that
- * we can pass blames to it.  file_p has the blob contents for
- * the parent.
- */
-static void find_copy_in_blob(struct blame_scoreboard *sb,
-			      struct blame_entry *ent,
-			      struct origin *parent,
-			      struct blame_entry *split,
-			      mmfile_t *file_p)
-{
-	const char *cp;
-	int cnt;
-	mmfile_t file_o;
-	struct handle_split_cb_data d = { sb, ent, parent, split, 0, 0 };
-	xpparam_t xpp;
-	xdemitconf_t xecfg;
-
-	/*
-	 * Prepare mmfile that contains only the lines in ent.
-	 */
-	cp = nth_line(sb, ent->lno);
-	file_o.ptr = (char*) cp;
-	cnt = ent->num_lines;
-
-	while (cnt && cp < sb->final_buf + sb->final_buf_size) {
-		if (*cp++ == '\n')
-			cnt--;
-	}
-	file_o.size = cp - file_o.ptr;
-
-	/*
-	 * file_o is a part of final image we are annotating.
-	 * file_p partially may match that image.
-	 */
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = sb->ssb->xdl_opts;
-	memset(&xecfg, 0, sizeof(xecfg));
-	xecfg.ctxlen = 1;
-	memset(split, 0, sizeof(struct blame_entry [3]));
-	xdi_diff_hunks(file_p, &file_o, handle_split_cb, &d, &xpp, &xecfg);
-	/* remainder, if any, all match the preimage */
-	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
-}
-
-/*
- * See if lines currently target is suspected for can be attributed to
- * parent.
- */
-static int find_move_in_parent(struct blame_scoreboard *sb,
-			       struct origin *target,
-			       struct origin *parent)
-{
-	int last_in_target, made_progress;
-	struct blame_entry *e, split[3];
-	mmfile_t file_p;
-
-	last_in_target = find_last_in_target(sb, target);
-	if (last_in_target < 0)
-		return 1; /* nothing remains for this target */
-
-	fill_origin_blob(sb->ssb, parent, &file_p);
-	if (!file_p.ptr)
-		return 0;
-
-	made_progress = 1;
-	while (made_progress) {
-		made_progress = 0;
-		for (e = sb->ent; e; e = e->next) {
-			if (e->guilty || !same_suspect(e->suspect, target) ||
-			    ent_score(sb, e) < sb->ssb->blame_move_score)
-				continue;
-			find_copy_in_blob(sb, e, parent, split, &file_p);
-			if (split[1].suspect &&
-			    sb->ssb->blame_move_score < ent_score(sb, &split[1])) {
-				split_blame(sb, split, e);
-				made_progress = 1;
-			}
-			decref_split(split);
-		}
-	}
-	return 0;
-}
-
-struct blame_list {
-	struct blame_entry *ent;
-	struct blame_entry split[3];
-};
-
-/*
- * Count the number of entries the target is suspected for,
- * and prepare a list of entry and the best split.
- */
-static struct blame_list *setup_blame_list(struct blame_scoreboard *sb,
-					   struct origin *target,
-					   int min_score,
-					   int *num_ents_p)
-{
-	struct blame_entry *e;
-	int num_ents, i;
-	struct blame_list *blame_list = NULL;
-
-	for (e = sb->ent, num_ents = 0; e; e = e->next)
-		if (!e->scanned && !e->guilty &&
-		    same_suspect(e->suspect, target) &&
-		    min_score < ent_score(sb, e))
-			num_ents++;
-	if (num_ents) {
-		blame_list = xcalloc(num_ents, sizeof(struct blame_list));
-		for (e = sb->ent, i = 0; e; e = e->next)
-			if (!e->scanned && !e->guilty &&
-			    same_suspect(e->suspect, target) &&
-			    min_score < ent_score(sb, e))
-				blame_list[i++].ent = e;
-	}
-	*num_ents_p = num_ents;
-	return blame_list;
-}
-
-/*
- * Reset the scanned status on all entries.
- */
-static void reset_scanned_flag(struct blame_scoreboard *sb)
-{
-	struct blame_entry *e;
-	for (e = sb->ent; e; e = e->next)
-		e->scanned = 0;
-}
-
-/*
- * For lines target is suspected for, see if we can find code movement
- * across file boundary from the parent commit.  porigin is the path
- * in the parent we already tried.
- */
-static int find_copy_in_parent(struct blame_scoreboard *sb,
-			       struct origin *target,
-			       struct commit *parent,
-			       struct origin *porigin,
-			       int opt)
-{
-	struct diff_options diff_opts;
-	const char *paths[1];
-	int i, j;
-	int retval;
-	struct blame_list *blame_list;
-	int num_ents;
-
-	blame_list = setup_blame_list(sb, target, sb->ssb->blame_copy_score, &num_ents);
-	if (!blame_list)
-		return 1; /* nothing remains for this target */
-
-	diff_setup(&diff_opts);
-	DIFF_OPT_SET(&diff_opts, RECURSIVE);
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-
-	paths[0] = NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
-	if (diff_setup_done(&diff_opts) < 0)
-		die("diff-setup");
-
-	/* Try "find copies harder" on new path if requested;
-	 * we do not want to use diffcore_rename() actually to
-	 * match things up; find_copies_harder is set only to
-	 * force diff_tree_sha1() to feed all filepairs to diff_queue,
-	 * and this code needs to be after diff_setup_done(), which
-	 * usually makes find-copies-harder imply copy detection.
-	 */
-	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
-	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
-		&& (!porigin || strcmp(target->path, porigin->path))))
-		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
-
-	if (is_null_sha1(target->commit->object.sha1))
-		do_diff_cache(parent->tree->object.sha1, &diff_opts);
-	else
-		diff_tree_sha1(parent->tree->object.sha1,
-			       target->commit->tree->object.sha1,
-			       "", &diff_opts);
-
-	if (!DIFF_OPT_TST(&diff_opts, FIND_COPIES_HARDER))
-		diffcore_std(&diff_opts);
-
-	retval = 0;
-	while (1) {
-		int made_progress = 0;
-
-		for (i = 0; i < diff_queued_diff.nr; i++) {
-			struct diff_filepair *p = diff_queued_diff.queue[i];
-			struct origin *norigin;
-			mmfile_t file_p;
-			struct blame_entry this[3];
-
-			if (!DIFF_FILE_VALID(p->one))
-				continue; /* does not exist in parent */
-			if (S_ISGITLINK(p->one->mode))
-				continue; /* ignore git links */
-			if (porigin && !strcmp(p->one->path, porigin->path))
-				/* find_move already dealt with this path */
-				continue;
-
-			norigin = get_origin(sb, parent, p->one->path);
-			hashcpy(norigin->blob_sha1, p->one->sha1);
-			fill_origin_blob(sb->ssb, norigin, &file_p);
-			if (!file_p.ptr)
-				continue;
-
-			for (j = 0; j < num_ents; j++) {
-				find_copy_in_blob(sb, blame_list[j].ent,
-						  norigin, this, &file_p);
-				copy_split_if_better(sb, blame_list[j].split,
-						     this);
-				decref_split(this);
-			}
-			origin_decref(norigin);
-		}
-
-		for (j = 0; j < num_ents; j++) {
-			struct blame_entry *split = blame_list[j].split;
-			if (split[1].suspect &&
-			    sb->ssb->blame_copy_score < ent_score(sb, &split[1])) {
-				split_blame(sb, split, blame_list[j].ent);
-				made_progress = 1;
-			}
-			else
-				blame_list[j].ent->scanned = 1;
-			decref_split(split);
-		}
-		free(blame_list);
-
-		if (!made_progress)
-			break;
-		blame_list = setup_blame_list(sb, target, sb->ssb->blame_copy_score, &num_ents);
-		if (!blame_list) {
-			retval = 1;
-			break;
-		}
-	}
-	reset_scanned_flag(sb);
-	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
-	return retval;
-}
-
-/*
- * The blobs of origin and porigin exactly match, so everything
- * origin is suspected for can be blamed on the parent.
- */
-static void pass_whole_blame(struct blame_scoreboard *sb,
-			     struct origin *origin, struct origin *porigin)
-{
-	struct blame_entry *e;
-
-	if (!porigin->file.ptr && origin->file.ptr) {
-		/* Steal its file */
-		porigin->file = origin->file;
-		origin->file.ptr = NULL;
-	}
-	for (e = sb->ent; e; e = e->next) {
-		if (!same_suspect(e->suspect, origin))
-			continue;
-		origin_incref(porigin);
-		origin_decref(e->suspect);
-		e->suspect = porigin;
-	}
-}
-
-/*
- * We pass blame from the current commit to its parents.  We keep saying
- * "parent" (and "porigin"), but what we mean is to find scapegoat to
- * exonerate ourselves.
- */
-static struct commit_list *first_scapegoat(struct blame_info *ssb,
-					   struct rev_info *revs,
-					   struct commit *commit)
-{
-	if (!ssb->reverse)
-		return commit->parents;
-	return lookup_decoration(&revs->children, &commit->object);
-}
-
-static int num_scapegoats(struct blame_info *ssb,
-			  struct rev_info *revs,
-			  struct commit *commit)
-{
-	int cnt;
-	struct commit_list *l = first_scapegoat(ssb, revs, commit);
-	for (cnt = 0; l; l = l->next)
-		cnt++;
-	return cnt;
-}
-
-#define MAXSG 16
-
-static void pass_blame(struct blame_scoreboard *sb, struct origin *origin, int opt)
-{
-	struct rev_info *revs = sb->revs;
-	int i, pass, num_sg;
-	struct commit *commit = origin->commit;
-	struct commit_list *sg;
-	struct origin *sg_buf[MAXSG];
-	struct origin *porigin, **sg_origin = sg_buf;
-
-	num_sg = num_scapegoats(sb->ssb, revs, commit);
-	if (!num_sg)
-		goto finish;
-	else if (num_sg < ARRAY_SIZE(sg_buf))
-		memset(sg_buf, 0, sizeof(sg_buf));
-	else
-		sg_origin = xcalloc(num_sg, sizeof(*sg_origin));
-
-	/*
-	 * The first pass looks for unrenamed path to optimize for
-	 * common cases, then we look for renames in the second pass.
-	 */
-	for (pass = 0; pass < 2; pass++) {
-		struct origin *(*find)(struct blame_scoreboard *,
-				       struct commit *, struct origin *);
-		find = pass ? find_rename : find_origin;
-
-		for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
-		     i < num_sg && sg;
-		     sg = sg->next, i++) {
-			struct commit *p = sg->item;
-			int j, same;
-
-			if (sg_origin[i])
-				continue;
-			if (parse_commit(p))
-				continue;
-			porigin = find(sb, p, origin);
-			if (!porigin)
-				continue;
-			if (!hashcmp(porigin->blob_sha1, origin->blob_sha1)) {
-				pass_whole_blame(sb, origin, porigin);
-				origin_decref(porigin);
-				goto finish;
-			}
-			for (j = same = 0; j < i; j++)
-				if (sg_origin[j] &&
-				    !hashcmp(sg_origin[j]->blob_sha1,
-					     porigin->blob_sha1)) {
-					same = 1;
-					break;
-				}
-			if (!same)
-				sg_origin[i] = porigin;
-			else
-				origin_decref(porigin);
-		}
-	}
-
-	sb->ssb->stat->num_commits++;
-	for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
-	     i < num_sg && sg;
-	     sg = sg->next, i++) {
-		struct origin *porigin = sg_origin[i];
-		if (!porigin)
-			continue;
-		if (!origin->previous) {
-			origin_incref(porigin);
-			origin->previous = porigin;
-		}
-		if (pass_blame_to_parent(sb, origin, porigin))
-			goto finish;
-	}
-
-	/*
-	 * Optionally find moves in parents' files.
-	 */
-	if (opt & PICKAXE_BLAME_MOVE)
-		for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
-		     i < num_sg && sg;
-		     sg = sg->next, i++) {
-			struct origin *porigin = sg_origin[i];
-			if (!porigin)
-				continue;
-			if (find_move_in_parent(sb, origin, porigin))
-				goto finish;
-		}
-
-	/*
-	 * Optionally find copies from parents' files.
-	 */
-	if (opt & PICKAXE_BLAME_COPY)
-		for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
-		     i < num_sg && sg;
-		     sg = sg->next, i++) {
-			struct origin *porigin = sg_origin[i];
-			if (find_copy_in_parent(sb, origin, sg->item,
-						porigin, opt))
-				goto finish;
-		}
-
- finish:
-	for (i = 0; i < num_sg; i++) {
-		if (sg_origin[i]) {
-			drop_origin_blob(sg_origin[i]);
-			origin_decref(sg_origin[i]);
-		}
-	}
-	drop_origin_blob(origin);
-	if (sg_buf != sg_origin)
-		free(sg_origin);
-}
-
-/*
- * Information on commits, used for output.
- */
-struct commit_info
-{
-	const char *author;
-	const char *author_mail;
-	unsigned long author_time;
-	const char *author_tz;
-
-	/* filled only when asked for details */
-	const char *committer;
-	const char *committer_mail;
-	unsigned long committer_time;
-	const char *committer_tz;
-
-	const char *summary;
-};
-
-/*
- * Parse author/committer line in the commit object buffer
- */
-static void get_ac_line(struct string_list *mailmap, const char *inbuf,
-			const char *what, int person_len, char *person,
-			int mail_len, char *mail,
-			unsigned long *time, const char **tz)
-{
-	int len, tzlen, maillen;
-	char *tmp, *endp, *timepos, *mailpos;
-
-	tmp = strstr(inbuf, what);
-	if (!tmp)
-		goto error_out;
-	tmp += strlen(what);
-	endp = strchr(tmp, '\n');
-	if (!endp)
-		len = strlen(tmp);
-	else
-		len = endp - tmp;
-	if (person_len <= len) {
-	error_out:
-		/* Ugh */
-		*tz = "(unknown)";
-		strcpy(mail, *tz);
-		*time = 0;
-		return;
-	}
-	memcpy(person, tmp, len);
-
-	tmp = person;
-	tmp += len;
-	*tmp = 0;
-	while (*tmp != ' ')
-		tmp--;
-	*tz = tmp+1;
-	tzlen = (person+len)-(tmp+1);
-
-	*tmp = 0;
-	while (*tmp != ' ')
-		tmp--;
-	*time = strtoul(tmp, NULL, 10);
-	timepos = tmp;
-
-	*tmp = 0;
-	while (*tmp != ' ')
-		tmp--;
-	mailpos = tmp + 1;
-	*tmp = 0;
-	maillen = timepos - tmp;
-	memcpy(mail, mailpos, maillen);
-
-	if (!mailmap->nr)
-		return;
-
-	/*
-	 * mailmap expansion may make the name longer.
-	 * make room by pushing stuff down.
-	 */
-	tmp = person + person_len - (tzlen + 1);
-	memmove(tmp, *tz, tzlen);
-	tmp[tzlen] = 0;
-	*tz = tmp;
-
-	/*
-	 * Now, convert both name and e-mail using mailmap
-	 */
-	if (map_user(mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
-		/* Add a trailing '>' to email, since map_user returns plain emails
-		   Note: It already has '<', since we replace from mail+1 */
-		mailpos = memchr(mail, '\0', mail_len);
-		if (mailpos && mailpos-mail < mail_len - 1) {
-			*mailpos = '>';
-			*(mailpos+1) = '\0';
-		}
-	}
-}
-
-static void get_commit_info(struct string_list *mailmap,
-			    struct commit *commit,
-			    struct commit_info *ret,
-			    int detailed)
-{
-	int len;
-	char *tmp, *endp, *reencoded, *message;
-	static char author_name[1024];
-	static char author_mail[1024];
-	static char committer_name[1024];
-	static char committer_mail[1024];
-	static char summary_buf[1024];
-
-	/*
-	 * We've operated without save_commit_buffer, so
-	 * we now need to populate them for output.
-	 */
-	if (!commit->buffer) {
-		enum object_type type;
-		unsigned long size;
-		commit->buffer =
-			read_sha1_file(commit->object.sha1, &type, &size);
-		if (!commit->buffer)
-			die("Cannot read commit %s",
-			    sha1_to_hex(commit->object.sha1));
-	}
-	reencoded = reencode_commit_message(commit, NULL);
-	message   = reencoded ? reencoded : commit->buffer;
-	ret->author = author_name;
-	ret->author_mail = author_mail;
-	get_ac_line(mailmap, message, "\nauthor ",
-		    sizeof(author_name), author_name,
-		    sizeof(author_mail), author_mail,
-		    &ret->author_time, &ret->author_tz);
-
-	if (!detailed) {
-		free(reencoded);
-		return;
-	}
-
-	ret->committer = committer_name;
-	ret->committer_mail = committer_mail;
-	get_ac_line(mailmap, message, "\ncommitter ",
-		    sizeof(committer_name), committer_name,
-		    sizeof(committer_mail), committer_mail,
-		    &ret->committer_time, &ret->committer_tz);
-
-	ret->summary = summary_buf;
-	tmp = strstr(message, "\n\n");
-	if (!tmp) {
-	error_out:
-		sprintf(summary_buf, "(%s)", sha1_to_hex(commit->object.sha1));
-		free(reencoded);
-		return;
-	}
-	tmp += 2;
-	endp = strchr(tmp, '\n');
-	if (!endp)
-		endp = tmp + strlen(tmp);
-	len = endp - tmp;
-	if (len >= sizeof(summary_buf) || len == 0)
-		goto error_out;
-	memcpy(summary_buf, tmp, len);
-	summary_buf[len] = 0;
-	free(reencoded);
-}
-
-/*
- * To allow LF and other nonportable characters in pathnames,
- * they are c-style quoted as needed.
- */
-static void write_filename_info(const char *path)
-{
-	printf("filename ");
-	write_name_quoted(path, stdout, '\n');
-}
-
-/*
- * Porcelain/Incremental format wants to show a lot of details per
- * commit.  Instead of repeating this every line, emit it only once,
- * the first time each commit appears in the output.
- */
-static int emit_one_suspect_detail(struct string_list *mailmap,
-				   struct origin *suspect)
-{
-	struct commit_info ci;
-
-	if (suspect->commit->object.flags & METAINFO_SHOWN)
-		return 0;
-
-	suspect->commit->object.flags |= METAINFO_SHOWN;
-	get_commit_info(mailmap, suspect->commit, &ci, 1);
-	printf("author %s\n", ci.author);
-	printf("author-mail %s\n", ci.author_mail);
-	printf("author-time %lu\n", ci.author_time);
-	printf("author-tz %s\n", ci.author_tz);
-	printf("committer %s\n", ci.committer);
-	printf("committer-mail %s\n", ci.committer_mail);
-	printf("committer-time %lu\n", ci.committer_time);
-	printf("committer-tz %s\n", ci.committer_tz);
-	printf("summary %s\n", ci.summary);
-	if (suspect->commit->object.flags & UNINTERESTING)
-		printf("boundary\n");
-	if (suspect->previous) {
-		struct origin *prev = suspect->previous;
-		printf("previous %s ", sha1_to_hex(prev->commit->object.sha1));
-		write_name_quoted(prev->path, stdout, '\n');
-	}
-	return 1;
-}
-
-/*
- * The blame_entry is found to be guilty for the range.  Mark it
- * as such, and show it in incremental output.
- */
-static void found_guilty_entry(struct blame_info *ssb, struct blame_entry *ent)
-{
-	if (ent->guilty)
-		return;
-	ent->guilty = 1;
-	if (ssb->incremental) {
-		struct origin *suspect = ent->suspect;
-
-		printf("%s %d %d %d\n",
-		       sha1_to_hex(suspect->commit->object.sha1),
-		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
-		emit_one_suspect_detail(&ssb->mailmap, suspect);
-		write_filename_info(suspect->path);
-		maybe_flush_or_die(stdout, "stdout");
-	}
-}
-
-/*
- * The main loop -- while the scoreboard has lines whose true origin
- * is still unknown, pick one blame_entry, and allow its current
- * suspect to pass blames to its parents.
- */
-void assign_blame(struct blame_scoreboard *sb, int opt)
-{
-	struct rev_info *revs = sb->revs;
-
-	while (1) {
-		struct blame_entry *ent;
-		struct commit *commit;
-		struct origin *suspect = NULL;
-
-		/* find one suspect to break down */
-		for (ent = sb->ent; !suspect && ent; ent = ent->next)
-			if (!ent->guilty)
-				suspect = ent->suspect;
-		if (!suspect)
-			return; /* all done */
-
-		/*
-		 * We will use this suspect later in the loop,
-		 * so hold onto it in the meantime.
-		 */
-		origin_incref(suspect);
-		commit = suspect->commit;
-		if (!commit->object.parsed)
-			parse_commit(commit);
-		if (sb->ssb->reverse ||
-		    (!(commit->object.flags & UNINTERESTING) &&
-		     !(revs->max_age != -1 && commit->date < revs->max_age)))
-			pass_blame(sb, suspect, opt);
-		else {
-			commit->object.flags |= UNINTERESTING;
-			if (commit->object.parsed)
-				mark_parents_uninteresting(commit);
-		}
-		/* treat root commit as boundary */
-		if (!commit->parents && !sb->ssb->show_root)
-			commit->object.flags |= UNINTERESTING;
-
-		/* Take responsibility for the remaining entries */
-		for (ent = sb->ent; ent; ent = ent->next)
-			if (same_suspect(ent->suspect, suspect))
-				found_guilty_entry(sb->ssb, ent);
-		origin_decref(suspect);
-
-		if (DEBUG) /* sanity */
-			sanity_check_refcnt(sb);
-	}
-}
-
-static const char *format_time(struct blame_info *ssb, unsigned long time,
-			       const char *tz_str, int show_raw_time)
-{
-	static char time_buf[128];
-	const char *time_str;
-	int time_len;
-	int tz;
-
-	if (show_raw_time) {
-		sprintf(time_buf, "%lu %s", time, tz_str);
-	}
-	else {
-		tz = atoi(tz_str);
-		time_str = show_date(time, tz, ssb->blame_date_mode);
-		time_len = strlen(time_str);
-		memcpy(time_buf, time_str, time_len);
-		memset(time_buf + time_len, ' ', ssb->blame_date_width - time_len);
-	}
-	return time_buf;
-}
-
-#define OUTPUT_ANNOTATE_COMPAT	001
-#define OUTPUT_LONG_OBJECT_NAME	002
-#define OUTPUT_RAW_TIMESTAMP	004
-#define OUTPUT_PORCELAIN	010
-#define OUTPUT_SHOW_NAME	020
-#define OUTPUT_SHOW_NUMBER	040
-#define OUTPUT_SHOW_SCORE      0100
-#define OUTPUT_NO_AUTHOR       0200
-
-static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent)
-{
-	int cnt;
-	const char *cp;
-	struct origin *suspect = ent->suspect;
-	char hex[41];
-
-	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
-	printf("%s%c%d %d %d\n",
-	       hex,
-	       ent->guilty ? ' ' : '*', // purely for debugging
-	       ent->s_lno + 1,
-	       ent->lno + 1,
-	       ent->num_lines);
-	if (emit_one_suspect_detail(&sb->ssb->mailmap, suspect) ||
-	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
-		write_filename_info(suspect->path);
-
-	cp = nth_line(sb, ent->lno);
-	for (cnt = 0; cnt < ent->num_lines; cnt++) {
-		char ch;
-		if (cnt)
-			printf("%s %d %d\n", hex,
-			       ent->s_lno + 1 + cnt,
-			       ent->lno + 1 + cnt);
-		putchar('\t');
-		do {
-			ch = *cp++;
-			putchar(ch);
-		} while (ch != '\n' &&
-			 cp < sb->final_buf + sb->final_buf_size);
-	}
-}
-
-static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
-{
-	int cnt;
-	const char *cp;
-	struct origin *suspect = ent->suspect;
-	struct commit_info ci;
-	char hex[41];
-	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
-
-	get_commit_info(&sb->ssb->mailmap, suspect->commit, &ci, 1);
-	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
-
-	cp = nth_line(sb, ent->lno);
-	for (cnt = 0; cnt < ent->num_lines; cnt++) {
-		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
-
-		if (suspect->commit->object.flags & UNINTERESTING) {
-			if (sb->ssb->blank_boundary)
-				memset(hex, ' ', length);
-			else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
-				length--;
-				putchar('^');
-			}
-		}
-
-		printf("%.*s", length, hex);
-		if (opt & OUTPUT_ANNOTATE_COMPAT)
-			printf("\t(%10s\t%10s\t%d)", ci.author,
-			       format_time(sb->ssb, ci.author_time,
-					   ci.author_tz, show_raw_time),
-			       ent->lno + 1 + cnt);
-		else {
-			if (opt & OUTPUT_SHOW_SCORE)
-				printf(" %*d %02d",
-				       sb->ssb->max_score_digits, ent->score,
-				       ent->suspect->refcnt);
-			if (opt & OUTPUT_SHOW_NAME)
-				printf(" %-*.*s", sb->ssb->longest_file,
-						  sb->ssb->longest_file, suspect->path);
-			if (opt & OUTPUT_SHOW_NUMBER)
-				printf(" %*d", sb->ssb->max_orig_digits,
-				       ent->s_lno + 1 + cnt);
-
-			if (!(opt & OUTPUT_NO_AUTHOR)) {
-				int pad = sb->ssb->longest_author - utf8_strwidth(ci.author);
-				printf(" (%s%*s %10s",
-				       ci.author, pad, "",
-				       format_time(sb->ssb, ci.author_time,
-						   ci.author_tz,
-						   show_raw_time));
-			}
-			printf(" %*d) ",
-			       sb->ssb->max_digits, ent->lno + 1 + cnt);
-		}
-		do {
-			ch = *cp++;
-			putchar(ch);
-		} while (ch != '\n' &&
-			 cp < sb->final_buf + sb->final_buf_size);
-	}
-}
-
-static void output(struct blame_scoreboard *sb, int option)
-{
-	struct blame_entry *ent;
-
-	if (option & OUTPUT_PORCELAIN) {
-		for (ent = sb->ent; ent; ent = ent->next) {
-			struct blame_entry *oth;
-			struct origin *suspect = ent->suspect;
-			struct commit *commit = suspect->commit;
-			if (commit->object.flags & MORE_THAN_ONE_PATH)
-				continue;
-			for (oth = ent->next; oth; oth = oth->next) {
-				if ((oth->suspect->commit != commit) ||
-				    !strcmp(oth->suspect->path, suspect->path))
-					continue;
-				commit->object.flags |= MORE_THAN_ONE_PATH;
-				break;
-			}
-		}
-	}
-
-	for (ent = sb->ent; ent; ent = ent->next) {
-		if (option & OUTPUT_PORCELAIN)
-			emit_porcelain(sb, ent);
-		else {
-			emit_other(sb, ent, option);
-		}
-	}
-}
-
-/*
- * To allow quick access to the contents of nth line in the
- * final image, prepare an index in the scoreboard.
- */
-static int prepare_lines(struct blame_scoreboard *sb)
-{
-	const char *buf = sb->final_buf;
-	unsigned long len = sb->final_buf_size;
-	int num = 0, incomplete = 0, bol = 1;
-
-	if (len && buf[len-1] != '\n')
-		incomplete++; /* incomplete line at the end */
-	while (len--) {
-		if (bol) {
-			sb->lineno = xrealloc(sb->lineno,
-					      sizeof(int* ) * (num + 1));
-			sb->lineno[num] = buf - sb->final_buf;
-			bol = 0;
-		}
-		if (*buf++ == '\n') {
-			num++;
-			bol = 1;
-		}
-	}
-	sb->lineno = xrealloc(sb->lineno,
-			      sizeof(int* ) * (num + incomplete + 1));
-	sb->lineno[num + incomplete] = buf - sb->final_buf;
-	sb->num_lines = num + incomplete;
-	return sb->num_lines;
-}
-
-/*
- * Add phony grafts for use with -S; this is primarily to
- * support git's cvsserver that wants to give a linear history
- * to its clients.
- */
-static int read_ancestry(const char *graft_file)
-{
-	FILE *fp = fopen(graft_file, "r");
-	char buf[1024];
-	if (!fp)
-		return -1;
-	while (fgets(buf, sizeof(buf), fp)) {
-		/* The format is just "Commit Parent1 Parent2 ...\n" */
-		int len = strlen(buf);
-		struct commit_graft *graft = read_graft_line(buf, len);
-		if (graft)
-			register_commit_graft(graft, 0);
-	}
-	fclose(fp);
-	return 0;
-}
-
-/*
- * How many columns do we need to show line numbers in decimal?
- */
-static int lineno_width(int lines)
-{
-	int i, width;
-
-	for (width = 1, i = 10; i <= lines + 1; width++)
-		i *= 10;
-	return width;
-}
-
-/*
- * How many columns do we need to show line numbers, authors,
- * and filenames?
- */
-static void find_alignment(struct blame_scoreboard *sb, int *option)
-{
-	int longest_src_lines = 0;
-	int longest_dst_lines = 0;
-	unsigned largest_score = 0;
-	struct blame_entry *e;
-
-	for (e = sb->ent; e; e = e->next) {
-		struct origin *suspect = e->suspect;
-		struct commit_info ci;
-		int num;
-
-		if (strcmp(suspect->path, sb->path))
-			*option |= OUTPUT_SHOW_NAME;
-		num = strlen(suspect->path);
-		if (sb->ssb->longest_file < num)
-			sb->ssb->longest_file = num;
-		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
-			suspect->commit->object.flags |= METAINFO_SHOWN;
-			get_commit_info(&sb->ssb->mailmap, suspect->commit, &ci, 1);
-			num = utf8_strwidth(ci.author);
-			if (sb->ssb->longest_author < num)
-				sb->ssb->longest_author = num;
-		}
-		num = e->s_lno + e->num_lines;
-		if (longest_src_lines < num)
-			longest_src_lines = num;
-		num = e->lno + e->num_lines;
-		if (longest_dst_lines < num)
-			longest_dst_lines = num;
-		if (largest_score < ent_score(sb, e))
-			largest_score = ent_score(sb, e);
-	}
-	sb->ssb->max_orig_digits = lineno_width(longest_src_lines);
-	sb->ssb->max_digits = lineno_width(longest_dst_lines);
-	sb->ssb->max_score_digits = lineno_width(largest_score);
-}
-
-/*
- * For debugging -- origin is refcounted, and this asserts that
- * we do not underflow.
- */
-static void sanity_check_refcnt(struct blame_scoreboard *sb)
-{
-	int baa = 0;
-	struct blame_entry *ent;
-
-	for (ent = sb->ent; ent; ent = ent->next) {
-		/* Nobody should have zero or negative refcnt */
-		if (ent->suspect->refcnt <= 0) {
-			fprintf(stderr, "%s in %s has negative refcnt %d\n",
-				ent->suspect->path,
-				sha1_to_hex(ent->suspect->commit->object.sha1),
-				ent->suspect->refcnt);
-			baa = 1;
-		}
-	}
-	if (baa) {
-		int opt = 0160;
-		find_alignment(sb, &opt);
-		output(sb, opt);
-		die("Baa %d!", baa);
-	}
-}
-
-/*
- * Used for the command line parsing; check if the path exists
- * in the working tree.
- */
-static int has_string_in_work_tree(const char *path)
-{
-	struct stat st;
-	return !lstat(path, &st);
-}
-
-static unsigned parse_score(const char *arg)
-{
-	char *end;
-	unsigned long score = strtoul(arg, &end, 10);
-	if (*end)
-		return 0;
-	return score;
-}
-
-static const char *add_prefix(const char *prefix, const char *path)
-{
-	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
-}
-
-/*
  * Parsing of (comma separated) one item in the -L option
  */
 static const char *parse_loc(const char *spec,
-- 
1.5.4.3
