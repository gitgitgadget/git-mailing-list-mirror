Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAF5C433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22602065E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgG1UZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:25:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:40226 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgG1UZT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:25:19 -0400
Received: (qmail 29750 invoked by uid 109); 28 Jul 2020 20:25:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:25:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28579 invoked by uid 111); 28 Jul 2020 20:25:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:25:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:25:12 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/11] strvec: convert remaining callers away from argv_array
 name
Message-ID: <20200728202512.GG1021513@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We eventually want to drop the argv_array name and just use strvec
consistently. There's no particular reason we have to do it all at once,
or care about interactions between converted and unconverted bits.
Because of our preprocessor compat layer, the names are interchangeable
to the compiler (so even a definition and declaration using different
names is OK).

This patch converts all of the remaining files, as the resulting diff is
reasonably sized.

The conversion was done purely mechanically with:

  git ls-files '*.c' '*.h' |
  xargs perl -i -pe '
    s/ARGV_ARRAY/STRVEC/g;
    s/argv_array/strvec/g;
  '

We'll deal with any indentation/style fallouts separately.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge.c                     |  16 ++--
 midx.c                      |  12 +--
 pager.c                     |   8 +-
 parse-options-cb.c          |   6 +-
 pathspec.c                  |   6 +-
 quote.c                     |   4 +-
 range-diff.c                |  10 +-
 range-diff.h                |   2 +-
 ref-filter.c                |   6 +-
 refs.c                      |   6 +-
 refspec.c                   |   4 +-
 remote-curl.c               |  86 ++++++++---------
 remote-testsvn.c            |   8 +-
 remote.c                    |  12 +--
 revision.c                  |  14 +--
 run-command.c               |  50 +++++-----
 run-command.h               |  10 +-
 send-pack.c                 |  18 ++--
 sequencer.c                 | 112 +++++++++++------------
 serve.c                     |  12 +--
 sha1-file.c                 |  14 +--
 sub-process.c               |   2 +-
 submodule.c                 | 178 ++++++++++++++++++------------------
 t/helper/test-run-command.c |  36 ++++----
 tmp-objdir.c                |  16 ++--
 transport-helper.c          |  30 +++---
 transport-internal.h        |   2 +-
 transport.c                 |  12 +--
 transport.h                 |   2 +-
 unpack-trees.c              |  10 +-
 unpack-trees.h              |   2 +-
 upload-pack.c               |  48 +++++-----
 wt-status.c                 |  16 ++--
 33 files changed, 385 insertions(+), 385 deletions(-)

diff --git a/merge.c b/merge.c
index aa36de2f64..a05b054faa 100644
--- a/merge.c
+++ b/merge.c
@@ -19,22 +19,22 @@ int try_merge_command(struct repository *r,
 		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
 {
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 	int i, ret;
 	struct commit_list *j;
 
-	argv_array_pushf(&args, "merge-%s", strategy);
+	strvec_pushf(&args, "merge-%s", strategy);
 	for (i = 0; i < xopts_nr; i++)
-		argv_array_pushf(&args, "--%s", xopts[i]);
+		strvec_pushf(&args, "--%s", xopts[i]);
 	for (j = common; j; j = j->next)
-		argv_array_push(&args, merge_argument(j->item));
-	argv_array_push(&args, "--");
-	argv_array_push(&args, head_arg);
+		strvec_push(&args, merge_argument(j->item));
+	strvec_push(&args, "--");
+	strvec_push(&args, head_arg);
 	for (j = remotes; j; j = j->next)
-		argv_array_push(&args, merge_argument(j->item));
+		strvec_push(&args, merge_argument(j->item));
 
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
-	argv_array_clear(&args);
+	strvec_clear(&args);
 
 	discard_index(r->index);
 	if (repo_read_index(r) < 0)
diff --git a/midx.c b/midx.c
index 6d1584ca51..a5fb797ede 100644
--- a/midx.c
+++ b/midx.c
@@ -1408,21 +1408,21 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
 	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
 
-	argv_array_push(&cmd.args, "pack-objects");
+	strvec_push(&cmd.args, "pack-objects");
 
 	strbuf_addstr(&base_name, object_dir);
 	strbuf_addstr(&base_name, "/pack/pack");
-	argv_array_push(&cmd.args, base_name.buf);
+	strvec_push(&cmd.args, base_name.buf);
 
 	if (delta_base_offset)
-		argv_array_push(&cmd.args, "--delta-base-offset");
+		strvec_push(&cmd.args, "--delta-base-offset");
 	if (use_delta_islands)
-		argv_array_push(&cmd.args, "--delta-islands");
+		strvec_push(&cmd.args, "--delta-islands");
 
 	if (flags & MIDX_PROGRESS)
-		argv_array_push(&cmd.args, "--progress");
+		strvec_push(&cmd.args, "--progress");
 	else
-		argv_array_push(&cmd.args, "-q");
+		strvec_push(&cmd.args, "-q");
 
 	strbuf_release(&base_name);
 
diff --git a/pager.c b/pager.c
index 41446d4f05..ee435de675 100644
--- a/pager.c
+++ b/pager.c
@@ -68,7 +68,7 @@ const char *git_pager(int stdout_is_tty)
 	return pager;
 }
 
-static void setup_pager_env(struct argv_array *env)
+static void setup_pager_env(struct strvec *env)
 {
 	const char **argv;
 	int i;
@@ -88,7 +88,7 @@ static void setup_pager_env(struct argv_array *env)
 		*cp = '\0';
 		if (!getenv(argv[i])) {
 			*cp = '=';
-			argv_array_push(env, argv[i]);
+			strvec_push(env, argv[i]);
 		}
 	}
 	free(pager_env);
@@ -97,7 +97,7 @@ static void setup_pager_env(struct argv_array *env)
 
 void prepare_pager_args(struct child_process *pager_process, const char *pager)
 {
-	argv_array_push(&pager_process->args, pager);
+	strvec_push(&pager_process->args, pager);
 	pager_process->use_shell = 1;
 	setup_pager_env(&pager_process->env_array);
 	pager_process->trace2_child_class = "pager";
@@ -126,7 +126,7 @@ void setup_pager(void)
 	/* spawn the pager */
 	prepare_pager_args(&pager_process, pager);
 	pager_process.in = -1;
-	argv_array_push(&pager_process.env_array, "GIT_PAGER_IN_USE");
+	strvec_push(&pager_process.env_array, "GIT_PAGER_IN_USE");
 	if (start_command(&pager_process))
 		return;
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 7cba96454c..d9d3b0819f 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -275,19 +275,19 @@ int parse_opt_passthru(const struct option *opt, const char *arg, int unset)
 
 /**
  * For an option opt, recreate the command-line option, appending it to
- * opt->value which must be a argv_array. This is useful when we need to pass
+ * opt->value which must be a strvec. This is useful when we need to pass
  * the command-line option, which can be specified multiple times, to another
  * command.
  */
 int parse_opt_passthru_argv(const struct option *opt, const char *arg, int unset)
 {
 	static struct strbuf sb = STRBUF_INIT;
-	struct argv_array *opt_value = opt->value;
+	struct strvec *opt_value = opt->value;
 
 	if (recreate_opt(&sb, opt, arg, unset) < 0)
 		return -1;
 
-	argv_array_push(opt_value, sb.buf);
+	strvec_push(opt_value, sb.buf);
 
 	return 0;
 }
diff --git a/pathspec.c b/pathspec.c
index 57c9b58418..c303126f37 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -624,7 +624,7 @@ void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
 			 unsigned flags, const char *prefix,
 			 const char *file, int nul_term_line)
 {
-	struct argv_array parsed_file = ARGV_ARRAY_INIT;
+	struct strvec parsed_file = STRVEC_INIT;
 	strbuf_getline_fn getline_fn = nul_term_line ? strbuf_getline_nul :
 						       strbuf_getline;
 	struct strbuf buf = STRBUF_INIT;
@@ -643,7 +643,7 @@ void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
 				die(_("line is badly quoted: %s"), buf.buf);
 			strbuf_swap(&buf, &unquoted);
 		}
-		argv_array_push(&parsed_file, buf.buf);
+		strvec_push(&parsed_file, buf.buf);
 		strbuf_reset(&buf);
 	}
 
@@ -653,7 +653,7 @@ void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
 		fclose(in);
 
 	parse_pathspec(pathspec, magic_mask, flags, prefix, parsed_file.argv);
-	argv_array_clear(&parsed_file);
+	strvec_clear(&parsed_file);
 }
 
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
diff --git a/quote.c b/quote.c
index 10b383cc1d..ced0245e80 100644
--- a/quote.c
+++ b/quote.c
@@ -172,7 +172,7 @@ char *sq_dequote(char *arg)
 
 static int sq_dequote_to_argv_internal(char *arg,
 				       const char ***argv, int *nr, int *alloc,
-				       struct argv_array *array)
+				       struct strvec *array)
 {
 	char *next = arg;
 
@@ -187,7 +187,7 @@ static int sq_dequote_to_argv_internal(char *arg,
 			(*argv)[(*nr)++] = dequoted;
 		}
 		if (array)
-			argv_array_push(array, dequoted);
+			strvec_push(array, dequoted);
 	} while (next);
 
 	return 0;
