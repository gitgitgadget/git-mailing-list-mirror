From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 6/8] branch.c: use 'ref-filter' data structures
Date: Wed, 19 Aug 2015 00:45:43 +0530
Message-ID: <1439925345-9969-7-git-send-email-Karthik.188@gmail.com>
References: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 21:16:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRmMi-0003qn-CX
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 21:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbbHRTQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 15:16:00 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36076 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbbHRTP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 15:15:58 -0400
Received: by pawq9 with SMTP id q9so41772404paw.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a22MH32DY+q0ef/lB8aAXbvc9yDZoGnPB8ZRUUAwV1w=;
        b=pmneTGW0eikTrvshqGq1N5iZ2LI9g07re/pvfjG5i1yitMRauuIJkgUqPAFoEu2XUh
         fVrwBegxf2IHjdE4i3PnF34j/Np2RX01Gv47w2Db1XPVfxM79geY/jSHP35MJ6XBFO/F
         M3piaO9CqqwpQrotf+rDdLXyYKtUBpM6V+QqKUpd9ASwnXlXc0JA4d4xYCfLk5DVJCKE
         5zSP44lJg6sHCmS1nO3eql/uND77UhJ828Qn9k5PpUaK5MQGVq9BVJ65tehfeFo20gpD
         OZ4UEY5vNfuFTWSdcFWSo/dpJBkM7dUD9p+7VjUP7kSjL3FHOCpGR+BkvnBp8oEhj9BN
         S6BA==
X-Received: by 10.66.102.71 with SMTP id fm7mr16190132pab.5.1439925357373;
        Tue, 18 Aug 2015 12:15:57 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id v2sm43800pda.34.2015.08.18.12.15.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 12:15:54 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276150>

Make 'branch.c' use 'ref-filter' data structures and make changes to
support the new data structures. This is a part of the process of
porting 'branch.c' to use 'ref-filter' APIs.

This is a temporary step before porting 'branch.c' to use 'ref-filter'
completely. As this is a temporary step, most of the code introduced
here will be removed when 'branch.c' is ported over to use
'ref-filter' APIs

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 321 ++++++++++++++++++++++---------------------------------
 ref-filter.h     |   7 +-
 2 files changed, 135 insertions(+), 193 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d15d184..cfa5722 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -19,6 +19,7 @@
 #include "column.h"
 #include "utf8.h"
 #include "wt-status.h"
+#include "ref-filter.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
@@ -28,10 +29,6 @@ static const char * const builtin_branch_usage[] = {
 	NULL
 };
 
-#define REF_LOCAL_BRANCH    0x01
-#define REF_REMOTE_BRANCH   0x02
-#define REF_DETACHED_HEAD   0x04
-
 static const char *head;
 static unsigned char head_sha1[20];
 
@@ -53,13 +50,6 @@ enum color_branch {
 	BRANCH_COLOR_UPSTREAM = 5
 };
 
-static enum merge_filter {
-	NO_FILTER = 0,
-	SHOW_NOT_MERGED,
-	SHOW_MERGED
-} merge_filter;
-static unsigned char merge_filter_ref[20];
-
 static struct string_list output = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
