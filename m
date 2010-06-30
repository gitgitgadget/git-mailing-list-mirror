From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 08/13] map/take range to parent
Date: Wed, 30 Jun 2010 23:25:21 +0800
Message-ID: <1277911526-12105-8-git-send-email-struggleyb.nku@gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:30:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzF2-00014K-8I
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103Ab0F3PaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:30:17 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34267 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab0F3PaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:30:16 -0400
Received: by pwj8 with SMTP id 8so320542pwj.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SvZuzzcsfFrGd8/TA4lgcALEFbyx9ZPS1oKKzV3OPmE=;
        b=Ahd2ry457tmLIYmQwbBkFhdzkAr7BJvAIRD3RGW7runyUJwKj/p9aEC/iSrmUpw2Kk
         DHjZrAbec6wYc+qEWJuw1/cY8w7GwsKNwI5AZQOMZnnT2stVeujszVKozvn2+O7cGbPR
         9VB0YaScJkXu0h6AKOiKZwlDS/zTR2A3Dx8Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gG5ItdnaHfjtg5qvT7uZDzFoAwAIMInvTKVKw+9U0z6oc1HXgl6B8OVydKVOj0F7tL
         IdvXadL/As+YcLewi42pCoCm8IaJHz4YB+czY9KItqA6Cw8w0mSj7tTwi/YKBUjFBFQ/
         nMOijF/cL66UCDQ7FwYpmy1R3IaMmKIWQ5sO4=
Received: by 10.115.103.40 with SMTP id f40mr9955447wam.38.1277911814519;
        Wed, 30 Jun 2010 08:30:14 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.29.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:30:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
In-Reply-To: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149971>

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
 revision.h |    5 +-
 2 files changed, 456 insertions(+), 1 deletions(-)

diff --git a/line.c b/line.c
index 904d0c2..734a3cb 100644
--- a/line.c
+++ b/line.c
@@ -493,3 +493,455 @@ void setup_line(struct rev_info *rev, struct diff_line_range *r)
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
+		assert(pair->two->sha1_valid);
+		diff_populate_filespec(pair->two, 0);
+		file_t.ptr = pair->two->data;
+		file_t.size = pair->two->size;
+
+		if (rg->prev)
+			free_filespec(rg->prev);
+		rg->prev = pair->one;
+		rg->prev->count++;
+		if (pair->one->sha1_valid) {
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
+		if (pair->one->sha1_valid) {
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
index 7b01277..32bde08 100644
--- a/revision.h
+++ b/revision.h
@@ -15,7 +15,9 @@
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
 #define RANGE_UPDATE	(1u<<9) /* for line level traverse */
-#define ALL_REV_FLAGS	((1u<<10)-1)
+#define NEED_PRINT	(1u<<10)
+#define EVIL_MERGE	(1u<<11)
+#define ALL_REV_FLAGS	((1u<<12)-1)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
@@ -137,6 +139,7 @@ struct rev_info {
 
 	/* line-level intersting range */
 	struct decoration line_range;
+	struct decoration nontrivial_merge;
 };
 
 #define REV_TREE_SAME		0
-- 
1.7.0.2.273.gc2413.dirty
