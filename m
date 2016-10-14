Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3BB1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757362AbcJNOOb (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:14:31 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:32819
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757289AbcJNOOT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=nek9FSc4VkVEE0NT50XLrKmjgLPTJfkjt8bfT4jvbX8=;
        b=X13ROO5jf977US2xoF90DOjXwvluMBQBUY9zSWeHt5lTMknl7tquI784MFCYzIdm
        B+hRToCQwtmLulPU20Fbpd3nRmA0uQ6xJjaJJr4aQYnhA+YKgJk3coez9bYmG23kVKc
        WukwJFJKryc84wDyTYxdQFttA1erKPeB6sk1JXNA=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1b18-b81203b0-122f-4244-bfb2-9fac8ae71767-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 22/27] bisect--helper: `bisect_log` shell function in C
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
 builtin/bisect--helper.c | 27 ++++++++++++++++++++++++++-
 git-bisect.sh            |  7 +------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 493034c..c18ca07 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -858,6 +858,23 @@ static int bisect_state(struct bisect_terms *terms, const char **argv,
 	return -1;
 }
 
+static int bisect_log(void)
+{
+	int fd, status;
+	fd = open(git_path_bisect_log(), O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	status = copy_fd(fd, 1);
+	if (status) {
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+	return status;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -870,7 +887,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
-		BISECT_STATE
+		BISECT_STATE,
+		BISECT_LOG
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -894,6 +912,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisection if BISECT_START empty or missing"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
+		OPT_CMDMODE(0, "bisect-log", &cmdmode,
+			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -973,6 +993,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
