Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9EF01F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbcJNOWw (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:22:52 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:53332
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751158AbcJNOWu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ip7+TSgjONNPV1+GNVbraW10T/SEd4u1aEBVGl3aoVI=;
        b=Snx9lkrS0hlT3OQ5iqbL47kBmnCP1M9O7/9gcTckpBKmyobhsdVvyzE8jrSz2B48
        7282ed9GRvbaPl1ECUNp5YdlqM2sXP+q69/co1eNlWYMjW0Gkl8SlEWaOv1u4S/KN0/
        owaHth93+usX81c/1rByAF4ilUHvFlU6bsfhzSpk=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1af0-5d688c2e-868d-4d8c-a8fd-9a675f7f01da-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 15/27] bisect--helper: `bisect_next` and
 `bisect_auto_next` shell function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Oct 2016 14:14:16 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement the `bisect_next` and the `bisect_auto_next` shell function
in C and add the subcommands to `git bisect--helper` to call it from
git-bisect.sh .

Along with this conversion of `bisect_start` has also finished and thus
it has been fully ported to C.

A lot of parts of bisect.c uses exit() and these signals are then
trapped in the `bisect_start` function. Since the shell script ceases
its existence it would be necessary to convert those exit() calls to
return statements so that errors can be reported.

As more and more calls are happening to the subcommands in `git
bisect--helper`, more specifically when `bisect_start $rev` is converted to
`git bisect--helper --bisect-start $rev` it is necessary to dequote the
arguments because of shell to C conversion.

Using `--bisect-next` and `--bisect-auto-start` subcommands is a
temporary measure to port shell function to C so as to use the existing
test suite. As more functions are ported, this subcommand will be
retired and will be called by some other methods.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 bisect.c                 | 128 ++++++++++++++++++++++++--------
 builtin/bisect--helper.c | 189 ++++++++++++++++++++++++++++++++++++++++++++---
 git-bisect.sh            |  74 ++-----------------
 3 files changed, 285 insertions(+), 106 deletions(-)

diff --git a/bisect.c b/bisect.c
index 45d598d..7c97e85 100644
--- a/bisect.c
+++ b/bisect.c
@@ -618,6 +618,12 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 	struct argv_array rev_argv = ARGV_ARRAY_INIT;
 	int i;
 
+	/*
+	 * Since the code is slowly being converted to C, there might be
+	 * instances where the revisions were initialized before. Thus
+	 * we first need to reset it.
+	 */
+	reset_revision_walk();
 	init_revisions(revs, prefix);
 	revs->abbrev = 0;
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
@@ -638,17 +644,22 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 
 static void bisect_common(struct rev_info *revs)
 {
+	/*
+	 * We don't want to clean the bisection state
+	 * as we need to get back to where we started
+	 * by using `git bisect reset`.
+	 */
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 	if (revs->tree_objects)
 		mark_edges_uninteresting(revs, NULL);
 }
 
-static void exit_if_skipped_commits(struct commit_list *tried,
+static int exit_if_skipped_commits(struct commit_list *tried,
 				    const struct object_id *bad)
 {
 	if (!tried)
-		return;
+		return 0;
 
 	printf("There are only 'skip'ped commits left to test.\n"
 	       "The first %s commit could be any of:\n", term_bad);
@@ -659,7 +670,13 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
 	printf(_("We cannot bisect more!\n"));
-	exit(2);
+
+	/*
+	 * We don't want to clean the bisection state
+	 * as we need to get back to where we started
+	 * by using `git bisect reset`.
+	 */
+	return 2;
 }
 
 static int is_expected_rev(const struct object_id *oid)
@@ -700,7 +717,7 @@ static int bisect_checkout(const unsigned char *bisect_rev, int no_checkout)
 		int res;
 		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
 		if (res)
-			exit(res);
+			return res;
 	}
 
 	argv_show_branch[1] = bisect_rev_hex;
@@ -729,7 +746,7 @@ static struct commit **get_bad_and_good_commits(int *rev_nr)
 	return rev;
 }
 
-static void handle_bad_merge_base(void)
+static int handle_bad_merge_base(void)
 {
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
@@ -750,17 +767,23 @@ static void handle_bad_merge_base(void)
 				"between %s and [%s].\n"),
 				bad_hex, term_bad, term_good, bad_hex, good_hex);
 		}
-		exit(3);
+		/*
+		 * We don't want to clean the bisection state
+		 * as we need to get back to where we started
+		 * by using `git bisect reset`.
+		 */
+		return 3;
 	}
 
 	fprintf(stderr, _("Some %s revs are not ancestor of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
 		"Maybe you mistook %s and %s revs?\n"),
 		term_good, term_bad, term_good, term_bad);
