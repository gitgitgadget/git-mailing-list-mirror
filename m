Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A26209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 14:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757415AbcJNOOz (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:14:55 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:52104
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757324AbcJNOOT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Y/YRMwut/1slWmkTaVqpa4EimrXfp07xpXol+zfGYjI=;
        b=Ksqcdz3abJX57mT60smx5ecYTvoJWVqTc6MFNaiBKw1CwkxR8HNvJSIEoN4gcywq
        l2FvXyUhrrJ2yJ/PPwqcukW7EuuoqbXyaqpC6kelGtmFTHRaHvLFE6HtdjF1ylPT+Ae
        BIswigijcfYBstE591kyWRORhP2cUjlseLvLZHsg=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1b1a-067117ef-cd0d-469b-ba80-ea1a1169f694-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 18/27] bisect--helper: `bisect_autostart` shell function
 in C
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

Reimplement the `bisect_autostart` shell function in C and add the
C implementation from `bisect_next()` which was previously left
uncovered. Also add a subcommand `--bisect-autostart` to
`git bisect--helper` be called from `bisect_state()` from
git-bisect.sh .

Using `--bisect-autostart` subcommand is a temporary measure to port
shell function to C so as to use the existing test suite. As more
functions are ported, this subcommand will be retired and will be called
by `bisect_state()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 40 ++++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            | 23 +----------------------
 2 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 502bf18..1767916 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 					      "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
+	N_("git bisect--helper --bisect-autostart"),
 	NULL
 };
 
@@ -38,6 +39,8 @@ struct bisect_terms {
 	const char *term_bad;
 };
 
+static int bisect_autostart(struct bisect_terms *terms);
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -422,6 +425,7 @@ static int bisect_next(struct bisect_terms *terms, const char *prefix)
 {
 	int res, no_checkout;
 
+	bisect_autostart(terms);
 	/*
 	 * In case of mistaken revs or checkout error, or signals received,
 	 * "bisect_auto_next" below may exit or misbehave.
@@ -754,6 +758,32 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	return retval || bisect_auto_next(terms, NULL);
 }
 
+static int bisect_autostart(struct bisect_terms *terms)
+{
+	if (is_empty_or_missing_file(git_path_bisect_start())) {
+		const char *yesno;
+		const char *argv[] = {NULL};
+		fprintf(stderr, _("You need to start by \"git bisect "
+				  "start\"\n"));
+
+		if (!isatty(0))
+			return 1;
+
+		/*
+		 * TRANSLATORS: Make sure to include [Y] and [n] in your
+		 * translation. THe program will only accept English input
+		 * at this point.
+		 */
+		yesno = git_prompt(_("Do you want me to do it for you "
+				     "[Y/n]? "), PROMPT_ECHO);
+		if (starts_with(yesno, "n") || starts_with(yesno, "N"))
+			exit(0);
+
+		return bisect_start(terms, 0, argv, 0);
+	}
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -767,6 +797,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
+		BISECT_AUTOSTART,
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -790,6 +821,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
+		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
+			 N_("start the bisection if BISECT_START empty or missing"), BISECT_AUTOSTART),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -862,6 +895,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
+	case BISECT_AUTOSTART:
+		if (argc)
+			die(_("--bisect-autostart requires 0 arguments"));
+		terms.term_good = "good";
+		terms.term_bad = "bad";
+		res = bisect_autostart(&terms);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index d574c44..cd56551 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -49,27 +49,6 @@ bisect_head()
 	fi
 }
 
-bisect_autostart() {
-	test -s "$GIT_DIR/BISECT_START" || {
-		gettextln "You need to start by \"git bisect start\"" >&2
-		if test -t 0
-		then
-			# TRANSLATORS: Make sure to include [Y] and [n] in your
-			# translation. The program will only accept English input
-			# at this point.
-			gettext "Do you want me to do it for you [Y/n]? " >&2
-			read yesno
-			case "$yesno" in
-			[Nn]*)
-				exit ;;
-			esac
-			git bisect--helper --bisect-start
-		else
-			exit 1
-		fi
-	}
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -86,7 +65,7 @@ bisect_skip() {
 }
 
 bisect_state() {
-	bisect_autostart
+	git bisect--helper --bisect-autostart
 	state=$1
 	get_terms
 	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit

--
https://github.com/git/git/pull/287
