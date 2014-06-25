From: Jeff King <peff@peff.net>
Subject: [PATCH 7/8] tag: use commit_contains
Date: Wed, 25 Jun 2014 19:49:21 -0400
Message-ID: <20140625234921.GG23146@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 01:49:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzwwR-0002UD-Hc
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 01:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702AbaFYXtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 19:49:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:51230 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754496AbaFYXtX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 19:49:23 -0400
Received: (qmail 5518 invoked by uid 102); 25 Jun 2014 23:49:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 18:49:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 19:49:21 -0400
Content-Disposition: inline
In-Reply-To: <20140625233429.GA20457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252479>

The newly added commit_contains function should do a better
job than our custom depth-first traversal. It should be the
same speed when going close to the roots, but much faster
when all tags are close to the searched-for commit (this
usually isn't the case, but could be if you limit the tags
with a pattern).

It also cleans up some of the more egregious pitfalls of the
original implementation, including an abuse of the
UNINTERESTING and TMP_MARK flags, an utterly confusing
calling convention (it silently caches the bits between
calls, with no checks that our "with_commit" was the same
for each call), and a failure to clean up after itself
(tainting any further traversals).

Signed-off-by: Jeff King <peff@peff.net>
---
The code to use the new contains function ends up disappointingly longer
than I would have hoped, but it has to massage our string_list of tag
names into a list of commits, and then massage the output back into a
filtered string list. It's not too bad, though. And as I mentioned, I
hope to eventually factor this out to share with for-each-ref and
branch.

 builtin/tag.c | 161 +++++++++++++++++-----------------------------------------
 1 file changed, 48 insertions(+), 113 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 3ef2fab..f17192c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -72,108 +72,6 @@ static const unsigned char *match_points_at(const char *refname,
 	return NULL;
 }
 