-	exit(1);
+	bisect_clean_state();
+	return 1;
 }
 
-static void handle_skipped_merge_base(const unsigned char *mb)
+static int handle_skipped_merge_base(const unsigned char *mb)
 {
 	char *mb_hex = sha1_to_hex(mb);
 	char *bad_hex = oid_to_hex(current_bad_oid);
@@ -773,21 +796,22 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 		"We continue anyway."),
 		bad_hex, good_hex, term_bad, mb_hex, bad_hex);
 	free(good_hex);
+	return 0;
 }
 
 /*
  * "check_merge_bases" checks that merge bases are not "bad" (or "new").
  *
  * - If one is "bad" (or "new"), it means the user assumed something wrong
- * and we must exit with a non 0 error code.
+ * and we must return error with a non 0 error code.
  * - If one is "good" (or "old"), that's good, we have nothing to do.
  * - If one is "skipped", we can't know but we should warn.
  * - If we don't know, we should check it out and ask the user to test.
  */
-static void check_merge_bases(int no_checkout)
+static int check_merge_bases(int no_checkout)
 {
 	struct commit_list *result;
-	int rev_nr;
+	int rev_nr, res = 0;
 	struct commit **rev = get_bad_and_good_commits(&rev_nr);
 
 	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
@@ -795,19 +819,30 @@ static void check_merge_bases(int no_checkout)
 	for (; result; result = result->next) {
 		const unsigned char *mb = result->item->object.oid.hash;
 		if (!hashcmp(mb, current_bad_oid->hash)) {
-			handle_bad_merge_base();
+			res = handle_bad_merge_base();
+			break;
 		} else if (0 <= sha1_array_lookup(&good_revs, mb)) {
 			continue;
 		} else if (0 <= sha1_array_lookup(&skipped_revs, mb)) {
-			handle_skipped_merge_base(mb);
+			res = handle_skipped_merge_base(mb);
+			break;
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
-			exit(bisect_checkout(mb, no_checkout));
+			res = bisect_checkout(mb, no_checkout);
+			/*
+			 * We don't want to clean the bisection state
+			 * as we need to get back to where we started
+			 * by using `git bisect reset`.
+			 */
+			if (!res)
+				exit(0);
+			break;
 		}
 	}
 
 	free(rev);
 	free_commit_list(result);
+	return res;
 }
 
 static int check_ancestors(const char *prefix)
@@ -843,16 +878,21 @@ static int check_ancestors(const char *prefix)
  *
  * If that's not the case, we need to check the merge bases.
  * If a merge base must be tested by the user, its source code will be
- * checked out to be tested by the user and we will exit.
+ * checked out to be tested by the user and we will return.
  */
-static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
+static int check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 {
 	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
 	struct stat st;
-	int fd;
+	int fd, res = 0;
 
+	/*
+	 * We don't want to clean the bisection state
+	 * as we need to get back to where we started
+	 * by using `git bisect reset`.
+	 */
 	if (!current_bad_oid)
-		die(_("a %s revision is needed"), term_bad);
+		error(_("a %s revision is needed"), term_bad);
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -864,7 +904,10 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 
 	/* Check if all good revs are ancestor of the bad rev. */
 	if (check_ancestors(prefix))
-		check_merge_bases(no_checkout);
+		res = check_merge_bases(no_checkout);
+
+	if (res)
+		goto done;
 
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
@@ -873,8 +916,11 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 			      filename);
 	else
 		close(fd);
+
+	goto done;
  done:
 	free(filename);
+	return res;
 }
 
 /*
@@ -933,7 +979,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 }
 
 /*
- * We use the convention that exiting with an exit code 10 means that
+ * We use the convention to return with an return code 10 means that
  * the bisection process finished successfully.
  * In this case the calling shell script should exit 0.
  *
@@ -944,7 +990,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
-	int reaches = 0, all = 0, nr, steps;
+	int reaches = 0, all = 0, nr, steps, res;
 	const unsigned char *bisect_rev;
 	char steps_msg[32];
 
@@ -952,7 +998,9 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	if (read_bisect_refs())
 		die(_("reading bisect refs failed"));
 
-	check_good_are_ancestors_of_bad(prefix, no_checkout);
+	res = check_good_are_ancestors_of_bad(prefix, no_checkout);
+	if (res)
+		return res;
 
 	bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
 	revs.limited = 1;
@@ -964,34 +1012,52 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
+		int res;
 		/*
-		 * We should exit here only if the "bad"
+		 * We should return error here only if the "bad"
 		 * commit is also a "skip" commit.
 		 */
