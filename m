From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Thu,  7 Jul 2011 17:24:17 -0700
Message-ID: <1310084657-16790-3-git-send-email-gitster@pobox.com>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 02:24:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qeyrz-0000Tr-D8
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 02:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab1GHAY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 20:24:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab1GHAYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 20:24:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 689D7658A;
	Thu,  7 Jul 2011 20:24:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=m4Rb
	KYqUzY6SQM+mSFodgQgnCmk=; b=DHAAnduDxg4q4SVQxX7DQDFZm+YBztxNupnH
	uHE1rvjIRGskIYRS9Vub69PR4S4YbGaFk6bEknTIzwAurO4s8Xp5+Iou/ODmA3Vm
	v1JRdYzZ9tZg0RUDfwqA5WRmuGm9gAlBt/o6p2sk70mzXfLtyUe9aKvb8FKPrUvm
	uYjCRJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Ndkq1SrH1KutLcgiqnb2AEi3mtO+EWxMsS9p7vmlJf34cqHlHdxAEUjza1gZEibh
	qCU9xLOdo071x725h2qKLMR4zGyuUt+3dq/Ja9I7EPPvB9Ivv+bISTgNKBw88CSm
	4EVNXWKNGhHG5mAefiAxt1r1Y7vWGrZ647eNpaHq6Fo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 50D586589;
	Thu,  7 Jul 2011 20:24:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F3726588; Thu,  7 Jul 2011
 20:24:22 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.134.gcf13f6
In-Reply-To: <1310084657-16790-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A12F54F2-A8F8-11E0-AD30-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176791>

This optimizes the "recency order" (see pack-heuristics.txt in
Documentation/technical/ directory) used to order objects within a
packfile in three ways:

 - Commits at the tip of tags are written together, in the hope that
   revision traversal done in incremental fetch (which starts by
   putting them in a revision queue marked as UNINTERESTING) will see a
   better locality of these objects;

 - In the original recency order, trees and blobs are intermixed. Write
   trees together before blobs, in the hope that this will improve
   locality when running pathspec-limited revision traversal, i.e.
   "git log paths...";

 - When writing blob objects out, write the whole family of blobs that use
   the same delta base object together, by starting from the root of the
   delta chain, and writing its immediate children in a width-first
   manner, in the hope that this will again improve locality when reading
   blobs that belong to the same path, which are likely to be deltified
   against each other.

