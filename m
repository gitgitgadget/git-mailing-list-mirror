Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC341F6C1
	for <e@80x24.org>; Tue, 23 Aug 2016 12:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758078AbcHWMAv (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 08:00:51 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:51609
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758016AbcHWMAB (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 08:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=POXZ8sJT49dXfaZn1iC1qyGRX6lrE/FCNQt0TfLWAQA=;
        b=czpPtlNOJSPF+G/t/pnp9Fj4PAJsN1gH9RQWd9MndcZ6uyTlzNtFOqianYyrBbaG
        /vd4WapZbrfOhcT/vQyo/0QHQnEkucFJwrnTw5K+oFD1GGRrS9xE54oZOyZzXKkTNl9
        o2xKNbAH7jk9xHbGj/h9th0fWhNWlbdFUKdsWNfA=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe6b9-5e500c96-9bc3-4a6b-beb9-b5988dc9ee85-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 13/27] bisect--helper: `bisect_start` shell function
 partially in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Aug 2016 11:53:53 +0000
X-SES-Outgoing: 2016.08.23-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement the `bisect_start` shell function partially in C and add
`bisect-start` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

The last part is not converted because it calls another shell function
`bisect_start` shell function will be completed after the `bisect_next`
shell function is ported in C.

Using `--bisect-start` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other methods.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 238 ++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 133 +-------------------------
 2 files changed, 238 insertions(+), 133 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 44adf6b..c64996a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -7,6 +7,7 @@
 #include "argv-array.h"
 #include "run-command.h"
 #include "prompt.h"
+#include "quote.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -14,6 +15,8 @@ static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
+static GIT_PATH_FUNC(git_path_head_name, "head-name")
+static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
@@ -24,6 +27,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
 	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
+	N_("git bisect--helper --bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
+					      "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	NULL
 };
 
@@ -391,6 +396,226 @@ static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
 	return 0;
 }
 