-static int in_commit_list(const struct commit_list *want, struct commit *c)
-{
-	for (; want; want = want->next)
-		if (!hashcmp(want->item->object.sha1, c->object.sha1))
-			return 1;
-	return 0;
-}
-
-enum contains_result {
-	CONTAINS_UNKNOWN = -1,
-	CONTAINS_NO = 0,
-	CONTAINS_YES = 1,
-};
-
-/*
- * Test whether the candidate or one of its parents is contained in the list.
- * Do not recurse to find out, though, but return -1 if inconclusive.
- */
-static enum contains_result contains_test(struct commit *candidate,
-			    const struct commit_list *want)
-{
-	/* was it previously marked as containing a want commit? */
-	if (candidate->object.flags & TMP_MARK)
-		return 1;
-	/* or marked as not possibly containing a want commit? */
-	if (candidate->object.flags & UNINTERESTING)
-		return 0;
-	/* or are we it? */
-	if (in_commit_list(want, candidate)) {
-		candidate->object.flags |= TMP_MARK;
-		return 1;
-	}
-
-	if (parse_commit(candidate) < 0)
-		return 0;
-
-	return -1;
-}
-
-/*
- * Mimicking the real stack, this stack lives on the heap, avoiding stack
- * overflows.
- *
- * At each recursion step, the stack items points to the commits whose
- * ancestors are to be inspected.
- */
-struct stack {
-	int nr, alloc;
-	struct stack_entry {
-		struct commit *commit;
-		struct commit_list *parents;
-	} *stack;
-};
-
-static void push_to_stack(struct commit *candidate, struct stack *stack)
-{
-	int index = stack->nr++;
-	ALLOC_GROW(stack->stack, stack->nr, stack->alloc);
-	stack->stack[index].commit = candidate;
-	stack->stack[index].parents = candidate->parents;
-}
-
-static enum contains_result contains(struct commit *candidate,
-		const struct commit_list *want)
-{
-	struct stack stack = { 0, 0, NULL };
-	int result = contains_test(candidate, want);
-
-	if (result != CONTAINS_UNKNOWN)
-		return result;
-
-	push_to_stack(candidate, &stack);
-	while (stack.nr) {
-		struct stack_entry *entry = &stack.stack[stack.nr - 1];
-		struct commit *commit = entry->commit;
-		struct commit_list *parents = entry->parents;
-
-		if (!parents) {
-			commit->object.flags |= UNINTERESTING;
-			stack.nr--;
-		}
-		/*
-		 * If we just popped the stack, parents->item has been marked,
-		 * therefore contains_test will return a meaningful 0 or 1.
-		 */
-		else switch (contains_test(parents->item, want)) {
-		case CONTAINS_YES:
-			commit->object.flags |= TMP_MARK;
-			stack.nr--;
-			break;
-		case CONTAINS_NO:
-			entry->parents = parents->next;
-			break;
-		case CONTAINS_UNKNOWN:
-			push_to_stack(parents->item, &stack);
-			break;
-		}
-	}
-	free(stack.stack);
-	return contains_test(candidate, want);
-}
-
 static void show_tag_lines(const unsigned char *sha1, int lines)
 {
 	int i;
@@ -227,7 +125,7 @@ static void print_tag(const char *refname, const unsigned char *sha1,
 
 static int filter_can_stream(struct tag_filter *filter)
 {
-	return !filter->sort;
+	return !filter->sort && !filter->with_commit;
 }
 
 static int show_reference(const char *refname, const unsigned char *sha1,
@@ -236,16 +134,6 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 	struct tag_filter *filter = cb_data;
 
 	if (match_pattern(filter->patterns, refname)) {
-		if (filter->with_commit) {
-			struct commit *commit;
-
-			commit = lookup_commit_reference_gently(sha1, 1);
-			if (!commit)
-				return 0;
-			if (!contains(commit, filter->with_commit))
-				return 0;
-		}
-
 		if (points_at.nr && !match_points_at(refname, sha1))
 			return 0;
 
@@ -258,6 +146,46 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
+static int util_is_not_null(struct string_list_item *it, int pos, void *data)
+{
+	return !!it->util;
+}
+
+static int matches_contains(struct string_list_item *it, int pos, void *data)
+{
+	unsigned char *contains = data;
+	return contains[pos];
+}
+
+static void limit_by_contains(struct string_list *tags, struct commit_list *with)
+{
+	struct commit_list *tag_commits = NULL, **tail = &tag_commits;
+	unsigned char *result;
+	int i;
+
+	for (i = 0; i < tags->nr; i++) {
+		struct string_list_item *it = &tags->items[i];
+		struct commit *c = lookup_commit_reference_gently(it->util, 1);
+		if (c)
+			tail = commit_list_append(c, tail);
+		else {
+			free(it->util);
+			it->util = NULL;
+		}
+	}
+	filter_string_list(tags, 0, util_is_not_null, NULL);
+
+	if (!tags->nr)
+		return;
+
+	result = xmalloc(tags->nr);
+	commit_contains(with, tag_commits, NULL, result);
+	filter_string_list(tags, 1, matches_contains, result);
+
+	free(result);
+	free_commit_list(tag_commits);
+}
+
 static int sort_by_version(const void *a_, const void *b_)
 {
 	const struct string_list_item *a = a_;
@@ -278,9 +206,16 @@ static int list_tags(const char **patterns, int lines,
 	filter.tags.strdup_strings = 1;
 
 	for_each_tag_ref(show_reference, (void *) &filter);
+	if (with_commit)
+		limit_by_contains(&filter.tags, with_commit);
 	if ((sort & SORT_MASK) == VERCMP_SORT)
 		qsort(filter.tags.items, filter.tags.nr,
 		      sizeof(struct string_list_item), sort_by_version);
+	if (sort) {
+		if ((sort & SORT_MASK) == VERCMP_SORT)
+			qsort(filter.tags.items, filter.tags.nr,
+			      sizeof(struct string_list_item), sort_by_version);
+	}
 	if (!filter_can_stream(&filter)) {
 		int i;
 		if (sort & REVERSE_SORT)
-- 
2.0.0.566.gfe3e6b2
