From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 07/12] map/take range to parent
Date: Sat, 26 Jun 2010 06:27:32 -0700
Message-ID: <1277558857-23103-8-git-send-email-struggleyb.nku@gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 15:28:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVQm-0007r7-Dc
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024Ab0FZN2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 09:28:14 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36015 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992Ab0FZN2L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 09:28:11 -0400
Received: by mail-px0-f174.google.com with SMTP id 8so1126863pxi.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 06:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RPvl+aR8ypYnH8thAqY6cmFgIypgCLTunOOCMcSA78w=;
        b=S69EomIFFUOYYnvbB6IAqFBKIHJmcCZsd+yVzIYFBCNYnc5uFTxYRlP+FCU21BqJhN
         uTcj9T2PHIXBYbnK4XWfUCATAwO2dDpiPGUsHHy6hRTDYaj5KkuKREZQxB3QZjqeRLK1
         ekEP0f8YOwpCJrAs7WDGjdjXAPxF0aePx0hgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vWSoEYXEViZw4g9VT64YgXk78Kn9a+KKY6La0omzy5BwxxdJ82Gh0G6FuS3jw82+tb
         Lw76UbbhkfgQ136nEoQJ7DaqJc27WypR6Cp/aUQ+XQxeoZiGz2b3FloNNaK55GDMCPgG
         iuABvlqUqEPkJR9wPhV/LCTxFzbc4wchZvcug=
Received: by 10.142.73.1 with SMTP id v1mr459530wfa.300.1277558891005;
        Sat, 26 Jun 2010 06:28:11 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id b23sm1553667wfj.0.2010.06.26.06.28.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 06:28:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.577.g36cf0.dirty
In-Reply-To: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149749>

The interesting line range will be passed to all of its parents.
For non-merge commit, we just map_range the ranges. Generally, the
algorithm do:

1. Run a diffcore_std to find out the pairs;
2. Run a xdi_diff_hunks on each interesting file pair;
3. The map_range_cb callback will be invoked for each diff hunk,
   and in the function map_lines we will calculate the pre-image
   range from the post-image range.

For merge commit, another take_range pass will be done except the
above normal map_range work. It is used to subtract each same
part lines of the current range out. After this pass, if there is
any line range left, this means the merge must be a non-trivial
merge. This is how the non-trivial merge detect work.

The algorithm that map lines from post-image to pre-image is in
the function map_lines. Generally, we use simple line number
calculation method to do the map.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c     |  452 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.h |    3 +
 2 files changed, 455 insertions(+), 0 deletions(-)

diff --git a/line.c b/line.c
index f765a03..322fd8a 100644
--- a/line.c
+++ b/line.c
@@ -486,3 +486,455 @@ void setup_line(struct rev_info *rev, struct diff_line_range *r)
 	diff_tree_release_paths(opt);
 }
 
