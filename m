Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C58202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 20:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbdCOUIH (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 16:08:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:44765 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbdCOUIG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 16:08:06 -0400
Received: (qmail 30014 invoked by uid 109); 15 Mar 2017 20:08:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 20:08:05 +0000
Received: (qmail 27881 invoked by uid 111); 15 Mar 2017 20:08:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 16:08:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 16:08:02 -0400
Date:   Wed, 15 Mar 2017 16:08:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] rev-parse: simplify parsing of ref options
Message-ID: <20170315200802.r4un6p5admfu4h34@sigill.intra.peff.net>
References: <20170315200521.qwcm5tqcdzkbwp3x@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315200521.qwcm5tqcdzkbwp3x@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of these options do the same thing "--foo" iterates over
the "foo" refs, and "--foo=<glob>" does the same with a
glob. We can factor this into its own function to avoid
repeating ourselves.

There are two subtleties to note:

  - the original called for_each_branch_ref(), etc, in the
    non-glob case. Now we will call for_each_ref_in("refs/heads/")
    which is exactly what for_each_branch_ref() did under
    the hood.

  - for --glob, we'll call for_each_glob_ref_in() with a
    NULL "prefix" argument. Which is exactly what
    for_each_glob_ref() was doing already.

So both cases should behave identically, and it seems
reasonable to assume that this will remain the same. The
functions we are calling now are the more-generic ones, and
the ones we are dropping are just convenience wrappers.

Signed-off-by: Jeff King <peff@peff.net>
---
This actually drops the last caller for for_each_branch_ref(). I'm not
sure if we shoulder consider cleaning up the proliferation of
for_each_ref() helpers.

 builtin/rev-parse.c | 45 ++++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index db1417160..76be91350 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -554,6 +554,15 @@ static int opt_with_value(const char *arg, const char *opt, const char **value)
 	return 0;
 }
 
+static void handle_ref_opt(const char *pattern, const char *prefix)
+{
+	if (pattern)
+		for_each_glob_ref_in(show_reference, pattern, prefix, NULL);
+	else
+		for_each_ref_in(prefix, show_reference, NULL);
+	clear_ref_exclusion(&ref_excludes);
+}
+
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
@@ -749,42 +758,20 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
 			}
-			if (skip_prefix(arg, "--branches=", &arg)) {
-				for_each_glob_ref_in(show_reference, arg,
-					"refs/heads/", NULL);
-				clear_ref_exclusion(&ref_excludes);
-				continue;
-			}
-			if (!strcmp(arg, "--branches")) {
-				for_each_branch_ref(show_reference, NULL);
-				clear_ref_exclusion(&ref_excludes);
-				continue;
-			}
-			if (skip_prefix(arg, "--tags=", &arg)) {
-				for_each_glob_ref_in(show_reference, arg,
-					"refs/tags/", NULL);
-				clear_ref_exclusion(&ref_excludes);
+			if (opt_with_value(arg, "--branches", &arg)) {
+				handle_ref_opt(arg, "refs/heads/");
 				continue;
 			}
-			if (!strcmp(arg, "--tags")) {
-				for_each_tag_ref(show_reference, NULL);
-				clear_ref_exclusion(&ref_excludes);
+			if (opt_with_value(arg, "--tags", &arg)) {
+				handle_ref_opt(arg, "refs/tags/");
 				continue;
 			}
 			if (skip_prefix(arg, "--glob=", &arg)) {
-				for_each_glob_ref(show_reference, arg, NULL);
-				clear_ref_exclusion(&ref_excludes);
-				continue;
-			}
-			if (skip_prefix(arg, "--remotes=", &arg)) {
-				for_each_glob_ref_in(show_reference, arg,
-					"refs/remotes/", NULL);
-				clear_ref_exclusion(&ref_excludes);
+				handle_ref_opt(arg, NULL);
 				continue;
 			}
-			if (!strcmp(arg, "--remotes")) {
-				for_each_remote_ref(show_reference, NULL);
-				clear_ref_exclusion(&ref_excludes);
+			if (opt_with_value(arg, "--remotes", &arg)) {
+				handle_ref_opt(arg, "refs/remotes/");
 				continue;
 			}
 			if (skip_prefix(arg, "--exclude=", &arg)) {
-- 
2.12.0.613.g6e7c52a0d
