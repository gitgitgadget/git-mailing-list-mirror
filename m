From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v17 12/14] tag.c: use 'ref-filter' APIs
Date: Thu, 10 Sep 2015 21:52:47 +0530
Message-ID: <1441902169-9891-1-git-send-email-Karthik.188@gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 18:23:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za4cd-0004T2-5K
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 18:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbbIJQWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 12:22:44 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34076 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbbIJQWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 12:22:42 -0400
Received: by padhy16 with SMTP id hy16so47250211pad.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cb9EpfO3L75CcDj0f8yznA5OFmoN8Uy9E4GC5JeAqzU=;
        b=ZLAkaiFQDToqkvkfKGiTQ+mxkSm9QY/R3roVz6AQ1CnKWJiZ0LxfnKBaVzlD3edalD
         dfsaWkx4x5r8ia9Af/3SV2r9KV58MYRtjo9zMj2emcW83943aispwHF2h3pY7zB7cIp0
         vsbu3UgwGBVP+cJrL6iJYJiyqnZuwfTZGla1xXuAzHRobiyxZfaYnI212+OTNHi/R9cG
         t50ZrKTgt2WtbwWEdOsjAwN4tDYBuiPI4FkgYs01nz4xq4/2f8bPY355SsEFtlyeWzLO
         enunpNiZsgTxJWMVNqnMm5YtLCla9GlGSyeUygkPJOUObaqt16votyR/Huuo6286Ga3/
         4VqA==
X-Received: by 10.66.139.133 with SMTP id qy5mr75649158pab.44.1441902161302;
        Thu, 10 Sep 2015 09:22:41 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id qp5sm12910843pbc.0.2015.09.10.09.22.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Sep 2015 09:22:40 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277597>

From: Karthik Nayak <karthik.188@gmail.com>

Make 'tag.c' use 'ref-filter' APIs for iterating through refs, sorting
and printing of refs. This removes most of the code used in 'tag.c'
replacing it with calls to the 'ref-filter' library.

Make 'tag.c' use the 'filter_refs()' function provided by 'ref-filter'
to filter out tags based on the options set.

For printing tags we use 'show_ref_array_item()' function provided by
'ref-filter'.

We improve the sorting option provided by 'tag.c' by using the sorting
options provided by 'ref-filter'. This causes the test 'invalid sort
parameter on command line' in t7004 to fail, as 'ref-filter' throws an
error for all sorting fields which are incorrect. The test is changed
to reflect the same.

Modify documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-tag.txt |  16 ++-
 builtin/tag.c             | 345 ++++++----------------------------------------
 t/t7004-tag.sh            |   8 +-
 3 files changed, 53 insertions(+), 316 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 84f6496..3ac4a96 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
-	[--column[=<options>] | --no-column] [--create-reflog] [<pattern>...]
+	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>] [<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -94,14 +94,16 @@ OPTIONS
 	using fnmatch(3)).  Multiple patterns may be given; if any of
 	them matches, the tag is shown.
 
