Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B72F41F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757294AbcJNOOg (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:14:36 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:32824
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757280AbcJNOOT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=PoJdNtVu2DgshIoXCwVNxipyXFNXTNB/ds39JsZ4i7M=;
        b=IrBz5fxZ0NFaTWfTSkZhdf5XbBJbNVkHu7QA+YvFcpgKYzUuoRiNoy8HqU0/iNjw
        UcQsBWEA2jDKXVi6Ssj8UQ3YHB+iEFUFl0bt6wNyNVrC+v6fFk6mtlBCPulneW6q0K4
        KTZozmm/kFVo74X2njenAcsUeRElpWNkVL/aJidk=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1b29-65f79716-42c6-4327-acda-8c8d0fe05471-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 23/27] bisect--helper: `bisect_replay` shell function in
 C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Oct 2016 14:14:16 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement the `bisect_replay` shell function in C and also add
`--bisect-replay` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-replay` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other method.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            |  32 +-----------
 2 files changed, 124 insertions(+), 33 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c18ca07..b367d8d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -32,6 +32,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+	N_("git bisect--helper --bisect-replay <filename>"),
 	NULL
 };
 
@@ -601,7 +602,6 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			terms->term_good = arg;
 		} else if (!strcmp(arg, "--term-bad") ||
 			 !strcmp(arg, "--term-new")) {
-			const char *next_arg;
 			if (starts_with(argv[++i], "'"))
 				terms->term_bad = sq_dequote(xstrdup(argv[i]));
 			else
@@ -875,6 +875,117 @@ static int bisect_log(void)
 	return status;
 }
 
+static int get_next_word(const char *line, int pos, struct strbuf *word)
+{
+	int i, len = strlen(line), begin = 0;
+	strbuf_reset(word);
+	for (i = pos; i < len; i++) {
+		if (line[i] == ' ' && begin)
+			return i + 1;
+
+		if (!begin)
+			begin = 1;
+		strbuf_addch(word, line[i]);
+	}
+
+	return i;
+}
+
+static int bisect_replay(struct bisect_terms *terms, const char *filename)
+{
+	struct strbuf line = STRBUF_INIT;
+	struct strbuf word = STRBUF_INIT;
+	FILE *fp = NULL;
+	int res = 0;
+
+	if (is_empty_or_missing_file(filename)) {
+		error(_("no such file with name '%s' exists"), filename);
+		res = -1;
+		goto finish;
+	}
+
+	if (bisect_reset(NULL)) {
+		res = -1;
+		goto finish;
+	}
+
+	fp = fopen(filename, "r");
+	if (!fp) {
+		res = -1;
+		goto finish;
+	}
+
+	while (strbuf_getline(&line, fp) != EOF) {
+		int pos = 0;
+		while (pos < line.len) {
+			pos = get_next_word(line.buf, pos, &word);
+
+			if (!strcmp(word.buf, "git")) {
+				continue;
+			} else if (!strcmp(word.buf, "git-bisect")) {
+				continue;
+			} else if (!strcmp(word.buf, "bisect")) {
+				continue;
+			} else if (!strcmp(word.buf, "#")) {
+				break;
+			}
+
+			get_terms(terms);
+			if (check_and_set_terms(terms, word.buf)) {
+				res = -1;
+				goto finish;
+			}
+
+			if (!strcmp(word.buf, "start")) {
+				struct argv_array argv = ARGV_ARRAY_INIT;
+				sq_dequote_to_argv_array(line.buf+pos, &argv);
+				if (bisect_start(terms, 0, argv.argv, argv.argc)) {
+					argv_array_clear(&argv);
+					res = -1;
+					goto finish;
+				}
+				argv_array_clear(&argv);
+				break;
+			}
+
+			if (one_of(word.buf, terms->term_good,
+			    terms->term_bad, "skip", NULL)) {
+				if (bisect_write(word.buf, line.buf+pos, terms, 0)) {
+					res = -1;
+					goto finish;
+				}
+				break;
+			}
+
+			if (!strcmp(word.buf, "terms")) {
+				struct argv_array argv = ARGV_ARRAY_INIT;
+				sq_dequote_to_argv_array(line.buf+pos, &argv);
+				if (bisect_terms(terms, argv.argv, argv.argc)) {
+					argv_array_clear(&argv);
+					res = -1;
+					goto finish;
+				}
+				argv_array_clear(&argv);
+				break;
+			}
+
+			error(_("?? what are you talking about?"));
+			res = -1;
+			goto finish;
+		}
+	}
+	goto finish;
+finish:
+	if (fp)
+		fclose(fp);
+	strbuf_release(&line);
+	strbuf_release(&word);
+	if (res)
+		return -1;
+
+	return bisect_auto_next(terms, NULL);
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -888,7 +999,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
 		BISECT_STATE,
-		BISECT_LOG
+		BISECT_LOG,
+		BISECT_REPLAY
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -914,6 +1026,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
 			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
+		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
+			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -998,6 +1112,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			die(_("--bisect-log requires 0 arguments"));
 		res = bisect_log();
 		break;
+	case BISECT_REPLAY:
+		if (argc != 1)
+			die(_("--bisect-replay requires 1 argument"));
+		terms.term_good = "good";
+		terms.term_bad = "bad";
+		res = bisect_replay(&terms, argv[0]);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index a47e3b5..bf66ee2 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -77,36 +77,6 @@ bisect_visualize() {
 	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
-bisect_replay () {
-	file="$1"
-	test "$#" -eq 1 || die "$(gettext "No logfile given")"
-	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
-	git bisect--helper --bisect-reset || exit
-	while read git bisect command rev
-	do
-		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
-		if test "$git" = "git-bisect"
-		then
-			rev="$command"
-			command="$bisect"
-		fi
-		get_terms
-		git bisect--helper --check-and-set-terms "$command" "$TERM_GOOD" "$TERM_BAD" || exit
-		get_terms
-		case "$command" in
-		start)
-			eval "git bisect--helper --bisect-start $rev" ;;
-		"$TERM_GOOD"|"$TERM_BAD"|skip)
-			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
-		terms)
-			git bisect--helper --bisect-terms $rev  || exit;;
-		*)
-			die "$(gettext "?? what are you talking about?")" ;;
-		esac
-	done <"$file"
-	git bisect--helper --bisect-auto-next
-}
-
 bisect_run () {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
@@ -201,7 +171,7 @@ case "$#" in
 	reset)
 		git bisect--helper --bisect-reset "$@" ;;
 	replay)
-		bisect_replay "$@" ;;
+		git bisect--helper --bisect-replay "$@" ;;
 	log)
 		git bisect--helper --bisect-log ;;
 	run)

--
https://github.com/git/git/pull/287
