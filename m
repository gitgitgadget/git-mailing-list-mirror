Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6B4202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 16:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbdCOQ43 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 12:56:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:44651 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753379AbdCOQ41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 12:56:27 -0400
Received: (qmail 17029 invoked by uid 109); 15 Mar 2017 16:56:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 16:56:26 +0000
Received: (qmail 29409 invoked by uid 111); 15 Mar 2017 16:56:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 12:56:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 12:56:23 -0400
Date:   Wed, 15 Mar 2017 12:56:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] cherry-pick: detect bogus arguments to --mainline
Message-ID: <20170315165623.sniukjnhonf3uddy@sigill.intra.peff.net>
References: <CACBZZX7Um==4pWfUVcLM8Kbk-ry8HQAmDoUVGjVPmhY3ZXUNYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7Um==4pWfUVcLM8Kbk-ry8HQAmDoUVGjVPmhY3ZXUNYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 12:08:35AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Both of these emit the "is a merge but no -m option was given" when
> <commit> is a merge.
> 
> I tried to track this down for a bit in the options parsing code but
> couldn't see where it was happening, but at some point we're setting
> opts->mainline to 0 both when it's not provided, and when it's
> explicitly provided as 0.
> 
> Instead we should e.g. pass "no option" through as NULL to the
> sequencer, and emit some better error about how -m isn't zero-indexed.

The "0" comes from the initialization of the replay_opts struct (it also
happens if you explicitly disclaim any previous option with
--no-mainline).

I think using 0 as a sentinel is OK here, but the option-parser should
complain when we go out of range. Like this:

-- >8 --
Subject: [PATCH] cherry-pick: detect bogus arguments to --mainline

The cherry-pick and revert commands use OPT_INTEGER() to
parse --mainline. The stock parser is smart enough to reject
non-numeric nonsense, but it doesn't know that parent
counting starts at 1.

Worse, the value "0" is indistinguishable from the unset
case, so a user who assumes the counting is 0-based will get
a confusing message:

  $ git cherry-pick -m 0 $merge
  error: commit ... is a merge but no -m option was given.

Let's use a custom callback that enforces our range.

Signed-off-by: Jeff King <peff@peff.net>
---
Another option would be to add a range-checking variant of OPT_INTEGER,
and have something like:

  OPT_RANGE('m', "mainline", &opt->mainline, 1, INT_MAX,
            N_("parent number"))

I don't know if other places would want to make use of it, though. The
callback approach is way more flexible in general.

 builtin/revert.c             | 21 ++++++++++++++++++++-
 t/t3502-cherry-pick-merge.sh |  9 +++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 4ca5b5154..345d9586a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -54,6 +54,24 @@ static int option_parse_x(const struct option *opt,
 	return 0;
 }
 
+static int option_parse_m(const struct option *opt,
+			  const char *arg, int unset)
+{
+	struct replay_opts *replay = opt->value;
+	char *end;
+
+	if (unset) {
+		replay->mainline = 0;
+		return 0;
+	}
+
+	replay->mainline = strtol(arg, &end, 10);
+	if (*end || replay->mainline <= 0)
+		return opterror(opt, "expects a number greater than zero", 0);
+
+	return 0;
+}
+
 LAST_ARG_MUST_BE_NULL
 static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 {
@@ -84,7 +102,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
 		OPT_BOOL('s', "signoff", &opts->signoff, N_("add Signed-off-by:")),
-		OPT_INTEGER('m', "mainline", &opts->mainline, N_("parent number")),
+		OPT_CALLBACK('m', "mainline", opts, N_("parent-number"),
+			     N_("select mainline parent"), option_parse_m),
 		OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
 		OPT_STRING(0, "strategy", &opts->strategy, N_("strategy"), N_("merge strategy")),
 		OPT_CALLBACK('X', "strategy-option", &opts, N_("option"),
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index e37547f41..b1602718f 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -31,6 +31,15 @@ test_expect_success setup '
 
 '
 
+test_expect_success 'cherry-pick -m complains of bogus numbers' '
+	# expect 129 here to distinguish between cases where
+	# there was nothing to cherry-pick
+	test_expect_code 129 git cherry-pick -m &&
+	test_expect_code 129 git cherry-pick -m foo b &&
+	test_expect_code 129 git cherry-pick -m -1 b &&
+	test_expect_code 129 git cherry-pick -m 0 b
+'
+
 test_expect_success 'cherry-pick a non-merge with -m should fail' '
 
 	git reset --hard &&
-- 
2.12.0.613.g6e7c52a0d