I tried various workloads in the Linux kernel repositories (HEAD at
v3.0-rc6-71-g4dd1b49) packed with v1.7.6 and with this patch, counting how
large seeks are needed between adjacent accesses to objects in the pack,
and the result looks promising.  The history has 2072052 objects, weighing
some 490MiB.

 * Simple commit-only log.

   $ git log >/dev/null

   There are 254656 commits in total.

                                  v1.7.6  with patch
   Total number of access :      258,031     258,032
	  0.0% percentile :           12          12
	 10.0% percentile :          259         259
	 20.0% percentile :          294         294
	 30.0% percentile :          326         326
	 40.0% percentile :          363         363
	 50.0% percentile :          415         415
	 60.0% percentile :          513         513
	 70.0% percentile :          857         858
	 80.0% percentile :       10,434      10,441
	 90.0% percentile :       91,985      91,996
	 95.0% percentile :      260,852     260,885
	 99.0% percentile :    1,150,680   1,152,811
	 99.9% percentile :    3,148,435   3,148,435
       Less than 2MiB seek:       99.70%      99.69%

   95% of the pack accesses look at data that is no further than 260kB
   from the previous location we accessed. The patch does not change the
   order of commit objects very much, and the result is very similar.

 * Pathspec-limited log.

   $ git log drivers/net >/dev/null

   The path is touched by 26551 commits and merges (among 254656 total).

                                  v1.7.6  with patch
   Total number of access :      559,511     558,663
	  0.0% percentile :            0           0
	 10.0% percentile :          182         167
	 20.0% percentile :          259         233
	 30.0% percentile :          357         304
	 40.0% percentile :          714         485
	 50.0% percentile :        5,046       3,976
	 60.0% percentile :      688,671     443,578
	 70.0% percentile :  319,574,732 110,370,100
	 80.0% percentile :  361,647,599 123,707,229
	 90.0% percentile :  393,195,669 128,947,636
	 95.0% percentile :  405,496,875 131,609,321
	 99.0% percentile :  412,942,470 133,078,115
	 99.5% percentile :  413,172,266 133,163,349
	 99.9% percentile :  413,354,356 133,240,445
       Less than 2MiB seek:       61.71%      62.87%

   With the current pack heuristics, more than 30% of accesses have to
   seek further than 300MB; the updated pack heuristics ensures that less
   than 0.1% of accesses have to seek further than 135MB. This is largely
   due to the fact that the updated heuristics does not mix blobs and
   trees together.

 * Blame.

   $ git blame drivers/net/ne.c >/dev/null

   The path is touched by 34 commits and merges.

                                  v1.7.6  with patch
   Total number of access :      178,147     178,166
	  0.0% percentile :            0           0
	 10.0% percentile :          142         139
	 20.0% percentile :          222         194
	 30.0% percentile :          373         300
	 40.0% percentile :        1,168         837
	 50.0% percentile :       11,248       7,334
	 60.0% percentile :  305,121,284 106,850,130
	 70.0% percentile :  361,427,854 123,709,715
	 80.0% percentile :  388,127,343 128,171,047
	 90.0% percentile :  399,987,762 130,200,707
	 95.0% percentile :  408,230,673 132,174,308
	 99.0% percentile :  412,947,017 133,181,160
	 99.5% percentile :  413,312,798 133,220,425
	 99.9% percentile :  413,352,366 133,269,051
       Less than 2MiB seek:       56.47%      56.83%

   The result is very similar to the pathspec-limited log above, which
   only looks at the tree objects.

 * Packing recent history.

   $ (git for-each-ref --format='^%(refname)' refs/tags; echo HEAD) |
     git pack-objects --revs --stdout >/dev/null

   This should pack data worth 71 commits.

                                  v1.7.6  with patch
   Total number of access :       11,511      11,514
	  0.0% percentile :            0           0
	 10.0% percentile :           48          47
	 20.0% percentile :          134          98
	 30.0% percentile :          332         178
	 40.0% percentile :        1,386         293
	 50.0% percentile :        8,030         478
	 60.0% percentile :       33,676       1,195
	 70.0% percentile :      147,268      26,216
	 80.0% percentile :    9,178,662     464,598
	 90.0% percentile :   67,922,665     965,782
	 95.0% percentile :   87,773,251   1,226,102
	 99.0% percentile :   98,011,763   1,932,377
	 99.5% percentile :  100,074,427  33,642,128
	 99.9% percentile :  105,336,398 275,772,650
       Less than 2MiB seek:       77.09%      99.04%

    The long-tail part of the result looks worse with the patch, but
    the change helps majority of the access. 99.04% of the accesses
    need less than 2MiB of seeking, compared to 77.09% with the current
    packing heuristics.

 * Index pack.

   $ git index-pack -v .git/objects/pack/pack*.pack

                                  v1.7.6  with patch
   Total number of access :    2,791,228   2,788,802
	  0.0% percentile :            9           9
	 10.0% percentile :          140          89
	 20.0% percentile :          233         167
	 30.0% percentile :          322         235
	 40.0% percentile :          464         310
	 50.0% percentile :          862         423
	 60.0% percentile :        2,566         686
	 70.0% percentile :       25,827       1,498
	 80.0% percentile :    1,317,862       4,971
	 90.0% percentile :   11,926,385     119,398
	 95.0% percentile :   41,304,149     952,519
	 99.0% percentile :  227,613,070   6,709,650
	 99.5% percentile :  321,265,121  11,734,871
	 99.9% percentile :  382,919,785  33,155,191
       Less than 2MiB seek:       81.73%      96.92%

   As the index-pack command already walks objects in the delta chain
   order, writing the blobs out in the delta chain order seems to
   drastically improve the locality of access.

Note that a half-a-gigabyte packfile comfortably fits in the buffer cache,
and you would unlikely to see much performance difference on a modern and
reasonably beefy machine with enough memory and local disks. Benchmarking
with cold cache (or over NFS) would be interesting.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c |  138 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 137 insertions(+), 1 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f402a84..27132bb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -51,6 +51,8 @@ struct object_entry {
 				       * objects against.
 				       */
 	unsigned char no_try_delta;
+	unsigned char tagged; /* near the very tip of refs */
+	unsigned char filled; /* assigned write-order */
 };
 
 /*
@@ -95,6 +97,7 @@ static unsigned long window_memory_limit = 0;
  */
 static int *object_ix;
 static int object_ix_hashsz;
+static struct object_entry *locate_object_entry(const unsigned char *sha1);
 
 /*
  * stats
@@ -199,6 +202,7 @@ static void copy_pack_data(struct sha1file *f,
 	}
 }
 
+/* Return 0 if we will bust the pack-size limit */
 static unsigned long write_object(struct sha1file *f,
 				  struct object_entry *entry,
 				  off_t write_offset)
@@ -433,6 +437,134 @@ static int write_one(struct sha1file *f,
 	return 1;
 }
 