-		exit_if_skipped_commits(tried, NULL);
+		res = exit_if_skipped_commits(tried, NULL);
+		if (res)
+			return res;
 
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
 		       term_bad);
-		exit(1);
+
+		/*
+		 * We don't want to clean the bisection state
+		 * as we need to get back to where we started
+		 * by using `git bisect reset`.
+		 */
+		return 1;
 	}
 
 	if (!all) {
 		fprintf(stderr, _("No testable commit found.\n"
 			"Maybe you started with bad path parameters?\n"));
-		exit(4);
+
+		/*
+		 * We don't want to clean the bisection state
+		 * as we need to get back to where we started
+		 * by using `git bisect reset`.
+		 */
+		return 4;
 	}
 
 	bisect_rev = revs.commits->item->object.oid.hash;
 
 	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
-		exit_if_skipped_commits(tried, current_bad_oid);
+		res = exit_if_skipped_commits(tried, current_bad_oid);
+		if (res)
+			return res;
+
 		printf("%s is the first %s commit\n", sha1_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
-		exit(10);
+		return 10;
 	}
 
 	nr = all - reaches - 1;
@@ -1005,7 +1071,11 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
 
-	return bisect_checkout(bisect_rev, no_checkout);
+	res = bisect_checkout(bisect_rev, no_checkout);
+	if (res)
+		bisect_clean_state();
+
+	return res;
 }
 
 static inline int log2i(int n)
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1d3e17f..fcd7574 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -8,6 +8,7 @@
 #include "run-command.h"
 #include "prompt.h"
 #include "quote.h"
+#include "revision.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -29,6 +30,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
 					      "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
+	N_("git bisect--helper --bisect-next"),
+	N_("git bisect--helper --bisect-auto-next"),
 	NULL
 };
 
@@ -408,6 +411,136 @@ static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
 	return 0;
 }
 
