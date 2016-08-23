Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2746C1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 12:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755511AbcHWMam (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 08:30:42 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:44287
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752999AbcHWMal (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 08:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=5xLzbnkhIJN0pFq+PrVA756Ve9k8Dts8/2rRvPPYql0=;
        b=LAxeg9H/YtegbYJzXD68MK9ThCC5RbmJ/pCJMb64nlTyAk+HkAYkLaIQM9CNhWLn
        rBHaoR3uCgzYWuc7fXc5PoQqP4dD3Ngvkrr0Xuno+s7DFab8Q+XAzgVqbwG6tR+MaiG
        kLiQTkY2cUz3zR/QOA18VZBPhoGbleR7xlKb0GBs=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe69f-6b734e3c-806c-431d-aa52-c96b3783f248-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 08/27] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Aug 2016 11:53:53 +0000
X-SES-Outgoing: 2016.08.23-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement `is_expected_rev` & `check_expected_revs` shell function in
C and add a `--check-expected-revs` subcommand to `git bisect--helper` to
call it from git-bisect.sh .

Using `--check-expected-revs` subcommand is a temporary measure to port
shell functions to C so as to use the existing test suite. As more
functions are ported, this subcommand would be retired but its
implementation will be called by some other method.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 33 ++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 20 ++------------------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 9aba094..711be75 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -123,13 +123,40 @@ static int bisect_reset(const char *commit)
 	return bisect_clean_state();
 }
 
+static int is_expected_rev(const char *expected_hex)
+{
+	struct strbuf actual_hex = STRBUF_INIT;
+	int res = 0;
+	if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 0) {
+		strbuf_trim(&actual_hex);
+		res = !strcmp(actual_hex.buf, expected_hex);
+	}
+	strbuf_release(&actual_hex);
+	return res;
+}
+
+static int check_expected_revs(const char **revs, int rev_nr)
+{
+	int i;
+
+	for (i = 0; i < rev_nr; i++) {
+		if (!is_expected_rev(revs[i])) {
+			unlink_or_warn(git_path_bisect_ancestors_ok());
+			unlink_or_warn(git_path_bisect_expected_rev());
+			return 0;
+		}
+	}
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
 		BISECT_CLEAN_STATE,
-		BISECT_RESET
+		BISECT_RESET,
+		CHECK_EXPECTED_REVS
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -141,6 +168,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
+		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
+			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -167,6 +196,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc > 1)
 			die(_("--bisect-reset requires either zero or one arguments"));
 		return bisect_reset(argc ? argv[0] : NULL);
+	case CHECK_EXPECTED_REVS:
+		return check_expected_revs(argv, argc);
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 442397b..c3e43248 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -237,22 +237,6 @@ bisect_write() {
 	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
-is_expected_rev() {
-	test -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
-	test "$1" = $(cat "$GIT_DIR/BISECT_EXPECTED_REV")
-}
-
-check_expected_revs() {
-	for _rev in "$@"; do
-		if ! is_expected_rev "$_rev"
-		then
-			rm -f "$GIT_DIR/BISECT_ANCESTORS_OK"
-			rm -f "$GIT_DIR/BISECT_EXPECTED_REV"
-			return
-		fi
-	done
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -280,7 +264,7 @@ bisect_state() {
 		rev=$(git rev-parse --verify "$bisected_head") ||
 			die "$(eval_gettext "Bad rev input: \$bisected_head")"
 		bisect_write "$state" "$rev"
-		check_expected_revs "$rev" ;;
+		git bisect--helper --check-expected-revs "$rev" ;;
 	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
 		shift
 		hash_list=''
@@ -294,7 +278,7 @@ bisect_state() {
 		do
 			bisect_write "$state" "$rev"
 		done
-		check_expected_revs $hash_list ;;
+		git bisect--helper --check-expected-revs $hash_list ;;
 	*,"$TERM_BAD")
 		die "$(eval_gettext "'git bisect \$TERM_BAD' can take only one argument.")" ;;
 	*)

--
https://github.com/git/git/pull/287
