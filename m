Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23129202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdGMPHi (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:07:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:39158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752082AbdGMPHh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:07:37 -0400
Received: (qmail 24390 invoked by uid 109); 13 Jul 2017 15:07:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:07:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32280 invoked by uid 111); 13 Jul 2017 15:07:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:07:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:07:30 -0400
Date:   Thu, 13 Jul 2017 11:07:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 13/15] rev-list: pass diffopt->use_colors through to
 pretty-print
Message-ID: <20170713150729.fccsplqohebnqb4l@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rev-list pretty-prints a commit, it creates a new
pretty_print_context and copies items from the rev_info
struct. We don't currently copy the "use_color" field,
though. Nobody seems to have noticed because the only part
of pretty.c that cares is the %C(auto,...) placeholder, and
presumably not many people use that with the rev-list
plumbing (as opposed to with git-log).

It will become more noticeable in a future patch, though,
when we start treating all user-format colors as auto-colors
(in which case it would become impossible to format colors
with rev-list, even with --color=always).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c         |  1 +
 t/t6006-rev-list-format.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 95d84d5cd..fee10d856 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -122,6 +122,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.date_mode_explicit = revs->date_mode_explicit;
 		ctx.fmt = revs->commit_format;
 		ctx.output_encoding = get_log_output_encoding();
+		ctx.color = revs->diffopt.use_color;
 		pretty_print_commit(&ctx, commit, &buf);
 		if (buf.len) {
 			if (revs->commit_format != CMIT_FMT_ONELINE)
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 647218b4e..7b97a90ba 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -245,6 +245,17 @@ test_expect_success '%C(auto) respects --no-color' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list %C(auto,...) respects --color' '
+	git rev-list --color --format="%C(auto,green)foo%C(auto,reset)" \
+		-1 HEAD >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	cat >expect <<-EOF &&
+	commit $(git rev-parse HEAD)
+	<GREEN>foo<RESET>
+	EOF
+	test_cmp expect actual
+'
+
 iconv -f utf-8 -t $test_encoding > commit-msg <<EOF
 Test printing of complex bodies
 
-- 
2.13.2.1157.gc6daca446

