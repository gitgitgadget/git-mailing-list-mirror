From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 8/9] ref-filter: add '--contains' option
Date: Sun,  7 Jun 2015 01:34:11 +0530
Message-ID: <1433621052-5588-8-git-send-email-karthik.188@gmail.com>
References: <5573520A.90603@gmail.com>
 <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 22:04:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1KKn-0002fF-Qi
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 22:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbbFFUEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 16:04:44 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36750 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbbFFUEk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 16:04:40 -0400
Received: by pdjm12 with SMTP id m12so74010235pdj.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gJFx0+ypR4dZpfRjN644K9QWmCvLJ0szf6IWd5DRguI=;
        b=h47zF0XFV0IIQZuP7/G45vAKOnKQRRnMPyHOZhx4poy2R/1LvHdH1bez0uQ/OXlCrn
         7NItumla7t7aUJLTpf9u1r3PoafX/VdbxQluj5NJSGBNde6UVadcrdd7Kx9pLstTHedz
         KuNt/BgYTnefqZsela9wCZ64HTGbykFEctAp2EfAe6NFB20ebfQuU0IXiC9HOE2zzl9O
         5GYh9Kbortooj1gvgurt0z1vzrXWvDxFb2C4BSTNTUG0vkjDS2v+Wb+xHcQg1EAGkxWV
         ZOsJmMyG8qQwSGq6ObQw+GKiq8qIBsNV++pRp8xyElJT+dUFs8WqxqB+aoiE0Fmgy5Pk
         kNAA==
X-Received: by 10.68.209.130 with SMTP id mm2mr16290003pbc.88.1433621078745;
        Sat, 06 Jun 2015 13:04:38 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id q5sm10333703pde.56.2015.06.06.13.04.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 13:04:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270946>

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
 ref-filter.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 ref-filter.h |   3 ++
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 2be9df2..6c5f5c2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -818,6 +818,113 @@ static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom
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
+struct stack {
+	int nr, alloc;
+	struct stack_entry {
+		struct commit *commit;
+		struct commit_list *parents;
+	} *stack;
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
+static void push_to_stack(struct commit *candidate, struct stack *stack)
+{
+	ALLOC_GROW(stack->stack, stack->nr + 1, stack->alloc);
+	stack->stack[stack->nr].commit = candidate;
+	stack->stack[stack->nr++].parents = candidate->parents;
+}
+
+static enum contains_result contains_tag_algo(struct commit *candidate,
+		const struct commit_list *want)
+{
+	struct stack stack = { 0, 0, NULL };
+	int result = contains_test(candidate, want);
+
+	if (result != CONTAINS_UNKNOWN)
+		return result;
+
+	push_to_stack(candidate, &stack);
+	while (stack.nr) {
+		struct stack_entry *entry = &stack.stack[stack.nr - 1];
+		struct commit *commit = entry->commit;
+		struct commit_list *parents = entry->parents;
+
+		if (!parents) {
+			commit->object.flags |= UNINTERESTING;
+			stack.nr--;
+		}
+		/*
+		 * If we just popped the stack, parents->item has been marked,
+		 * therefore contains_test will return a meaningful 0 or 1.
+		 */
+		else switch (contains_test(parents->item, want)) {
+		case CONTAINS_YES:
+			commit->object.flags |= TMP_MARK;
+			stack.nr--;
+			break;
+		case CONTAINS_NO:
+			entry->parents = parents->next;
+			break;
+		case CONTAINS_UNKNOWN:
+			push_to_stack(parents->item, &stack);
+			break;
+		}
+	}
+	free(stack.stack);
+	return contains_test(candidate, want);
+}
+
+static int commit_contains(struct ref_filter *filter, struct commit *commit)
+{
+	if (filter->with_commit_tag_algo)
+		return contains_tag_algo(commit, filter->with_commit);
+	return is_descendant_of(commit, filter->with_commit);
+}
 /*
  * Given a refname, return 1 if the refname matches with one of the patterns
  * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
@@ -902,10 +1009,13 @@ int ref_filter_handler(const char *refname, const struct object_id *oid, int fla
 	if (!match_points_at(&filter->points_at, oid->hash, refname))
 		return 0;
 
-	if(filter->merge_commit) {
-		commit = lookup_commit_reference_gently(sha1, 1);
+	if(filter->merge_commit || filter->with_commit) {
+		commit = lookup_commit_reference_gently(oid->hash, 1);
 		if (!commit)
 			return 0;
+		if(filter->with_commit &&
+		   !commit_contains(filter, commit))
+			return 0;
 	}
 
 	/*
diff --git a/ref-filter.h b/ref-filter.h
index 622b942..c71704e 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -41,6 +41,7 @@ struct ref_array {
 struct ref_filter {
 	const char **name_patterns;
 	struct sha1_array points_at;
+	struct commit_list *with_commit;
 
 	enum {
 		REF_FILTER_MERGED_NONE = 0,
@@ -48,6 +49,8 @@ struct ref_filter {
 		REF_FILTER_MERGED_OMIT
 	} merge;
 	struct commit *merge_commit;
+
+	unsigned int with_commit_tag_algo: 1;
 };
 
 struct ref_filter_cbdata {
-- 
2.4.2