+static int bisect_start(struct bisect_terms *terms, int no_checkout,
+			const char **argv, int argc)
+{
+	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
+	int flags, pathspec_pos;
+	struct string_list revs = STRING_LIST_INIT_DUP;
+	struct string_list states = STRING_LIST_INIT_DUP;
+	struct strbuf start_head = STRBUF_INIT;
+	struct strbuf bisect_names = STRBUF_INIT;
+	struct strbuf orig_args = STRBUF_INIT;
+	const char *head;
+	unsigned char sha1[20];
+	FILE *fp;
+	struct object_id oid;
+
+	if (is_bare_repository())
+		no_checkout = 1;
+
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--")) {
+			has_double_dash = 1;
+			break;
+		}
+	}
+
+	for (i = 0; i < argc; i++) {
+		const char *commit_id = xstrfmt("%s^{commit}", argv[i]);
+		if (!strcmp(argv[i], "--")) {
+			has_double_dash = 1;
+			break;
+		} else if (!strcmp(argv[i], "--no-checkout"))
+			no_checkout = 1;
+		else if (!strcmp(argv[i], "--term-good") ||
+			 !strcmp(argv[i], "--term-old")) {
+			must_write_terms = 1;
+			strbuf_reset(&terms->term_good);
+			strbuf_addstr(&terms->term_good, argv[++i]);
+		} else if (skip_prefix(argv[i], "--term-good=", &argv[i])) {
+			must_write_terms = 1;
+			strbuf_reset(&terms->term_good);
+			strbuf_addstr(&terms->term_good, argv[i]);
+		} else if (skip_prefix(argv[i], "--term-old=", &argv[i])) {
+			must_write_terms = 1;
+			strbuf_reset(&terms->term_good);
+			strbuf_addstr(&terms->term_good, argv[i]);
+		} else if (!strcmp(argv[i], "--term-bad") ||
+			 !strcmp(argv[i], "--term-new")) {
+			must_write_terms = 1;
+			strbuf_reset(&terms->term_bad);
+			strbuf_addstr(&terms->term_bad, argv[++i]);
+		} else if (skip_prefix(argv[i], "--term-bad=", &argv[i])) {
+			must_write_terms = 1;
+			strbuf_reset(&terms->term_bad);
+			strbuf_addstr(&terms->term_bad, argv[i]);
+		} else if (skip_prefix(argv[i], "--term-new=", &argv[i])) {
+			must_write_terms = 1;
+			strbuf_reset(&terms->term_good);
+			strbuf_addstr(&terms->term_good, argv[i]);
+		} else if (starts_with(argv[i], "--") &&
+			 !one_of(argv[i], "--term-good", "--term-bad", NULL)) {
+			string_list_clear(&revs, 0);
+			string_list_clear(&states, 0);
+			die(_("unrecognised option: '%s'"), argv[i]);
+		} else if (get_oid(commit_id, &oid) && has_double_dash) {
+			string_list_clear(&revs, 0);
+			string_list_clear(&states, 0);
+			die(_("'%s' does not appear to be a valid revision"), argv[i]);
+		} else {
+			string_list_append(&revs, oid_to_hex(&oid));
+		}
+	}
+	pathspec_pos = i;
+
+	/*
+	 * The user ran "git bisect start <sha1> <sha1>", hence did not
+	 * explicitly specify the terms, but we are already starting to
+	 * set references named with the default terms, and won't be able
+	 * to change afterwards.
+	 */
+	must_write_terms |= !!revs.nr;
+	for (i = 0; i < revs.nr; i++) {
+		if (bad_seen)
+			string_list_append(&states, terms->term_good.buf);
+		else {
+			bad_seen = 1;
+			string_list_append(&states, terms->term_bad.buf);
+		}
+	}
+
+	/*
+	 * Verify HEAD
+	 */
+	head = resolve_ref_unsafe("HEAD", 0, sha1, &flags);
+	if (!head) {
+		if (get_sha1("HEAD", sha1)) {
+			string_list_clear(&revs, 0);
+			string_list_clear(&states, 0);
+			die(_("Bad HEAD - I need a HEAD"));
+		}
+	}
+	if (!is_empty_or_missing_file(git_path_bisect_start())) {
+		/* Reset to the rev from where we started */
+		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
+		strbuf_trim(&start_head);
+		if (!no_checkout) {
+			struct argv_array argv = ARGV_ARRAY_INIT;
+			argv_array_pushl(&argv, "checkout", start_head.buf,
+					 "--", NULL);
+			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+				error(_("checking out '%s' failed. Try 'git "
+					"bisect start <valid-branch>'."),
+				      start_head.buf);
+				strbuf_release(&start_head);
+				string_list_clear(&revs, 0);
+				string_list_clear(&states, 0);
+				return -1;
+			}
+		}
+	} else {
+		if (starts_with(head, "refs/heads/") ||
+		    !get_oid_hex(head, &oid) || ref_exists(head)) {
+			/*
+			 * This error message should only be triggered by
+			 * cogito usage, and cogito users should understand
+			 * it relates to cg-seek.
+			 */
+			if (!is_empty_or_missing_file(git_path_head_name())) {
+				strbuf_release(&start_head);
+				string_list_clear(&revs, 0);
+				string_list_clear(&states, 0);
+				die(_("won't bisect on cg-seek'ed tree"));
+			}
+			if (starts_with(head, "refs/heads/")) {
+				strbuf_reset(&start_head);
+				strbuf_addstr(&start_head, head + 11);
+			}
+			else {
+				strbuf_reset(&start_head);
+				strbuf_addstr(&start_head, sha1_to_hex(sha1));
+			}
+		} else {
+			strbuf_release(&start_head);
+			string_list_clear(&revs, 0);
+			string_list_clear(&states, 0);
+			die(_("Bad HEAD - strange symbolic ref"));
+		}
+	}
+
+	/*
+	 * Get rid of any old bisect state.
+	 */
+	if (bisect_clean_state()) {
+		return -1;
+	}
+	/*
+	 * In case of mistaken revs or checkout error, or signals received,
+	 * "bisect_auto_next" below may exit or misbehave.
+	 * We have to trap this to be able to clean up using
+	 * "bisect_clean_state".
+	 */
+
+	/*
+	 * Write new start state
+	 */
+	write_file(git_path_bisect_start(), "%s\n", start_head.buf);
+
+	if (no_checkout) {
+		get_oid(start_head.buf, &oid);
+		if (update_ref(NULL, "BISECT_HEAD", oid.hash, NULL, 0,
+			       UPDATE_REFS_MSG_ON_ERR)) {
+			strbuf_release(&start_head);
+			string_list_clear(&revs, 0);
+			string_list_clear(&states, 0);
+			return -1;
+		}
+	}
+	strbuf_release(&start_head);
+
+	if (pathspec_pos < argc - 1)
+		sq_quote_argv(&bisect_names, argv + pathspec_pos, 0);
+	write_file(git_path_bisect_names(), "%s\n", bisect_names.buf);
+	strbuf_release(&bisect_names);
+
+	for (i = 0; i < states.nr; i++) {
+		if (bisect_write(states.items[i].string,
+				  revs.items[i].string, terms, 1)) {
+			string_list_clear(&revs, 0);
+			string_list_clear(&states, 0);
+			return -1;
+		}
+	}
+	string_list_clear(&revs, 0);
+	string_list_clear(&states, 0);
+
+	if (must_write_terms)
+		if (write_terms(terms->term_bad.buf, terms->term_good.buf))
+			return -1;
+
+	fp = fopen(git_path_bisect_log(), "a");
+	if (!fp)
+		return -1;
+
+	if (fprintf(fp, "git bisect start") < 1)
+		return -1;
+
+	sq_quote_argv(&orig_args, argv, 0);
+	if (fprintf(fp, "%s", orig_args.buf) < 0) {
+		strbuf_release(&orig_args);
+		return -1;
+	}
+	strbuf_release(&orig_args);
+	if (fprintf(fp, "\n") < 1) {
+		fclose(fp);
+		return -1;
+	}
+	fclose(fp);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -402,7 +627,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
-		BISECT_TERMS
+		BISECT_TERMS,
+		BISECT_START
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -424,6 +650,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
 			 N_("print out the bisect terms"), BISECT_TERMS),
