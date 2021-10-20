Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928B9C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B037610A2
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJTN1E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhJTN1A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 09:27:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E40C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 06:24:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g39so14850034wmp.3
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OgSAgl5f34N+81acmtEqcKf6kye+twP0/+MtnJHP0Q4=;
        b=fD9gqJK5DMJTCGn+2vJ4fl4ozKlKjZWu8rHoIxB2aRkgeammJw221w2mL13ihkkklf
         z7G695wME1/U7D8i0pX06bGigKAfAz7FxOFAUuAmf0bHit/dZoAGaPiepNDosr9a6gd0
         Qp52fPlkqlfSlbdYxaB+9OQj2ZnLDbu+mfhxvWoZL2rpG4Z6FNEU5Ujnmt/Iq8QwBSRW
         NbUXhRJH+Z1nP+Rv6jFc8iPYuYMp1o0Xg5+WhhTA80tW32/W2NbizO+ukFOoPQirCoF7
         Nxjzk+g3L0CZ5+QiP5vx0C9WAkdUG8B1YhOggt7Ibp2DacnrAWxSIwXL+D5o1BpD2hxb
         hcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OgSAgl5f34N+81acmtEqcKf6kye+twP0/+MtnJHP0Q4=;
        b=QbH0WZB55mGCcUzLPgXEqrO3OsSnzu7LunBAJN9Q4SMucBWFYNqUkorPEN2NoepcHd
         6A7vRVFH5WIPdiOV31la7HgWL/N23kbJqkdJouQ/8pshAL2EGoXv29vvFWB38NNGC7yY
         XxGUYIceLkBg9CMvCPyMKVJeBG6zVDACN84dtd2o4lx1n2NZ5ta4NxvAlFETtVBgNmRH
         R830Kt1nxdMW0NpKTS/yhH8DvZicR+jNQNQHKniMzrOc9OsZd31sjdiZiqyiCyGOZUDn
         YurhV8ZV0Q57mNa6y+tp79Kll5raRunhmWctgbi9v+sKPpOIESzwH3ShyWgIsnzPCVMm
         LNpg==
X-Gm-Message-State: AOAM530mdhOl+3wwyjFNRUmu8cyO0VLkNKfyYfJHFcy+CDsdej/6Vnq6
        oVqiAvYvA5N/3RNS6iIxtFOc3VAN4dQYqA==
X-Google-Smtp-Source: ABdhPJx+VdVuGansaLevvqeNq2SSYIhpidB5Ez5Ds4umcVUS4GAqaNwL3rqtVKzWt3jk5DrWbepFJw==
X-Received: by 2002:adf:e746:: with SMTP id c6mr51484818wrn.367.1634736284236;
        Wed, 20 Oct 2021 06:24:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k17sm5933351wmj.0.2021.10.20.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:24:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [RFC PATCH v2 3/4] for-each-ref: delay parsing of --sort=<atom> options
Date:   Wed, 20 Oct 2021 15:24:35 +0200
Message-Id: <RFC-patch-v2-3.4-7abbbe4468c-20211020T131627Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
References: <211020.864k9boo0f.gmgdl@evledraar.gmail.com> <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

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
index 0b7ed82654a..69211f8dd1c 100644
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
index 16a2c7d57ca..6f62f40d126 100644
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
index 318949c3d75..44448fa61d1 100644
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
+
+		sorting = ref_sorting_options(&sorting_options);
 		ref_array_sort(sorting, &ref_array);
+		ref_sorting_release(sorting);
+	}
 
 	for (i = 0; i < ref_array.nr; i++) {
 		const struct ref_array_item *ref = ref_array.items[i];
diff --git a/builtin/tag.c b/builtin/tag.c
index 6fe646710d6..41863c5ab77 100644
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
@@ -486,7 +486,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	setup_ref_filter_porcelain_msg();
 
-	git_config(git_tag_config, sorting_tail);
+	git_config(git_tag_config, &sorting_options);
 
 	memset(&opt, 0, sizeof(opt));
 	memset(&filter, 0, sizeof(filter));
@@ -525,8 +525,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
index bdf8b0725df..ec7f30c5d31 100644
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
 
 void ref_sorting_release(struct ref_sorting *sorting)
diff --git a/ref-filter.h b/ref-filter.h
index 6228458d306..b6a317e92c5 100644
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
 /* Release a "struct ref_sorting" */
 void ref_sorting_release(struct ref_sorting *);
 /*  Function to parse --merged and --no-merged options */
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e575ffb4ffb..0e23d18807b 100755
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
index 80679d5e12d..83921502a40 100755
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
2.33.1.1338.g20da966911a

