Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A311EC4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F802071E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgI3M3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:29:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:45300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3M3D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:29:03 -0400
Received: (qmail 23929 invoked by uid 109); 30 Sep 2020 12:29:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:29:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27948 invoked by uid 111); 30 Sep 2020 12:29:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:29:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:29:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/10] assert PARSE_OPT_NONEG in parse-options callbacks
Message-ID: <20200930122902.GD1901279@coredump.intra.peff.net>
References: <20200930122732.GA1901036@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930122732.GA1901036@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the spirit of 517fe807d6 (assert NOARG/NONEG behavior of
parse-options callbacks, 2018-11-05), let's cover some parse-options
callbacks which expect to be used with PARSE_OPT_NONEG but don't
explicitly assert that this is the case. These callbacks are all used
correctly in the current code, but this will help document their
expectations and future-proof the code.

As a bonus, it also silences -Wunused-parameters (these were added since
the initial sweep of 517fe807d6, and we can't yet turn on
-Wunused-parameters to remind people because it has too many existing
false positives).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c           | 2 ++
 builtin/commit-graph.c | 2 ++
 builtin/env--helper.c  | 2 ++
 parse-options-cb.c     | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 7259186408..2c7673f74e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2180,6 +2180,8 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 	};
 	int new_value = SHOW_PATCH_RAW;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (arg) {
 		for (new_value = 0; new_value < ARRAY_SIZE(valid_modes); new_value++) {
 			if (!strcmp(arg, valid_modes[new_value]))
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 988445abdf..78fa08f43a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -128,6 +128,8 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 {
 	enum commit_graph_split_flags *flags = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	opts.split = 1;
 	if (!arg)
 		return 0;
diff --git a/builtin/env--helper.c b/builtin/env--helper.c
index 3aa4282114..27349098b0 100644
--- a/builtin/env--helper.c
+++ b/builtin/env--helper.c
@@ -17,6 +17,8 @@ static int option_parse_type(const struct option *opt, const char *arg,
 {
 	enum cmdmode *cmdmode = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (!strcmp(arg, "bool"))
 		*cmdmode = ENV_HELPER_TYPE_BOOL;
 	else if (!strcmp(arg, "ulong"))
diff --git a/parse-options-cb.c b/parse-options-cb.c
index d9d3b0819f..4542d4d3f9 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -105,6 +105,8 @@ int parse_opt_commit(const struct option *opt, const char *arg, int unset)
 	struct commit *commit;
 	struct commit **target = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (!arg)
 		return -1;
 	if (get_oid(arg, &oid))
-- 
2.28.0.1173.gad90222cf0