+		OPT_CMDMODE(0, "bisect-start", &cmdmode,
+			 N_("start the bisect session"), BISECT_START),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -432,7 +660,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	bisect_terms_init(&terms);
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
+			     git_bisect_helper_usage,
+			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
@@ -486,6 +715,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			die(_("--bisect-terms requires 0 or 1 argument"));
 		res = bisect_terms(&terms, argv, argc);
 		break;
+	case BISECT_START:
+		strbuf_addstr(&terms.term_good, "good");
+		strbuf_addstr(&terms.term_bad, "bad");
+		res = bisect_start(&terms, no_checkout, argv, argc);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index d6c8b5a..f0896b3 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -71,122 +71,7 @@ bisect_autostart() {
 }
 
 bisect_start() {
-	#
-	# Check for one bad and then some good revisions.
-	#
-	has_double_dash=0
-	for arg; do
-		case "$arg" in --) has_double_dash=1; break ;; esac
-	done
-	orig_args=$(git rev-parse --sq-quote "$@")
-	bad_seen=0
-	eval=''
-	must_write_terms=0
-	revs=''
-	if test "z$(git rev-parse --is-bare-repository)" != zfalse
-	then
-		mode=--no-checkout
-	else
-		mode=''
-	fi
-	while [ $# -gt 0 ]; do
-		arg="$1"
-		case "$arg" in
-		--)
-			shift
-			break
-		;;
-		--no-checkout)
-			mode=--no-checkout
-			shift ;;
-		--term-good|--term-old)
-			shift
-			must_write_terms=1
-			TERM_GOOD=$1
-			shift ;;
-		--term-good=*|--term-old=*)
-			must_write_terms=1
-			TERM_GOOD=${1#*=}
-			shift ;;
-		--term-bad|--term-new)
-			shift
-			must_write_terms=1
-			TERM_BAD=$1
-			shift ;;
-		--term-bad=*|--term-new=*)
-			must_write_terms=1
-			TERM_BAD=${1#*=}
-			shift ;;
-		--*)
-			die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
-		*)
-			rev=$(git rev-parse -q --verify "$arg^{commit}") || {
-				test $has_double_dash -eq 1 &&
-				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
-				break
-			}
-			revs="$revs $rev"
-			shift
-			;;
-		esac
-	done
-
-	for rev in $revs
-	do
-		# The user ran "git bisect start <sha1>
-		# <sha1>", hence did not explicitly specify
-		# the terms, but we are already starting to
-		# set references named with the default terms,
-		# and won't be able to change afterwards.
-		must_write_terms=1
-
-		case $bad_seen in
-		0) state=$TERM_BAD ; bad_seen=1 ;;
-		*) state=$TERM_GOOD ;;
-		esac
-		eval="$eval git bisect--helper --bisect-write '$state' '$rev' '$TERM_GOOD' '$TERM_BAD' 'nolog' &&"
-	done
-	#
-	# Verify HEAD.
-	#
-	head=$(GIT_DIR="$GIT_DIR" git symbolic-ref -q HEAD) ||
-	head=$(GIT_DIR="$GIT_DIR" git rev-parse --verify HEAD) ||
-	die "$(gettext "Bad HEAD - I need a HEAD")"
-
-	#
-	# Check if we are bisecting.
-	#
-	start_head=''
-	if test -s "$GIT_DIR/BISECT_START"
-	then
-		# Reset to the rev from where we started.
-		start_head=$(cat "$GIT_DIR/BISECT_START")
-		if test "z$mode" != "z--no-checkout"
-		then
-			git checkout "$start_head" -- ||
-			die "$(eval_gettext "Checking out '\$start_head' failed. Try 'git bisect reset <valid-branch>'.")"
-		fi
-	else
-		# Get rev from where we start.
-		case "$head" in
-		refs/heads/*|$_x40)
-			# This error message should only be triggered by
-			# cogito usage, and cogito users should understand
-			# it relates to cg-seek.
-			[ -s "$GIT_DIR/head-name" ] &&
-				die "$(gettext "won't bisect on cg-seek'ed tree")"
-			start_head="${head#refs/heads/}"
-			;;
-		*)
-			die "$(gettext "Bad HEAD - strange symbolic ref")"
-			;;
-		esac
-	fi
-
-	#
-	# Get rid of any old bisect state.
-	#
-	git bisect--helper --bisect-clean-state || exit
+	git bisect--helper --bisect-start $@ || exit
 
 	#
 	# Change state.
@@ -197,24 +82,10 @@ bisect_start() {
 	#
 	trap 'git bisect--helper --bisect-clean-state' 0
 	trap 'exit 255' 1 2 3 15
-
-	#
-	# Write new start state.
-	#
-	echo "$start_head" >"$GIT_DIR/BISECT_START" && {
-		test "z$mode" != "z--no-checkout" ||
-		git update-ref --no-deref BISECT_HEAD "$start_head"
-	} &&
-	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
-	eval "$eval true" &&
-	if test $must_write_terms -eq 1
-	then
-		git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD"
-	fi &&
-	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
 	# Check if we can proceed to the next bisect state.
 	#
+	get_terms
 	bisect_auto_next
 
 	trap '-' 0

--
https://github.com/git/git/pull/287
