Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E682020D0A
	for <e@80x24.org>; Tue, 30 May 2017 05:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750905AbdE3FTd (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:19:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:59641 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbdE3FTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:19:32 -0400
Received: (qmail 13124 invoked by uid 109); 30 May 2017 05:19:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 05:19:32 +0000
Received: (qmail 20928 invoked by uid 111); 30 May 2017 05:20:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 01:20:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 01:19:30 -0400
Date:   Tue, 30 May 2017 01:19:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 8/8] t0012: test "-h" with builtins
Message-ID: <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 99caeed05 (Let 'git <command> -h' show usage
without a git dir, 2009-11-09), the git wrapper handles "-h"
specially, skipping any repository setup but still calling
the builtin's cmd_foo() function. This means that every
cmd_foo() must be ready to handle this case, but we don't
have any systematic tests. This led to "git am -h" being
broken for some time without anybody noticing.

This patch just tests that "git foo -h" works for every
builtin, where we see a 129 exit code (the normal code for
our usage() helper), and that the word "usage" appears in
the output.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0012-help.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 8faba2e8b..487b92a5d 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -49,4 +49,16 @@ test_expect_success "--help does not work for guides" "
 	test_i18ncmp expect actual
 "
 
+test_expect_success 'generate builtin list' '
+	git --list-builtins >builtins
+'
+
+while read builtin
+do
+	test_expect_success "$builtin can handle -h" '
+		test_expect_code 129 git $builtin -h >output 2>&1 &&
+		test_i18ngrep usage output
+	'
+done <builtins
+
 test_done
-- 
2.13.0.613.g11c956365
