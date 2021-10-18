Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53890C433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 18:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315FF6115A
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 18:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhJRSey (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 14:34:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54254 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhJRSex (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 14:34:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4401814670A;
        Mon, 18 Oct 2021 14:32:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=I
        lT0favYplB3qu0JnJlimAAEJslpjGNoBL0WZLqowxI=; b=t967UHN86j0BpaUwF
        96aFN98gDDyECShCHbWPmixjo4s/+HkA905JvvTSO35BRqJi9PCqRuZdM8ml/hXn
        4P3AUI9oSAQpqX0Jb89366WqM0RNNojsHnhpXeUb3GKvxQ6Smkj5XzHrJ71G1Znx
        LHnXj5B4LWAwit+8JyFrq8L2SM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D467146709;
        Mon, 18 Oct 2021 14:32:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 998E3146708;
        Mon, 18 Oct 2021 14:32:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] for-each-ref: delay parsing of --sort=<atom> options
Date:   Mon, 18 Oct 2021 11:32:38 -0700
Message-ID: <xmqqv91uw5dl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C61CDCCC-3041-11EC-8C04-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The for-each-ref family of commands invoke parsers immediately when
it sees each --sort=<atom> option, and die before even seeing the
other options on the command line when the <atom> is unrecognised.

Instead, accumulate them in a string list, and have them parsed into
a ref_sorting structure after the command line parsing is done.  As
a consequence, "git branch --sort=bogus -h" used to fail to give the
brief help, which arguably may have been a feature, now does so,
which is more consistent with how other options work.

The patch is smaller than the actual extent of the "damage" to the
codebase, thanks to the fact that the original code consistently
used OPT_REF_SORT() macro to handle command line options.  We only
needed to replace the variable used for the list, and implementation
of the callback function used in the macro.

The old rule was for the users of the API to:

 - Declare ref_sorting and ref_sorting_tail variables;

 - OPT_REF_SORT() macro will instantiate ref_sorting instance (which
   may barf and die) and append it to the tail;

 - Append to the tail each ref_sorting read from the configuration
   by parsing in the config callback (which may barf and die);

 - See if ref_sorting is null and use ref_sorting_default() instead.

Now the rule is not all that different but is simpler:

 - Declare ref_sorting_options string list.

 - OPT_REF_SORT() macro will append it to the string list;

 - Append to the string list the sort key read from the
   configuration;

 - call ref_sorting_options() to turn the string list to ref_sorting
   structure (which also deals with the default value).

As side effects, this change also cleans up a few issues:

 - 95be717c (parse_opt_ref_sorting: always use with NONEG flag,
   2019-03-20) muses that "git for-each-ref --no-sort" should simply
   clear the sort keys accumulated so far; it now does.

 - The implementation detail of "struct ref_sorting" and the helper
   function parse_ref_sorting() can now be private to the ref-filter
   API implementation.

 - If you set branch.sort to a bogus value, the any "git branch"
   invocation, not only the listing mode, would abort with the
   original code; now it doesn't

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/branch.c        | 13 ++++++-------
 builtin/for-each-ref.c  |  8 ++++----
 builtin/ls-remote.c     | 13 ++++++++-----
 builtin/tag.c           | 13 ++++++-------
 ref-filter.c            | 34 ++++++++++++++++++++++++----------
 ref-filter.h            | 28 ++++++++++------------------
 t/t3200-branch.sh       | 12 +++++++++++-
 t/t6300-for-each-ref.sh |  5 +++++
 8 files changed, 74 insertions(+), 52 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0b7ed82654..69211f8dd1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -77,12 +77,11 @@ define_list_config_array(color_branch_slots);
 static int git_branch_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
-	struct ref_sorting **sorting_tail = (struct ref_sorting **)cb;
 
 	if (!strcmp(var, "branch.sort")) {
 		if (!value)
 			return config_error_nonbool(var);
-		parse_ref_sorting(sorting_tail, value);
+		string_list_append(cb, value);
 		return 0;
 	}
 
@@ -624,7 +623,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	struct ref_filter filter;
 	int icase = 0;
-	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	static struct ref_sorting *sorting;
+	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
 
 	struct option options[] = {
@@ -665,7 +665,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
-		OPT_REF_SORT(sorting_tail),
+		OPT_REF_SORT(&sorting_options),
 		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), parse_opt_object_name),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
@@ -682,7 +682,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_branch_usage, options);
 
-	git_config(git_branch_config, sorting_tail);
+	git_config(git_branch_config, &sorting_options);
 
 	track = git_branch_track;
 
@@ -748,8 +748,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 * local branches 'refs/heads/...' and finally remote-tracking
 		 * branches 'refs/remotes/...'.
 		 */
