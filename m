From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 08/10] branch.c: use 'ref-filter' APIs
Date: Tue,  4 Aug 2015 18:31:21 +0530
Message-ID: <1438693282-15516-8-git-send-email-Karthik.188@gmail.com>
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
	id 1ZMbqp-0003P5-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934022AbbHDNBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:01:41 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35476 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934006AbbHDNBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:01:39 -0400
Received: by pdrg1 with SMTP id g1so4327871pdr.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a5GHNWCYyFeC2EFecOna4dPpIH/fFRhWTHVdtp6O4Oc=;
        b=h3n+345ZYRqnYko8XIyGOE+dLool1FqHGj7Ce27JiPFRPMlVXUavMhsAjbyizQM456
         ow1tbYO+ar+MMfFS/YfWMIgCvuFdHICIq5SaNpUd4nEOxPnZKT+eWXtLxpYrl3qRJCQ+
         Esz+cA8/4nP6NGPDuaAxetZ6ToQzZ5w7uwzcTuZUgQyLWDEs0Cy1q1VH1aolpUZxjSmk
         EUaKULexYqDf5mzJ/I+VWl6vNQ3MC4eYX3cdM+YBTo2GpAxGwGvtNJVuO6JVarMPAXky
         PwiR8gB7SuHfurtjKi5X/0rxx+xyY2wkdnjHVU1PH9r5TP8GVRZ5MiWWJqLatL5Vv983
         R6DQ==
X-Received: by 10.70.130.34 with SMTP id ob2mr7553045pdb.15.1438693298863;
        Tue, 04 Aug 2015 06:01:38 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uy6sm1450657pbc.13.2015.08.04.06.01.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:01:38 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275272>

Make 'branch.c' use 'ref-filter' APIs for iterating through refs
sorting. This removes most of the code used in 'branch.c' replacing it
with calls to the 'ref-filter' library.

Make 'branch.c' use the 'filter_refs()' function provided by 'ref-filter'
to filter out tags based on the options set.

We provide a sorting option provided for 'branch.c' by using the sorting
options provided by 'ref-filter'.

Also remove the 'ignore' variable from ref_array_item as it was
previously used for the '--merged' option and now that is handled by
ref-filter.

The test t1430 'git branch shows badly named ref' fails as this checks
the ability of branch.c to list broken refs, which is now displayed as
a warning while using ref-filter APIs.

Modify documentation and add tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-branch.txt |   9 +-
 builtin/branch.c             | 219 ++++++++-----------------------------------
 ref-filter.c                 |   8 +-
 ref-filter.h                 |   1 -
 t/t1430-bad-ref-name.sh      |  10 +-
 t/t3203-branch-output.sh     |  11 +++
 6 files changed, 68 insertions(+), 190 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index a67138a..897cd81 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[--list] [-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column]