+static int mark_tagged(const char *path, const unsigned char *sha1, int flag,
+		       void *cb_data)
+{
+	unsigned char peeled[20];
+	struct object_entry *entry = locate_object_entry(sha1);
+
+	if (entry)
+		entry->tagged = 1;
+	if (!peel_ref(path, peeled)) {
+		entry = locate_object_entry(peeled);
+		if (entry)
+			entry->tagged = 1;
+	}
+	return 0;
+}
+
+static void add_to_write_order(struct object_entry **wo,
+			       int *endp,
+			       struct object_entry *e)
+{
+	if (e->filled)
+		return;
+	wo[(*endp)++] = e;
+	e->filled = 1;
+}
+
+static void add_descendants_to_write_order(struct object_entry **wo,
+					   int *endp,
+					   struct object_entry *e)
+{
+	struct object_entry *child;
+
+	for (child = e->delta_child; child; child = child->delta_sibling)
+		add_to_write_order(wo, endp, child);
+	for (child = e->delta_child; child; child = child->delta_sibling)
+		add_descendants_to_write_order(wo, endp, child);
+}
+
+static void add_family_to_write_order(struct object_entry **wo,
+				      int *endp,
+				      struct object_entry *e)
+{
+	struct object_entry *root;
+
+	for (root = e; root->delta; root = root->delta)
+		; /* nothing */
+	add_to_write_order(wo, endp, root);
+	add_descendants_to_write_order(wo, endp, root);
+}
+
+static struct object_entry **compute_write_order(void)
+{
+	int i, wo_end;
+
+	struct object_entry **wo = xmalloc(nr_objects * sizeof(*wo));
+
+	for (i = 0; i < nr_objects; i++) {
+		objects[i].tagged = 0;
+		objects[i].filled = 0;
+		objects[i].delta_child = NULL;
+		objects[i].delta_sibling = NULL;
+	}
+
+	/*
+	 * Fully connect delta_child/delta_sibling network.
+	 * Make sure delta_sibling is sorted in the original
+	 * recency order.
+	 */
+	for (i = nr_objects - 1; 0 <= i; i--) {
+		struct object_entry *e = &objects[i];
+		if (!e->delta)
+			continue;
+		/* Mark me as the first child */
+		e->delta_sibling = e->delta->delta_child;
+		e->delta->delta_child = e;
+	}
+
+	/*
+	 * Mark objects that are at the tip of tags.
+	 */
+	for_each_tag_ref(mark_tagged, NULL);
+
+	/*
+	 * Give the commits in the original recency order until
+	 * we see a tagged tip.
+	 */
+	for (i = wo_end = 0; i < nr_objects; i++) {
+		if (objects[i].tagged)
+			break;
+		add_to_write_order(wo, &wo_end, &objects[i]);
+	}
+
+	/*
+	 * Then fill all the tagged tips.
+	 */
+	for (; i < nr_objects; i++) {
+		if (objects[i].tagged)
+			add_to_write_order(wo, &wo_end, &objects[i]);
+	}
+
+	/*
+	 * And then all remaining commits and tags.
+	 */
+	for (i = 0; i < nr_objects; i++) {
+		if (objects[i].type != OBJ_COMMIT &&
+		    objects[i].type != OBJ_TAG)
+			continue;
+		add_to_write_order(wo, &wo_end, &objects[i]);
+	}
+
+	/*
+	 * And then all the trees.
+	 */
+	for (i = 0; i < nr_objects; i++) {
+		if (objects[i].type != OBJ_TREE)
+			continue;
+		add_to_write_order(wo, &wo_end, &objects[i]);
+	}
+
+	/*
+	 * Finally all the rest in really tight order
+	 */
+	for (i = 0; i < nr_objects; i++)
+		add_family_to_write_order(wo, &wo_end, &objects[i]);
+
+	return wo;
+}
+
 static void write_pack_file(void)
 {
 	uint32_t i = 0, j;
@@ -441,10 +573,12 @@ static void write_pack_file(void)
 	struct pack_header hdr;
 	uint32_t nr_remaining = nr_result;
 	time_t last_mtime = 0;
+	struct object_entry **write_order;
 
 	if (progress > pack_to_stdout)
 		progress_state = start_progress("Writing objects", nr_result);
 	written_list = xmalloc(nr_objects * sizeof(*written_list));
+	write_order = compute_write_order();
 
 	do {
 		unsigned char sha1[20];
@@ -468,7 +602,8 @@ static void write_pack_file(void)
 		offset = sizeof(hdr);
 		nr_written = 0;
 		for (; i < nr_objects; i++) {
-			if (!write_one(f, objects + i, &offset))
+			struct object_entry *e = write_order[i];
+			if (!write_one(f, e, &offset))
 				break;
 			display_progress(progress_state, written);
 		}
@@ -545,6 +680,7 @@ static void write_pack_file(void)
 	} while (nr_remaining && i < nr_objects);
 
 	free(written_list);
+	free(write_order);
 	stop_progress(&progress_state);
 	if (written != nr_result)
 		die("wrote %"PRIu32" objects while expecting %"PRIu32,
-- 
1.7.6.134.gcf13f6
