Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312AF202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 14:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbdGMO4N (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 10:56:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:39080 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752378AbdGMO4M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 10:56:12 -0400
Received: (qmail 23842 invoked by uid 109); 13 Jul 2017 14:56:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 14:56:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32032 invoked by uid 111); 13 Jul 2017 14:56:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 10:56:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 10:56:10 -0400
Date:   Thu, 13 Jul 2017 10:56:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/15] check return value of verify_ref_format()
Message-ID: <20170713145610.gpomty7guf54lmsb@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users of the ref-filter code must call verify_ref_format()
before formatting any refs, but most ignore its return
value. This means we may print an error on a syntactically
bogus pattern, but keep going anyway.

In most cases this results in a fatal error when we actually
try to format a ref. But if you have no refs to show at all,
then the behavior is confusing: git prints the error from
verify_ref_format(), then exits with code 0 without showing
any output.  Let's instead abort immediately if we know we
have a bogus format.

We'll output the usage information if we have it handy (just
like the existing call in cmd_for_each_ref() does), and
otherwise just die().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c     | 4 +++-
 builtin/tag.c        | 7 ++++---
 builtin/verify-tag.c | 4 +++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 8a0595e11..e756a5667 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -409,7 +409,9 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 
 	if (!format)
 		format = to_free = build_format(filter, maxwidth, remote_prefix);
-	verify_ref_format(format);
+
+	if (verify_ref_format(format))
+		die(_("unable to parse format string"));
 
 	ref_array_sort(sorting, &array);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 01154ea8d..216629fb2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -53,7 +53,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 			format = "%(refname:lstrip=2)";
 	}
 
-	verify_ref_format(format);
+	if (verify_ref_format(format))
+		die(_("unable to parse format string"));
 	filter->with_commit_tag_algo = 1;
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
 	ref_array_sort(sorting, &array);
@@ -501,8 +502,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag, NULL);
 	if (cmdmode == 'v') {
-		if (format)
-			verify_ref_format(format);
+		if (format && verify_ref_format(format))
+			usage_with_options(git_tag_usage, options);
 		return for_each_tag_name(argv, verify_tag, format);
 	}
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f9a5f7535..a10eca2b2 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -51,7 +51,9 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		flags |= GPG_VERIFY_VERBOSE;
 
 	if (fmt_pretty) {
-		verify_ref_format(fmt_pretty);
+		if (verify_ref_format(fmt_pretty))
+			usage_with_options(verify_tag_usage,
+					   verify_tag_options);
 		flags |= GPG_VERIFY_OMIT_STATUS;
 	}
 
-- 
2.13.2.1157.gc6daca446