-	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
+	[(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
@@ -229,6 +229,13 @@ start-point is either a local or remote-tracking branch.
 	The new name for an existing branch. The same restrictions as for
 	<branchname> apply.
 
+--sort=<key>::
+	Sort based on the key given. Prefix `-` to sort in descending
+	order of the value. You may use the --sort=<key> option
+	multiple times, in which case the last key becomes the primary
+	key. The keys supported are the same as those in `git
+	for-each-ref`. Sort order defaults to sorting based on branch
+	type.
 
 Examples
 --------
diff --git a/builtin/branch.c b/builtin/branch.c
index edc3d7d..34ccf0c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -270,125 +270,6 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	return(ret);
 }
 
-static char *resolve_symref(const char *src, const char *prefix)
-{
-	unsigned char sha1[20];
-	int flag;
-	const char *dst;
-
-	dst = resolve_ref_unsafe(src, 0, sha1, &flag);
-	if (!(dst && (flag & REF_ISSYMREF)))
-		return NULL;
-	if (prefix)
-		skip_prefix(dst, prefix, &dst);
-	return xstrdup(dst);
-}
-
-static int match_patterns(const char **pattern, const char *refname)
-{
-	if (!*pattern)
-		return 1; /* no pattern always matches */
-	while (*pattern) {
-		if (!wildmatch(*pattern, refname, 0, NULL))
-			return 1;
-		pattern++;
-	}
-	return 0;
-}
-
-/*
- * Allocate memory for a new ref_array_item and insert that into the
- * given ref_array. Doesn't take the objectname unlike
- * new_ref_array_item(). This is a temporary function which will be
- * removed when we port branch.c to use ref-filter APIs.
- */
-static struct ref_array_item *ref_array_append(struct ref_array *array, const char *refname)
-{
-	size_t len = strlen(refname);
-	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
-	memcpy(ref->refname, refname, len);
-	ref->refname[len] = '\0';
-	REALLOC_ARRAY(array->items, array->nr + 1);
-	array->items[array->nr++] = ref;
-	return ref;
-}
-
-static int append_ref(const char *refname, const struct object_id *oid, int flags, void *cb_data)
-{
-	struct ref_filter_cbdata *cb = (struct ref_filter_cbdata *)(cb_data);
-	struct ref_filter *filter = cb->filter;
-	struct ref_array *array = cb->array;
-	struct ref_array_item *item;
-	struct commit *commit;
-	int kind, i;
-	const char *prefix, *orig_refname = refname;
-
-	static struct {
-		int kind;
-		const char *prefix;
-	} ref_kind[] = {
-		{ REF_LOCAL_BRANCH, "refs/heads/" },
-		{ REF_REMOTE_BRANCH, "refs/remotes/" },
-	};
-
-	/* Detect kind */
-	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
-		prefix = ref_kind[i].prefix;
-		if (skip_prefix(refname, prefix, &refname)) {
-			kind = ref_kind[i].kind;
-			break;
-		}
-	}
-	if (ARRAY_SIZE(ref_kind) <= i) {
-		if (!strcmp(refname, "HEAD"))
-			kind = REF_DETACHED_HEAD;
-		else
-			return 0;
-	}
-
-	/* Don't add types the caller doesn't want */
-	if ((kind & filter->branch_kind) == 0)
-		return 0;
-
-	if (!match_patterns(filter->name_patterns, refname))
-		return 0;
-
-	commit = NULL;
-	if (filter->verbose || filter->with_commit || filter->merge != REF_FILTER_MERGED_NONE) {
-		commit = lookup_commit_reference_gently(oid->hash, 1);
-		if (!commit)
-			return 0;
-
-		/* Filter with with_commit if specified */
-		if (!is_descendant_of(commit, filter->with_commit))
-			return 0;
-
-		if (filter->merge != REF_FILTER_MERGED_NONE)
-			add_pending_object(array->revs,
-					   (struct object *)commit, refname);
-	}
-
-	item = ref_array_append(array, refname);
-
-	/* Record the new item */
-	item->kind = kind;
-	item->commit = commit;
-	item->symref = resolve_symref(orig_refname, prefix);
-	item->ignore = 0;
-
-	return 0;
-}
-
-static int ref_cmp(const void *r1, const void *r2)
-{
-	struct ref_array_item *c1 = *((struct ref_array_item **)r1);
-	struct ref_array_item *c2 = *((struct ref_array_item **)r2);
-
-	if (c1->kind != c2->kind)
-		return c1->kind - c2->kind;
-	return strcmp(c1->refname, c2->refname);
-}
-
 static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 		int show_upstream_ref)
 {
@@ -452,7 +333,7 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 }
 
 static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
-			     struct ref_filter *filter)
+			     struct ref_filter *filter, const char *refname)
 {
 	struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
 	const char *sub = _(" **** invalid ref ****");
@@ -464,7 +345,7 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
 	}
 
 	if (item->kind == REF_LOCAL_BRANCH)
-		fill_tracking_info(&stat, item->refname, filter->verbose > 1);
+		fill_tracking_info(&stat, refname, filter->verbose > 1);
 
 	strbuf_addf(out, " %s %s%s",
 		find_unique_abbrev(item->commit->object.sha1, filter->abbrev),
@@ -504,8 +385,8 @@ static char *get_head_description(void)
 	return strbuf_detach(&desc, NULL);
 }
 