-		if (!sorting)
-			sorting = ref_default_sorting();
+		sorting = ref_sorting_options(&sorting_options);
 		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 		ref_sorting_set_sort_flags_all(
 			sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 642b4b888f..75d277ed60 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -17,7 +17,8 @@ static char const * const for_each_ref_usage[] = {
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	struct ref_sorting *sorting;
+	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	int maxcount = 0, icase = 0;
 	struct ref_array array;
 	struct ref_filter filter;
@@ -39,7 +40,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
-		OPT_REF_SORT(sorting_tail),
+		OPT_REF_SORT(&sorting_options),
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
 			     N_("object"), N_("print only refs which points at the given object"),
 			     parse_opt_object_name),
@@ -70,8 +71,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (verify_ref_format(&format))
 		usage_with_options(for_each_ref_usage, opts);
 
-	if (!sorting)
-		sorting = ref_default_sorting();
+	sorting = ref_sorting_options(&sorting_options);
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 318949c3d7..1e6017cdaa 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -54,7 +54,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct transport *transport;
 	const struct ref *ref;
 	struct ref_array ref_array;
-	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print remote URL")),
@@ -68,7 +68,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
-		OPT_REF_SORT(sorting_tail),
+		OPT_REF_SORT(&sorting_options),
 		OPT_SET_INT_F(0, "exit-code", &status,
 			      N_("exit with exit code 2 if no matching refs are found"),
 			      2, PARSE_OPT_NOCOMPLETE),
@@ -86,8 +86,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("ls-remote");
 
-	UNLEAK(sorting);
-
 	if (argc > 1) {
 		int i;
 		CALLOC_ARRAY(pattern, argc);
@@ -139,8 +137,13 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		item->symref = xstrdup_or_null(ref->symref);
 	}
 
-	if (sorting)
+	if (sorting_options.nr) {
+		struct ref_sorting *sorting;
+		UNLEAK(sorting);
+
+		sorting = ref_sorting_options(&sorting_options);
 		ref_array_sort(sorting, &ref_array);
+	}
 
 	for (i = 0; i < ref_array.nr; i++) {
 		const struct ref_array_item *ref = ref_array.items[i];
diff --git a/builtin/tag.c b/builtin/tag.c
index 6535ed27ee..7b03cddd29 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -178,7 +178,6 @@ static const char tag_template_nocleanup[] =
 static int git_tag_config(const char *var, const char *value, void *cb)
 {
 	int status;
-	struct ref_sorting **sorting_tail = (struct ref_sorting **)cb;
 
 	if (!strcmp(var, "tag.gpgsign")) {
 		config_sign_tag = git_config_bool(var, value);
@@ -188,7 +187,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "tag.sort")) {
 		if (!value)
 			return config_error_nonbool(var);
-		parse_ref_sorting(sorting_tail, value);
+		string_list_append(cb, value);
 		return 0;
 	}
 
@@ -436,7 +435,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
-	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	struct ref_sorting *sorting;
+	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
 	int icase = 0;
 	int edit_flag = 0;
@@ -470,7 +470,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_WITHOUT(&filter.no_commit, N_("print only tags that don't contain the commit")),
 		OPT_MERGED(&filter, N_("print only tags that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
-		OPT_REF_SORT(sorting_tail),
+		OPT_REF_SORT(&sorting_options),
 		{
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only tags of the object"), PARSE_OPT_LASTARG_DEFAULT,
@@ -485,7 +485,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	setup_ref_filter_porcelain_msg();
 
-	git_config(git_tag_config, sorting_tail);
+	git_config(git_tag_config, &sorting_options);
 
 	memset(&opt, 0, sizeof(opt));
 	memset(&filter, 0, sizeof(filter));
@@ -524,8 +524,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			die(_("--column and -n are incompatible"));
 		colopts = 0;
 	}
-	if (!sorting)
-		sorting = ref_default_sorting();
+	sorting = ref_sorting_options(&sorting_options);
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 	if (cmdmode == 'l') {
diff --git a/ref-filter.c b/ref-filter.c
index add429be79..fc80abd432 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2470,6 +2470,12 @@ static int memcasecmp(const void *vs1, const void *vs2, size_t n)
 	return 0;
 }
 
+struct ref_sorting {
+	struct ref_sorting *next;
+	int atom; /* index into used_atom array (internal) */
+	enum ref_sorting_order sort_flags;
+};
+
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
@@ -2663,7 +2669,7 @@ static int parse_sorting_atom(const char *atom)
 }
 
 /*  If no sorting option is given, use refname to sort as default */
-struct ref_sorting *ref_default_sorting(void)
+static struct ref_sorting *ref_default_sorting(void)
 {
 	static const char cstr_name[] = "refname";
 
@@ -2674,7 +2680,7 @@ struct ref_sorting *ref_default_sorting(void)
 	return sorting;
 }
 
-void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
+static void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
 {
 	struct ref_sorting *s;
 
@@ -2692,17 +2698,25 @@ void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
 	s->atom = parse_sorting_atom(arg);
 }
 
-int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
+struct ref_sorting *ref_sorting_options(struct string_list *options)
 {
+	struct string_list_item *item;
+	struct ref_sorting *sorting = NULL, **tail = &sorting;
+
+	if (!options->nr) {
+		sorting = ref_default_sorting();
+	} else {
+		for_each_string_list_item(item, options)
+			parse_ref_sorting(tail, item->string);
+	}
+
 	/*
-	 * NEEDSWORK: We should probably clear the list in this case, but we've
-	 * already munged the global used_atoms list, which would need to be
-	 * undone.
+	 * From here on, the ref_sorting list should be used to talk
+	 * about the sort order used for the output.  The caller
+	 * should not touch the string form anymore.
 	 */
-	BUG_ON_OPT_NEG(unset);
-
-	parse_ref_sorting(opt->value, arg);
-	return 0;
+	string_list_clear(options, 0);
+	return sorting;
 }
 
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
diff --git a/ref-filter.h b/ref-filter.h
index b636f4389d..706c90a18f 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -23,16 +23,13 @@
 #define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
 
 struct atom_value;
+struct ref_sorting;
 
-struct ref_sorting {
-	struct ref_sorting *next;
-	int atom; /* index into used_atom array (internal) */
-	enum {
-		REF_SORTING_REVERSE = 1<<0,
-		REF_SORTING_ICASE = 1<<1,
-		REF_SORTING_VERSION = 1<<2,
-		REF_SORTING_DETACHED_HEAD_FIRST = 1<<3,
-	} sort_flags;
+enum ref_sorting_order {
+	REF_SORTING_REVERSE = 1<<0,
+	REF_SORTING_ICASE = 1<<1,
+	REF_SORTING_VERSION = 1<<2,
+	REF_SORTING_DETACHED_HEAD_FIRST = 1<<3,
 };
 
 struct ref_array_item {
@@ -97,9 +94,8 @@ struct ref_format {
 #define OPT_NO_MERGED(f, h) _OPT_MERGED_NO_MERGED("no-merged", f, h)
 
 #define OPT_REF_SORT(var) \
-	OPT_CALLBACK_F(0, "sort", (var), \
-		       N_("key"), N_("field name to sort on"), \
-		       PARSE_OPT_NONEG, parse_opt_ref_sorting)
+	OPT_STRING_LIST(0, "sort", (var), \
+			N_("key"), N_("field name to sort on"))
 
 /*
  * API for filtering a set of refs. Based on the type of refs the user
@@ -121,12 +117,8 @@ int format_ref_array_item(struct ref_array_item *info,
 			  struct ref_format *format,
 			  struct strbuf *final_buf,
 			  struct strbuf *error_buf);
-/*  Parse a single sort specifier and add it to the list */
-void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
-/*  Callback function for parsing the sort option */
-int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
-/*  Default sort option based on refname */
-struct ref_sorting *ref_default_sorting(void);
+/*  Convert list of sort options into ref_sorting */
+struct ref_sorting *ref_sorting_options(struct string_list *);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 /*  Get the current HEAD's description */
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e575ffb4ff..0e23d18807 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1418,7 +1418,17 @@ test_expect_success 'invalid sort parameter in configuration' '
 	(
 		cd sort &&
 		git config branch.sort "v:notvalid" &&
-		test_must_fail git branch
+
+		# this works in the "listing" mode, so bad sort key
+		# is a dying offence.
+		test_must_fail git branch &&
+
+		# these do not need to use sorting, and should all
+		# succeed
+		git branch newone main &&
+		git branch -c newone newerone &&
+		git branch -m newone newestone &&
+		git branch -d newerone newestone
 	)
 '
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 80679d5e12..83921502a4 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -419,6 +419,11 @@ test_expect_success 'Verify descending sort' '
 	test_cmp expected actual
 '
 
+test_expect_success 'Give help even with invalid sort atoms' '
+	test_expect_code 129 git for-each-ref --sort=bogus -h >actual 2>&1 &&
+	grep "^usage: git for-each-ref" actual
+'
+
 cat >expected <<\EOF
 refs/tags/testtag
 refs/tags/testtag-2
-- 
2.33.1-878-gcde26e7e77

