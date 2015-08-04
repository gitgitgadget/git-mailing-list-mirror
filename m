From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 07/10] branch.c: use 'ref-filter' data structures
Date: Tue,  4 Aug 2015 18:31:20 +0530
Message-ID: <1438693282-15516-7-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:01:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbqq-0003P5-9u
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934039AbbHDNBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:01:46 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:32774 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934003AbbHDNBh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:01:37 -0400
Received: by pdbnt7 with SMTP id nt7so4284713pdb.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n+/aoNlupQT0rvaLSmTqilADlPfQ2OWqGhySiKiM5gM=;
        b=HRnN0wPQo2ckdMb5SyTYFUp80qMw2VCZRzJRQ8yQhV61Nrot9lB4USIzozRUO0U9sh
         KdeUcwCch4mtH2l98cX9tMTf8eSsB32+rnf91X7dtWXfHF/0a1PhIWLPbWjfS/GPZ5g5
         uEXXtSIOn65I7SZ2pAijqLO1EJZxdtN0UxGiCM1k8T3crPt2BQflVfYH68xGZNcvT/eR
         ouwEWBLT9AwxFE7zfMSS2BEInEvA7iyn+xy23sgFSjBUQETx4LUXEVS2gHpwFdewDcoo
         cI5g3b38El1q3ffiVD+lJMRJPNDCaQHRHaDIS5z6QNpRtys1gjLxjgP8WQCoP2ojhh+O
         mqRw==
X-Received: by 10.70.61.134 with SMTP id p6mr7669951pdr.108.1438693296273;
        Tue, 04 Aug 2015 06:01:36 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uy6sm1450657pbc.13.2015.08.04.06.01.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:01:35 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275273>

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
 builtin/branch.c | 295 ++++++++++++++++++++++---------------------------------
 ref-filter.h     |   7 +-
 2 files changed, 122 insertions(+), 180 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1ac7fbc..edc3d7d 100644
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
@@ -360,59 +347,46 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
 	}
 
 	/* Don't add types the caller doesn't want */
-	if ((kind & ref_list->kinds) == 0)
+	if ((kind & filter->branch_kind) == 0)
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
@@ -490,10 +464,10 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 	}
 
 	if (item->kind == REF_LOCAL_BRANCH)
-		fill_tracking_info(&stat, item->name, verbose > 1);
+		fill_tracking_info(&stat, item->refname, filter->verbose > 1);
 
 	strbuf_addf(out, " %s %s%s",
-		find_unique_abbrev(item->commit->object.sha1, abbrev),
+		find_unique_abbrev(item->commit->object.sha1, filter->abbrev),
 		stat.buf, sub);
 	strbuf_release(&stat);
 	strbuf_release(&subject);
@@ -530,22 +504,22 @@ static char *get_head_description(void)
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
 
 	if (item->ignore)
 		return;
 
 	switch (item->kind) {
 	case REF_LOCAL_BRANCH:
-		if (!detached && !strcmp(item->name, head))
+		if (!filter->detached && !strcmp(item->refname, head))
 			current = 1;
 		else
 			color = BRANCH_COLOR_LOCAL;
@@ -570,7 +544,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	}
 
 	strbuf_addf(&name, "%s%s", prefix, desc);