diff --git a/range-diff.c b/range-diff.c
index b4d1d56445..3a0eb70c89 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -41,7 +41,7 @@ static size_t find_end_of_line(char *buffer, unsigned long size)
  * as struct object_id (will need to be free()d).
  */
 static int read_patches(const char *range, struct string_list *list,
-			const struct argv_array *other_arg)
+			const struct strvec *other_arg)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
@@ -51,7 +51,7 @@ static int read_patches(const char *range, struct string_list *list,
 	int offset, len;
 	size_t size;
 
-	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
+	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 			"--reverse", "--date-order", "--decorate=no",
 			"--no-prefix",
 			/*
@@ -67,8 +67,8 @@ static int read_patches(const char *range, struct string_list *list,
 			"--notes",
 			NULL);
 	if (other_arg)
-		argv_array_pushv(&cp.args, other_arg->argv);
-	argv_array_push(&cp.args, range);
+		strvec_pushv(&cp.args, other_arg->argv);
+	strvec_push(&cp.args, range);
 	cp.out = -1;
 	cp.no_stdin = 1;
 	cp.git_cmd = 1;
@@ -523,7 +523,7 @@ static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
 int show_range_diff(const char *range1, const char *range2,
 		    int creation_factor, int dual_color,
 		    const struct diff_options *diffopt,
-		    const struct argv_array *other_arg)
+		    const struct strvec *other_arg)
 {
 	int res = 0;
 
diff --git a/range-diff.h b/range-diff.h
index 916f18bcd7..583ced2e8e 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -14,6 +14,6 @@
 int show_range_diff(const char *range1, const char *range2,
 		    int creation_factor, int dual_color,
 		    const struct diff_options *diffopt,
-		    const struct argv_array *other_arg);
+		    const struct strvec *other_arg);
 
 #endif
diff --git a/ref-filter.c b/ref-filter.c
index 81c4399da9..7f013851ed 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1914,15 +1914,15 @@ static void find_longest_prefixes_1(struct string_list *out,
 static void find_longest_prefixes(struct string_list *out,
 				  const char **patterns)
 {
-	struct argv_array sorted = ARGV_ARRAY_INIT;
+	struct strvec sorted = STRVEC_INIT;
 	struct strbuf prefix = STRBUF_INIT;
 
-	argv_array_pushv(&sorted, patterns);
+	strvec_pushv(&sorted, patterns);
 	QSORT(sorted.argv, sorted.argc, qsort_strcmp);
 
 	find_longest_prefixes_1(out, &prefix, sorted.argv, sorted.argc);
 
-	argv_array_clear(&sorted);
+	strvec_clear(&sorted);
 	strbuf_release(&prefix);
 }
 
diff --git a/refs.c b/refs.c
index 0067926262..d8d3b10fbd 100644
--- a/refs.c
+++ b/refs.c
@@ -553,13 +553,13 @@ int refname_match(const char *abbrev_name, const char *full_name)
  * Given a 'prefix' expand it by the rules in 'ref_rev_parse_rules' and add
  * the results to 'prefixes'
  */
-void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
+void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
 {
 	const char **p;
 	int len = strlen(prefix);
 
 	for (p = ref_rev_parse_rules; *p; p++)
-		argv_array_pushf(prefixes, *p, len, prefix);
+		strvec_pushf(prefixes, *p, len, prefix);
 }
 
 char *repo_default_branch_name(struct repository *r)
@@ -2037,7 +2037,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 		return ret;
 	}
 
-	argv_array_pushl(&proc.args, hook, state, NULL);
+	strvec_pushl(&proc.args, hook, state, NULL);
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
 	proc.trace2_hook_name = "reference-transaction";
