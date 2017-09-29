Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDD62047F
	for <e@80x24.org>; Fri, 29 Sep 2017 06:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbdI2Gtu (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 02:49:50 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:39808
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750847AbdI2Gtl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Sep 2017 02:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506667780;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=3af89bFqv5juRENNrK6trDC4mu4rWSRe0XduJFj3Ya4=;
        b=Jf1TO3b//nOJYtCPWnDzIuMEXVTnbIGFmpAGaVTmEPizfmdwJmYL7t0Jt+Cu7uGc
        apo7+I2RDha9Rze4KlLYxcalqaupRHF1dCeOlfqoq8+Il70EAxUmQOtx5tfbXxRR+A8
        0t4zxRsuWveDyIEQa34UKeSmM6v//KthY8tv1unM=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015ecc65d76b-124658b5-5b79-4321-a6cc-01be807c62aa-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
References: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
Subject: [PATCH v16 6/6] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Sep 2017 06:49:40 +0000
X-SES-Outgoing: 2017.09.29-54.240.7.17
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
 builtin/bisect--helper.c | 34 +++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 20 ++------------------
 2 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 0f4d4e41cf233..35d2105f941c6 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -5,6 +5,8 @@
 #include "refs.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
+static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
+static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
@@ -80,12 +82,37 @@ static int write_terms(const char *bad, const char *good)
 	return (res < 0) ? -1 : 0;
 }
 
+static int is_expected_rev(const char *expected_hex)
+{
+	struct strbuf actual_hex = STRBUF_INIT;
+	int res = 0;
+	if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 40) {
+		strbuf_trim(&actual_hex);
+		res = !strcmp(actual_hex.buf, expected_hex);
+	}
+	strbuf_release(&actual_hex);
+	return res;
+}
+
+static void check_expected_revs(const char **revs, int rev_nr)
+{
+	int i;
+
+	for (i = 0; i < rev_nr; i++) {
+		if (!is_expected_rev(revs[i])) {
+			unlink_or_warn(git_path_bisect_ancestors_ok());
+			unlink_or_warn(git_path_bisect_expected_rev());
+		}
+	}
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE
+		BISECT_CLEAN_STATE,
+		CHECK_EXPECTED_REVS
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -95,6 +122,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
+		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
+			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -117,6 +146,9 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 0)
 			return error(_("--bisect-clean-state requires no arguments"));
 		return bisect_clean_state();
+	case CHECK_EXPECTED_REVS:
+		check_expected_revs(argv, argc);
+		return 0;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 045830c399873..0138a8860e377 100755
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
https://github.com/git/git/pull/410
