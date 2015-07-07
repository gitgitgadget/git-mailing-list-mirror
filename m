From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 10/11] ref-filter: implement '--contains' option
Date: Tue,  7 Jul 2015 21:36:16 +0530
Message-ID: <1436285177-12279-10-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
 <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 18:08:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVPk-0001w7-T9
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051AbbGGQH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:07:59 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36514 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758036AbbGGQHs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:07:48 -0400
Received: by pddu5 with SMTP id u5so40705255pdd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VhQRPv2K5z+gCe6bU7teXHwI36nIK/YNaD8YsDRSNMc=;
        b=lIsmYnphJVA95Ga+cppzU3iVBNXxmaTw3r0TNr/XO8DHxo7TmBcowHz2AKvMhvbK4X
         O/UVA8r3TOrqquLoz3SyqRclbeFubBZYauM82s0uVyTzLi0Mm4IIB2Pdw0hHONRKkHOO
         E5lY7RA7HbmUfN1gGfR5X1t6DH/GfQMqpnxZonT4L0w+3r7PVlNpHBboDONAW0bcHVY2
         WimITIa5JwN4bH8XDPlzxpufTzAAZ3fDehPYmo7Fvq+ztvJk/duLcbwrA8xwaGpAsd/I
         Oglcb4FXGvX4aZlZRJWnaurmTYSgG04NSUn71qoUKZCG2Q/IQ3YQPAKtgyMGwdRSNoC1
         sSaw==
X-Received: by 10.68.222.167 with SMTP id qn7mr10315554pbc.136.1436285267230;
        Tue, 07 Jul 2015 09:07:47 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nt6sm22295515pbc.18.2015.07.07.09.07.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 09:07:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273580>

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
 builtin/tag.c |   5 +++
 ref-filter.c  | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 ref-filter.h  |   3 ++
 3 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 767162e..071d001 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -86,6 +86,11 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
 	return 0;
 }
 
+/*
+ * The entire code segment for supporting the --contains option has been
+ * copied over to ref-filter.{c,h}. This will be deleted evetually when
+ * we port tag.c to use ref-filter APIs.
+ */
 enum contains_result {
 	CONTAINS_UNKNOWN = -1,
 	CONTAINS_NO = 0,
diff --git a/ref-filter.c b/ref-filter.c
index 148b7cd..dd0709d 100644
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
@@ -922,10 +1030,14 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
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
index f115174..6bf27d8 100644
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
+	unsigned int with_commit_tag_algo : 1;
 };
 
 struct ref_filter_cbdata {
-- 
2.4.5
