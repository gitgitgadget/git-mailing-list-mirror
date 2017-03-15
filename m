Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6255C202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 20:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbdCOUG6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 16:06:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:44762 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753626AbdCOUG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 16:06:57 -0400
Received: (qmail 29876 invoked by uid 109); 15 Mar 2017 20:06:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 20:06:56 +0000
Received: (qmail 25736 invoked by uid 111); 15 Mar 2017 20:07:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 16:07:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 16:06:53 -0400
Date:   Wed, 15 Mar 2017 16:06:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] rev-parse: add helper for parsing "--foo/--foo="
Message-ID: <20170315200653.ougdpmv2oombefrt@sigill.intra.peff.net>
References: <20170315200521.qwcm5tqcdzkbwp3x@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315200521.qwcm5tqcdzkbwp3x@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can't just use a bare skip_prefix() for these cases,
because we need to match both the "--foo" form and the
"--foo=<value>" form (and tell the difference between the
two in the caller).

We can wrap this in a simple helper which has two obvious
callsites, and will gain some more in the next patch.

Note that the error output for abbrev-ref changes slightly,
as we don't keep our original "arg" pointer. However, the
new output should hopefully be more clear:

  [before]
  fatal: unknown mode for --abbrev-ref=foo

  [after]
  fatal: unknown mode for --abbrev-ref: foo

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 836ccf00e..db1417160 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -535,6 +535,25 @@ N_("git rev-parse --parseopt [<options>] -- [<args>...]\n"
    "\n"
    "Run \"git rev-parse --parseopt -h\" for more information on the first usage.");
 
+/*
+ * Parse "opt" or "opt=<value>", setting value respectively to either
+ * NULL or the string after "=".
+ */
+static int opt_with_value(const char *arg, const char *opt, const char **value)
+{
+	if (skip_prefix(arg, opt, &arg)) {
+		if (!*arg) {
+			*value = NULL;
+			return 1;
+		}
+		if (*arg++ == '=') {
+			*value = arg;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
@@ -674,14 +693,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				flags |= GET_SHA1_QUIETLY;
 				continue;
 			}
-			if (!strcmp(arg, "--short") ||
-			    starts_with(arg, "--short=")) {
+			if (opt_with_value(arg, "--short", &arg)) {
 				filter &= ~(DO_FLAGS|DO_NOREV);
 				verify = 1;
 				abbrev = DEFAULT_ABBREV;
-				if (!arg[7])
+				if (!arg)
 					continue;
-				abbrev = strtoul(arg + 8, NULL, 10);
+				abbrev = strtoul(arg, NULL, 10);
 				if (abbrev < MINIMUM_ABBREV)
 					abbrev = MINIMUM_ABBREV;
 				else if (40 <= abbrev)
@@ -704,17 +722,17 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				symbolic = SHOW_SYMBOLIC_FULL;
 				continue;
 			}
-			if (starts_with(arg, "--abbrev-ref") &&
-			    (!arg[12] || arg[12] == '=')) {
+			if (opt_with_value(arg, "--abbrev-ref", &arg)) {
 				abbrev_ref = 1;
 				abbrev_ref_strict = warn_ambiguous_refs;
-				if (arg[12] == '=') {
-					if (!strcmp(arg + 13, "strict"))
+				if (arg) {
+					if (!strcmp(arg, "strict"))
 						abbrev_ref_strict = 1;
-					else if (!strcmp(arg + 13, "loose"))
+					else if (!strcmp(arg, "loose"))
 						abbrev_ref_strict = 0;
 					else
-						die("unknown mode for %s", arg);
+						die("unknown mode for --abbrev-ref: %s",
+						    arg);
 				}
 				continue;
 			}
-- 
2.12.0.613.g6e7c52a0d

