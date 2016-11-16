Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D802042F
	for <e@80x24.org>; Wed, 16 Nov 2016 17:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933268AbcKPRSB (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 12:18:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:44000 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933080AbcKPRR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 12:17:59 -0500
Received: (qmail 15166 invoked by uid 109); 16 Nov 2016 17:17:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Nov 2016 17:17:58 +0000
Received: (qmail 17204 invoked by uid 111); 16 Nov 2016 08:46:59 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Nov 2016 03:46:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Nov 2016 00:46:26 -0800
Date:   Wed, 16 Nov 2016 00:46:26 -0800
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] rev-parse: fix parent shorthands with --symbolic
Message-ID: <20161116084624.6bfeiekwhdt7iscr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The try_parent_shorthands() function shows each parent via
show_rev(). We pass the correct parent sha1, but our "name"
parameter still points at the original refname. So asking
for a regular rev-parse works fine (it prints the sha1s),
but asking for the symbolic name gives nonsense like:

    $ git rev-parse --symbolic HEAD^-1
    HEAD
    ^HEAD

which is always an empty set of commits. Asking for "^!" is
likewise broken, with the added bonus that its prints ^HEAD
for _each_ parent. And "^@" just prints HEAD repeatedly.

Arguably it would be correct to just pass NULL as the name
here, and always get the parent expressed as a sha1. The
"--symbolic" documentaton claims only "as close to the
original input as possible", and we certainly fallback to
sha1s where necessary. But it's pretty easy to generate a
symbolic name on the fly from the original.

Signed-off-by: Jeff King <peff@peff.net>
---

I noticed this because tig uses "--symbolic", and "tig 1234abcd^-1" does
not work without this patch.

I thought at first it might be a regression in the upcoming v2.11 from
8779351dd (revision: new rev^-n shorthand for rev^n..rev, 2016-09-27).
But nope, "^!" has been broken at least as far back as v1.6.6.3 (I
didn't check further).

So assuming it's too late in the -rc cycle for a non-regression fix,
this is probably post-v2.11 maint material.

 builtin/rev-parse.c          |  7 ++++++-
 t/t6101-rev-parse-parents.sh | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index cfb0f1510..ff13e59e1 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -342,11 +342,16 @@ static int try_parent_shorthands(const char *arg)
 	for (parents = commit->parents, parent_number = 1;
 	     parents;
 	     parents = parents->next, parent_number++) {
+		char *name = NULL;
+
 		if (exclude_parent && parent_number != exclude_parent)
 			continue;
 
+		if (symbolic)
+			name = xstrfmt("%s^%d", arg, parent_number);
 		show_rev(include_parents ? NORMAL : REVERSED,
-			 parents->item->object.oid.hash, arg);
+			 parents->item->object.oid.hash, name);
+		free(name);
 	}
 
 	*dotdot = '^';
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 64a9850e3..8c617981a 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -83,12 +83,24 @@ test_expect_success 'final^1^@ = final^1^1 final^1^2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'symbolic final^1^@ = final^1^1 final^1^2' '
+	git rev-parse --symbolic final^1^1 final^1^2 >expect &&
+	git rev-parse --symbolic final^1^@ >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'final^1^! = final^1 ^final^1^1 ^final^1^2' '
 	git rev-parse final^1 ^final^1^1 ^final^1^2 >expect &&
 	git rev-parse final^1^! >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'symbolic final^1^! = final^1 ^final^1^1 ^final^1^2' '
+	git rev-parse --symbolic final^1 ^final^1^1 ^final^1^2 >expect &&
+	git rev-parse --symbolic final^1^! >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'large graft octopus' '
 	test_cmp_rev_output b31 "git rev-parse --verify b1^30"
 '
@@ -143,6 +155,12 @@ test_expect_success 'rev-parse merge^-2 = merge^2..merge' '
 	test_cmp expect actual
 '
 
+test_expect_success 'symbolic merge^-1 = merge^1..merge' '
+	git rev-parse --symbolic merge^1..merge >expect &&
+	git rev-parse --symbolic merge^-1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rev-parse merge^-0 (invalid parent)' '
 	test_must_fail git rev-parse merge^-0
 '
-- 
2.11.0.rc1.280.gf9bb6f9
