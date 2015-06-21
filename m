From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 10/19] ref-filter: implement '--contains' option
Date: Mon, 22 Jun 2015 02:18:24 +0530
Message-ID: <1434919705-4884-10-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 22:49:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6mBG-0005l0-Sc
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbbFUUt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:49:27 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32819 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853AbbFUUtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:49:25 -0400
Received: by padev16 with SMTP id ev16so119974111pad.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qr/g7svruGEc5vc252pEXVSjW8KhXUlgg/pd48/dpt8=;
        b=zdzmdyeFNe4hLlOD0CqfXzi9IPeZPovAqYkG+ITv6h+tZzT4qbyFSqV7QVOFnFgAwG
         9QRtA7a/MHVHstqaqgegAXxrbLP4BZ9r9uShThD4b/N/oo3IL6Gl8k7nUxHqVxPYvEk8
         X4GcDukBDQPwJdF38LlkJChZXSBN3hbl9M6ZEbezPt7oKu8BO2jZAEC2dSNlnaLYeauq
         4zHFTSnMIS/w6/M6XHnIK30/KR8fYJBg3on9E8bRiZ+wbxT7sayecjyjLD8LEX+nHsk9
         HWknT+XWQHx94VB/2RRs0oF72qDpXMP1HqSgfy4nhAm8TA4Wbl/vd+VnAvFFFiksbbqK
         XbWA==
X-Received: by 10.68.180.67 with SMTP id dm3mr15762312pbc.167.1434919765256;
        Sun, 21 Jun 2015 13:49:25 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm17519488pda.54.2015.06.21.13.49.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jun 2015 13:49:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272296>

'tag -l' and 'branch -l' have two different ways of finding
out if a certain ref contains a commit. Implement both these
methods in ref-filter and give the caller of ref-filter API
the option to pick which implementation to be used.

'branch -l' uses 'is_descendant_of()' from commit.c which is
left as the default implementation to be used.

'tag -l' uses a more specific algorithm since ffc4b80. This
implementation is used whenever the 'with_commit_tag_algo' bit
is set in 'struct ref_filter'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 ref-filter.h |   3 ++
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index d62fa63..06f598b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -818,6 +818,114 @@ static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom
 	*v = &ref->value[atom];
 }
 
+enum contains_result {
+	CONTAINS_UNKNOWN = -1,
+	CONTAINS_NO = 0,
+	CONTAINS_YES = 1
+};
+
+/*
+ * Mimicking the real stack, this stack lives on the heap, avoiding stack
+ * overflows.
+ *
+ * At each recursion step, the stack items points to the commits whose
+ * ancestors are to be inspected.
+ */
+struct contains_stack {
+	int nr, alloc;
+	struct contains_stack_entry {
+		struct commit *commit;
+		struct commit_list *parents;
+	} *contains_stack;
+};
+
+static int in_commit_list(const struct commit_list *want, struct commit *c)
+{
+	for (; want; want = want->next)
+		if (!hashcmp(want->item->object.sha1, c->object.sha1))
+			return 1;
+	return 0;
+}
+
+/*
+ * Test whether the candidate or one of its parents is contained in the list.
+ * Do not recurse to find out, though, but return -1 if inconclusive.
+ */
+static enum contains_result contains_test(struct commit *candidate,
+			    const struct commit_list *want)
+{
+	/* was it previously marked as containing a want commit? */
+	if (candidate->object.flags & TMP_MARK)
+		return 1;
+	/* or marked as not possibly containing a want commit? */
+	if (candidate->object.flags & UNINTERESTING)
+		return 0;
+	/* or are we it? */
+	if (in_commit_list(want, candidate)) {
+		candidate->object.flags |= TMP_MARK;
+		return 1;
+	}
+
+	if (parse_commit(candidate) < 0)
+		return 0;
+
+	return -1;
+}
+
+static void push_to_contains_stack(struct commit *candidate, struct contains_stack *contains_stack)
+{
+	ALLOC_GROW(contains_stack->contains_stack, contains_stack->nr + 1, contains_stack->alloc);
+	contains_stack->contains_stack[contains_stack->nr].commit = candidate;
+	contains_stack->contains_stack[contains_stack->nr++].parents = candidate->parents;
+}
+
+static enum contains_result contains_tag_algo(struct commit *candidate,
+		const struct commit_list *want)
+{
+	struct contains_stack contains_stack = { 0, 0, NULL };
+	int result = contains_test(candidate, want);
+
+	if (result != CONTAINS_UNKNOWN)
+		return result;
+
+	push_to_contains_stack(candidate, &contains_stack);
+	while (contains_stack.nr) {
+		struct contains_stack_entry *entry = &contains_stack.contains_stack[contains_stack.nr - 1];
+		struct commit *commit = entry->commit;
+		struct commit_list *parents = entry->parents;
+
+		if (!parents) {
+			commit->object.flags |= UNINTERESTING;
+			contains_stack.nr--;
+		}
+		/*
+		 * If we just popped the stack, parents->item has been marked,
+		 * therefore contains_test will return a meaningful 0 or 1.
+		 */
+		else switch (contains_test(parents->item, want)) {
+		case CONTAINS_YES:
+			commit->object.flags |= TMP_MARK;
+			contains_stack.nr--;
+			break;
+		case CONTAINS_NO:
+			entry->parents = parents->next;
+			break;
+		case CONTAINS_UNKNOWN:
+			push_to_contains_stack(parents->item, &contains_stack);
+			break;
+		}
+	}
+	free(contains_stack.contains_stack);
+	return contains_test(candidate, want);
+}
+
+static int commit_contains(struct ref_filter *filter, struct commit *commit)
+{
+	if (filter->with_commit_tag_algo)
+		return contains_tag_algo(commit, filter->with_commit);
+	return is_descendant_of(commit, filter->with_commit);
+}
+
 /*
  * Return 1 if the refname matches one of the patterns, otherwise 0.
  * A pattern can be path prefix (e.g. a refname "refs/heads/master"
@@ -908,10 +1016,14 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * obtain the commit using the 'oid' available and discard all
 	 * non-commits early. The actual filtering is done later.
 	 */
-	if (filter->merge_commit) {
+	if (filter->merge_commit || filter->with_commit) {
 		commit = lookup_commit_reference_gently(oid->hash, 1);
 		if (!commit)
 			return 0;
+		/* We perform the filtering for the '--contains' option */
+		if (filter->with_commit &&
+		    !commit_contains(filter, commit))
+			return 0;
 	}
 
 	/*
diff --git a/ref-filter.h b/ref-filter.h
index 7241a1d..3c59431 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -44,6 +44,7 @@ struct ref_array {
 struct ref_filter {
 	const char **name_patterns;
 	struct sha1_array points_at;
+	struct commit_list *with_commit;
 
 	enum {
 		REF_FILTER_MERGED_NONE = 0,
@@ -51,6 +52,8 @@ struct ref_filter {
 		REF_FILTER_MERGED_OMIT
 	} merge;
 	struct commit *merge_commit;
+
+	unsigned int with_commit_tag_algo: 1;
 };
 
 struct ref_filter_cbdata {
-- 
2.4.3.439.gfea0c2a.dirty
