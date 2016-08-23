Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3199C1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 12:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757283AbcHWMo7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 08:44:59 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:33941
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751255AbcHWMo6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 08:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=o/pQK75iIcKvaw5MqbNirjFw5WAR0BNqXNvo70ioGCk=;
        b=ZwDcXQ0jwb8voys87ucJyg8yp9bFCpp+HNXOtl6WtO9X7wpvWchf4V5JqphTsBlG
        fmLBej2kcqMldreBO36rUz3/JiD9QDM7g33lKOx2EkzwD1xZHCymAPdyMRhtX+DD24e
        9IwRcAC9AkDB5odHm41xx+vnFFVsd4zOKBWPAyKk=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe6d7-6cd42223-f46c-4e4c-a15f-516fc13a4521-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 22/27] bisect--helper: `bisect_replay` shell function in
 C
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
 builtin/bisect--helper.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            |  32 +--------------
 2 files changed, 100 insertions(+), 32 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index b57b0c8..9c1108d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -32,6 +32,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+	N_("git bisect--helper --bisect-replay <filename>"),
 	NULL
 };
 
@@ -879,6 +880,93 @@ static int bisect_log(void)
 	return 0;
 }
 
+static int get_next_word(struct strbuf *line, struct strbuf *word)
+{
+	int i;
+	for (i = 0; line->buf[i] != ' ' && line->buf[i] != '\0'; i++)
+		strbuf_addch(word, line->buf[i]);
+
+	return 0;
+}
+
+static int bisect_replay(struct bisect_terms *terms, const char *filename)
+{
+	struct strbuf line = STRBUF_INIT;
+	FILE *fp;
+
+	if (is_empty_or_missing_file(filename))
+		die(_("no such file with name '%s' exists"), filename);
+
+	if (bisect_reset(NULL))
+		return -1;
+
+	fp = fopen(filename, "r");
+
+	while (strbuf_getline(&line, fp) != EOF) {
+		struct strbuf command = STRBUF_INIT;
+		if (starts_with(line.buf, "git bisect ") ||
+		    starts_with(line.buf, "git-bisect "))
+			strbuf_remove(&line, 0, 11);
+		else
+			continue;
+
+		get_terms(terms);
+		get_next_word(&line, &command);
+		if (check_and_set_terms(terms, command.buf)) {
+			strbuf_release(&line);
+			strbuf_release(&command);
+		}
+
+		if (line.buf[command.len] != '\0')
+			strbuf_remove(&line, 0, command.len + 1);
+		else
+			strbuf_remove(&line, 0, command.len);
+
+		if (!strcmp(command.buf, "start")) {
+			struct argv_array argv = ARGV_ARRAY_INIT;
+			sq_dequote_to_argv_array(line.buf, &argv);
+			if (bisect_start(terms, 0, argv.argv, argv.argc)) {
+				strbuf_release(&command);
+				strbuf_release(&line);
+				argv_array_clear(&argv);
+				return -1;
+			}
+			argv_array_clear(&argv);
+			continue;
+		}
+
+		if (one_of(command.buf, terms->term_good.buf,
+		    terms->term_bad.buf, "skip", NULL)) {
+			if (bisect_write(command.buf, line.buf, terms, 0)) {
+				strbuf_release(&command);
+				strbuf_release(&line);
+				return -1;
+			}
+			continue;
+		}
+
+		if (!strcmp(command.buf, "terms")) {
+			struct argv_array argv = ARGV_ARRAY_INIT;
+			sq_dequote_to_argv_array(line. buf, &argv);
+			if (bisect_terms(terms, argv.argv, argv.argc)) {
+				strbuf_release(&command);
+				strbuf_release(&line);
+				argv_array_clear(&argv);
+				return -1;
+			}
+			argv_array_clear(&argv);
+			continue;
+		}
+
+		strbuf_release(&command);
+		strbuf_release(&line);
+		die(_("?? what are you talking about?"));
+	}
+	strbuf_release(&line);
+
+	return bisect_auto_next(terms, NULL);
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -892,7 +980,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
 		BISECT_STATE,
-		BISECT_LOG
+		BISECT_LOG,
+		BISECT_REPLAY
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -918,6 +1007,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
 			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
+		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
+			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -1001,6 +1092,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			die(_("--bisect-log requires 0 arguments"));
 		res = bisect_log();
 		break;
+	case BISECT_REPLAY:
+		if (argc != 1)
+			die(_("--bisect-replay requires 1 argument"));
+		strbuf_addstr(&terms.term_good, "good");
+		strbuf_addstr(&terms.term_bad, "bad");
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