-	if (verbose) {
+	if (filter->verbose) {
 		int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
 		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
 			    maxwidth + utf8_compensation, name.buf,
@@ -579,13 +553,13 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
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
@@ -596,14 +570,14 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		free((void *)desc);
 }
 
-static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
+static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 {
 	int i, max = 0;
-	for (i = 0; i < refs->index; i++) {
-		struct ref_item *it = &refs->list[i];
-		int w = utf8_strwidth(it->name);
+	for (i = 0; i < refs->nr; i++) {
+		struct ref_array_item *it = refs->items[i];
+		int w = utf8_strwidth(it->refname);
 
-		if (refs->list[i].ignore)
+		if (it->ignore)
 			continue;
 		if (it->kind == REF_REMOTE_BRANCH)
 			w += remote_bonus;
@@ -613,90 +587,81 @@ static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
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
+	if (filter->branch_kind != REF_REMOTE_BRANCH)
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
 	 * First we obtain all regular branch refs and then if the
 	 * HEAD is detached then we insert that ref to the end of the
 	 * ref_fist so that it can be printed first.
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
+	if (filter->detached) {
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
@@ -752,24 +717,6 @@ static void rename_branch(const char *oldname, const char *newname, int force)
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
@@ -809,17 +756,15 @@ static int edit_branch_description(const char *branch_name)
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
@@ -829,14 +774,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
-		OPT_SET_INT('r', "remotes",     &kinds, N_("act on remote-tracking branches"),
+		OPT_SET_INT('r', "remotes",     &filter.branch_kind, N_("act on remote-tracking branches"),
 			REF_REMOTE_BRANCH),
-		OPT_CONTAINS(&with_commit, N_("print only branches that contain the commit")),
-		OPT_WITH(&with_commit, N_("print only branches that contain the commit")),
-		OPT__ABBREV(&abbrev),
+		OPT_CONTAINS(&filter.with_commit, N_("print only branches that contain the commit")),
+		OPT_WITH(&filter.with_commit, N_("print only branches that contain the commit")),
+		OPT__ABBREV(&filter.abbrev),
 
 		OPT_GROUP(N_("Specific git-branch actions:")),
-		OPT_SET_INT('a', "all", &kinds, N_("list both remote-tracking and local branches"),
+		OPT_SET_INT('a', "all", &filter.branch_kind, N_("list both remote-tracking and local branches"),
 			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
 		OPT_BIT('d', "delete", &delete, N_("delete fully merged branch"), 1),
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
@@ -847,22 +792,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
+	filter.branch_kind = REF_LOCAL_BRANCH;
+	filter.abbrev = -1;
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_branch_usage, options);
 
@@ -874,11 +813,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
@@ -886,17 +823,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
@@ -910,13 +847,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		return delete_branches(argc, argv, delete > 1, kinds, quiet);
+		return delete_branches(argc, argv, delete > 1, filter.branch_kind, quiet);
 	} else if (list) {
 		/*  git branch --local also shows HEAD when it is detached */
-		if (kinds & REF_LOCAL_BRANCH)
-			kinds |= REF_DETACHED_HEAD;
-		print_ref_list(kinds, detached, verbose, abbrev,
-					 with_commit, argv);
+		if (filter.branch_kind & REF_LOCAL_BRANCH)
+			filter.branch_kind |= REF_DETACHED_HEAD;
+		filter.name_patterns = argv;
+		print_ref_list(&filter);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		return 0;
@@ -926,7 +863,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		struct strbuf branch_ref = STRBUF_INIT;
 
 		if (!argc) {
-			if (detached)
+			if (filter.detached)
 				die(_("Cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1)
@@ -1014,7 +951,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch)
 			die(_("no such branch '%s'"), argv[0]);
 
-		if (kinds != REF_LOCAL_BRANCH)
+		if (filter.branch_kind != REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)
diff --git a/ref-filter.h b/ref-filter.h
index b5a13e8..1b1e6de 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "parse-options.h"
+#include "revision.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -57,6 +58,7 @@ struct ref_sorting {
 struct ref_array_item {
 	unsigned char objectname[20];
 	int flag, kind;
+	int ignore : 1; /* To be removed in the next patch */
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
@@ -66,6 +68,7 @@ struct ref_array_item {
 struct ref_array {
 	int nr, alloc;
 	struct ref_array_item **items;
+	struct rev_info *revs;
 };
 
 struct ref_filter {
@@ -81,8 +84,10 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1,
-		match_as_path : 1;
+		match_as_path : 1,
+		detached : 1;
 	unsigned int lines, branch_kind;
+	int abbrev, verbose;
 };
 
 struct ref_filter_cbdata {
-- 
2.5.0