+struct take_range_cb_data {
+	struct diff_line_range *interesting;
+	struct diff_line_range *range;
+	long plno, tlno;
+	int diff;
+};
+
+#define SCALE_FACTOR 4
+void map_lines(long p_start, long p_end, long t_start, long t_end,
+		long start, long end, long *o_start, long *o_end)
+{
+	/*
+	 * xdiff always assign 'same' with the last line number of two
+	 * same ranges. When some lines are added from scratch,
+	 * p_start = same + 1;
+	 * p_end = same;
+	 * so, we can understand the following condition.
+	 */
+	if (p_start > p_end) {
+		*o_start = *o_end = 0;
+		return;
+	}
+	/* A deletion */
+	if (t_start > t_end) {
+		*o_start = p_start;
+		*o_end = p_end;
+		return;
+	}
+
+	if (start == t_start && end == t_end) {
+		*o_start = p_start;
+		*o_end = p_end;
+		return;
+	}
+
+	/*
+	 * A new strategy for lines mapping:
+	 *
+	 * When the pre-image is no more than 1/4 of the post-image, it
+	 * take no sense to say what the real pre-image is, wan can just
+	 * treat all the post-image lines as added from scratch.
+	 */
+	if (SCALE_FACTOR * (p_end - p_start + 1) < (t_end - t_start + 1)) {
+		*o_start = *o_end = 0;
+		return;
+	}
+
+	*o_start = p_start + start - t_start;
+	*o_end = p_end - (t_end - end);
+
+	if (*o_start > *o_end) {
+		int temp = *o_start;
+		*o_start = *o_end;
+		*o_end = temp;
+	}
+
+	if (*o_start < p_start)
+		*o_start = p_start;
+	if (*o_end > p_end)
+		*o_end = p_end;
+}
+
+static void map_range(struct take_range_cb_data *data, int same,
+		long p_start, long p_end, long t_start, long t_end)
+{
+	struct range *ranges = data->interesting->ranges;
+	long takens, takene, start, end;
+	int i = 0, out = 0, added = 0;
+	long op_start = p_start, op_end = p_end, ot_start = t_start, ot_end = t_end;
+
+	for (; i < data->interesting->nr; i++) {
+		added = 0;
+		if (t_start > ranges[i].end)
+			continue;
+		if (t_end < ranges[i].start)
+			break;
+
+		if (t_start > ranges[i].start) {
+			start = t_start;
+			takens = p_start;
+			if (t_end >= ranges[i].end) {
+				end = ranges[i].end;
+				takene = p_start + end - t_start;
+			} else {
+				end = t_end;
+				takene = p_end;
+				out = 1;
+			}
+		} else {
+			start = ranges[i].start;
+			takens = p_start + start - t_start;
+			if (t_end >= ranges[i].end) {
+				end = ranges[i].end;
+				takene = p_start + end - t_start;
+			} else {
+				end = t_end;
+				takene = p_end;
+				out = 1;
+			}
+		}
+
+		if (!same) {
+			struct print_pair *pair = &ranges[i].pair;
+			PRINT_PAIR_GROW(pair);
+			struct print_range *rr = pair->ranges + pair->nr - 1;
+			PRINT_RANGE_INIT(rr);
+			rr->start = start;
+			rr->end = end;
+			map_lines(op_start, op_end, ot_start, ot_end, start, end,
+					&takens, &takene);
+			if (takens == 0 && takene == 0) {
+				added = 1;
+				rr->line_added = 1;
+			}
+			rr->pstart = takens;
+			rr->pend = takene;
+			data->diff = 1;
+			data->interesting->diff = 1;
+			ranges[i].diff = 1;
+		}
+		if (added) {
+			/* Code movement/copy detect here */
+		} else {
+			struct range *added_range = diff_line_range_insert(data->range,
+					NULL, takens, takene);
+			assert(added_range);
+			ranges[i].pstart = added_range->start;
+			ranges[i].pend = added_range->end;
+		}
+
+		t_start = end + 1;
+		p_start = takene + 1;
+
+		if (out)
+			break;
+	}
+}
+
+static void take_range(struct take_range_cb_data *data,
+		long p_start, long p_end, long t_start, long t_end)
+{
+	struct range *ranges = data->interesting->ranges;
+	long takens, takene, start, end;
+	int i = 0, out = 0, added = 0;
+
+	for (; i < data->interesting->nr; i++) {
+		added = 0;
+		if (t_start > ranges[i].end)
+			continue;
+		if (t_end < ranges[i].start)
+			break;
+
+		if (t_start > ranges[i].start) {
+			long tmp = ranges[i].end;
+			ranges[i].end = t_start - 1;
+			start = t_start;
+			takens = p_start;
+			if (t_end >= tmp) {
+				end = tmp;
+				takene = p_start + end - t_start;
+				p_start = takene + 1;
+				t_start = end + 1;
+			} else {
+				end = t_end;
+				takene = p_end;
+				diff_line_range_insert(data->interesting, NULL,
+					t_end + 1, tmp);
+				out = 1;
+			}
+		} else {
+			start = ranges[i].start;
+			takens = p_start + start - t_start;
+			if (t_end >= ranges[i].end) {
+				int num = data->interesting->nr - 1;
+				end = ranges[i].end;
+				takene = p_start + end - t_start;
+				t_start = end + 1;
+				p_start = takene + 1;
+				memmove(ranges + i, ranges + i + 1, (num - i) * sizeof(*ranges));
+				data->interesting->nr = num;
+				i--;
+			} else {
+				end = t_end;
+				takene = p_end;
+				ranges[i].start = t_end + 1;
+				out = 1;
+			}
+		}
+
+		diff_line_range_insert(data->range, NULL, takens, takene);
+
+		if (out)
+			break;
+	}
+}
+
+static void take_range_cb(void *data, long same, long p_next, long t_next)
+{
+	struct take_range_cb_data *d = data;
+	long p_start = d->plno + 1, t_start = d->tlno + 1;
+	long p_end = p_start + same - t_start, t_end = same;
+
+	/* If one file is added from scratch, this may confuse take_range */
+	if (t_end >= t_start)
+		take_range(d, p_start, p_end, t_start, t_end);
+	d->plno = p_next;
+	d->tlno = t_next;
+}
+
+static void map_range_cb(void *data, long same, long p_next, long t_next)
+{
+	struct take_range_cb_data *d = data;
+
+	long p_start = d->plno + 1;
+	long t_start = d->tlno + 1;
+	long p_end = same - t_start + p_start;
+	long t_end = same;
+
+	/* Firstly, take the unchanged lines from child */
+	if (t_end >= t_start)
+		map_range(d, 1, p_start, p_end, t_start, t_end);
+
+	/* find out which lines to print */
+	t_start = same + 1;
+	p_start = d->plno + t_start - d->tlno;
+	map_range(d, 0, p_start, p_next, t_start, t_next);
+
+	d->plno = p_next;
+	d->tlno = t_next;
+}
+
+static void assign_range_to_parent(struct rev_info *rev, struct commit *c,
+		struct commit *p, struct diff_line_range *r,
+		struct diff_options *opt, int map)
+{
+	struct diff_line_range *rr = xmalloc(sizeof(*rr));
+	struct diff_line_range *cr = rr, *prev_r = rr;
+	struct tree_desc desc1, desc2;
+	void *tree1 = NULL, *tree2 = NULL;
+	unsigned long size1, size2;
+	struct diff_queue_struct *queue;
+	struct take_range_cb_data cb = {NULL, cr, 0, 0};
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	int i, diff = 0;
+	xdiff_emit_hunk_consume_fn fn = map ? map_range_cb : take_range_cb;
+
+	DIFF_LINE_RANGE_INIT(cr);
+	memset(&xpp, 0, sizeof(xpp));
+	memset(&xecfg, 0, sizeof(xecfg));
+	xpp.flags = XDF_NEED_MINIMAL;
+	xecfg.ctxlen = xecfg.interhunkctxlen = 0;
+
+	/*
+	 * Compose up two trees, for root commit, we make up a empty tree.
+	 */
+	assert(c);
+	tree2 = read_object_with_reference(c->tree->object.sha1, "tree", &size2, NULL);
+	if (tree2 == NULL)
+		die("Unable to read tree (%s)", sha1_to_hex(c->tree->object.sha1));
+	init_tree_desc(&desc2, tree2, size2);
+	if (p) {
+		tree1 = read_object_with_reference(p->tree->object.sha1, "tree", &size1, NULL);
+		if (tree1 == NULL)
+			die("Unable to read tree (%s)", sha1_to_hex(p->tree->object.sha1));
+		init_tree_desc(&desc1, tree1, size1);
+	} else {
+		init_tree_desc(&desc1, "", 0);
+	}
+
+	DIFF_QUEUE_CLEAR(&diff_queued_diff);
+	diff_tree(&desc1, &desc2, "", opt);
+	diffcore_std(opt);
+
+	queue = &diff_queued_diff;
+	for (i = 0; i < queue->nr; i++) {
+		struct diff_filepair *pair = queue->queue[i];
+		struct diff_line_range *rg = r;
+		mmfile_t file_p, file_t;
+		while (rg) {
+			assert(rg->spec->path && pair->two->path);
+			if (!strcmp(rg->spec->path, pair->two->path))
+				break;
+			rg = rg->next;
+		}
+
+		if (rg == NULL)
+			continue;
+		rg->touch = 1;
+		if (rg->nr == 0)
+			continue;
+
+		rg->status = pair->status;
+		assert(FILESPEC_VALID(pair->two));
+		diff_populate_filespec(pair->two, 0);
+		file_t.ptr = pair->two->data;
+		file_t.size = pair->two->size;
+
+		if (rg->prev)
+			free_filespec(rg->prev);
+		rg->prev = pair->one;
+		rg->prev->count++;
+		if (FILESPEC_VALID(pair->one)) {
+			diff_populate_filespec(pair->one, 0);
+			file_p.ptr = pair->one->data;
+			file_p.size = pair->one->size;
+		} else {
+			file_p.ptr = "";
+			file_p.size = 0;
+		}
+
+		if (cr->nr != 0) {
+			struct diff_line_range *tmp = xmalloc(sizeof(*tmp));
+			cr->next = tmp;
+			prev_r = cr;
+			cr = tmp;
+		} else if (cr->spec)
+			DIFF_LINE_RANGE_CLEAR(cr);
+
+		DIFF_LINE_RANGE_INIT(cr);
+		if (FILESPEC_VALID(pair->one)) {
+			cr->spec = pair->one;
+			cr->spec->count++;
+		}
+
+		cb.interesting = rg;
+		cb.range = cr;
+		cb.diff = 0;
+		cb.plno = cb.tlno = 0;
+		xdi_diff_hunks(&file_p, &file_t, fn, &cb, &xpp, &xecfg);
+		if (cb.diff)
+			diff = 1;
+		/*
+		 * The remain part is the same part.
+		 * Instead of calculating the true line number of the two files,
+		 * use the biggest integer.
+		 */
+		if (map)
+			map_range(&cb, 1, cb.plno + 1, 0x7FFFFFFF, cb.tlno + 1, 0x7FFFFFFF);
+		else
+			take_range(&cb, cb.plno + 1, 0x7FFFFFFF, cb.tlno + 1, 0x7FFFFFFF);
+	}
+	opt->output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_flush(opt);
+
+	/* Collect the untouch ranges, this comes from the files not changed
+	 * between two commit.
+	 */
+	struct diff_line_range *rg = r;
+	while (rg) {
+		/* clear the touch one to make it usable in next round */
+		if (rg->touch) {
+			rg->touch = 0;
+		} else {
+			struct diff_line_range *untouch = diff_line_range_clone(rg);
+			if (prev_r == rr && rr->nr == 0) {
+				rr = prev_r = untouch;
+			} else {
+				prev_r->next = untouch;
+				prev_r = untouch;
+			}
+		}
+		rg = rg->next;
+	}
+
+	if (cr->nr == 0) {
+		DIFF_LINE_RANGE_CLEAR(cr);
+		free(cr);
+		if (prev_r == cr) {
+			rr = NULL;
+		} else {
+			prev_r->next = NULL;
+		}
+	}
+
+	if (rr) {
+		assert(p);
+		add_line_range(rev, p, rr);
+	}
+
+	/* and the ranges of current commit c is updated */
+	c->object.flags &= ~RANGE_UPDATE;
+	if (diff)
+		c->object.flags |= NEED_PRINT;
+
+	if (tree1)
+		free(tree1);
+	if (tree2)
+		free(tree2);
+}
+
+static void diff_update_parent_range(struct rev_info *rev, struct commit *commit)
+{
+	struct diff_line_range *r = lookup_line_range(rev, commit);
+	struct commit_list *parents = commit->parents;
+	struct commit *c = NULL;
+	if (parents) {
+		assert(parents->next == NULL);
+		c = parents->item;
+	}
+
+	assign_range_to_parent(rev, commit, c, r, &rev->diffopt, 1);
+}
+
+static void assign_parents_range(struct rev_info *rev, struct commit *commit)
+{
+	struct commit_list *parents = commit->parents;
+	struct diff_line_range *r = lookup_line_range(rev, commit);
+	struct diff_line_range *copy = NULL, *range = NULL;
+	int nontrivial = 0;
+
+	/*
+	 * If we are in linear history, update range and flush the patch if
+	 * necessary
+	 */
+	if (parents == NULL || parents->next == NULL) {
+		return diff_update_parent_range(rev, commit);
+	}
+
+	/*
+	 * Loop on the parents and assign the ranges to different
+	 * parents, if there is any range left, this commit must
+	 * be an evil merge.
+	 */
+	copy = diff_line_range_clone_deeply(r);
+	parents = commit->parents;
+	while (parents) {
+		struct commit *p = parents->item;
+		assign_range_to_parent(rev, commit, p, r, &rev->diffopt, 1);
+		assign_range_to_parent(rev, commit, p, copy, &rev->diffopt, 0);
+		parents = parents->next;
+	}
+
+	/*
+	 * yes, this must be an evil merge.
+	 */
+	range = copy;
+	while (range) {
+		if (range->nr) {
+			commit->object.flags |= NEED_PRINT | EVIL_MERGE;
+			nontrivial = 1;
+		}
+		range = range->next;
+	}
+
+	if (nontrivial) {
+		add_decoration(&rev->nontrivial_merge, &commit->object, copy);
+	} else {
+		cleanup(copy);
+	}
+}
+
diff --git a/revision.h b/revision.h
index 26c2ff5..2bc3750 100644
--- a/revision.h
+++ b/revision.h
@@ -15,6 +15,8 @@
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
 #define RANGE_UPDATE	(1u<<9) /* for line level traverse */
+#define NEED_PRINT	(1u<<10)
+#define EVIL_MERGE	(1u<<11)
 #define ALL_REV_FLAGS	((1u<<9)-1)
 
 #define DECORATE_SHORT_REFS	1
@@ -137,6 +139,7 @@ struct rev_info {
 
 	/* line-level intersting range */
 	struct decoration line_range;
+	struct decoration nontrivial_merge;
 };
 
 #define REV_TREE_SAME		0
-- 
1.7.1.577.g36cf0.dirty