---sort=<type>::
-	Sort in a specific order. Supported type is "refname"
-	(lexicographic order), "version:refname" or "v:refname" (tag
+--sort=<key>::
+	Sort based on the key given.  Prefix `-` to sort in
+	descending order of the value. You may use the --sort=<key> option
+	multiple times, in which case the last key becomes the primary
+	key. Also supports "version:refname" or "v:refname" (tag
 	names are treated as versions). The "version:refname" sort
 	order can also be affected by the
-	"versionsort.prereleaseSuffix" configuration variable. Prepend
-	"-" to reverse sort order. When this option is not given, the
-	sort order defaults to the value configured for the 'tag.sort'
+	"versionsort.prereleaseSuffix" configuration variable.
+	The keys supported are the same as those in `git for-each-ref`.
+	Sort order defaults to the value configured for the 'tag.sort'
 	variable if it exists, or lexicographic order otherwise. See
 	linkgit:git-config[1].
 
diff --git a/builtin/tag.c b/builtin/tag.c
index fe66f7b..f257d45 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -28,278 +28,35 @@ static const char * const git_tag_usage[] = {
 	NULL
 };
 
-#define STRCMP_SORT     0	/* must be zero */
-#define VERCMP_SORT     1
-#define SORT_MASK       0x7fff
-#define REVERSE_SORT    0x8000
-
-static int tag_sort;
-
 static unsigned int colopts;
 
-static int match_pattern(const char **patterns, const char *ref)
-{
-	/* no pattern means match everything */
-	if (!*patterns)
-		return 1;
-	for (; *patterns; patterns++)
-		if (!wildmatch(*patterns, ref, 0, NULL))
-			return 1;
-	return 0;
-}
-
-/*
- * This is currently duplicated in ref-filter.c, and will eventually be
- * removed as we port tag.c to use the ref-filter APIs.
- */
-static const unsigned char *match_points_at(const char *refname,
-					    const unsigned char *sha1,
-					    struct sha1_array *points_at)
-{
-	const unsigned char *tagged_sha1 = NULL;
-	struct object *obj;
-
-	if (sha1_array_lookup(points_at, sha1) >= 0)
-		return sha1;
-	obj = parse_object(sha1);
-	if (!obj)
-		die(_("malformed object at '%s'"), refname);
-	if (obj->type == OBJ_TAG)
-		tagged_sha1 = ((struct tag *)obj)->tagged->sha1;
-	if (tagged_sha1 && sha1_array_lookup(points_at, tagged_sha1) >= 0)
-		return tagged_sha1;
-	return NULL;
-}
-
-static int in_commit_list(const struct commit_list *want, struct commit *c)
-{
-	for (; want; want = want->next)
-		if (!hashcmp(want->item->object.sha1, c->object.sha1))
-			return 1;
-	return 0;
-}
-
-/*
- * The entire code segment for supporting the --contains option has been
- * copied over to ref-filter.{c,h}. This will be deleted evetually when
- * we port tag.c to use ref-filter APIs.
- */
-enum contains_result {
-	CONTAINS_UNKNOWN = -1,
-	CONTAINS_NO = 0,
-	CONTAINS_YES = 1
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
-/*
- * Currently modified and used in ref-filter as append_lines(), will
- * eventually be removed as we port tag.c to use ref-filter APIs.
- */
-static void show_tag_lines(const struct object_id *oid, int lines)
-{
-	int i;
-	unsigned long size;
-	enum object_type type;
-	char *buf, *sp, *eol;
-	size_t len;
-
-	buf = read_sha1_file(oid->hash, &type, &size);
-	if (!buf)
-		die_errno("unable to read object %s", oid_to_hex(oid));
-	if (type != OBJ_COMMIT && type != OBJ_TAG)
-		goto free_return;
-	if (!size)
-		die("an empty %s object %s?",
-		    typename(type), oid_to_hex(oid));
-
-	/* skip header */
-	sp = strstr(buf, "\n\n");
-	if (!sp)
-		goto free_return;
-
-	/* only take up to "lines" lines, and strip the signature from a tag */
-	if (type == OBJ_TAG)
-		size = parse_signature(buf, size);
-	for (i = 0, sp += 2; i < lines && sp < buf + size; i++) {
-		if (i)
-			printf("\n    ");
-		eol = memchr(sp, '\n', size - (sp - buf));
-		len = eol ? eol - sp : size - (sp - buf);
-		fwrite(sp, len, 1, stdout);
-		if (!eol)
-			break;
-		sp = eol + 1;
-	}
-free_return:
-	free(buf);
-}
-
-static void ref_array_append(struct ref_array *array, const char *refname)
-{
-	size_t len = strlen(refname);
-	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
-	memcpy(ref->refname, refname, len);
-	ref->refname[len] = '\0';
-	REALLOC_ARRAY(array->items, array->nr + 1);
-	array->items[array->nr++] = ref;
-}
-
-static int show_reference(const char *refname, const struct object_id *oid,
-			  int flag, void *cb_data)
-{
-	struct ref_filter_cbdata *data = cb_data;
-	struct ref_array *array = data->array;
-	struct ref_filter *filter = data->filter;
-
-	if (match_pattern(filter->name_patterns, refname)) {
-		if (filter->with_commit) {
-			struct commit *commit;
-
-			commit = lookup_commit_reference_gently(oid->hash, 1);
-			if (!commit)
-				return 0;
-			if (!contains(commit, filter->with_commit))
-				return 0;
-		}
-
-		if (filter->points_at.nr && !match_points_at(refname, oid->hash, &filter->points_at))
-			return 0;
-
-		if (!filter->lines) {
-			if (tag_sort)
-				ref_array_append(array, refname);
-			else
-				printf("%s\n", refname);
-			return 0;
-		}
-		printf("%-15s ", refname);
-		show_tag_lines(oid, filter->lines);
-		putchar('\n');
-	}
-
-	return 0;
-}
-
-static int sort_by_version(const void *a_, const void *b_)
-{
-	const struct ref_array_item *a = *((struct ref_array_item **)a_);
-	const struct ref_array_item *b = *((struct ref_array_item **)b_);
-	return versioncmp(a->refname, b->refname);
-}
-
-static int list_tags(struct ref_filter *filter, int sort)
+static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
 {
 	struct ref_array array;
-	struct ref_filter_cbdata data;
+	char *format, *to_free = NULL;
+	int i;
 
 	memset(&array, 0, sizeof(array));
-	data.array = &array;
-	data.filter = filter;
 
 	if (filter->lines == -1)
 		filter->lines = 0;
 
-	for_each_tag_ref(show_reference, &data);
-	if (sort) {
-		int i;
-		if ((sort & SORT_MASK) == VERCMP_SORT)
-			qsort(array.items, array.nr,
-			      sizeof(struct ref_array_item *), sort_by_version);
-		if (sort & REVERSE_SORT)
-			for (i = array.nr - 1; i >= 0; i--)
-				printf("%s\n", array.items[i]->refname);
-		else
-			for (i = 0; i < array.nr; i++)
-				printf("%s\n", array.items[i]->refname);
-		ref_array_clear(&array);
-	}
+	if (filter->lines) {
+		format = xstrfmt("%s %%(contents:lines=%d)",
+				 "%(align:15)%%(refname:short)%%(end)", filter->lines);
+		to_free = format;
+	} else
+		format = "%(refname:short)";
+
+	verify_ref_format(format);
+	filter_refs(&array, filter, FILTER_REFS_TAGS);
+	ref_array_sort(sorting, &array);
+
+	for (i = 0; i < array.nr; i++)
+		show_ref_array_item(array.items[i], format, 0);
+	ref_array_clear(&array);
+	free(to_free);
+
 	return 0;
 }
 
@@ -366,35 +123,26 @@ static const char tag_template_nocleanup[] =
 	"Lines starting with '%c' will be kept; you may remove them"
 	" yourself if you want to.\n");
 
-/*
- * Parse a sort string, and return 0 if parsed successfully. Will return
- * non-zero when the sort string does not parse into a known type. If var is
- * given, the error message becomes a warning and includes information about
- * the configuration value.
- */
-static int parse_sort_string(const char *var, const char *arg, int *sort)
+/* Parse arg given and add it the ref_sorting array */
+static int parse_sorting_string(const char *arg, struct ref_sorting **sorting_tail)
 {
-	int type = 0, flags = 0;
-
-	if (skip_prefix(arg, "-", &arg))
-		flags |= REVERSE_SORT;
+	struct ref_sorting *s;
+	int len;
 
-	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
-		type = VERCMP_SORT;
-	else
-		type = STRCMP_SORT;
+	s = xcalloc(1, sizeof(*s));
+	s->next = *sorting_tail;
+	*sorting_tail = s;
 
-	if (strcmp(arg, "refname")) {
-		if (!var)
-			return error(_("unsupported sort specification '%s'"), arg);
-		else {
-			warning(_("unsupported sort specification '%s' in variable '%s'"),
-				var, arg);
-			return -1;
-		}
+	if (*arg == '-') {
+		s->reverse = 1;
+		arg++;
 	}
+	if (skip_prefix(arg, "version:", &arg) ||
+	    skip_prefix(arg, "v:", &arg))
+		s->version = 1;
 
-	*sort = (type | flags);
+	len = strlen(arg);
+	s->atom = parse_ref_filter_atom(arg, arg+len);
 
 	return 0;
 }
@@ -402,11 +150,12 @@ static int parse_sort_string(const char *var, const char *arg, int *sort)
 static int git_tag_config(const char *var, const char *value, void *cb)
 {
 	int status;
+	struct ref_sorting **sorting_tail = (struct ref_sorting **)cb;
 
 	if (!strcmp(var, "tag.sort")) {
 		if (!value)
 			return config_error_nonbool(var);
-		parse_sort_string(var, value, &tag_sort);
+		parse_sorting_string(value, sorting_tail);
 		return 0;
 	}
 
@@ -564,13 +313,6 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	return check_refname_format(sb->buf, 0);
 }
 
-static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
-{
-	int *sort = opt->value;
-
-	return parse_sort_string(NULL, arg, sort);
-}
-
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -587,6 +329,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
+	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -613,10 +356,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
 		OPT_CONTAINS(&filter.with_commit, N_("print only tags that contain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only tags that contain the commit")),
-		{
-			OPTION_CALLBACK, 0, "sort", &tag_sort, N_("type"), N_("sort tags"),
-			PARSE_OPT_NONEG, parse_opt_sort
-		},
+		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
+			     N_("field name to sort on"), &parse_opt_ref_sorting),
 		{
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_object_name
@@ -624,7 +365,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_tag_config, NULL);
+	git_config(git_tag_config, sorting_tail);
 
 	memset(&opt, 0, sizeof(opt));
 	memset(&filter, 0, sizeof(filter));
@@ -650,6 +391,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			die(_("--column and -n are incompatible"));
 		colopts = 0;
 	}
+	if (!sorting)
+		sorting = ref_default_sorting();
 	if (cmdmode == 'l') {
 		int ret;
 		if (column_active(colopts)) {
@@ -658,10 +401,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			copts.padding = 2;
 			run_column_filter(colopts, &copts);
 		}
-		if (filter.lines != -1 && tag_sort)
-			die(_("--sort and -n are incompatible"));
 		filter.name_patterns = argv;
-		ret = list_tags(&filter, tag_sort);
+		ret = list_tags(&filter, sorting);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index d31788c..84153ef 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1462,13 +1462,7 @@ test_expect_success 'invalid sort parameter on command line' '
 
 test_expect_success 'invalid sort parameter in configuratoin' '
 	git config tag.sort "v:notvalid" &&
-	git tag -l "foo*" >actual &&
-	cat >expect <<-\EOF &&
-	foo1.10
-	foo1.3
-	foo1.6
-	EOF
-	test_cmp expect actual
+	test_must_fail git tag -l "foo*"
 '
 
 test_expect_success 'version sort with prerelease reordering' '
-- 
2.5.1