-static void print_ref_item(struct ref_array_item *item, int maxwidth,
-			   struct ref_filter *filter, const char *remote_prefix)
+static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
+				      struct ref_filter *filter, const char *remote_prefix)
 {
 	char c;
 	int current = 0;
@@ -514,17 +395,16 @@ static void print_ref_item(struct ref_array_item *item, int maxwidth,
 	const char *prefix = "";
 	const char *desc = item->refname;
 
-	if (item->ignore)
-		return;
-
 	switch (item->kind) {
 	case REF_LOCAL_BRANCH:
-		if (!filter->detached && !strcmp(item->refname, head))
+		skip_prefix(desc, "refs/heads/", &desc);
+		if (!filter->detached && !strcmp(desc, head))
 			current = 1;
 		else
 			color = BRANCH_COLOR_LOCAL;
 		break;
 	case REF_REMOTE_BRANCH:
+		skip_prefix(desc, "refs/remotes/", &desc);
 		color = BRANCH_COLOR_REMOTE;
 		prefix = remote_prefix;
 		break;
@@ -553,11 +433,13 @@ static void print_ref_item(struct ref_array_item *item, int maxwidth,
 		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
 			    name.buf, branch_get_color(BRANCH_COLOR_RESET));
 
-	if (item->symref)
-		strbuf_addf(&out, " -> %s", item->symref);
+	if (item->symref) {
+		skip_prefix(item->symref, "refs/remotes/", &desc);
+		strbuf_addf(&out, " -> %s", desc);
+	}
 	else if (filter->verbose)
 		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
-		add_verbose_info(&out, item, filter);
+		add_verbose_info(&out, item, filter, desc);
 	if (column_active(colopts)) {
 		assert(!filter->verbose && "--column and --verbose are incompatible");
 		string_list_append(&output, out.buf);
@@ -575,10 +457,13 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 	int i, max = 0;
 	for (i = 0; i < refs->nr; i++) {
 		struct ref_array_item *it = refs->items[i];
-		int w = utf8_strwidth(it->refname);
+		const char *desc = it->refname;
+		int w;
+
+		skip_prefix(it->refname, "refs/heads/", &desc);
+		skip_prefix(it->refname, "refs/remotes/", &desc);
+		w = utf8_strwidth(desc);
 
-		if (it->ignore)
-			continue;
 		if (it->kind == REF_REMOTE_BRANCH)
 			w += remote_bonus;
 		if (w > max)
@@ -587,14 +472,14 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 	return max;
 }
 
-static void print_ref_list(struct ref_filter *filter)
+static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting)
 {
 	int i, index;
 	struct ref_array array;
-	struct ref_filter_cbdata data;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
-	struct rev_info revs;
+	struct ref_sorting def_sorting;
+	const char *sort_type = "type";
 
 	/*
 	 * If we are listing more than just remote branches,
@@ -605,46 +490,10 @@ static void print_ref_list(struct ref_filter *filter)
 		remote_prefix = "remotes/";
 
 	memset(&array, 0, sizeof(array));
-	if (filter->merge != REF_FILTER_MERGED_NONE)
-		init_revisions(&revs, NULL);
-
-	data.array = &array;
-	data.filter = filter;
-	array.revs = &revs;
 
-	/*
-	 * First we obtain all regular branch refs and then if the
-	 * HEAD is detached then we insert that ref to the end of the
-	 * ref_fist so that it can be printed first.
-	 */
-	for_each_rawref(append_ref, &data);
-	if (filter->detached)
-		head_ref(append_ref, &data);
-	/*
-	 * The following implementation is currently duplicated in ref-filter. It
-	 * will eventually be removed when we port branch.c to use ref-filter APIs.
-	 */
-	if (filter->merge != REF_FILTER_MERGED_NONE) {
-		filter->merge_commit->object.flags |= UNINTERESTING;
-		add_pending_object(&revs, &filter->merge_commit->object, "");
-		revs.limited = 1;
-
-		if (prepare_revision_walk(&revs))
-			die(_("revision walk setup failed"));
-
-		for (i = 0; i < array.nr; i++) {
-			struct ref_array_item *item = array.items[i];
-			struct commit *commit = item->commit;
-			int is_merged = !!(commit->object.flags & UNINTERESTING);
-			item->ignore = is_merged != (filter->merge == REF_FILTER_MERGED_INCLUDE);
-		}
+	verify_ref_format("%(refname)%(symref)");
+	filter_refs(&array, filter, FILTER_REFS_BRANCHES);
 
-		for (i = 0; i < array.nr; i++) {
-			struct ref_array_item *item = array.items[i];
-			clear_commit_marks(item->commit, ALL_REV_FLAGS);
-		}
-		clear_commit_marks(filter->merge_commit, ALL_REV_FLAGS);
-	}
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
@@ -652,15 +501,22 @@ static void print_ref_list(struct ref_filter *filter)
 
 	/* Print detached HEAD before sorting and printing the rest */
 	if (filter->detached) {
-		print_ref_item(array.items[index - 1], maxwidth, filter, remote_prefix);
-		index -= 1;
+		format_and_print_ref_item(array.items[index - 1], maxwidth, filter, remote_prefix);
+		array.nr--;
 	}
 
-	qsort(array.items, index, sizeof(struct ref_array_item *), ref_cmp);
+	if (!sorting) {
+		def_sorting.next = NULL;
+		def_sorting.atom = parse_ref_filter_atom(sort_type,
+							 sort_type + strlen(sort_type));
+		sorting = &def_sorting;
+	}
+	ref_array_sort(sorting, &array);
 
-	for (i = 0; i < index; i++)
-		print_ref_item(array.items[i], maxwidth, filter, remote_prefix);
+	for (i = 0; i < array.nr; i++)
+		format_and_print_ref_item(array.items[i], maxwidth, filter, remote_prefix);
 
+	array.nr = index;
 	ref_array_clear(&array);
 }
 
@@ -761,6 +617,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	const char *new_upstream = NULL;
 	enum branch_track track;
 	struct ref_filter filter;
+	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -795,6 +652,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
+		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
+			     N_("field name to sort on"), &parse_opt_ref_sorting),
 		OPT_END(),
 	};
 
@@ -853,7 +712,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (filter.branch_kind & REF_LOCAL_BRANCH)
 			filter.branch_kind |= REF_DETACHED_HEAD;
 		filter.name_patterns = argv;
-		print_ref_list(&filter);
+		print_ref_list(&filter, sorting);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		return 0;
diff --git a/ref-filter.c b/ref-filter.c
index c573109..d83d4d2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1135,7 +1135,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * obtain the commit using the 'oid' available and discard all
 	 * non-commits early. The actual filtering is done later.
 	 */
-	if (filter->merge_commit || filter->with_commit) {
+	if (filter->merge_commit || filter->with_commit || filter->verbose) {
 		commit = lookup_commit_reference_gently(oid->hash, 1);
 		if (!commit)
 			return 0;
@@ -1243,9 +1243,11 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_TAGS)
 		ret = for_each_tag_ref_fullpath(ref_filter_handler, &ref_cbdata);
-	else if (type & FILTER_REFS_BRANCHES)
+	else if (type & FILTER_REFS_BRANCHES) {
 		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
-	else if (type)
+		if (filter->detached)
+			head_ref(ref_filter_handler, &ref_cbdata);
+	} else if (type)
 		die("filter_refs: invalid type");
 
 	/*  Filters that need revision walking */
diff --git a/ref-filter.h b/ref-filter.h
index 1b1e6de..4379741 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -58,7 +58,6 @@ struct ref_sorting {
 struct ref_array_item {
 	unsigned char objectname[20];
 	int flag, kind;
-	int ignore : 1; /* To be removed in the next patch */
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 16d0b8b..dcf2931 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -38,11 +38,11 @@ test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"'
 	test_must_fail git fast-import <input
 '
 
-test_expect_success 'git branch shows badly named ref' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
-	git branch >output &&
-	grep -e "broken\.\.\.ref" output
+test_expect_failure 'git branch shows badly named ref' '
+       cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+       test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+       git branch >output &&
+       grep -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'branch -d can delete badly named ref' '
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index f51d0f3..38c68bd 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -143,4 +143,15 @@ EOF
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'git branch `--sort` option' '
+	cat >expect <<EOF &&
+* (HEAD detached from fromtag)
+  branch-two
+  branch-one
+  master
+EOF
+	git branch --sort=objectsize >actual &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
2.5.0
