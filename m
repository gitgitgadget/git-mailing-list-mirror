Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08468C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjC1Uyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC1Uyf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:54:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264241FEC
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:54:34 -0700 (PDT)
Received: (qmail 2251 invoked by uid 109); 28 Mar 2023 20:54:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:54:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2215 invoked by uid 111); 28 Mar 2023 20:54:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:54:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:54:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/7] builtins: always pass prefix to parse_options()
Message-ID: <20230328205432.GB1754055@coredump.intra.peff.net>
References: <20230328205253.GA1753925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328205253.GA1753925@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our builtins receive a "prefix" argument as part of their cmd_foo()
function. We should always pass this to parse_options() if we're calling
it, as it may be used for OPT_FILENAME() options.

In the cases here, there's no option that would use it, so we're not
fixing any bug. This is just future-proofing and setting a good example
(plus quelling some -Wunused-parameter warnings).

Note in the case of revert/cherry-pick, that we plumb the prefix through
to run_sequencer(), as those builtins are just thin wrappers around it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mktag.c  | 2 +-
 builtin/revert.c | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 42c2457c705..967a4442dee 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -81,7 +81,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	int tagged_type;
 	struct object_id result;
 
-	argc = parse_options(argc, argv, NULL,
+	argc = parse_options(argc, argv, prefix,
 			     builtin_mktag_options,
 			     builtin_mktag_usage, 0);
 
diff --git a/builtin/revert.c b/builtin/revert.c
index 62986a7b1b0..287721fd37b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -94,7 +94,8 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 		die(_("%s: %s cannot be used with %s"), me, this_opt, base_opt);
 }
 
-static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
+static int run_sequencer(int argc, const char **argv, const char *prefix,
+			 struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
@@ -141,7 +142,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		options = parse_options_concat(options, cp_extra);
 	}
 
-	argc = parse_options(argc, argv, NULL, options, usage_str,
+	argc = parse_options(argc, argv, prefix, options, usage_str,
 			PARSE_OPT_KEEP_ARGV0 |
 			PARSE_OPT_KEEP_UNKNOWN_OPT);
 
@@ -246,7 +247,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 
 	opts.action = REPLAY_REVERT;
 	sequencer_init_config(&opts);
-	res = run_sequencer(argc, argv, &opts);
+	res = run_sequencer(argc, argv, prefix, &opts);
 	if (res < 0)
 		die(_("revert failed"));
 	replay_opts_release(&opts);
@@ -260,7 +261,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
 	opts.action = REPLAY_PICK;
 	sequencer_init_config(&opts);
-	res = run_sequencer(argc, argv, &opts);
+	res = run_sequencer(argc, argv, prefix, &opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	replay_opts_release(&opts);
-- 
2.40.0.675.gb17cd5d94c8

