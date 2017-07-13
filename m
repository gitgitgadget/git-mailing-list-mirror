Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB92202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbdGMPHW (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:07:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:39156 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751337AbdGMPHW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:07:22 -0400
Received: (qmail 24358 invoked by uid 109); 13 Jul 2017 15:07:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:07:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32277 invoked by uid 111); 13 Jul 2017 15:07:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:07:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:07:14 -0400
Date:   Thu, 13 Jul 2017 11:07:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/15] for-each-ref: load config earlier
Message-ID: <20170713150714.p6272nblhg53sdrd@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In most commands we load config before parsing command line
options, since it lets the latter override the former with a
simple variable assignment. In the case of for-each-ref,
though, we do it in the reverse order. This is OK with
the current code, since there's no interaction between the
config and command-line options.

However, as the ref-filter code starts to care about config
during verify_ref_format(), we'll want to make sure the
config is loaded. Let's bump the config to the usual spot
near the top of the function.

We can drop the comment there; it's impossible to keep a
"why we load the config" comment like this up to date with
every config option we might be interested in. And indeed,
it's already stale; we'd care about core.abbrev, for
instance, when %(objectname:short) is used.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/for-each-ref.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index f47066b42..5d7c921a7 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -54,6 +54,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
 
+	git_config(git_default_config, NULL);
+
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
 	if (maxcount < 0) {
 		error("invalid --count argument: `%d'", maxcount);
@@ -71,9 +73,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	sorting->ignore_case = icase;
 	filter.ignore_case = icase;
 
-	/* for warn_ambiguous_refs */
-	git_config(git_default_config, NULL);
-
 	filter.name_patterns = argv;
 	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
-- 
2.13.2.1157.gc6daca446

