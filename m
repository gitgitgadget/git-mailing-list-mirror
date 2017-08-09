Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC790208B5
	for <e@80x24.org>; Wed,  9 Aug 2017 12:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbdHIM0q (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 08:26:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:33224 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753070AbdHIM0p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 08:26:45 -0400
Received: (qmail 3195 invoked by uid 109); 9 Aug 2017 12:26:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 12:26:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26759 invoked by uid 111); 9 Aug 2017 12:27:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 08:27:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 08:26:42 -0400
Date:   Wed, 9 Aug 2017 08:26:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] interpret-trailers: add --parse convenience option
Message-ID: <20170809122642.uwhv2epmgmr7wrk5@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last few commits have added command line options that
can turn interpret-trailers into a parsing tool. Since
they'd most often be used together, let's provide a
convenient single option for callers to invoke this mode.

This is implemented as a callback rather than a boolean so
that its effect is applied immediately, as if those options
had been specified. Later options can then override them.
E.g.:

  git interpret-trailers --parse --no-normalize

would work.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-interpret-trailers.txt |  4 ++++
 builtin/interpret-trailers.c             | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 6d867e8ab3..ab2d5c7696 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -93,6 +93,10 @@ OPTIONS
 	line, with any existing whitespace continuation folded into a
 	single line.
 
+--parse::
+	A convenience alias for `--only-trailers --only-existing
+	--normalize`.
+
 CONFIGURATION VARIABLES
 -----------------------
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index ed2d893b4f..70ca855aa6 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -16,6 +16,16 @@ static const char * const git_interpret_trailers_usage[] = {
 	NULL
 };
 
+static int parse_opt_parse(const struct option *opt, const char *arg,
+			   int unset)
+{
+	struct process_trailer_options *v = opt->value;
+	v->only_trailers = 1;
+	v->only_existing = 1;
+	v->normalize = 1;
+	return 0;
+}
+
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
@@ -27,6 +37,8 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
 		OPT_BOOL(0, "only-existing", &opts.only_existing, N_("output only existing trailers")),
 		OPT_BOOL(0, "normalize", &opts.normalize, N_("normalize trailer formatting")),
+		{ OPTION_CALLBACK, 0, "parse", &opts, NULL, N_("set parsing options"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse },
 		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add")),
 		OPT_END()
-- 
2.14.0.609.gd2d1f7ddf