+static int register_good_ref(const char *refname,
+			     const struct object_id *oid, int flags,
+			     void *cb_data)
+{
+	struct string_list *good_refs = cb_data;
+	string_list_append(good_refs, oid_to_hex(oid));
+	return 0;
+}
+
+static int bisect_next(struct bisect_terms *terms, const char *prefix)
+{
+	int res, no_checkout;
+
+	/*
+	 * In case of mistaken revs or checkout error, or signals received,
+	 * "bisect_auto_next" below may exit or misbehave.
+	 * We have to trap this to be able to clean up using
+	 * "bisect_clean_state".
+	 */
+	if (bisect_next_check(terms, terms->term_good))
+		return -1;
+
+	no_checkout = !is_empty_or_missing_file(git_path_bisect_head());
+
+	/* Perform all bisection computation, display and checkout */
+	res = bisect_next_all(prefix , no_checkout);
+
+	if (res == 10) {
+		FILE *fp = NULL;
+		unsigned char sha1[20];
+		struct commit *commit;
+		struct pretty_print_context pp = {0};
+		struct strbuf commit_name = STRBUF_INIT;
+		char *bad_ref = xstrfmt("refs/bisect/%s",
+					      terms->term_bad);
+		int retval = 0;
+
+		read_ref(bad_ref, sha1);
+		commit = lookup_commit_reference(sha1);
+		format_commit_message(commit, "%s", &commit_name, &pp);
+		fp = fopen(git_path_bisect_log(), "a");
+		if (!fp) {
+			retval = -1;
+			goto finish_10;
+		}
+		if (fprintf(fp, "# first %s commit: [%s] %s\n",
+			    terms->term_bad, sha1_to_hex(sha1),
+			    commit_name.buf) < 1){
+			retval = -1;
+			goto finish_10;
+		}
+		goto finish_10;
+	finish_10:
+		if (fp)
+			fclose(fp);
+		strbuf_release(&commit_name);
+		free(bad_ref);
+		return retval;
+	}
+	else if (res == 2) {
+		FILE *fp = NULL;
+		struct rev_info revs;
+		struct argv_array rev_argv = ARGV_ARRAY_INIT;
+		struct string_list good_revs = STRING_LIST_INIT_DUP;
+		struct pretty_print_context pp = {0};
+		struct commit *commit;
+		char *term_good = xstrfmt("%s-*", terms->term_good);
+		int i, retval = 0;
+
+		fp = fopen(git_path_bisect_log(), "a");
+		if (!fp) {
+			retval = -1;
+			goto finish_2;
+		}
+		if (fprintf(fp, "# only skipped commits left to test\n") < 1) {
+			retval = -1;
+			goto finish_2;
+		}
+		for_each_glob_ref_in(register_good_ref, term_good,
+				     "refs/bisect/", (void *) &good_revs);
+
+		argv_array_pushl(&rev_argv, "skipped_commits", "refs/bisect/bad", "--not", NULL);
+		for (i = 0; i < good_revs.nr; i++)
+			argv_array_push(&rev_argv, good_revs.items[i].string);
+
+		/* It is important to reset the flags used by revision walks
+		 * as the previous call to bisect_next_all() in turn
+		 * setups a revision walk.
+		 */
+		reset_revision_walk();
+		init_revisions(&revs, NULL);
+		rev_argv.argc = setup_revisions(rev_argv.argc, rev_argv.argv, &revs, NULL);
+		argv_array_clear(&rev_argv);
+		string_list_clear(&good_revs, 0);
+		if (prepare_revision_walk(&revs))
+			die(_("revision walk setup failed\n"));
+
+		while ((commit = get_revision(&revs)) != NULL) {
+			struct strbuf commit_name = STRBUF_INIT;
+			format_commit_message(commit, "%s",
+					      &commit_name, &pp);
+			fprintf(fp, "# possible first %s commit: "
+				    "[%s] %s\n", terms->term_bad,
+				    oid_to_hex(&commit->object.oid),
+				    commit_name.buf);
+			strbuf_release(&commit_name);
+		}
+		goto finish_2;
+	finish_2:
+		if (fp)
+			fclose(fp);
+		string_list_clear(&good_revs, 0);
+		argv_array_clear(&rev_argv);
+		free(term_good);
+		if (retval)
+			return retval;
+		else
+			return res;
+	}
+	return res;
+}
+
+static int bisect_auto_next(struct bisect_terms *terms, const char *prefix)
+{
+	if (!bisect_next_check(terms, NULL))
+		return bisect_next(terms, prefix);
+
+	return 0;
+}
+
 static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			const char **argv, int argc)
 {
@@ -427,15 +560,24 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		no_checkout = 1;
 
 	for (i = 0; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
+		const char *arg;
+		if (starts_with(argv[i], "'"))
+			arg = sq_dequote(xstrdup(argv[i]));
+		else
+			arg = argv[i];
+		if (!strcmp(arg, "--")) {
 			has_double_dash = 1;
 			break;
 		}
 	}
 
 	for (i = 0; i < argc; i++) {
-		const char *commit_id = xstrfmt("%s^{commit}", argv[i]);
-		const char *arg = argv[i];
+		const char *arg, *commit_id;
+		if (starts_with(argv[i], "'"))
+			arg = sq_dequote(xstrdup(argv[i]));
+		else
+			arg = argv[i];
+		commit_id = xstrfmt("%s^{commit}", arg);
 		if (!strcmp(argv[i], "--")) {
 			has_double_dash = 1;
 			break;
@@ -443,24 +585,31 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			no_checkout = 1;
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
+			if (starts_with(argv[++i], "'"))
+				terms->term_good = sq_dequote(xstrdup(argv[i]));
+			else
+				terms->term_good = xstrdup(argv[i]);
 			must_write_terms = 1;
-			terms->term_good = xstrdup(argv[++i]);
 		} else if (skip_prefix(arg, "--term-good=", &arg)) {
 			must_write_terms = 1;
-			terms->term_good = xstrdup(arg);
+			terms->term_good = arg;
 		} else if (skip_prefix(arg, "--term-old=", &arg)) {
 			must_write_terms = 1;
-			terms->term_good = xstrdup(arg);
+			terms->term_good = arg;
 		} else if (!strcmp(arg, "--term-bad") ||
 			 !strcmp(arg, "--term-new")) {
+			const char *next_arg;
+			if (starts_with(argv[++i], "'"))
+				terms->term_bad = sq_dequote(xstrdup(argv[i]));
+			else
+				terms->term_bad = xstrdup(argv[i]);
 			must_write_terms = 1;
-			terms->term_bad = xstrdup(argv[++i]);
 		} else if (skip_prefix(arg, "--term-bad=", &arg)) {
 			must_write_terms = 1;
-			terms->term_bad = xstrdup(arg);
+			terms->term_bad = arg;
 		} else if (skip_prefix(arg, "--term-new=", &arg)) {
 			must_write_terms = 1;
-			terms->term_good = xstrdup(arg);
+			terms->term_good = arg;
 		} else if (starts_with(arg, "--") &&
 			 !one_of(arg, "--term-good", "--term-bad", NULL)) {
 			die(_("unrecognised option: '%s'"), arg);
@@ -604,7 +753,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	strbuf_release(&start_head);
 	strbuf_release(&bisect_names);
 	strbuf_release(&orig_args);
-	return retval;
+	return retval || bisect_auto_next(terms, NULL);
 }
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
@@ -619,7 +768,9 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
-		BISECT_START
+		BISECT_START,
+		BISECT_NEXT,
+		BISECT_AUTO_NEXT,
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -643,6 +794,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
 			 N_("start the bisect session"), BISECT_START),
+		OPT_CMDMODE(0, "bisect-next", &cmdmode,
+			 N_("find the next bisection commit"), BISECT_NEXT),
+		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
+			 N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -710,6 +865,18 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		terms.term_bad = "bad";
 		res = bisect_start(&terms, no_checkout, argv, argc);
 		break;
+	case BISECT_NEXT:
+		if (argc)
+			die(_("--bisect-next requires 0 arguments"));
+		get_terms(&terms);
+		res = bisect_next(&terms, prefix);
+		break;
+	case BISECT_AUTO_NEXT:
+		if (argc)
+			die(_("--bisect-auto-next requires 0 arguments"));
+		get_terms(&terms);
+		res = bisect_auto_next(&terms, prefix);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index f0896b3..d574c44 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -63,34 +63,13 @@ bisect_autostart() {
 			[Nn]*)
 				exit ;;
 			esac
-			bisect_start
+			git bisect--helper --bisect-start
 		else
 			exit 1
 		fi
 	}
 }
 
