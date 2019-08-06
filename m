Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3EDE1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 14:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbfHFOj7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 10:39:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:35398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729535AbfHFOj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 10:39:59 -0400
Received: (qmail 17873 invoked by uid 109); 6 Aug 2019 14:39:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 14:39:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2393 invoked by uid 111); 6 Aug 2019 14:42:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 10:42:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 10:39:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] revision: allow --end-of-options to end option parsing
Message-ID: <20190806143957.GA2161@sigill.intra.peff.net>
References: <20190806143829.GA515@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806143829.GA515@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's currently no robust way to tell Git that a particular option is
meant to be a revision, and not an option. So if you have a branch
"refs/heads/--foo", you cannot just say:

  git rev-list --foo

You can say:

  git rev-list refs/heads/--foo

But that breaks down if you don't know the refname, and in particular if
you're a script passing along a value from elsewhere. In most programs,
you can use "--" to end option parsing, like this:

  some-prog -- "$revision"

But that doesn't work for the revision parser, because "--" is already
meaningful there: it separates revisions from pathspecs. So we need some
other marker to separate options from revisions.

This patch introduces "--end-of-options", which serves that purpose:

  git rev-list --oneline --end-of-options "$revision"

will work regardless of what's in "$revision" (well, if you say "--" it
may fail, but it won't do something dangerous, like triggering an
unexpected option).

The name is verbose, but that's probably a good thing; this is meant to
be used for scripted invocations where readability is more important
than terseness.

One alternative would be to introduce an explicit option to mark a
revision, like:

  git rev-list --oneline --revision="$revision"

That's slightly _more_ informative than this commit (because it makes
even something silly like "--" unambiguous). But the pattern of using a
separator like "--" is well established in git and in other commands,
and it makes some scripting tasks simpler like:

  git rev-list --end-of-options "$@"

There's no documentation in this patch, because it will make sense to
describe the feature once it is available everywhere (and support will
be added in further patches).

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c               | 8 +++++++-
 t/t6000-rev-list-misc.sh | 8 ++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 07412297f0..51690e480d 100644
--- a/revision.c
+++ b/revision.c
@@ -2523,6 +2523,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	int i, flags, left, seen_dashdash, got_rev_arg = 0, revarg_opt;
 	struct argv_array prune_data = ARGV_ARRAY_INIT;
 	const char *submodule = NULL;
+	int seen_end_of_options = 0;
 
 	if (opt)
 		submodule = opt->submodule;
@@ -2552,7 +2553,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		revarg_opt |= REVARG_CANNOT_BE_FILENAME;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (*arg == '-') {
+		if (!seen_end_of_options && *arg == '-') {
 			int opts;
 
 			opts = handle_revision_pseudo_opt(submodule,
@@ -2574,6 +2575,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				continue;
 			}
 
+			if (!strcmp(arg, "--end-of-options")) {
+				seen_end_of_options = 1;
+				continue;
+			}
+
 			opts = handle_revision_opt(revs, argc - i, argv + i,
 						   &left, argv, opt);
 			if (opts > 0) {
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 52a9e38d66..b8cf82349b 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -140,4 +140,12 @@ test_expect_success '--header shows a NUL after each commit' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list --end-of-options' '
+	git update-ref refs/heads/--output=yikes HEAD &&
+	git rev-list --end-of-options --output=yikes >actual &&
+	test_path_is_missing yikes &&
+	git rev-list HEAD >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.23.0.rc1.436.g24d2e81391