@@ -122,7 +112,7 @@ static int branch_merged(int kind, const char *name,
 	void *reference_name_to_free = NULL;
 	int merged;
 
-	if (kind == REF_LOCAL_BRANCH) {
+	if (kind == FILTER_REFS_BRANCHES) {
 		struct branch *branch = branch_get(name);
 		const char *upstream = branch_get_upstream(branch, NULL);
 		unsigned char sha1[20];
@@ -200,14 +190,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	struct strbuf bname = STRBUF_INIT;
 
 	switch (kinds) {
-	case REF_REMOTE_BRANCH:
+	case FILTER_REFS_REMOTES:
 		fmt = "refs/remotes/%s";
 		/* For subsequent UI messages */
 		remote_branch = 1;
 
 		force = 1;
 		break;
-	case REF_LOCAL_BRANCH:
+	case FILTER_REFS_BRANCHES:
 		fmt = "refs/heads/%s";
 		break;
 	default:
@@ -224,7 +214,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		int flags = 0;
 
 		strbuf_branchname(&bname, argv[i]);
-		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, bname.buf)) {
+		if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
 			error(_("Cannot delete the branch '%s' "
 			      "which you are currently on."), bname.buf);
 			ret = 1;
@@ -280,22 +270,6 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	return(ret);
 }
 
-struct ref_item {
-	char *name;
-	char *dest;
-	unsigned int kind;
-	struct commit *commit;
-	int ignore;
-};
-
-struct ref_list {
-	struct rev_info revs;
-	int index, alloc, verbose, abbrev;
-	struct ref_item *list;
-	struct commit_list *with_commit;
-	int kinds;
-};
-
 static char *resolve_symref(const char *src, const char *prefix)
 {
 	unsigned char sha1[20];
@@ -310,11 +284,6 @@ static char *resolve_symref(const char *src, const char *prefix)
 	return xstrdup(dst);
 }
 
-struct append_ref_cb {
-	struct ref_list *ref_list;
-	const char **pattern;
-};
-
 static int match_patterns(const char **pattern, const char *refname)
 {
 	if (!*pattern)
@@ -327,11 +296,29 @@ static int match_patterns(const char **pattern, const char *refname)
 	return 0;
 }
 
+/*
+ * Allocate memory for a new ref_array_item and insert that into the
+ * given ref_array. Doesn't take the objectname unlike
+ * new_ref_array_item(). This is a temporary function which will be
+ * removed when we port branch.c to use ref-filter APIs.
+ */
+static struct ref_array_item *ref_array_append(struct ref_array *array, const char *refname)
+{
+	size_t len = strlen(refname);
+	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
+	memcpy(ref->refname, refname, len);
+	ref->refname[len] = '\0';
+	REALLOC_ARRAY(array->items, array->nr + 1);
+	array->items[array->nr++] = ref;
+	return ref;
+}
+
 static int append_ref(const char *refname, const struct object_id *oid, int flags, void *cb_data)
 {
-	struct append_ref_cb *cb = (struct append_ref_cb *)(cb_data);
-	struct ref_list *ref_list = cb->ref_list;
-	struct ref_item *newitem;
+	struct ref_filter_cbdata *cb = (struct ref_filter_cbdata *)(cb_data);
+	struct ref_filter *filter = cb->filter;
+	struct ref_array *array = cb->array;
+	struct ref_array_item *item;
 	struct commit *commit;
 	int kind, i;
 	const char *prefix, *orig_refname = refname;
@@ -340,8 +327,8 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
 		int kind;
 		const char *prefix;
 	} ref_kind[] = {
-		{ REF_LOCAL_BRANCH, "refs/heads/" },
-		{ REF_REMOTE_BRANCH, "refs/remotes/" },
+		{ FILTER_REFS_BRANCHES, "refs/heads/" },
+		{ FILTER_REFS_REMOTES, "refs/remotes/" },
 	};
 
 	/* Detect kind */
@@ -354,65 +341,52 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
 	}
 	if (ARRAY_SIZE(ref_kind) <= i) {
 		if (!strcmp(refname, "HEAD"))
-			kind = REF_DETACHED_HEAD;
+			kind = FILTER_REFS_DETACHED_HEAD;
 		else
 			return 0;
 	}
 
 	/* Don't add types the caller doesn't want */
-	if ((kind & ref_list->kinds) == 0)
+	if ((kind & filter->kind) == 0)
 		return 0;
 
-	if (!match_patterns(cb->pattern, refname))
+	if (!match_patterns(filter->name_patterns, refname))
 		return 0;
 
 	commit = NULL;
-	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
+	if (filter->verbose || filter->with_commit || filter->merge != REF_FILTER_MERGED_NONE) {
 		commit = lookup_commit_reference_gently(oid->hash, 1);
 		if (!commit)
 			return 0;
 
 		/* Filter with with_commit if specified */
-		if (!is_descendant_of(commit, ref_list->with_commit))
+		if (!is_descendant_of(commit, filter->with_commit))
 			return 0;
 
-		if (merge_filter != NO_FILTER)
-			add_pending_object(&ref_list->revs,
+		if (filter->merge != REF_FILTER_MERGED_NONE)
+			add_pending_object(array->revs,
 					   (struct object *)commit, refname);
 	}
 
-	ALLOC_GROW(ref_list->list, ref_list->index + 1, ref_list->alloc);
+	item = ref_array_append(array, refname);
 
 	/* Record the new item */
-	newitem = &(ref_list->list[ref_list->index++]);
-	newitem->name = xstrdup(refname);
-	newitem->kind = kind;
-	newitem->commit = commit;
-	newitem->dest = resolve_symref(orig_refname, prefix);
-	newitem->ignore = 0;
+	item->kind = kind;
+	item->commit = commit;
+	item->symref = resolve_symref(orig_refname, prefix);
+	item->ignore = 0;
 
 	return 0;
 }
 
-static void free_ref_list(struct ref_list *ref_list)
-{
-	int i;
-
-	for (i = 0; i < ref_list->index; i++) {
-		free(ref_list->list[i].name);
-		free(ref_list->list[i].dest);
-	}
-	free(ref_list->list);
-}
-
 static int ref_cmp(const void *r1, const void *r2)
 {
-	struct ref_item *c1 = (struct ref_item *)(r1);
-	struct ref_item *c2 = (struct ref_item *)(r2);
+	struct ref_array_item *c1 = *((struct ref_array_item **)r1);
+	struct ref_array_item *c2 = *((struct ref_array_item **)r2);
 
 	if (c1->kind != c2->kind)
 		return c1->kind - c2->kind;
-	return strcmp(c1->name, c2->name);
+	return strcmp(c1->refname, c2->refname);
 }
 
 static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
@@ -477,8 +451,8 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	free(ref);
 }
 