-bisect_start() {
-	git bisect--helper --bisect-start $@ || exit
-
-	#
-	# Change state.
-	# In case of mistaken revs or checkout error, or signals received,
-	# "bisect_auto_next" below may exit or misbehave.
-	# We have to trap this to be able to clean up using
-	# "bisect_clean_state".
-	#
-	trap 'git bisect--helper --bisect-clean-state' 0
-	trap 'exit 255' 1 2 3 15
-	#
-	# Check if we can proceed to the next bisect state.
-	#
-	get_terms
-	bisect_auto_next
-
-	trap '-' 0
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -109,6 +88,7 @@ bisect_skip() {
 bisect_state() {
 	bisect_autostart
 	state=$1
+	get_terms
 	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
 	get_terms
 	case "$#,$state" in
@@ -139,45 +119,7 @@ bisect_state() {
 	*)
 		usage ;;
 	esac
-	bisect_auto_next
-}
-
-bisect_auto_next() {
-	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bisect_next || :
-}
-
-bisect_next() {
-	case "$#" in 0) ;; *) usage ;; esac
-	bisect_autostart
-	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD|| exit
-
-	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
-	res=$?
-
-	# Check if we should exit because bisection is finished
-	if test $res -eq 10
-	then
-		bad_rev=$(git show-ref --hash --verify refs/bisect/$TERM_BAD)
-		bad_commit=$(git show-branch $bad_rev)
-		echo "# first $TERM_BAD commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"
-		exit 0
-	elif test $res -eq 2
-	then
-		echo "# only skipped commits left to test" >>"$GIT_DIR/BISECT_LOG"
-		good_revs=$(git for-each-ref --format="%(objectname)" "refs/bisect/$TERM_GOOD-*")
-		for skipped in $(git rev-list refs/bisect/$TERM_BAD --not $good_revs)
-		do
-			skipped_commit=$(git show-branch $skipped)
-			echo "# possible first $TERM_BAD commit: $skipped_commit" >>"$GIT_DIR/BISECT_LOG"
-		done
-		exit $res
-	fi
-
-	# Check for an error in the bisection process
-	test $res -ne 0 && exit $res
-
-	return 0
+	git bisect--helper --bisect-auto-next || exit
 }
 
 bisect_visualize() {
@@ -221,8 +163,7 @@ bisect_replay () {
 		get_terms
 		case "$command" in
 		start)
-			cmd="bisect_start $rev"
-			eval "$cmd" ;;
+			eval "git bisect--helper --bisect-start $rev" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
@@ -231,7 +172,7 @@ bisect_replay () {
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
 	done <"$file"
-	bisect_auto_next
+	git bisect--helper --bisect-auto-next
 }
 
 bisect_run () {
@@ -319,14 +260,15 @@ case "$#" in
 	help)
 		git bisect -h ;;
 	start)
-		bisect_start "$@" ;;
+		git bisect--helper --bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
 		bisect_state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
 	next)
 		# Not sure we want "next" at the UI level anymore.
-		bisect_next "$@" ;;
+		get_terms
+		git bisect--helper --bisect-next "$@" || exit ;;
 	visualize|view)
 		bisect_visualize "$@" ;;
 	reset)

--
https://github.com/git/git/pull/287