diff --git a/refspec.c b/refspec.c
index f9fb67d295..6f317d6b44 100644
--- a/refspec.c
+++ b/refspec.c
@@ -202,7 +202,7 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
 }
 
 void refspec_ref_prefixes(const struct refspec *rs,
-			  struct argv_array *ref_prefixes)
+			  struct strvec *ref_prefixes)
 {
 	int i;
 	for (i = 0; i < rs->nr; i++) {
@@ -221,7 +221,7 @@ void refspec_ref_prefixes(const struct refspec *rs,
 		if (prefix) {
 			if (item->pattern) {
 				const char *glob = strchr(prefix, '*');
-				argv_array_pushf(ref_prefixes, "%.*s",
+				strvec_pushf(ref_prefixes, "%.*s",
 						 (int)(glob - prefix),
 						 prefix);
 			} else {
diff --git a/remote-curl.c b/remote-curl.c
index 05fb794ddd..85ce4f7e6f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1141,41 +1141,41 @@ static int fetch_git(struct discovery *heads,
 	struct rpc_state rpc;
 	struct strbuf preamble = STRBUF_INIT;
 	int i, err;
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 	struct strbuf rpc_result = STRBUF_INIT;
 
-	argv_array_pushl(&args, "fetch-pack", "--stateless-rpc",
+	strvec_pushl(&args, "fetch-pack", "--stateless-rpc",
 			 "--stdin", "--lock-pack", NULL);
 	if (options.followtags)
-		argv_array_push(&args, "--include-tag");
+		strvec_push(&args, "--include-tag");
 	if (options.thin)
-		argv_array_push(&args, "--thin");
+		strvec_push(&args, "--thin");
 	if (options.verbosity >= 3)
-		argv_array_pushl(&args, "-v", "-v", NULL);
+		strvec_pushl(&args, "-v", "-v", NULL);
 	if (options.check_self_contained_and_connected)
-		argv_array_push(&args, "--check-self-contained-and-connected");
+		strvec_push(&args, "--check-self-contained-and-connected");
 	if (options.cloning)
-		argv_array_push(&args, "--cloning");
+		strvec_push(&args, "--cloning");
 	if (options.update_shallow)
-		argv_array_push(&args, "--update-shallow");
+		strvec_push(&args, "--update-shallow");
 	if (!options.progress)
-		argv_array_push(&args, "--no-progress");
+		strvec_push(&args, "--no-progress");
 	if (options.depth)
-		argv_array_pushf(&args, "--depth=%lu", options.depth);
+		strvec_pushf(&args, "--depth=%lu", options.depth);
 	if (options.deepen_since)
-		argv_array_pushf(&args, "--shallow-since=%s", options.deepen_since);
+		strvec_pushf(&args, "--shallow-since=%s", options.deepen_since);
 	for (i = 0; i < options.deepen_not.nr; i++)
-		argv_array_pushf(&args, "--shallow-exclude=%s",
+		strvec_pushf(&args, "--shallow-exclude=%s",
 				 options.deepen_not.items[i].string);
 	if (options.deepen_relative && options.depth)
-		argv_array_push(&args, "--deepen-relative");
+		strvec_push(&args, "--deepen-relative");
 	if (options.from_promisor)
-		argv_array_push(&args, "--from-promisor");
+		strvec_push(&args, "--from-promisor");
 	if (options.no_dependents)
-		argv_array_push(&args, "--no-dependents");
+		strvec_push(&args, "--no-dependents");
 	if (options.filter)
-		argv_array_pushf(&args, "--filter=%s", options.filter);
-	argv_array_push(&args, url.buf);
+		strvec_pushf(&args, "--filter=%s", options.filter);
+	strvec_push(&args, url.buf);
 
 	for (i = 0; i < nr_heads; i++) {
 		struct ref *ref = to_fetch[i];
@@ -1195,7 +1195,7 @@ static int fetch_git(struct discovery *heads,
 		write_or_die(1, rpc_result.buf, rpc_result.len);
 	strbuf_release(&rpc_result);
 	strbuf_release(&preamble);
-	argv_array_clear(&args);
+	strvec_clear(&args);
 	return err;
 }
 
@@ -1267,15 +1267,15 @@ static int push_dav(int nr_spec, const char **specs)
 	size_t i;
 
 	child.git_cmd = 1;
-	argv_array_push(&child.args, "http-push");
-	argv_array_push(&child.args, "--helper-status");
+	strvec_push(&child.args, "http-push");
+	strvec_push(&child.args, "--helper-status");
 	if (options.dry_run)
-		argv_array_push(&child.args, "--dry-run");
+		strvec_push(&child.args, "--dry-run");
 	if (options.verbosity > 1)
-		argv_array_push(&child.args, "--verbose");
-	argv_array_push(&child.args, url.buf);
+		strvec_push(&child.args, "--verbose");
+	strvec_push(&child.args, url.buf);
 	for (i = 0; i < nr_spec; i++)
-		argv_array_push(&child.args, specs[i]);
+		strvec_push(&child.args, specs[i]);
 
 	if (run_command(&child))
 		die(_("git-http-push failed"));
@@ -1286,38 +1286,38 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 {
 	struct rpc_state rpc;
 	int i, err;
-	struct argv_array args;
+	struct strvec args;
 	struct string_list_item *cas_option;
 	struct strbuf preamble = STRBUF_INIT;
 	struct strbuf rpc_result = STRBUF_INIT;
 
-	argv_array_init(&args);
-	argv_array_pushl(&args, "send-pack", "--stateless-rpc", "--helper-status",
+	strvec_init(&args);
+	strvec_pushl(&args, "send-pack", "--stateless-rpc", "--helper-status",
 			 NULL);
 
 	if (options.thin)
-		argv_array_push(&args, "--thin");
+		strvec_push(&args, "--thin");
 	if (options.dry_run)
-		argv_array_push(&args, "--dry-run");
+		strvec_push(&args, "--dry-run");
 	if (options.push_cert == SEND_PACK_PUSH_CERT_ALWAYS)
-		argv_array_push(&args, "--signed=yes");
+		strvec_push(&args, "--signed=yes");
 	else if (options.push_cert == SEND_PACK_PUSH_CERT_IF_ASKED)
-		argv_array_push(&args, "--signed=if-asked");
+		strvec_push(&args, "--signed=if-asked");
 	if (options.atomic)
-		argv_array_push(&args, "--atomic");
+		strvec_push(&args, "--atomic");
 	if (options.verbosity == 0)
-		argv_array_push(&args, "--quiet");
+		strvec_push(&args, "--quiet");
 	else if (options.verbosity > 1)
-		argv_array_push(&args, "--verbose");
+		strvec_push(&args, "--verbose");
 	for (i = 0; i < options.push_options.nr; i++)
-		argv_array_pushf(&args, "--push-option=%s",
+		strvec_pushf(&args, "--push-option=%s",
 				 options.push_options.items[i].string);
-	argv_array_push(&args, options.progress ? "--progress" : "--no-progress");
+	strvec_push(&args, options.progress ? "--progress" : "--no-progress");
 	for_each_string_list_item(cas_option, &cas_options)
-		argv_array_push(&args, cas_option->string);
-	argv_array_push(&args, url.buf);
+		strvec_push(&args, cas_option->string);
+	strvec_push(&args, url.buf);
 
-	argv_array_push(&args, "--stdin");
+	strvec_push(&args, "--stdin");
 	for (i = 0; i < nr_spec; i++)
 		packet_buf_write(&preamble, "%s\n", specs[i]);
 	packet_buf_flush(&preamble);
@@ -1330,7 +1330,7 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 		write_or_die(1, rpc_result.buf, rpc_result.len);
 	strbuf_release(&rpc_result);
 	strbuf_release(&preamble);
-	argv_array_clear(&args);
+	strvec_clear(&args);
 	return err;
 }
 
@@ -1349,13 +1349,13 @@ static int push(int nr_spec, const char **specs)
 
 static void parse_push(struct strbuf *buf)
 {
-	struct argv_array specs = ARGV_ARRAY_INIT;
+	struct strvec specs = STRVEC_INIT;
 	int ret;
 
 	do {
 		const char *arg;
 		if (skip_prefix(buf->buf, "push ", &arg))
-			argv_array_push(&specs, arg);
+			strvec_push(&specs, arg);
 		else
 			die(_("http transport does not support %s"), buf->buf);
 
@@ -1374,7 +1374,7 @@ static void parse_push(struct strbuf *buf)
 		exit(128); /* error already reported */
 
 free_specs:
-	argv_array_clear(&specs);
+	strvec_clear(&specs);
 }
 
 static int stateless_connect(const char *service_name)
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 809b290d45..636b2b62a6 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -198,10 +198,10 @@ static int cmd_import(const char *line)
 			die_errno("Couldn't open svn dump file %s.", url);
 	} else {
 		svndump_proc.out = -1;
-		argv_array_push(&svndump_proc.args, command);
-		argv_array_push(&svndump_proc.args, "dump");
-		argv_array_push(&svndump_proc.args, url);
-		argv_array_pushf(&svndump_proc.args, "-r%u:HEAD", startrev);
+		strvec_push(&svndump_proc.args, command);
+		strvec_push(&svndump_proc.args, "dump");
+		strvec_push(&svndump_proc.args, url);
+		strvec_pushf(&svndump_proc.args, "-r%u:HEAD", startrev);
 
 		code = start_command(&svndump_proc);
 		if (code)
diff --git a/remote.c b/remote.c
index ba1a386d98..13b097866c 100644
--- a/remote.c
+++ b/remote.c
@@ -1885,7 +1885,7 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	struct object_id oid;
 	struct commit *ours, *theirs;
 	struct rev_info revs;
-	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct strvec argv = STRVEC_INIT;
 
 	/* Cannot stat if what we used to build on no longer exists */
 	if (read_ref(base, &oid))
@@ -1911,12 +1911,12 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 		BUG("stat_branch_pair: invalid abf '%d'", abf);
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
-	argv_array_push(&argv, ""); /* ignored */
-	argv_array_push(&argv, "--left-right");
-	argv_array_pushf(&argv, "%s...%s",
+	strvec_push(&argv, ""); /* ignored */
+	strvec_push(&argv, "--left-right");
+	strvec_pushf(&argv, "%s...%s",
 			 oid_to_hex(&ours->object.oid),
 			 oid_to_hex(&theirs->object.oid));
-	argv_array_push(&argv, "--");
+	strvec_push(&argv, "--");
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	setup_revisions(argv.argc, argv.argv, &revs, NULL);
@@ -1938,7 +1938,7 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	clear_commit_marks(ours, ALL_REV_FLAGS);
 	clear_commit_marks(theirs, ALL_REV_FLAGS);
 
-	argv_array_clear(&argv);
+	strvec_clear(&argv);
 	return 1;
 }
 
diff --git a/revision.c b/revision.c
index 07e16ed44b..e144132ae9 100644
--- a/revision.c
+++ b/revision.c
@@ -2073,14 +2073,14 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 }
 
 static void read_pathspec_from_stdin(struct strbuf *sb,
-				     struct argv_array *prune)
+				     struct strvec *prune)
 {
 	while (strbuf_getline(sb, stdin) != EOF)
-		argv_array_push(prune, sb->buf);
+		strvec_push(prune, sb->buf);
 }
 
 static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct argv_array *prune)
+				      struct strvec *prune)
 {
 	struct strbuf sb;
 	int seen_dashdash = 0;
@@ -2675,7 +2675,7 @@ static void NORETURN diagnose_missing_default(const char *def)
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *opt)
 {
 	int i, flags, left, seen_dashdash, got_rev_arg = 0, revarg_opt;
-	struct argv_array prune_data = ARGV_ARRAY_INIT;
+	struct strvec prune_data = STRVEC_INIT;
 	const char *submodule = NULL;
 	int seen_end_of_options = 0;
 
@@ -2694,7 +2694,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			argv[i] = NULL;
 			argc = i;
 			if (argv[i + 1])
-				argv_array_pushv(&prune_data, argv + i + 1);
+				strvec_pushv(&prune_data, argv + i + 1);
 			seen_dashdash = 1;
 			break;
 		}
@@ -2760,7 +2760,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			for (j = i; j < argc; j++)
 				verify_filename(revs->prefix, argv[j], j == i);
 
-			argv_array_pushv(&prune_data, argv + i);
+			strvec_pushv(&prune_data, argv + i);
 			break;
 		}
 		else
@@ -2785,7 +2785,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		parse_pathspec(&revs->prune_data, 0, 0,
 			       revs->prefix, prune_data.argv);
 	}
-	argv_array_clear(&prune_data);
+	strvec_clear(&prune_data);
 
 	if (revs->def == NULL)
 		revs->def = opt ? opt->def : NULL;
diff --git a/run-command.c b/run-command.c
index 8f57661d96..b9630a1b5f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -11,14 +11,14 @@
 void child_process_init(struct child_process *child)
 {
 	memset(child, 0, sizeof(*child));
-	argv_array_init(&child->args);
-	argv_array_init(&child->env_array);
+	strvec_init(&child->args);
+	strvec_init(&child->env_array);
 }
 
 void child_process_clear(struct child_process *child)
 {
-	argv_array_clear(&child->args);
-	argv_array_clear(&child->env_array);
+	strvec_clear(&child->args);
+	strvec_clear(&child->env_array);
 }
 
 struct child_to_clean {
@@ -263,30 +263,30 @@ int sane_execvp(const char *file, char * const argv[])
 	return -1;
 }
 
-static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
+static const char **prepare_shell_cmd(struct strvec *out, const char **argv)
 {
 	if (!argv[0])
 		BUG("shell command is empty");
 
 	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
 #ifndef GIT_WINDOWS_NATIVE
-		argv_array_push(out, SHELL_PATH);
+		strvec_push(out, SHELL_PATH);
 #else
-		argv_array_push(out, "sh");
+		strvec_push(out, "sh");
 #endif
-		argv_array_push(out, "-c");
+		strvec_push(out, "-c");
 
 		/*
 		 * If we have no extra arguments, we do not even need to
 		 * bother with the "$@" magic.
 		 */
 		if (!argv[1])
-			argv_array_push(out, argv[0]);
+			strvec_push(out, argv[0]);
 		else
-			argv_array_pushf(out, "%s \"$@\"", argv[0]);
+			strvec_pushf(out, "%s \"$@\"", argv[0]);
 	}
 
-	argv_array_pushv(out, argv);
+	strvec_pushv(out, argv);
 	return out->argv;
 }
 
@@ -401,7 +401,7 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 	set_error_routine(old_errfn);
 }
 
-static int prepare_cmd(struct argv_array *out, const struct child_process *cmd)
+static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
 {
 	if (!cmd->argv[0])
 		BUG("command is empty");
@@ -410,14 +410,14 @@ static int prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 	 * Add SHELL_PATH so in the event exec fails with ENOEXEC we can
 	 * attempt to interpret the command with 'sh'.
 	 */
-	argv_array_push(out, SHELL_PATH);
+	strvec_push(out, SHELL_PATH);
 
 	if (cmd->git_cmd) {
 		prepare_git_cmd(out, cmd->argv);
 	} else if (cmd->use_shell) {
 		prepare_shell_cmd(out, cmd->argv);
 	} else {
-		argv_array_pushv(out, cmd->argv);
+		strvec_pushv(out, cmd->argv);
 	}
 
 	/*
@@ -432,7 +432,7 @@ static int prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 			free((char *)out->argv[1]);
 			out->argv[1] = program;
 		} else {
-			argv_array_clear(out);
+			strvec_clear(out);
 			errno = ENOENT;
 			return -1;
 		}
@@ -742,7 +742,7 @@ int start_command(struct child_process *cmd)
 	int notify_pipe[2];
 	int null_fd = -1;
 	char **childenv;
-	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct strvec argv = STRVEC_INIT;
 	struct child_err cerr;
 	struct atfork_state as;
 
@@ -888,7 +888,7 @@ int start_command(struct child_process *cmd)
 
 	if (null_fd >= 0)
 		close(null_fd);
-	argv_array_clear(&argv);
+	strvec_clear(&argv);
 	free(childenv);
 }
 end_of_spawn:
@@ -897,7 +897,7 @@ int start_command(struct child_process *cmd)
 {
 	int fhin = 0, fhout = 1, fherr = 2;
 	const char **sargv = cmd->argv;
-	struct argv_array nargv = ARGV_ARRAY_INIT;
+	struct strvec nargv = STRVEC_INIT;
 
 	if (cmd->no_stdin)
 		fhin = open("/dev/null", O_RDWR);
@@ -935,7 +935,7 @@ int start_command(struct child_process *cmd)
 	if (cmd->clean_on_exit && cmd->pid >= 0)
 		mark_child_for_cleanup(cmd->pid, cmd);
 
-	argv_array_clear(&nargv);
+	strvec_clear(&nargv);
 	cmd->argv = sargv;
 	if (fhin != 0)
 		close(fhin);
@@ -1352,9 +1352,9 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	if (!p)
 		return 0;
 
-	argv_array_push(&hook.args, p);
+	strvec_push(&hook.args, p);
 	while ((p = va_arg(args, const char *)))
-		argv_array_push(&hook.args, p);
+		strvec_push(&hook.args, p);
 	hook.env = env;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
@@ -1868,13 +1868,13 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 
 int run_auto_gc(int quiet)
 {
-	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
+	struct strvec argv_gc_auto = STRVEC_INIT;
 	int status;
 
-	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
+	strvec_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (quiet)
-		argv_array_push(&argv_gc_auto, "--quiet");
+		strvec_push(&argv_gc_auto, "--quiet");
 	status = run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
-	argv_array_clear(&argv_gc_auto);
+	strvec_clear(&argv_gc_auto);
 	return status;
 }
diff --git a/run-command.h b/run-command.h
index f5e05d38d2..8b9bfaef16 100644
--- a/run-command.h
+++ b/run-command.h
@@ -52,15 +52,15 @@ struct child_process {
 	 * Note that the ownership of the memory pointed to by .argv stays with the
 	 * caller, but it should survive until `finish_command` completes. If the
 	 * .argv member is NULL, `start_command` will point it at the .args
-	 * `argv_array` (so you may use one or the other, but you must use exactly
+	 * `strvec` (so you may use one or the other, but you must use exactly
 	 * one). The memory in .args will be cleaned up automatically during
 	 * `finish_command` (or during `start_command` when it is unsuccessful).
 	 *
 	 */
 	const char **argv;
 
-	struct argv_array args;
-	struct argv_array env_array;
+	struct strvec args;
+	struct strvec env_array;
 	pid_t pid;
 
 	int trace2_child_id;
@@ -107,7 +107,7 @@ struct child_process {
 	 *   variable that will be removed from the child process's environment.
 	 *
 	 * If the .env member is NULL, `start_command` will point it at the
-	 * .env_array `argv_array` (so you may use one or the other, but not both).
+	 * .env_array `strvec` (so you may use one or the other, but not both).
 	 * The memory in .env_array will be cleaned up automatically during
 	 * `finish_command` (or during `start_command` when it is unsuccessful).
 	 */
@@ -134,7 +134,7 @@ struct child_process {
 	void *clean_on_exit_handler_cbdata;
 };
 
-#define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
+#define CHILD_PROCESS_INIT { NULL, STRVEC_INIT, STRVEC_INIT }
 
 /**
  * The functions: child_process_init, start_command, finish_command,
diff --git a/send-pack.c b/send-pack.c
index d671ab5d05..632f1580ca 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -68,20 +68,20 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
 	int i;
 	int rc;
 
-	argv_array_push(&po.args, "pack-objects");
-	argv_array_push(&po.args, "--all-progress-implied");
-	argv_array_push(&po.args, "--revs");
-	argv_array_push(&po.args, "--stdout");
+	strvec_push(&po.args, "pack-objects");
+	strvec_push(&po.args, "--all-progress-implied");
+	strvec_push(&po.args, "--revs");
+	strvec_push(&po.args, "--stdout");
 	if (args->use_thin_pack)
-		argv_array_push(&po.args, "--thin");
+		strvec_push(&po.args, "--thin");
 	if (args->use_ofs_delta)
-		argv_array_push(&po.args, "--delta-base-offset");
+		strvec_push(&po.args, "--delta-base-offset");
 	if (args->quiet || !args->progress)
-		argv_array_push(&po.args, "-q");
+		strvec_push(&po.args, "-q");
 	if (args->progress)
-		argv_array_push(&po.args, "--progress");
+		strvec_push(&po.args, "--progress");
 	if (is_repository_shallow(the_repository))
-		argv_array_push(&po.args, "--shallow");
+		strvec_push(&po.args, "--shallow");
 	po.in = -1;
 	po.out = args->stateless_rpc ? -1 : fd;
 	po.git_cmd = 1;
diff --git a/sequencer.c b/sequencer.c
index 9e7f868b00..80c770968a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -830,20 +830,20 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 
 /*
  * Read a GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL AND GIT_AUTHOR_DATE from a
- * file with shell quoting into struct argv_array. Returns -1 on
+ * file with shell quoting into struct strvec. Returns -1 on
  * error, 0 otherwise.
  */
-static int read_env_script(struct argv_array *env)
+static int read_env_script(struct strvec *env)
 {
 	char *name, *email, *date;
 
 	if (read_author_script(rebase_path_author_script(),
 			       &name, &email, &date, 0))
 		return -1;
 
-	argv_array_pushf(env, "GIT_AUTHOR_NAME=%s", name);
-	argv_array_pushf(env, "GIT_AUTHOR_EMAIL=%s", email);
-	argv_array_pushf(env, "GIT_AUTHOR_DATE=%s", date);
+	strvec_pushf(env, "GIT_AUTHOR_NAME=%s", name);
+	strvec_pushf(env, "GIT_AUTHOR_EMAIL=%s", email);
+	strvec_pushf(env, "GIT_AUTHOR_DATE=%s", date);
 	free(name);
 	free(email);
 	free(date);
@@ -929,34 +929,34 @@ static int run_git_commit(struct repository *r,
 			     gpg_opt, gpg_opt);
 	}
 
-	argv_array_push(&cmd.args, "commit");
+	strvec_push(&cmd.args, "commit");
 
 	if (!(flags & VERIFY_MSG))
-		argv_array_push(&cmd.args, "-n");
+		strvec_push(&cmd.args, "-n");
 	if ((flags & AMEND_MSG))
-		argv_array_push(&cmd.args, "--amend");
+		strvec_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
-		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
+		strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
 	else
-		argv_array_push(&cmd.args, "--no-gpg-sign");
+		strvec_push(&cmd.args, "--no-gpg-sign");
 	if (defmsg)
-		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
+		strvec_pushl(&cmd.args, "-F", defmsg, NULL);
 	else if (!(flags & EDIT_MSG))
-		argv_array_pushl(&cmd.args, "-C", "HEAD", NULL);
+		strvec_pushl(&cmd.args, "-C", "HEAD", NULL);
 	if ((flags & CLEANUP_MSG))
-		argv_array_push(&cmd.args, "--cleanup=strip");
+		strvec_push(&cmd.args, "--cleanup=strip");
 	if ((flags & EDIT_MSG))
-		argv_array_push(&cmd.args, "-e");
+		strvec_push(&cmd.args, "-e");
 	else if (!(flags & CLEANUP_MSG) &&
 		 !opts->signoff && !opts->record_origin &&
 		 !opts->explicit_cleanup)
-		argv_array_push(&cmd.args, "--cleanup=verbatim");
+		strvec_push(&cmd.args, "--cleanup=verbatim");
 
 	if ((flags & ALLOW_EMPTY))
-		argv_array_push(&cmd.args, "--allow-empty");
+		strvec_push(&cmd.args, "--allow-empty");
 
 	if (!(flags & EDIT_MSG))
-		argv_array_push(&cmd.args, "--allow-empty-message");
+		strvec_push(&cmd.args, "--allow-empty-message");
 
 	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
 		return run_command_silent_on_success(&cmd);
@@ -2754,15 +2754,15 @@ static int rollback_is_safe(void)
 static int reset_merge(const struct object_id *oid)
 {
 	int ret;
-	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct strvec argv = STRVEC_INIT;
 
-	argv_array_pushl(&argv, "reset", "--merge", NULL);
+	strvec_pushl(&argv, "reset", "--merge", NULL);
 
 	if (!is_null_oid(oid))
-		argv_array_push(&argv, oid_to_hex(oid));
+		strvec_push(&argv, oid_to_hex(oid));
 
 	ret = run_command_v_opt(argv.argv, RUN_GIT_CMD);
-	argv_array_clear(&argv);
+	strvec_clear(&argv);
 
 	return ret;
 }
@@ -3125,14 +3125,14 @@ static int error_failed_squash(struct repository *r,
 
 static int do_exec(struct repository *r, const char *command_line)
 {
-	struct argv_array child_env = ARGV_ARRAY_INIT;
+	struct strvec child_env = STRVEC_INIT;
 	const char *child_argv[] = { NULL, NULL };
 	int dirty, status;
 
 	fprintf(stderr, _("Executing: %s\n"), command_line);
 	child_argv[0] = command_line;
-	argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
-	argv_array_pushf(&child_env, "GIT_WORK_TREE=%s",
+	strvec_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
+	strvec_pushf(&child_env, "GIT_WORK_TREE=%s",
 			 absolute_path(get_git_work_tree()));
 	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
 					  child_env.argv);
@@ -3165,7 +3165,7 @@ static int do_exec(struct repository *r, const char *command_line)
 		status = 1;
 	}
 
-	argv_array_clear(&child_env);
+	strvec_clear(&child_env);
 
 	return status;
 }
@@ -3544,28 +3544,28 @@ static int do_merge(struct repository *r,
 		}
 
 		cmd.git_cmd = 1;
-		argv_array_push(&cmd.args, "merge");
-		argv_array_push(&cmd.args, "-s");
+		strvec_push(&cmd.args, "merge");
+		strvec_push(&cmd.args, "-s");
 		if (!strategy)
-			argv_array_push(&cmd.args, "octopus");
+			strvec_push(&cmd.args, "octopus");
 		else {
-			argv_array_push(&cmd.args, strategy);
+			strvec_push(&cmd.args, strategy);
 			for (k = 0; k < opts->xopts_nr; k++)
-				argv_array_pushf(&cmd.args,
+				strvec_pushf(&cmd.args,
 						 "-X%s", opts->xopts[k]);
 		}
-		argv_array_push(&cmd.args, "--no-edit");
-		argv_array_push(&cmd.args, "--no-ff");
-		argv_array_push(&cmd.args, "--no-log");
-		argv_array_push(&cmd.args, "--no-stat");
-		argv_array_push(&cmd.args, "-F");
-		argv_array_push(&cmd.args, git_path_merge_msg(r));
+		strvec_push(&cmd.args, "--no-edit");
+		strvec_push(&cmd.args, "--no-ff");
+		strvec_push(&cmd.args, "--no-log");
+		strvec_push(&cmd.args, "--no-stat");
+		strvec_push(&cmd.args, "-F");
+		strvec_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
-			argv_array_push(&cmd.args, opts->gpg_sign);
+			strvec_push(&cmd.args, opts->gpg_sign);
 
 		/* Add the tips to be merged */
 		for (j = to_merge; j; j = j->next)
-			argv_array_push(&cmd.args,
+			strvec_push(&cmd.args,
 					oid_to_hex(&j->item->object.oid));
 
 		strbuf_release(&ref_name);
@@ -3694,7 +3694,7 @@ void create_autostash(struct repository *r, const char *path,
 		struct child_process stash = CHILD_PROCESS_INIT;
 		struct object_id oid;
 
-		argv_array_pushl(&stash.args,
+		strvec_pushl(&stash.args,
 				 "stash", "create", "autostash", NULL);
 		stash.git_cmd = 1;
 		stash.no_stdin = 1;
@@ -3734,9 +3734,9 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		child.git_cmd = 1;
 		child.no_stdout = 1;
 		child.no_stderr = 1;
-		argv_array_push(&child.args, "stash");
-		argv_array_push(&child.args, "apply");
-		argv_array_push(&child.args, stash_oid);
+		strvec_push(&child.args, "stash");
+		strvec_push(&child.args, "apply");
+		strvec_push(&child.args, stash_oid);
 		ret = run_command(&child);
 	}
 
@@ -3746,12 +3746,12 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		struct child_process store = CHILD_PROCESS_INIT;
 
 		store.git_cmd = 1;
-		argv_array_push(&store.args, "stash");
-		argv_array_push(&store.args, "store");
-		argv_array_push(&store.args, "-m");
-		argv_array_push(&store.args, "autostash");
-		argv_array_push(&store.args, "-q");
-		argv_array_push(&store.args, stash_oid);
+		strvec_push(&store.args, "stash");
+		strvec_push(&store.args, "store");
+		strvec_push(&store.args, "-m");
+		strvec_push(&store.args, "autostash");
+		strvec_push(&store.args, "-q");
+		strvec_push(&store.args, stash_oid);
 		if (run_command(&store))
 			ret = error(_("cannot store %s"), stash_oid);
 		else
@@ -3831,9 +3831,9 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
 
 	cmd.git_cmd = 1;
 
-	argv_array_push(&cmd.args, "checkout");
-	argv_array_push(&cmd.args, commit);
-	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
+	strvec_push(&cmd.args, "checkout");
+	strvec_push(&cmd.args, commit);
+	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
 
 	if (opts->verbose)
 		ret = run_command(&cmd);
@@ -4157,9 +4157,9 @@ static int pick_commits(struct repository *r,
 
 			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			child.git_cmd = 1;
-			argv_array_push(&child.args, "notes");
-			argv_array_push(&child.args, "copy");
-			argv_array_push(&child.args, "--for-rewrite=rebase");
+			strvec_push(&child.args, "notes");
+			strvec_push(&child.args, "copy");
+			strvec_push(&child.args, "--for-rewrite=rebase");
 			/* we don't care if this copying failed */
 			run_command(&child);
 
@@ -4170,8 +4170,8 @@ static int pick_commits(struct repository *r,
 					O_RDONLY);
 				hook.stdout_to_stderr = 1;
 				hook.trace2_hook_name = "post-rewrite";
-				argv_array_push(&hook.args, post_rewrite_hook);
-				argv_array_push(&hook.args, "rebase");
+				strvec_push(&hook.args, post_rewrite_hook);
+				strvec_push(&hook.args, "rebase");
 				/* we don't care if this hook failed */
 				run_command(&hook);
 			}
diff --git a/serve.c b/serve.c
index 8d9a345b3d..523a9be32d 100644
--- a/serve.c
+++ b/serve.c
@@ -56,7 +56,7 @@ struct protocol_capability {
 	 * This field should be NULL for capabilities which are not commands.
 	 */
 	int (*command)(struct repository *r,
-		       struct argv_array *keys,
+		       struct strvec *keys,
 		       struct packet_reader *request);
 };
 
@@ -142,7 +142,7 @@ static int is_command(const char *key, struct protocol_capability **command)
 	return 0;
 }
 
-int has_capability(const struct argv_array *keys, const char *capability,
+int has_capability(const struct strvec *keys, const char *capability,
 		   const char **value)
 {
 	int i;
@@ -162,7 +162,7 @@ int has_capability(const struct argv_array *keys, const char *capability,
 	return 0;
 }
 
-static void check_algorithm(struct repository *r, struct argv_array *keys)
+static void check_algorithm(struct repository *r, struct strvec *keys)
 {
 	int client = GIT_HASH_SHA1, server = hash_algo_by_ptr(r->hash_algo);
 	const char *algo_name;
@@ -187,7 +187,7 @@ static int process_request(void)
 {
 	enum request_state state = PROCESS_REQUEST_KEYS;
 	struct packet_reader reader;
-	struct argv_array keys = ARGV_ARRAY_INIT;
+	struct strvec keys = STRVEC_INIT;
 	struct protocol_capability *command = NULL;
 
 	packet_reader_init(&reader, 0, NULL, 0,
@@ -211,7 +211,7 @@ static int process_request(void)
 			/* collect request; a sequence of keys and values */
 			if (is_command(reader.line, &command) ||
 			    is_valid_capability(reader.line))
-				argv_array_push(&keys, reader.line);
+				strvec_push(&keys, reader.line);
 			else
 				die("unknown capability '%s'", reader.line);
 
@@ -254,7 +254,7 @@ static int process_request(void)
 
 	command->command(the_repository, &keys, &reader);
 
-	argv_array_clear(&keys);
+	strvec_clear(&keys);
 	return 0;
 }
 
diff --git a/sha1-file.c b/sha1-file.c
index ccd34dd9e8..a7f7a14898 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -763,18 +763,18 @@ static void fill_alternate_refs_command(struct child_process *cmd,
 	if (!git_config_get_value("core.alternateRefsCommand", &value)) {
 		cmd->use_shell = 1;
 
-		argv_array_push(&cmd->args, value);
-		argv_array_push(&cmd->args, repo_path);
+		strvec_push(&cmd->args, value);
+		strvec_push(&cmd->args, repo_path);
 	} else {
 		cmd->git_cmd = 1;
 
-		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
-		argv_array_push(&cmd->args, "for-each-ref");
-		argv_array_push(&cmd->args, "--format=%(objectname)");
+		strvec_pushf(&cmd->args, "--git-dir=%s", repo_path);
+		strvec_push(&cmd->args, "for-each-ref");
+		strvec_push(&cmd->args, "--format=%(objectname)");
 
 		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
-			argv_array_push(&cmd->args, "--");
-			argv_array_split(&cmd->args, value);
+			strvec_push(&cmd->args, "--");
+			strvec_split(&cmd->args, value);
 		}
 	}
 
diff --git a/sub-process.c b/sub-process.c
index 1b1af9dcbd..dfa790d3ff 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -84,7 +84,7 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 	process = &entry->process;
 
 	child_process_init(process);
-	argv_array_push(&process->args, cmd);
+	strvec_push(&process->args, cmd);
 	process->use_shell = 1;
 	process->in = -1;
 	process->out = -1;
diff --git a/submodule.c b/submodule.c
index 874db5c4b2..5c9447422d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -262,17 +262,17 @@ int is_submodule_active(struct repository *repo, const char *path)
 	sl = repo_config_get_value_multi(repo, "submodule.active");
 	if (sl) {
 		struct pathspec ps;
-		struct argv_array args = ARGV_ARRAY_INIT;
+		struct strvec args = STRVEC_INIT;
 		const struct string_list_item *item;
 
 		for_each_string_list_item(item, sl) {
-			argv_array_push(&args, item->string);
+			strvec_push(&args, item->string);
 		}
 
 		parse_pathspec(&ps, 0, 0, NULL, args.argv);
 		ret = match_pathspec(repo->index, &ps, path, strlen(path), 0, NULL, 1);
 
-		argv_array_clear(&args);
+		strvec_clear(&args);
 		clear_pathspec(&ps);
 		return ret;
 	}
@@ -481,27 +481,27 @@ static void print_submodule_summary(struct repository *r, struct rev_info *rev,
 	strbuf_release(&sb);
 }
 
-static void prepare_submodule_repo_env_no_git_dir(struct argv_array *out)
+static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
 {
 	const char * const *var;
 
 	for (var = local_repo_env; *var; var++) {
 		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
-			argv_array_push(out, *var);
+			strvec_push(out, *var);
 	}
 }
 
-void prepare_submodule_repo_env(struct argv_array *out)
+void prepare_submodule_repo_env(struct strvec *out)
 {
 	prepare_submodule_repo_env_no_git_dir(out);
-	argv_array_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
+	strvec_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
-static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
+static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
 {
 	prepare_submodule_repo_env_no_git_dir(out);
-	argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
+	strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
 }
 
 /*
@@ -681,30 +681,30 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	cp.no_stdin = 1;
 
 	/* TODO: other options may need to be passed here. */
-	argv_array_pushl(&cp.args, "diff", "--submodule=diff", NULL);
-	argv_array_pushf(&cp.args, "--color=%s", want_color(o->use_color) ?
+	strvec_pushl(&cp.args, "diff", "--submodule=diff", NULL);
+	strvec_pushf(&cp.args, "--color=%s", want_color(o->use_color) ?
 			 "always" : "never");
 
 	if (o->flags.reverse_diff) {
-		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
+		strvec_pushf(&cp.args, "--src-prefix=%s%s/",
 				 o->b_prefix, path);
-		argv_array_pushf(&cp.args, "--dst-prefix=%s%s/",
+		strvec_pushf(&cp.args, "--dst-prefix=%s%s/",
 				 o->a_prefix, path);
 	} else {
-		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
+		strvec_pushf(&cp.args, "--src-prefix=%s%s/",
 				 o->a_prefix, path);
-		argv_array_pushf(&cp.args, "--dst-prefix=%s%s/",
+		strvec_pushf(&cp.args, "--dst-prefix=%s%s/",
 				 o->b_prefix, path);
 	}
-	argv_array_push(&cp.args, oid_to_hex(old_oid));
+	strvec_push(&cp.args, oid_to_hex(old_oid));
 	/*
 	 * If the submodule has modified content, we will diff against the
 	 * work tree, under the assumption that the user has asked for the
 	 * diff format and wishes to actually see all differences even if they
 	 * haven't yet been committed to the submodule yet.
 	 */
 	if (!(dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
-		argv_array_push(&cp.args, oid_to_hex(new_oid));
+		strvec_push(&cp.args, oid_to_hex(new_oid));
 
 	prepare_submodule_repo_env(&cp.env_array);
 	if (start_command(&cp))
@@ -836,7 +836,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
  */
 static void collect_changed_submodules(struct repository *r,
 				       struct string_list *changed,
-				       struct argv_array *argv)
+				       struct strvec *argv)
 {
 	struct rev_info rev;
 	const struct commit *commit;
@@ -879,8 +879,8 @@ static int has_remote(const char *refname, const struct object_id *oid,
 
 static int append_oid_to_argv(const struct object_id *oid, void *data)
 {
-	struct argv_array *argv = data;
-	argv_array_push(argv, oid_to_hex(oid));
+	struct strvec *argv = data;
+	strvec_push(argv, oid_to_hex(oid));
 	return 0;
 }
 
@@ -941,9 +941,9 @@ static int submodule_has_commits(struct repository *r,
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct strbuf out = STRBUF_INIT;
 
-		argv_array_pushl(&cp.args, "rev-list", "-n", "1", NULL);
+		strvec_pushl(&cp.args, "rev-list", "-n", "1", NULL);
 		oid_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
-		argv_array_pushl(&cp.args, "--not", "--all", NULL);
+		strvec_pushl(&cp.args, "--not", "--all", NULL);
 
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
@@ -982,9 +982,9 @@ static int submodule_needs_pushing(struct repository *r,
 		struct strbuf buf = STRBUF_INIT;
 		int needs_pushing = 0;
 
-		argv_array_push(&cp.args, "rev-list");
+		strvec_push(&cp.args, "rev-list");
 		oid_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
-		argv_array_pushl(&cp.args, "--not", "--remotes", "-n", "1" , NULL);
+		strvec_pushl(&cp.args, "--not", "--remotes", "-n", "1" , NULL);
 
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
@@ -1012,13 +1012,13 @@ int find_unpushed_submodules(struct repository *r,
 {
 	struct string_list submodules = STRING_LIST_INIT_DUP;
 	struct string_list_item *name;
-	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct strvec argv = STRVEC_INIT;
 
 	/* argv.argv[0] will be ignored by setup_revisions */
-	argv_array_push(&argv, "find_unpushed_submodules");
+	strvec_push(&argv, "find_unpushed_submodules");
 	oid_array_for_each_unique(commits, append_oid_to_argv, &argv);
-	argv_array_push(&argv, "--not");
-	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
+	strvec_push(&argv, "--not");
+	strvec_pushf(&argv, "--remotes=%s", remotes_name);
 
 	collect_changed_submodules(r, &submodules, &argv);
 
@@ -1041,7 +1041,7 @@ int find_unpushed_submodules(struct repository *r,
 	}
 
 	free_submodules_oids(&submodules);
-	argv_array_clear(&argv);
+	strvec_clear(&argv);
 
 	return needs_pushing->nr;
 }
@@ -1054,22 +1054,22 @@ static int push_submodule(const char *path,
 {
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
-		argv_array_push(&cp.args, "push");
+		strvec_push(&cp.args, "push");
 		if (dry_run)
-			argv_array_push(&cp.args, "--dry-run");
+			strvec_push(&cp.args, "--dry-run");
 
 		if (push_options && push_options->nr) {
 			const struct string_list_item *item;
 			for_each_string_list_item(item, push_options)
-				argv_array_pushf(&cp.args, "--push-option=%s",
+				strvec_pushf(&cp.args, "--push-option=%s",
 						 item->string);
 		}
 
 		if (remote->origin != REMOTE_UNCONFIGURED) {
 			int i;
-			argv_array_push(&cp.args, remote->name);
+			strvec_push(&cp.args, remote->name);
 			for (i = 0; i < rs->raw_nr; i++)
-				argv_array_push(&cp.args, rs->raw[i]);
+				strvec_push(&cp.args, rs->raw[i]);
 		}
 
 		prepare_submodule_repo_env(&cp.env_array);
@@ -1095,13 +1095,13 @@ static void submodule_push_check(const char *path, const char *head,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int i;
 
-	argv_array_push(&cp.args, "submodule--helper");
-	argv_array_push(&cp.args, "push-check");
-	argv_array_push(&cp.args, head);
-	argv_array_push(&cp.args, remote->name);
+	strvec_push(&cp.args, "submodule--helper");
+	strvec_push(&cp.args, "push-check");
+	strvec_push(&cp.args, head);
+	strvec_push(&cp.args, remote->name);
 
 	for (i = 0; i < rs->raw_nr; i++)
-		argv_array_push(&cp.args, rs->raw[i]);
+		strvec_push(&cp.args, rs->raw[i]);
 
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
@@ -1189,17 +1189,17 @@ void check_for_new_submodule_commits(struct object_id *oid)
 static void calculate_changed_submodule_paths(struct repository *r,
 		struct string_list *changed_submodule_names)
 {
-	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct strvec argv = STRVEC_INIT;
 	struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(r, NULL, NULL))
 		return;
 
-	argv_array_push(&argv, "--"); /* argv[0] program name */
+	strvec_push(&argv, "--"); /* argv[0] program name */
 	oid_array_for_each_unique(&ref_tips_after_fetch,
 				   append_oid_to_argv, &argv);
-	argv_array_push(&argv, "--not");
+	strvec_push(&argv, "--not");
 	oid_array_for_each_unique(&ref_tips_before_fetch,
 				   append_oid_to_argv, &argv);
 
@@ -1231,7 +1231,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 
 	string_list_remove_empty_items(changed_submodule_names, 1);
 
-	argv_array_clear(&argv);
+	strvec_clear(&argv);
 	oid_array_clear(&ref_tips_before_fetch);
 	oid_array_clear(&ref_tips_after_fetch);
 	initialized_fetch_ref_tips = 0;
@@ -1242,32 +1242,32 @@ int submodule_touches_in_range(struct repository *r,
 			       struct object_id *incl_oid)
 {
 	struct string_list subs = STRING_LIST_INIT_DUP;
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 	int ret;
 
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(r, NULL, NULL))
 		return 0;
 
-	argv_array_push(&args, "--"); /* args[0] program name */
-	argv_array_push(&args, oid_to_hex(incl_oid));
+	strvec_push(&args, "--"); /* args[0] program name */
+	strvec_push(&args, oid_to_hex(incl_oid));
 	if (!is_null_oid(excl_oid)) {
-		argv_array_push(&args, "--not");
-		argv_array_push(&args, oid_to_hex(excl_oid));
+		strvec_push(&args, "--not");
+		strvec_push(&args, oid_to_hex(excl_oid));
 	}
 
 	collect_changed_submodules(r, &subs, &args);
 	ret = subs.nr;
 
-	argv_array_clear(&args);
+	strvec_clear(&args);
 
 	free_submodules_oids(&subs);
 	return ret;
 }
 
 struct submodule_parallel_fetch {
 	int count;
-	struct argv_array args;
+	struct strvec args;
 	struct repository *r;
 	const char *prefix;
 	int command_line_option;
@@ -1283,7 +1283,7 @@ struct submodule_parallel_fetch {
 
 	struct strbuf submodules_with_errors;
 };
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
+#define SPF_INIT {0, STRVEC_INIT, NULL, NULL, 0, 0, 0, 0, \
 		  STRING_LIST_INIT_DUP, \
 		  NULL, 0, 0, STRBUF_INIT}
 
@@ -1452,15 +1452,15 @@ static int get_next_submodule(struct child_process *cp,
 			if (!spf->quiet)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
 					    spf->prefix, ce->name);
-			argv_array_init(&cp->args);
-			argv_array_pushv(&cp->args, spf->args.argv);
-			argv_array_push(&cp->args, default_argv);
-			argv_array_push(&cp->args, "--submodule-prefix");
+			strvec_init(&cp->args);
+			strvec_pushv(&cp->args, spf->args.argv);
+			strvec_push(&cp->args, default_argv);
+			strvec_push(&cp->args, "--submodule-prefix");
 
 			strbuf_addf(&submodule_prefix, "%s%s/",
 						       spf->prefix,
 						       task->sub->path);
-			argv_array_push(&cp->args, submodule_prefix.buf);
+			strvec_push(&cp->args, submodule_prefix.buf);
 
 			spf->count++;
 			*task_cb = task;
@@ -1500,14 +1500,14 @@ static int get_next_submodule(struct child_process *cp,
 		cp->git_cmd = 1;
 		cp->dir = task->repo->gitdir;
 
-		argv_array_init(&cp->args);
-		argv_array_pushv(&cp->args, spf->args.argv);
-		argv_array_push(&cp->args, "on-demand");
-		argv_array_push(&cp->args, "--submodule-prefix");
-		argv_array_push(&cp->args, submodule_prefix.buf);
+		strvec_init(&cp->args);
+		strvec_pushv(&cp->args, spf->args.argv);
+		strvec_push(&cp->args, "on-demand");
+		strvec_push(&cp->args, "--submodule-prefix");
+		strvec_push(&cp->args, submodule_prefix.buf);
 
 		/* NEEDSWORK: have get_default_remote from submodule--helper */
-		argv_array_push(&cp->args, "origin");
+		strvec_push(&cp->args, "origin");
 		oid_array_for_each_unique(task->commits,
 					  append_oid_to_argv, &cp->args);
 
@@ -1598,7 +1598,7 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 }
 
 int fetch_populated_submodules(struct repository *r,
-			       const struct argv_array *options,
+			       const struct strvec *options,
 			       const char *prefix, int command_line_option,
 			       int default_option,
 			       int quiet, int max_parallel_jobs)
@@ -1618,10 +1618,10 @@ int fetch_populated_submodules(struct repository *r,
 	if (repo_read_index(r) < 0)
 		die(_("index file corrupt"));
 
-	argv_array_push(&spf.args, "fetch");
+	strvec_push(&spf.args, "fetch");
 	for (i = 0; i < options->argc; i++)
-		argv_array_push(&spf.args, options->argv[i]);
-	argv_array_push(&spf.args, "--recurse-submodules-default");
+		strvec_push(&spf.args, options->argv[i]);
+	strvec_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths(r, &spf.changed_submodule_names);
@@ -1638,7 +1638,7 @@ int fetch_populated_submodules(struct repository *r,
 			spf.submodules_with_errors.buf);
 
 
-	argv_array_clear(&spf.args);
+	strvec_clear(&spf.args);
 out:
 	free_submodules_oids(&spf.changed_submodule_names);
 	return spf.result;
@@ -1666,9 +1666,9 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	}
 	strbuf_reset(&buf);
 
-	argv_array_pushl(&cp.args, "status", "--porcelain=2", NULL);
+	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
 	if (ignore_untracked)
-		argv_array_push(&cp.args, "-uno");
+		strvec_push(&cp.args, "-uno");
 
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
@@ -1779,16 +1779,16 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	if (!submodule_uses_gitfile(path))
 		return 1;
 
-	argv_array_pushl(&cp.args, "status", "--porcelain",
+	strvec_pushl(&cp.args, "status", "--porcelain",
 				   "--ignore-submodules=none", NULL);
 
 	if (flags & SUBMODULE_REMOVAL_IGNORE_UNTRACKED)
-		argv_array_push(&cp.args, "-uno");
+		strvec_push(&cp.args, "-uno");
 	else
-		argv_array_push(&cp.args, "-uall");
+		strvec_push(&cp.args, "-uall");
 
 	if (!(flags & SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED))
-		argv_array_push(&cp.args, "--ignored");
+		strvec_push(&cp.args, "--ignored");
 
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
@@ -1846,7 +1846,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 	prepare_submodule_repo_env(&cp.env_array);
 
 	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "diff-index", "--quiet",
+	strvec_pushl(&cp.args, "diff-index", "--quiet",
 				   "--cached", "HEAD", NULL);
 	cp.no_stdin = 1;
 	cp.no_stdout = 1;
@@ -1866,11 +1866,11 @@ static void submodule_reset_index(const char *path)
 	cp.no_stdin = 1;
 	cp.dir = path;
 
-	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
+	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
 				   get_super_prefix_or_empty(), path);
-	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
+	strvec_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
 
-	argv_array_push(&cp.args, empty_tree_oid_hex());
+	strvec_push(&cp.args, empty_tree_oid_hex());
 
 	if (run_command(&cp))
 		die(_("could not reset submodule index"));
@@ -1947,24 +1947,24 @@ int submodule_move_head(const char *path,
 	cp.no_stdin = 1;
 	cp.dir = path;
 
-	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
+	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
 			get_super_prefix_or_empty(), path);
-	argv_array_pushl(&cp.args, "read-tree", "--recurse-submodules", NULL);
+	strvec_pushl(&cp.args, "read-tree", "--recurse-submodules", NULL);
 
 	if (flags & SUBMODULE_MOVE_HEAD_DRY_RUN)
-		argv_array_push(&cp.args, "-n");
+		strvec_push(&cp.args, "-n");
 	else
-		argv_array_push(&cp.args, "-u");
+		strvec_push(&cp.args, "-u");
 
 	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
-		argv_array_push(&cp.args, "--reset");
+		strvec_push(&cp.args, "--reset");
 	else
-		argv_array_push(&cp.args, "-m");
+		strvec_push(&cp.args, "-m");
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
-		argv_array_push(&cp.args, old_head ? old_head : empty_tree_oid_hex());
+		strvec_push(&cp.args, old_head ? old_head : empty_tree_oid_hex());
 
-	argv_array_push(&cp.args, new_head ? new_head : empty_tree_oid_hex());
+	strvec_push(&cp.args, new_head ? new_head : empty_tree_oid_hex());
 
 	if (run_command(&cp)) {
 		ret = error(_("Submodule '%s' could not be updated."), path);
@@ -1980,7 +1980,7 @@ int submodule_move_head(const char *path,
 			cp.dir = path;
 
 			prepare_submodule_repo_env(&cp.env_array);
-			argv_array_pushl(&cp.args, "update-ref", "HEAD",
+			strvec_pushl(&cp.args, "update-ref", "HEAD",
 					 "--no-deref", new_head, NULL);
 
 			if (run_command(&cp)) {
@@ -2157,7 +2157,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		cp.dir = path;
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
-		argv_array_pushl(&cp.args, "--super-prefix", sb.buf,
+		strvec_pushl(&cp.args, "--super-prefix", sb.buf,
 					   "submodule--helper",
 					   "absorb-git-dirs", NULL);
 		prepare_submodule_repo_env(&cp.env_array);
@@ -2194,9 +2194,9 @@ int get_superproject_working_tree(struct strbuf *buf)
 	strbuf_release(&one_up);
 
 	prepare_submodule_repo_env(&cp.env_array);
-	argv_array_pop(&cp.env_array);
+	strvec_pop(&cp.env_array);
 
-	argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
+	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
 			"ls-files", "-z", "--stage", "--full-name", "--",
 			subpath, NULL);
 	strbuf_reset(&sb);
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 8d3f6d5a5e..67dde56962 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -31,7 +31,7 @@ static int parallel_next(struct child_process *cp,
 	if (number_callbacks >= 4)
 		return 0;
 
-	argv_array_pushv(&cp->args, d->argv);
+	strvec_pushv(&cp->args, d->argv);
 	strbuf_addstr(err, "preloaded output of a child\n");
 	number_callbacks++;
 	return 1;
@@ -72,19 +72,19 @@ static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
 		return 0;
 
 	test = suite->tests.items[suite->next++].string;
-	argv_array_pushl(&cp->args, "sh", test, NULL);
+	strvec_pushl(&cp->args, "sh", test, NULL);
 	if (suite->quiet)
-		argv_array_push(&cp->args, "--quiet");
+		strvec_push(&cp->args, "--quiet");
 	if (suite->immediate)
-		argv_array_push(&cp->args, "-i");
+		strvec_push(&cp->args, "-i");
 	if (suite->verbose)
-		argv_array_push(&cp->args, "-v");
+		strvec_push(&cp->args, "-v");
 	if (suite->verbose_log)
-		argv_array_push(&cp->args, "-V");
+		strvec_push(&cp->args, "-V");
 	if (suite->trace)
-		argv_array_push(&cp->args, "-x");
+		strvec_push(&cp->args, "-x");
 	if (suite->write_junit_xml)
-		argv_array_push(&cp->args, "--write-junit-xml");
+		strvec_push(&cp->args, "--write-junit-xml");
 
 	strbuf_addf(err, "Output of '%s':\n", test);
 	*task_cb = (void *)test;
@@ -220,7 +220,7 @@ static int quote_stress_test(int argc, const char **argv)
 	char special[] = ".?*\\^_\"'`{}()[]<>@~&+:;$%"; // \t\r\n\a";
 	int i, j, k, trials = 100, skip = 0, msys2 = 0;
 	struct strbuf out = STRBUF_INIT;
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 	struct option options[] = {
 		OPT_INTEGER('n', "trials", &trials, "Number of trials"),
 		OPT_INTEGER('s', "skip", &skip, "Skip <n> trials"),
@@ -241,20 +241,20 @@ static int quote_stress_test(int argc, const char **argv)
 		size_t arg_count, arg_offset;
 		int ret = 0;
 
-		argv_array_clear(&args);
+		strvec_clear(&args);
 		if (msys2)
-			argv_array_pushl(&args, "sh", "-c",
+			strvec_pushl(&args, "sh", "-c",
 					 "printf %s\\\\0 \"$@\"", "skip", NULL);
 		else
-			argv_array_pushl(&args, "test-tool", "run-command",
+			strvec_pushl(&args, "test-tool", "run-command",
 					 "quote-echo", NULL);
 		arg_offset = args.argc;
 
 		if (argc > 0) {
 			trials = 1;
 			arg_count = argc;
 			for (j = 0; j < arg_count; j++)
-				argv_array_push(&args, argv[j]);
+				strvec_push(&args, argv[j]);
 		} else {
 			arg_count = 1 + (my_random() % 5);
 			for (j = 0; j < arg_count; j++) {
@@ -268,7 +268,7 @@ static int quote_stress_test(int argc, const char **argv)
 						ARRAY_SIZE(special)];
 				buf[arg_len] = '\0';
 
-				argv_array_push(&args, buf);
+				strvec_push(&args, buf);
 			}
 		}
 
@@ -301,7 +301,7 @@ static int quote_stress_test(int argc, const char **argv)
 					(int)j, args.argv[j + arg_offset]);
 
 			strbuf_release(&out);
-			argv_array_clear(&args);
+			strvec_clear(&args);
 
 			return ret;
 		}
@@ -311,7 +311,7 @@ static int quote_stress_test(int argc, const char **argv)
 	}
 
 	strbuf_release(&out);
-	argv_array_clear(&args);
+	strvec_clear(&args);
 
 	return 0;
 }
@@ -338,7 +338,7 @@ static int inherit_handle(const char *argv0)
 	xsnprintf(path, sizeof(path), "out-XXXXXX");
 	tmp = xmkstemp(path);
 
-	argv_array_pushl(&cp.args,
+	strvec_pushl(&cp.args,
 			 "test-tool", argv0, "inherited-handle-child", NULL);
 	cp.in = -1;
 	cp.no_stdout = cp.no_stderr = 1;
@@ -391,7 +391,7 @@ int cmd__run_command(int argc, const char **argv)
 	while (!strcmp(argv[1], "env")) {
 		if (!argv[2])
 			die("env specifier without a value");
-		argv_array_push(&proc.env_array, argv[2]);
+		strvec_push(&proc.env_array, argv[2]);
 		argv += 2;
 		argc -= 2;
 	}
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 06924a7875..e78e481d8e 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -10,7 +10,7 @@
 
 struct tmp_objdir {
 	struct strbuf path;
-	struct argv_array env;
+	struct strvec env;
 };
 
 /*
@@ -24,7 +24,7 @@ static struct tmp_objdir *the_tmp_objdir;
 static void tmp_objdir_free(struct tmp_objdir *t)
 {
 	strbuf_release(&t->path);
-	argv_array_clear(&t->env);
+	strvec_clear(&t->env);
 	free(t);
 }
 
@@ -79,7 +79,7 @@ static void remove_tmp_objdir_on_signal(int signo)
  * separated by PATH_SEP (which is what separate values in
  * GIT_ALTERNATE_OBJECT_DIRECTORIES).
  */
-static void env_append(struct argv_array *env, const char *key, const char *val)
+static void env_append(struct strvec *env, const char *key, const char *val)
 {
 	struct strbuf quoted = STRBUF_INIT;
 	const char *old;
@@ -97,16 +97,16 @@ static void env_append(struct argv_array *env, const char *key, const char *val)
 
 	old = getenv(key);
 	if (!old)
-		argv_array_pushf(env, "%s=%s", key, val);
+		strvec_pushf(env, "%s=%s", key, val);
 	else
-		argv_array_pushf(env, "%s=%s%c%s", key, old, PATH_SEP, val);
+		strvec_pushf(env, "%s=%s%c%s", key, old, PATH_SEP, val);
 
 	strbuf_release(&quoted);
 }
 
-static void env_replace(struct argv_array *env, const char *key, const char *val)
+static void env_replace(struct strvec *env, const char *key, const char *val)
 {
-	argv_array_pushf(env, "%s=%s", key, val);
+	strvec_pushf(env, "%s=%s", key, val);
 }
 
 static int setup_tmp_objdir(const char *root)
@@ -131,7 +131,7 @@ struct tmp_objdir *tmp_objdir_create(void)
 
 	t = xmalloc(sizeof(*t));
 	strbuf_init(&t->path, 0);
-	argv_array_init(&t->env);
+	strvec_init(&t->env);
 
 	strbuf_addf(&t->path, "%s/incoming-XXXXXX", get_object_directory());
 
diff --git a/transport-helper.c b/transport-helper.c
index 441763fd7c..dcd4adf444 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -128,14 +128,14 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->in = -1;
 	helper->out = -1;
 	helper->err = 0;
-	argv_array_pushf(&helper->args, "git-remote-%s", data->name);
-	argv_array_push(&helper->args, transport->remote->name);
-	argv_array_push(&helper->args, remove_ext_force(transport->url));
+	strvec_pushf(&helper->args, "git-remote-%s", data->name);
+	strvec_push(&helper->args, transport->remote->name);
+	strvec_push(&helper->args, remove_ext_force(transport->url));
 	helper->git_cmd = 0;
 	helper->silent_exec_failure = 1;
 
 	if (have_git_dir())
-		argv_array_pushf(&helper->env_array, "%s=%s",
+		strvec_pushf(&helper->env_array, "%s=%s",
 				 GIT_DIR_ENVIRONMENT, get_git_dir());
 
 	helper->trace2_child_class = helper->args.argv[0]; /* "remote-<name>" */
@@ -439,13 +439,13 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	int cat_blob_fd, code;
 	child_process_init(fastimport);
 	fastimport->in = xdup(helper->out);
-	argv_array_push(&fastimport->args, "fast-import");
-	argv_array_push(&fastimport->args, "--allow-unsafe-features");
-	argv_array_push(&fastimport->args, debug ? "--stats" : "--quiet");
+	strvec_push(&fastimport->args, "fast-import");
+	strvec_push(&fastimport->args, "--allow-unsafe-features");
+	strvec_push(&fastimport->args, debug ? "--stats" : "--quiet");
 
 	if (data->bidi_import) {
 		cat_blob_fd = xdup(helper->in);
-		argv_array_pushf(&fastimport->args, "--cat-blob-fd=%d", cat_blob_fd);
+		strvec_pushf(&fastimport->args, "--cat-blob-fd=%d", cat_blob_fd);
 	}
 	fastimport->git_cmd = 1;
 
@@ -466,17 +466,17 @@ static int get_exporter(struct transport *transport,
 	/* we need to duplicate helper->in because we want to use it after
 	 * fastexport is done with it. */
 	fastexport->out = dup(helper->in);
-	argv_array_push(&fastexport->args, "fast-export");
-	argv_array_push(&fastexport->args, "--use-done-feature");
-	argv_array_push(&fastexport->args, data->signed_tags ?
+	strvec_push(&fastexport->args, "fast-export");
+	strvec_push(&fastexport->args, "--use-done-feature");
+	strvec_push(&fastexport->args, data->signed_tags ?
 		"--signed-tags=verbatim" : "--signed-tags=warn-strip");
 	if (data->export_marks)
-		argv_array_pushf(&fastexport->args, "--export-marks=%s.tmp", data->export_marks);
+		strvec_pushf(&fastexport->args, "--export-marks=%s.tmp", data->export_marks);
 	if (data->import_marks)
-		argv_array_pushf(&fastexport->args, "--import-marks=%s", data->import_marks);
+		strvec_pushf(&fastexport->args, "--import-marks=%s", data->import_marks);
 
 	for (i = 0; i < revlist_args->nr; i++)
-		argv_array_push(&fastexport->args, revlist_args->items[i].string);
+		strvec_push(&fastexport->args, revlist_args->items[i].string);
 
 	fastexport->git_cmd = 1;
 	return start_command(fastexport);
@@ -1082,7 +1082,7 @@ static int has_attribute(const char *attrs, const char *attr)
 }
 
 static struct ref *get_refs_list(struct transport *transport, int for_push,
-				 const struct argv_array *ref_prefixes)
+				 const struct strvec *ref_prefixes)
 {
 	get_helper(transport);
 
diff --git a/transport-internal.h b/transport-internal.h
index 284784a2a6..27c9daffc4 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -30,7 +30,7 @@ struct transport_vtable {
 	 * in the ref's old_sha1 field; otherwise it should be all 0.
 	 **/
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
-				     const struct argv_array *ref_prefixes);
+				     const struct strvec *ref_prefixes);
 
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
diff --git a/transport.c b/transport.c
index b41386eccb..2d4fd851dc 100644
--- a/transport.c
+++ b/transport.c
@@ -127,7 +127,7 @@ struct bundle_transport_data {
 
 static struct ref *get_refs_from_bundle(struct transport *transport,
 					int for_push,
-					const struct argv_array *ref_prefixes)
+					const struct strvec *ref_prefixes)
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
@@ -283,7 +283,7 @@ static void die_if_server_options(struct transport *transport)
  * remote refs.
  */
 static struct ref *handshake(struct transport *transport, int for_push,
-			     const struct argv_array *ref_prefixes,
+			     const struct strvec *ref_prefixes,
 			     int must_list_refs)
 {
 	struct git_transport_data *data = transport->data;
@@ -327,7 +327,7 @@ static struct ref *handshake(struct transport *transport, int for_push,
 }
 
 static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
-					const struct argv_array *ref_prefixes)
+					const struct strvec *ref_prefixes)
 {
 	return handshake(transport, for_push, ref_prefixes, 1);
 }
@@ -1153,7 +1153,7 @@ int transport_push(struct repository *r,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
-		struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
+		struct strvec ref_prefixes = STRVEC_INIT;
 
 		if (check_push_refs(local_refs, rs) < 0)
 			return -1;
@@ -1165,7 +1165,7 @@ int transport_push(struct repository *r,
 							       &ref_prefixes);
 		trace2_region_leave("transport_push", "get_refs_list", r);
 
-		argv_array_clear(&ref_prefixes);
+		strvec_clear(&ref_prefixes);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -1281,7 +1281,7 @@ int transport_push(struct repository *r,
 }
 
 const struct ref *transport_get_remote_refs(struct transport *transport,
-					    const struct argv_array *ref_prefixes)
+					    const struct strvec *ref_prefixes)
 {
 	if (!transport->got_remote_refs) {
 		transport->remote_refs =
diff --git a/transport.h b/transport.h
index b3c30133ea..1be4013dec 100644
--- a/transport.h
+++ b/transport.h
@@ -243,7 +243,7 @@ int transport_push(struct repository *repo,
  * ref_prefixes.
  */
 const struct ref *transport_get_remote_refs(struct transport *transport,
-					    const struct argv_array *ref_prefixes);
+					    const struct strvec *ref_prefixes);
 
 /*
  * Fetch the hash algorithm used by a remote.
diff --git a/unpack-trees.c b/unpack-trees.c
index 65c3395f0f..323280dd48 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -106,7 +106,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	const char **msgs = opts->msgs;
 	const char *msg;
 
-	argv_array_init(&opts->msgs_to_free);
+	strvec_init(&opts->msgs_to_free);
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
@@ -124,7 +124,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Please commit your changes or stash them before you %s.")
 		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
-		argv_array_pushf(&opts->msgs_to_free, msg, cmd, cmd);
+		strvec_pushf(&opts->msgs_to_free, msg, cmd, cmd);
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in them:\n%s");
@@ -145,7 +145,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be removed by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] =
-		argv_array_pushf(&opts->msgs_to_free, msg, cmd, cmd);
+		strvec_pushf(&opts->msgs_to_free, msg, cmd, cmd);
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
@@ -163,7 +163,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] =
-		argv_array_pushf(&opts->msgs_to_free, msg, cmd, cmd);
+		strvec_pushf(&opts->msgs_to_free, msg, cmd, cmd);
 
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
@@ -189,7 +189,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 
 void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
 {
-	argv_array_clear(&opts->msgs_to_free);
+	strvec_clear(&opts->msgs_to_free);
 	memset(opts->msgs, 0, sizeof(opts->msgs));
 }
 
diff --git a/unpack-trees.h b/unpack-trees.h
index f8a904a05b..2e87875b15 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -70,7 +70,7 @@ struct unpack_trees_options {
 	struct pathspec *pathspec;
 	merge_fn_t fn;
 	const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
-	struct argv_array msgs_to_free;
+	struct strvec msgs_to_free;
 	/*
 	 * Store error messages in an array, each case
 	 * corresponding to a error message type
diff --git a/upload-pack.c b/upload-pack.c
index b435dae62f..1b0e1fca1a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -269,45 +269,45 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	if (!pack_data->pack_objects_hook)
 		pack_objects.git_cmd = 1;
 	else {
-		argv_array_push(&pack_objects.args, pack_data->pack_objects_hook);
-		argv_array_push(&pack_objects.args, "git");
+		strvec_push(&pack_objects.args, pack_data->pack_objects_hook);
+		strvec_push(&pack_objects.args, "git");
 		pack_objects.use_shell = 1;
 	}
 
 	if (pack_data->shallow_nr) {
-		argv_array_push(&pack_objects.args, "--shallow-file");
-		argv_array_push(&pack_objects.args, "");
+		strvec_push(&pack_objects.args, "--shallow-file");
+		strvec_push(&pack_objects.args, "");
 	}
-	argv_array_push(&pack_objects.args, "pack-objects");
-	argv_array_push(&pack_objects.args, "--revs");
+	strvec_push(&pack_objects.args, "pack-objects");
+	strvec_push(&pack_objects.args, "--revs");
 	if (pack_data->use_thin_pack)
-		argv_array_push(&pack_objects.args, "--thin");
+		strvec_push(&pack_objects.args, "--thin");
 
-	argv_array_push(&pack_objects.args, "--stdout");
+	strvec_push(&pack_objects.args, "--stdout");
 	if (pack_data->shallow_nr)
-		argv_array_push(&pack_objects.args, "--shallow");
+		strvec_push(&pack_objects.args, "--shallow");
 	if (!pack_data->no_progress)
-		argv_array_push(&pack_objects.args, "--progress");
+		strvec_push(&pack_objects.args, "--progress");
 	if (pack_data->use_ofs_delta)
-		argv_array_push(&pack_objects.args, "--delta-base-offset");
+		strvec_push(&pack_objects.args, "--delta-base-offset");
 	if (pack_data->use_include_tag)
-		argv_array_push(&pack_objects.args, "--include-tag");
+		strvec_push(&pack_objects.args, "--include-tag");
 	if (pack_data->filter_options.choice) {
 		const char *spec =
 			expand_list_objects_filter_spec(&pack_data->filter_options);
 		if (pack_objects.use_shell) {
 			struct strbuf buf = STRBUF_INIT;
 			sq_quote_buf(&buf, spec);
-			argv_array_pushf(&pack_objects.args, "--filter=%s", buf.buf);
+			strvec_pushf(&pack_objects.args, "--filter=%s", buf.buf);
 			strbuf_release(&buf);
 		} else {
-			argv_array_pushf(&pack_objects.args, "--filter=%s",
+			strvec_pushf(&pack_objects.args, "--filter=%s",
 					 spec);
 		}
 	}
 	if (uri_protocols) {
 		for (i = 0; i < uri_protocols->nr; i++)
-			argv_array_pushf(&pack_objects.args, "--uri-protocol=%s",
+			strvec_pushf(&pack_objects.args, "--uri-protocol=%s",
 					 uri_protocols->items[i].string);
 	}
 
@@ -880,26 +880,26 @@ static int send_shallow_list(struct upload_pack_data *data)
 		deepen(data, data->depth);
 		ret = 1;
 	} else if (data->deepen_rev_list) {
-		struct argv_array av = ARGV_ARRAY_INIT;
+		struct strvec av = STRVEC_INIT;
 		int i;
 
-		argv_array_push(&av, "rev-list");
+		strvec_push(&av, "rev-list");
 		if (data->deepen_since)
-			argv_array_pushf(&av, "--max-age=%"PRItime, data->deepen_since);
+			strvec_pushf(&av, "--max-age=%"PRItime, data->deepen_since);
 		if (data->deepen_not.nr) {
-			argv_array_push(&av, "--not");
+			strvec_push(&av, "--not");
 			for (i = 0; i < data->deepen_not.nr; i++) {
 				struct string_list_item *s = data->deepen_not.items + i;
-				argv_array_push(&av, s->string);
+				strvec_push(&av, s->string);
 			}
-			argv_array_push(&av, "--not");
+			strvec_push(&av, "--not");
 		}
 		for (i = 0; i < data->want_obj.nr; i++) {
 			struct object *o = data->want_obj.objects[i].item;
-			argv_array_push(&av, oid_to_hex(&o->oid));
+			strvec_push(&av, oid_to_hex(&o->oid));
 		}
 		deepen_by_rev_list(data, av.argc, av.argv);
-		argv_array_clear(&av);
+		strvec_clear(&av);
 		ret = 1;
 	} else {
 		if (data->shallows.nr > 0) {
@@ -1521,7 +1521,7 @@ enum fetch_state {
 	FETCH_DONE,
 };
 
-int upload_pack_v2(struct repository *r, struct argv_array *keys,
+int upload_pack_v2(struct repository *r, struct strvec *keys,
 		   struct packet_reader *request)
 {
 	enum fetch_state state = FETCH_PROCESS_ARGS;
diff --git a/wt-status.c b/wt-status.c
index 9817161da4..60d4e847a5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -913,17 +913,17 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
 	struct strbuf summary = STRBUF_INIT;
 	char *summary_content;
 
-	argv_array_pushf(&sm_summary.env_array, "GIT_INDEX_FILE=%s",
+	strvec_pushf(&sm_summary.env_array, "GIT_INDEX_FILE=%s",
 			 s->index_file);
 
-	argv_array_push(&sm_summary.args, "submodule");
-	argv_array_push(&sm_summary.args, "summary");
-	argv_array_push(&sm_summary.args, uncommitted ? "--files" : "--cached");
-	argv_array_push(&sm_summary.args, "--for-status");
-	argv_array_push(&sm_summary.args, "--summary-limit");
-	argv_array_pushf(&sm_summary.args, "%d", s->submodule_summary);
+	strvec_push(&sm_summary.args, "submodule");
+	strvec_push(&sm_summary.args, "summary");
+	strvec_push(&sm_summary.args, uncommitted ? "--files" : "--cached");
+	strvec_push(&sm_summary.args, "--for-status");
+	strvec_push(&sm_summary.args, "--summary-limit");
+	strvec_pushf(&sm_summary.args, "%d", s->submodule_summary);
 	if (!uncommitted)
-		argv_array_push(&sm_summary.args, s->amend ? "HEAD^" : "HEAD");
+		strvec_push(&sm_summary.args, s->amend ? "HEAD^" : "HEAD");
 
 	sm_summary.git_cmd = 1;
 	sm_summary.no_stdin = 1;
-- 
2.28.0.rc2.475.g53c7e1c7f4

