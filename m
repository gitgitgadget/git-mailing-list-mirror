Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86B9C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 19:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A8D64DEC
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 19:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhA1T6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 14:58:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:42306 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhA1T6X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 14:58:23 -0500
Received: (qmail 15285 invoked by uid 109); 28 Jan 2021 19:57:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 19:57:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1001 invoked by uid 111); 28 Jan 2021 19:57:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 14:57:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 14:57:39 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] pretty: lazy-load commit data when expanding user-format
Message-ID: <YBMXM83xCZvC5WyA@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we expand a user-format, we try to avoid work that isn't necessary
for the output. For instance, we don't bother parsing the commit header
until we know we need the author, subject, etc.

But we do always load the commit object's contents from disk, even if
the format doesn't require it (e.g., just "%H"). Traditionally this
didn't matter much, because we'd have loaded it as part of the traversal
anyway, and we'd typically have those bytes attached to the commit
struct (or these days, cached in a commit-slab).

But when we have a commit-graph, we might easily get to the point of
pretty-printing a commit without ever having looked at the actual object
contents. We should push off that load (and reencoding) until we're
certain that it's needed.

I think the results of p4205 show the advantage pretty clearly (we serve
parent and tree oids out of the commit struct itself, so they benefit as
well):

  # using git.git as the test repo
  Test                          HEAD^             HEAD
  ----------------------------------------------------------------------
  4205.1: log with %H           0.40(0.39+0.01)   0.03(0.02+0.01) -92.5%
  4205.2: log with %h           0.45(0.44+0.01)   0.09(0.09+0.00) -80.0%
  4205.3: log with %T           0.40(0.39+0.00)   0.04(0.04+0.00) -90.0%
  4205.4: log with %t           0.46(0.46+0.00)   0.09(0.08+0.01) -80.4%
  4205.5: log with %P           0.39(0.39+0.00)   0.03(0.03+0.00) -92.3%
  4205.6: log with %p           0.46(0.46+0.00)   0.10(0.09+0.00) -78.3%
  4205.7: log with %h-%h-%h     0.52(0.51+0.01)   0.15(0.14+0.00) -71.2%
  4205.8: log with %an-%ae-%s   0.42(0.41+0.00)   0.42(0.41+0.01) +0.0%

  # using linux.git as the test repo
  Test                          HEAD^             HEAD
  ----------------------------------------------------------------------
  4205.1: log with %H           7.12(6.97+0.14)   0.76(0.65+0.11) -89.3%
  4205.2: log with %h           7.35(7.19+0.16)   1.30(1.19+0.11) -82.3%
  4205.3: log with %T           7.58(7.42+0.15)   1.02(0.94+0.08) -86.5%
  4205.4: log with %t           8.05(7.89+0.15)   1.55(1.41+0.13) -80.7%
  4205.5: log with %P           7.12(7.01+0.10)   0.76(0.69+0.07) -89.3%
  4205.6: log with %p           7.38(7.27+0.10)   1.32(1.20+0.12) -82.1%
  4205.7: log with %h-%h-%h     7.81(7.67+0.13)   1.79(1.67+0.12) -77.1%
  4205.8: log with %an-%ae-%s   7.90(7.74+0.15)   7.81(7.66+0.15) -1.1%

I added the final test to show where we don't improve (the 1% there is
just lucky noise), but also as a regression test to make sure we're not
doing anything stupid like loading the commit multiple times when there
are several placeholders that need it.

Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
This benefits "rev-list --format=", as well, though there you can also
use things like "--parents" instead, which are already fast.

 pretty.c                           | 23 ++++++++++++-----------
 t/perf/p4205-log-pretty-formats.sh |  2 +-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/pretty.c b/pretty.c
index 3922f6f9f2..b4ff3f602f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -783,6 +783,7 @@ enum trunc_type {
 };
 
 struct format_commit_context {
+	struct repository *repository;
 	const struct commit *commit;
 	const struct pretty_print_context *pretty_ctx;
 	unsigned commit_header_parsed:1;
@@ -1373,10 +1374,13 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 2;
 	}
 
-
 	/* For the rest we have to parse the commit header. */
-	if (!c->commit_header_parsed)
+	if (!c->commit_header_parsed) {
+		msg = c->message =
+			repo_logmsg_reencode(c->repository, commit,
+					     &c->commit_encoding, "UTF-8");
 		parse_commit_header(c);
+	}
 
 	switch (placeholder[0]) {
 	case 'a':	/* author ... */
@@ -1667,25 +1671,22 @@ void repo_format_commit_message(struct repository *r,
 				const struct pretty_print_context *pretty_ctx)
 {
 	struct format_commit_context context = {
+		.repository = r,
 		.commit = commit,
 		.pretty_ctx = pretty_ctx,
 		.wrap_start = sb->len
 	};
 	const char *output_enc = pretty_ctx->output_encoding;
 	const char *utf8 = "UTF-8";
 
-	/*
-	 * convert a commit message to UTF-8 first
-	 * as far as 'format_commit_item' assumes it in UTF-8
-	 */
-	context.message = repo_logmsg_reencode(r, commit,
-					       &context.commit_encoding,
-					       utf8);
-
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
 
-	/* then convert a commit message to an actual output encoding */
+	/*
+	 * Convert output to an actual output encoding; note that
+	 * format_commit_item() will always use UTF-8, so we don't
+	 * have to bother if that's what the output wants.
+	 */
 	if (output_enc) {
 		if (same_encoding(utf8, output_enc))
 			output_enc = NULL;
diff --git a/t/perf/p4205-log-pretty-formats.sh b/t/perf/p4205-log-pretty-formats.sh
index 7c26f4f337..609fecd65d 100755
--- a/t/perf/p4205-log-pretty-formats.sh
+++ b/t/perf/p4205-log-pretty-formats.sh
@@ -6,7 +6,7 @@ test_description='Tests the performance of various pretty format placeholders'
 
 test_perf_default_repo
 
-for format in %H %h %T %t %P %p %h-%h-%h
+for format in %H %h %T %t %P %p %h-%h-%h %an-%ae-%s
 do
 	test_perf "log with $format" "
 		git log --format=\"$format\" >/dev/null
-- 
2.30.0.757.g41d9b3dd9b
