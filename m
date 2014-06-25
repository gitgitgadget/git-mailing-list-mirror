From: Jeff King <peff@peff.net>
Subject: [PATCH 6/8] commit: provide a fast multi-tip contains function
Date: Wed, 25 Jun 2014 19:47:30 -0400
Message-ID: <20140625234730.GF23146@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 01:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzwud-0000wv-V0
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 01:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbaFYXrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 19:47:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:51228 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753302AbaFYXrb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 19:47:31 -0400
Received: (qmail 5421 invoked by uid 102); 25 Jun 2014 23:47:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 18:47:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 19:47:30 -0400
Content-Disposition: inline
In-Reply-To: <20140625233429.GA20457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252478>

When commands like "git branch --contains" want to know
which branches contain a particular commit, they run a
series of merge-base calculations, one per branch. This can
be very slow if you have a large number of branches.

We made "tag --contains" faster in ffc4b80 (tag: speed up
--contains calculation, 2011-06-11) by switching to a
different algorithm that caches intermediate "contains"
information from each tag we check. The downside of the new
algorithm is that it moves depth-first through the graph. So
it tends to go all the way to the roots, even if the
contained commit is near the top of history. That works OK
for tags, because repositories tend to have tags near the
roots anyway (e.g., a v0.1 or similar). The number of
commits we look at increased a little bit, but since we
avoid traversing over the same parts of history repeatedly,
it was a huge net win.

For "branch --contains", it is less clear that this is a
win. Most branches stay up to date, so we can bound a search
for a recent commit when we hit the merge base between the
commit and the branches.

The ideal would be to use the merge-base-style breadth-first
traversal, but to perform a single traversal for all tips.
The problem is that we need one bit of storage per tip in
each commit, and "struct commit" has only a fixed number of
bits. We can solve that by using a process similar to
paint_down_to_common, but instead of storing PARENT1 and
PARENT2 flags, using a commit slab to store one bit per tip.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the interesting commit, and I'd really love some eyes on the
logic. It's basically paint_down_to_common but with the PARENT1 and
PARENT2 flags replaced with larger bitfields.

I haven't quite convinced myself that the stale logic in the middle is
right. The origin paint_down function checks "PARENT1 | PARENT2" to see
if we found a merge base (even though PARENT2 may represent many tips).
Here I check whether we have _any_ "left" parent flag and _any_ "right"
parent flag. I'm not sure if I actually need to be finding the merge
base of _all_ of the commits. I don't think so, and I can't find a case
where this doesn't work, but perhaps I am not being imaginative enough.

 commit.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.h |  17 +++++++++++
 2 files changed, 119 insertions(+)

diff --git a/commit.c b/commit.c
index 445b679..66e0def 100644
--- a/commit.c
+++ b/commit.c
@@ -11,6 +11,7 @@
 #include "commit-slab.h"
 #include "prio-queue.h"
 #include "sha1-lookup.h"
+#include "bitset.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1040,6 +1041,107 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	return result;
 }
 
+define_commit_slab(bit_slab, unsigned char);
+
+static int init_contains_bits(const struct commit_list *commits,
+			      struct bit_slab *bits,
+			      struct prio_queue *queue)
+{
+	int i, nr = commit_list_count(commits);
+
+	init_bit_slab_with_stride(bits, bitset_sizeof(nr));
+	for (i = 0; i < nr; i++, commits = commits->next) {
+		struct commit *c = commits->item;
+
+		prio_queue_put(queue, c);
+		bitset_set(bit_slab_at(bits, c), i);
+	}
+
+	return nr;
+}
+
+static int queue_has_nonstale_bits(struct prio_queue *queue, struct bit_slab *stale)
+{
+	int i;
+	for (i = 0; i < queue->nr; i++) {
+		struct commit *commit = queue->array[i];
+		if (!*bit_slab_at(stale, commit))
+			return 1;
+	}
+	return 0;
+}
+
+static void fill_contains_result(unsigned char *result, int nr,
+				 struct bit_slab *bits,
+				 const struct commit_list *other_side)
+{
+	const struct commit_list *c;
+
+	memset(result, 0, nr);
+	for (c = other_side; c; c = c->next) {
+		unsigned char *c_bits = bit_slab_at(bits, c->item);
+		int i;
+
+		for (i = 0; i < nr; i++)
+			result[i] |= bitset_get(c_bits, i);
+	}
+}
+
+void commit_contains(const struct commit_list *left,
+		     const struct commit_list *right,
+		     unsigned char *left_contains,
+		     unsigned char *right_contains)
+{
+	struct prio_queue queue = { compare_commits_by_commit_date };
+	struct bit_slab left_bits, right_bits, stale_bits;
+	int left_nr, right_nr;
+
+	left_nr = init_contains_bits(left, &left_bits, &queue);
+	right_nr = init_contains_bits(right, &right_bits, &queue);
+	init_bit_slab(&stale_bits);
+
+	while (queue_has_nonstale_bits(&queue, &stale_bits)) {
+		struct commit *commit = prio_queue_get(&queue);
+		struct commit_list *parents;
+		unsigned char *c_left, *c_right, *c_stale;
+
+		c_left = bit_slab_at(&left_bits, commit);
+		c_right = bit_slab_at(&right_bits, commit);
+		c_stale = bit_slab_at(&stale_bits, commit);
+
+		if (!bitset_empty(c_left, left_nr) &&
+		    !bitset_empty(c_right, right_nr))
+			*c_stale = 1;
+
+		for (parents = commit->parents; parents; parents = parents->next) {
+			struct commit *p = parents->item;
+			unsigned char *p_left = bit_slab_at(&left_bits, p),
+				      *p_right = bit_slab_at(&right_bits, p);
+
+			if (bitset_equal(c_left, p_left, left_nr) &&
+			    bitset_equal(c_right, p_right, right_nr))
+				continue;
+			if (parse_commit(p))
+				die("unable to parse commit");
+			bitset_or(p_left, c_left, left_nr);
+			bitset_or(p_right, c_right, right_nr);
+			*bit_slab_at(&stale_bits, p) |= *c_stale;
+			prio_queue_put(&queue, p);
+		}
+	}
+
+	if (left_contains)
+		fill_contains_result(left_contains, left_nr, &left_bits, right);
+	if (right_contains)
+		fill_contains_result(right_contains, right_nr, &right_bits, left);
+
+	clear_prio_queue(&queue);
+	clear_bit_slab(&left_bits);
+	clear_bit_slab(&right_bits);
+	clear_bit_slab(&stale_bits);
+}
+
+
 static const char gpg_sig_header[] = "gpgsig";
 static const int gpg_sig_header_len = sizeof(gpg_sig_header) - 1;
 
diff --git a/commit.h b/commit.h
index a9f177b..d3a142a 100644
--- a/commit.h
+++ b/commit.h
@@ -307,4 +307,21 @@ int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 LAST_ARG_MUST_BE_NULL
 extern int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
 
+/*
+ * Calculate which commits in left contain commits in right, and vice versa.
+ *
+ * The left_contains result, if non-NULL, must point to an array of unsigned
+ * char with as many elements as there are items in the "left" commit_list.
+ * When the function completes, the nth char in left_contains will be non-zero
+ * iff the nth commit in the "left" list contains at least one commit from the
+ * "right" list.
+ *
+ * The right_contains result works in the same way, but with left and right
+ * swapped.
+ */
+void commit_contains(const struct commit_list *left,
+		     const struct commit_list *right,
+		     unsigned char *left_contains,
+		     unsigned char *right_contains);
+
 #endif /* COMMIT_H */
-- 
2.0.0.566.gfe3e6b2
