Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83EF20699
	for <e@80x24.org>; Tue, 23 Aug 2016 12:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758043AbcHWMAr (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 08:00:47 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:56587
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758022AbcHWMA1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 08:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=nv+X+x5zKMBcalN67MBGK7lwzdTIl/Z3UWYwwkYiBzM=;
        b=EZD3J6Pf7z8yl3pu9TQyN9UduIjtQ5j8GCaS+zYu1pZfwKG0ZxATYQDTMXMWMeGa
        4QZtRAsWFajKh4Jp4IaK//joQ7VuCi033G2DokQvhZfN95JyN+MU0OskiGtUQyKHftU
        D1b4qVTSkgayxAquts7v2p/eqnyqvpHKAdaYQwR8=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe6d5-6a363195-eb91-48a0-9a3c-3159fba6d327-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 21/27] bisect--helper: `bisect_log` shell function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Aug 2016 11:53:53 +0000
X-SES-Outgoing: 2016.08.23-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement the `bisect_log` shell function in C and also add
`--bisect-log` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-log` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other method.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 25 ++++++++++++++++++++++++-
 git-bisect.sh            |  7 +------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1b6e5d8..b57b0c8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -864,6 +864,21 @@ static int bisect_state(struct bisect_terms *terms, const char **argv,
 	return -1;
 }
 
+static int bisect_log(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (strbuf_read_file(&buf, git_path_bisect_log(), 256) < 0) {
+		strbuf_release(&buf);
+		return error(_("We are not bisecting.\n"));
+	}
+
+	printf("%s", buf.buf);
+	strbuf_release(&buf);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -876,7 +891,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
-		BISECT_STATE
+		BISECT_STATE,
+		BISECT_LOG
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -900,6 +916,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisection if BISECT_START empty or missing"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
+		OPT_CMDMODE(0, "bisect-log", &cmdmode,
+			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -978,6 +996,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_state(&terms, argv, argc);
 		break;
+	case BISECT_LOG:
+		if (argc > 1)
+			die(_("--bisect-log requires 0 arguments"));
+		res = bisect_log();
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index a9eebbb..a47e3b5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -166,11 +166,6 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 	done
 }
 
-bisect_log () {
-	test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting.")"
-	cat "$GIT_DIR/BISECT_LOG"
-}
-
 get_terms () {
 	if test -s "$GIT_DIR/BISECT_TERMS"
 	then
@@ -208,7 +203,7 @@ case "$#" in
 	replay)
 		bisect_replay "$@" ;;
 	log)
-		bisect_log ;;
+		git bisect--helper --bisect-log ;;
 	run)
 		bisect_run "$@" ;;
 	terms)

--
https://github.com/git/git/pull/287
