Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1C61F855
	for <e@80x24.org>; Sun, 31 Jul 2016 11:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbcGaLAB (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 07:00:01 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:47774
	"EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750748AbcGaLAA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2016 07:00:00 -0400
X-Greylist: delayed 4758 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Jul 2016 06:59:59 EDT
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1469956898;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=Us6zN7ASHYP+u/ZTmXayFLHg/HTIg4HaP7qbKtFq550=;
	b=OYWE6vPjo1dxPN5yo+EBTJtOdzkDqowrYUWlGtZIAjKQnuoIX+zBdQ7H7l9ecpTW
	hivG6ZcSwhW9ghGdU2d4R7eW+P7P8XKy/noKSFAOpn+fAgg6PE0mNQ08D8Sjhtu8uvi
	DrWSd7EaCeQy/+ZVcI+Kmdo9adXUaaiObt+j6h5I=
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Message-ID: <0102015640423d18-86d50542-5e5d-40ff-860e-caf56146982d-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
Subject: [RFC/PATCH v11 13/13] bisect--helper: `bisect_start` shell function
 partially in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:	Sun, 31 Jul 2016 09:21:38 +0000
X-SES-Outgoing:	2016.07.31-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement the `bisect_start` shell function partially in C and add
`bisect-start` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

The last part is not converted because it calls another shell function.
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
This patch contains a small bug. The option handling for `--term-good`
and `--term-bad` needs to be decided as it is now shared between
`--bisect-terms` and `--bisect-start` and the later one also requires
string support. Can comments on which approach would seem the most
feasible? Here[1] is a normal output of t6030 and here[2] is a verbose
output of [2].

[1]: http://paste.ubuntu.com/21252069/
[2]: http://paste.ubuntu.com/21252140/
---
 builtin/bisect--helper.c | 232 ++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 132 +--------------------------
 2 files changed, 232 insertions(+), 132 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 81a16a5..ab18786 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -404,6 +404,228 @@ static int bisect_terms(struct bisect_terms *terms, int term_defined)
 	return 0;
 }
 