-static void add_verbose_info(struct strbuf *out, struct ref_item *item,
-			     int verbose, int abbrev)
+static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
+			     struct ref_filter *filter)
 {
 	struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
 	const char *sub = _(" **** invalid ref ****");
@@ -489,11 +463,11 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 		sub = subject.buf;
 	}
 
-	if (item->kind == REF_LOCAL_BRANCH)
-		fill_tracking_info(&stat, item->name, verbose > 1);
+	if (item->kind == FILTER_REFS_BRANCHES)
+		fill_tracking_info(&stat, item->refname, filter->verbose > 1);
 
 	strbuf_addf(out, " %s %s%s",
-		find_unique_abbrev(item->commit->object.sha1, abbrev),
+		find_unique_abbrev(item->commit->object.sha1, filter->abbrev),
 		stat.buf, sub);
 	strbuf_release(&stat);
 	strbuf_release(&subject);
@@ -530,32 +504,32 @@ static char *get_head_description(void)
 	return strbuf_detach(&desc, NULL);
 }
 
-static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
-			   int abbrev, int detached, const char *remote_prefix)
+static void print_ref_item(struct ref_array_item *item, int maxwidth,
+			   struct ref_filter *filter, const char *remote_prefix)
 {
 	char c;
 	int current = 0;
 	int color;
 	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
 	const char *prefix = "";
-	const char *desc = item->name;
+	const char *desc = item->refname;
 	char *to_free = NULL;
 
 	if (item->ignore)
 		return;
 
 	switch (item->kind) {
-	case REF_LOCAL_BRANCH:
-		if (!detached && !strcmp(item->name, head))
+	case FILTER_REFS_BRANCHES:
+		if (!filter->detached && !strcmp(item->refname, head))
 			current = 1;
 		else
 			color = BRANCH_COLOR_LOCAL;
 		break;
-	case REF_REMOTE_BRANCH:
+	case FILTER_REFS_REMOTES:
 		color = BRANCH_COLOR_REMOTE;
 		prefix = remote_prefix;
 		break;
-	case REF_DETACHED_HEAD:
+	case FILTER_REFS_DETACHED_HEAD:
 		desc = to_free = get_head_description();
 		current = 1;
 		break;
@@ -571,7 +545,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	}
 
 	strbuf_addf(&name, "%s%s", prefix, desc);
-	if (verbose) {
+	if (filter->verbose) {
 		int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
 		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
 			    maxwidth + utf8_compensation, name.buf,
@@ -580,13 +554,13 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
 			    name.buf, branch_get_color(BRANCH_COLOR_RESET));
 
-	if (item->dest)
-		strbuf_addf(&out, " -> %s", item->dest);
-	else if (verbose)
+	if (item->symref)
+		strbuf_addf(&out, " -> %s", item->symref);
+	else if (filter->verbose)
 		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
-		add_verbose_info(&out, item, verbose, abbrev);
+		add_verbose_info(&out, item, filter);
 	if (column_active(colopts)) {
-		assert(!verbose && "--column and --verbose are incompatible");
+		assert(!filter->verbose && "--column and --verbose are incompatible");
 		string_list_append(&output, out.buf);
 	} else {
 		printf("%s\n", out.buf);
@@ -596,17 +570,17 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	free(to_free);
 }
 
-static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
+static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 {
 	int i, max = 0;
-	for (i = 0; i < refs->index; i++) {
-		struct ref_item *it = &refs->list[i];
+	for (i = 0; i < refs->nr; i++) {
+		struct ref_array_item *it = refs->items[i];
 		int w;
 
 		if (it->ignore)
 			continue;
-		w = utf8_strwidth(it->name);
-		if (it->kind == REF_REMOTE_BRANCH)
+		w = utf8_strwidth(it->refname);
+		if (it->kind == FILTER_REFS_REMOTES)
 			w += remote_bonus;
 		if (w > max)
 			max = w;
@@ -614,90 +588,81 @@ static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
 	return max;
 }
 
-static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
+static void print_ref_list(struct ref_filter *filter)
 {
 	int i, index;
-	struct append_ref_cb cb;
-	struct ref_list ref_list;
+	struct ref_array array;
+	struct ref_filter_cbdata data;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
+	struct rev_info revs;
 
 	/*
 	 * If we are listing more than just remote branches,
 	 * then remote branches will have a "remotes/" prefix.
 	 * We need to account for this in the width.
 	 */
-	if (kinds != REF_REMOTE_BRANCH)
+	if (filter->kind != FILTER_REFS_REMOTES)
 		remote_prefix = "remotes/";
 
-	memset(&ref_list, 0, sizeof(ref_list));
-	ref_list.kinds = kinds;
-	ref_list.verbose = verbose;
-	ref_list.abbrev = abbrev;
-	ref_list.with_commit = with_commit;
-	if (merge_filter != NO_FILTER)
-		init_revisions(&ref_list.revs, NULL);
-	cb.ref_list = &ref_list;
-	cb.pattern = pattern;
+	memset(&array, 0, sizeof(array));
+	if (filter->merge != REF_FILTER_MERGED_NONE)
+		init_revisions(&revs, NULL);
+
+	data.array = &array;
+	data.filter = filter;
+	array.revs = &revs;
+
 	/*
 	 * First we obtain all regular branch refs and if the HEAD is
 	 * detached then we insert that ref to the end of the ref_fist
 	 * so that it can be printed first.
 	 */
-	for_each_rawref(append_ref, &cb);
-	if (detached)
-		head_ref(append_ref, &cb);
+	for_each_rawref(append_ref, &data);
+	if (filter->detached)
+		head_ref(append_ref, &data);
 	/*
 	 * The following implementation is currently duplicated in ref-filter. It
 	 * will eventually be removed when we port branch.c to use ref-filter APIs.
 	 */
-	if (merge_filter != NO_FILTER) {
-		struct commit *filter;
-		filter = lookup_commit_reference_gently(merge_filter_ref, 0);
-		if (!filter)
-			die(_("object '%s' does not point to a commit"),
-			    sha1_to_hex(merge_filter_ref));
-
-		filter->object.flags |= UNINTERESTING;
-		add_pending_object(&ref_list.revs,
-				   (struct object *) filter, "");
-		ref_list.revs.limited = 1;
-
-		if (prepare_revision_walk(&ref_list.revs))
+	if (filter->merge != REF_FILTER_MERGED_NONE) {
+		filter->merge_commit->object.flags |= UNINTERESTING;
+		add_pending_object(&revs, &filter->merge_commit->object, "");
+		revs.limited = 1;
+
+		if (prepare_revision_walk(&revs))
 			die(_("revision walk setup failed"));
 
-		for (i = 0; i < ref_list.index; i++) {
-			struct ref_item *item = &ref_list.list[i];
+		for (i = 0; i < array.nr; i++) {
+			struct ref_array_item *item = array.items[i];
 			struct commit *commit = item->commit;
 			int is_merged = !!(commit->object.flags & UNINTERESTING);
-			item->ignore = is_merged != (merge_filter == SHOW_MERGED);
+			item->ignore = is_merged != (filter->merge == REF_FILTER_MERGED_INCLUDE);
 		}
 
-		for (i = 0; i < ref_list.index; i++) {
-			struct ref_item *item = &ref_list.list[i];
+		for (i = 0; i < array.nr; i++) {
+			struct ref_array_item *item = array.items[i];
 			clear_commit_marks(item->commit, ALL_REV_FLAGS);
 		}
-		clear_commit_marks(filter, ALL_REV_FLAGS);
+		clear_commit_marks(filter->merge_commit, ALL_REV_FLAGS);
 	}
-	if (verbose)
-		maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
+	if (filter->verbose)
+		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
-	index = ref_list.index;
+	index = array.nr;
 
 	/* Print detached HEAD before sorting and printing the rest */
-	if (detached) {
-		print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
-			       detached, remote_prefix);
+	if (filter->kind & FILTER_REFS_DETACHED_HEAD) {
+		print_ref_item(array.items[index - 1], maxwidth, filter, remote_prefix);
 		index -= 1;
 	}
 
-	qsort(ref_list.list, index, sizeof(struct ref_item), ref_cmp);
+	qsort(array.items, index, sizeof(struct ref_array_item *), ref_cmp);
 
 	for (i = 0; i < index; i++)
-		print_ref_item(&ref_list.list[i], maxwidth, verbose,
-			       abbrev, detached, remote_prefix);
+		print_ref_item(array.items[i], maxwidth, filter, remote_prefix);
 
-	free_ref_list(&ref_list);
+	ref_array_clear(&array);
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -753,24 +718,6 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	strbuf_release(&newsection);
 }
 
-/*
- * This function is duplicated in ref-filter. It will eventually be removed
- * when we port branch.c to use ref-filter APIs.
- */
-static int opt_parse_merge_filter(const struct option *opt, const char *arg, int unset)
-{
-	merge_filter = ((opt->long_name[0] == 'n')
-			? SHOW_NOT_MERGED
-			: SHOW_MERGED);
-	if (unset)
-		merge_filter = SHOW_NOT_MERGED; /* b/c for --no-merged */
-	if (!arg)
-		arg = "HEAD";
-	if (get_sha1(arg, merge_filter_ref))
-		die(_("malformed object name %s"), arg);
-	return 0;
-}
-
 static const char edit_description[] = "BRANCH_DESCRIPTION";
 
 static int edit_branch_description(const char *branch_name)
@@ -810,17 +757,15 @@ static int edit_branch_description(const char *branch_name)
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force = 0, list = 0;
-	int verbose = 0, abbrev = -1, detached = 0;
 	int reflog = 0, edit_description = 0;
 	int quiet = 0, unset_upstream = 0;
 	const char *new_upstream = NULL;
 	enum branch_track track;
-	int kinds = REF_LOCAL_BRANCH;
-	struct commit_list *with_commit = NULL;
+	struct ref_filter filter;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
-		OPT__VERBOSE(&verbose,
+		OPT__VERBOSE(&filter.verbose,
 			N_("show hash and subject, give twice for upstream branch")),
 		OPT__QUIET(&quiet, N_("suppress informational messages")),
 		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
@@ -830,15 +775,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
-		OPT_SET_INT('r', "remotes",     &kinds, N_("act on remote-tracking branches"),
-			REF_REMOTE_BRANCH),
-		OPT_CONTAINS(&with_commit, N_("print only branches that contain the commit")),
-		OPT_WITH(&with_commit, N_("print only branches that contain the commit")),
-		OPT__ABBREV(&abbrev),
+		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
+			FILTER_REFS_REMOTES),
+		OPT_CONTAINS(&filter.with_commit, N_("print only branches that contain the commit")),
+		OPT_WITH(&filter.with_commit, N_("print only branches that contain the commit")),
+		OPT__ABBREV(&filter.abbrev),
 
 		OPT_GROUP(N_("Specific git-branch actions:")),
-		OPT_SET_INT('a', "all", &kinds, N_("list both remote-tracking and local branches"),
-			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
+		OPT_SET_INT('a', "all", &filter.kind, N_("list both remote-tracking and local branches"),
+			FILTER_REFS_REMOTES | FILTER_REFS_BRANCHES),
 		OPT_BIT('d', "delete", &delete, N_("delete fully merged branch"), 1),
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
@@ -848,22 +793,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion")),
-		{
-			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
-			N_("commit"), N_("print only not merged branches"),
-			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
-			opt_parse_merge_filter, (intptr_t) "HEAD",
-		},
-		{
-			OPTION_CALLBACK, 0, "merged", &merge_filter_ref,
-			N_("commit"), N_("print only merged branches"),
-			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
-			opt_parse_merge_filter, (intptr_t) "HEAD",
-		},
+		OPT_MERGED(&filter, N_("print only branches that are merged")),
+		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_END(),
 	};
 
+	memset(&filter, 0, sizeof(filter));
+	filter.kind = FILTER_REFS_BRANCHES;
+	filter.abbrev = -1;
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_branch_usage, options);
 
@@ -875,11 +814,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
 	if (!strcmp(head, "HEAD"))
-		detached = 1;
+		filter.detached = 1;
 	else if (!skip_prefix(head, "refs/heads/", &head))
 		die(_("HEAD not found below refs/heads!"));
-	hashcpy(merge_filter_ref, head_sha1);
-
 
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
@@ -887,17 +824,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
-	if (with_commit || merge_filter != NO_FILTER)
+	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE)
 		list = 1;
 
 	if (!!delete + !!rename + !!new_upstream +
 	    list + unset_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
-	if (abbrev == -1)
-		abbrev = DEFAULT_ABBREV;
+	if (filter.abbrev == -1)
+		filter.abbrev = DEFAULT_ABBREV;
 	finalize_colopts(&colopts, -1);
-	if (verbose) {
+	if (filter.verbose) {
 		if (explicitly_enable_column(colopts))
 			die(_("--column and --verbose are incompatible"));
 		colopts = 0;
@@ -911,13 +848,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		return delete_branches(argc, argv, delete > 1, kinds, quiet);
+		return delete_branches(argc, argv, delete > 1, filter.kind, quiet);
 	} else if (list) {
 		/*  git branch --local also shows HEAD when it is detached */
-		if (kinds & REF_LOCAL_BRANCH)
-			kinds |= REF_DETACHED_HEAD;
-		print_ref_list(kinds, detached, verbose, abbrev,
-					 with_commit, argv);
+		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
+			filter.kind |= FILTER_REFS_DETACHED_HEAD;
+		filter.name_patterns = argv;
+		print_ref_list(&filter);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		return 0;
@@ -927,7 +864,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		struct strbuf branch_ref = STRBUF_INIT;
 
 		if (!argc) {
-			if (detached)
+			if (filter.detached)
 				die(_("Cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1)
@@ -1015,7 +952,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch)
 			die(_("no such branch '%s'"), argv[0]);
 
-		if (kinds != REF_LOCAL_BRANCH)
+		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)
diff --git a/ref-filter.h b/ref-filter.h
index 8241066..ae9cede 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -35,6 +35,7 @@ struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
 	unsigned int kind;
+	int ignore : 1; /* To be removed in the next patch */
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
@@ -44,6 +45,7 @@ struct ref_array_item {
 struct ref_array {
 	int nr, alloc;
 	struct ref_array_item **items;
+	struct rev_info *revs;
 };
 
 struct ref_filter {
@@ -59,9 +61,12 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1,
-		match_as_path : 1;
+		match_as_path : 1,
+		detached : 1;
 	unsigned int kind,
 		lines;
+	int abbrev,
+		verbose;
 };
 
 struct ref_filter_cbdata {
-- 
2.5.0