+static int bisect_start(struct bisect_terms *terms, int no_checkout,
+			const char **argv, int argc)
+{
+	int i, j, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
+	int flag;
+	struct string_list revs = STRING_LIST_INIT_DUP;
+	struct string_list states = STRING_LIST_INIT_DUP;
+	struct strbuf start_head = STRBUF_INIT;
+	const char *head;
+	unsigned char sha1[20];
+	FILE *fp;
+	struct object_id oid;
+
+	if (is_bare_repository())
+		no_checkout = 1;
+
+	for(i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--")) {
+			has_double_dash = 1;
+			break;
+		}
+		if (!strcmp(argv[i], "--term-good")) {
+			must_write_terms = 1;
+			strbuf_reset(&terms->term_good);
+			strbuf_addstr(&terms->term_good, argv[++i]);
+			break;
+		}
+		if (!strcmp(argv[i], "--term-bad")) {
+			must_write_terms = 1;
+			strbuf_reset(&terms->term_bad);
+			strbuf_addstr(&terms->term_bad, argv[++i]);
+			break;
+		}
+		if (starts_with(argv[i], "--") &&
+		    !one_of(argv[i], "--term-good", "--term-bad", NULL)) {
+			string_list_clear(&revs, 0);
+			string_list_clear(&states, 0);
+			die(_("unrecognised option: '%s'"), argv[i]);
+		}
+		if (get_oid(argv[i], &oid) || has_double_dash) {
+			string_list_clear(&revs, 0);
+			string_list_clear(&revs, 0);
+			die(_("'%s' does not appear to be a valid revision"), argv[i]);
+		}
+		else
+			string_list_append(&revs, oid_to_hex(&oid));
+	}
+
+	for (j = 0; j < revs.nr; j++) {
+		struct strbuf state = STRBUF_INIT;
+		/*
+		 * The user ran "git bisect start <sha1> <sha1>", hence
+		 * did not explicitly specify the terms, but we are already
+		 * starting to set references named with the default terms,
+		 * and won't be able to change afterwards.
+		 */
+		must_write_terms = 1;
+
+		if (bad_seen)
+			strbuf_addstr(&state, terms->term_good.buf);
+		else {
+			bad_seen = 1;
+			strbuf_addstr(&state, terms->term_bad.buf);
+		}
+		string_list_append(&states, state.buf);
+		strbuf_release(&state);
+	}
+
+	/*
+	 * Verify HEAD
+	 */
+	head = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
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
+				error(_("checking out '%s' failed. Try again."),
+				      start_head.buf);
+				strbuf_release(&start_head);
+				string_list_clear(&revs, 0);
+				string_list_clear(&states, 0);
+				return -1;
+			}
+		}
+	} else {
+		if (starts_with(head, "refs/head/") || !get_oid(head, &oid)) {
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
+
+	/*
+	 * Write new start state
+	 */
+	fp = fopen(git_path_bisect_start(), "w");
+	if (!fp) {
+		bisect_clean_state();
+		strbuf_release(&start_head);
+		string_list_clear(&revs, 0);
+		string_list_clear(&states, 0);
+		return -1;
+	}
+	if (!fprintf(fp, "%s\n", start_head.buf)) {
+		fclose(fp);
+		bisect_clean_state();
+		strbuf_release(&start_head);
+		string_list_clear(&revs, 0);
+		string_list_clear(&states, 0);
+		return -1;
+	}
+	fclose(fp);
+
+	if (no_checkout) {
+		get_oid(start_head.buf, &oid);
+		if (update_ref(NULL, "BISECT_HEAD", oid.hash, NULL, 0,
+			       UPDATE_REFS_MSG_ON_ERR)) {
+			bisect_clean_state();
+			strbuf_release(&start_head);
+			string_list_clear(&revs, 0);
+			string_list_clear(&states, 0);
+			return -1;
+		}
+	}
+	strbuf_release(&start_head);
+	fp = fopen(git_path_bisect_names(), "w");
+
+	for (; i < argc; i++) {
+		if (!fprintf(fp, "%s ", argv[i])) {
+			fclose(fp);
+			bisect_clean_state();
+			string_list_clear(&revs, 0);
+			string_list_clear(&states, 0);
+			return -1;
+		}
+	}
+	fclose(fp);
+
+	for (j = 0; j < states.nr; j ++) {
+		if (bisect_write(states.items[j].string,
+				  revs.items[j].string, terms, 1)) {
+			bisect_clean_state();
+			string_list_clear(&revs, 0);
+			string_list_clear(&states, 0);
+			return -1;
+		}
+	}
+	string_list_clear(&revs, 0);
+	string_list_clear(&states, 0);
+
+	if (must_write_terms)
+		if (write_terms(terms->term_bad.buf, terms->term_good.buf)) {
+			bisect_clean_state();
+			return -1;
+		}
+
+	fp = fopen(git_path_bisect_log(), "a");
+	if (!fp) {
+		bisect_clean_state();
+		return -1;
+	}
+	if (!fprintf(fp, "git bisect start")) {
+		bisect_clean_state();
+		return -1;
+	}
+	for (i = 0; i < argc; i++) {
+		if (!fprintf(fp, " '%s'", argv[i])) {
+			fclose(fp);
+			bisect_clean_state();
+			return -1;
+		}
+	}
+	if (!fprintf(fp, "\n")) {
+		fclose(fp);
+		bisect_clean_state();
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
@@ -415,7 +637,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
-		BISECT_TERMS
+		BISECT_TERMS,
+		BISECT_START
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	enum terms_defined term_defined = 0;
@@ -446,6 +669,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("show the new term"), TERM_NEW),
 		OPT_BIT(0, "term-old", &term_defined,
 			 N_("show the old term"), TERM_OLD),
+		OPT_CMDMODE(0, "bisect-start", &cmdmode,
+			 N_("start the bisect session"), BISECT_START),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -518,6 +743,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			die(_("--bisect-terms requires 0 or 1 argument"));
 		res = bisect_terms(&terms, term_defined);
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
index aea97c5f..51d0a71 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -72,122 +72,7 @@ bisect_autostart() {
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
@@ -198,21 +83,6 @@ bisect_start() {
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

--
https://github.com/git/git/pull/281
