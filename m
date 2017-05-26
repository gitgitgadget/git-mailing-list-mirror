Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187EF1FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932475AbdEZTIy (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:08:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:58610 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932478AbdEZTIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:08:48 -0400
Received: (qmail 21728 invoked by uid 109); 26 May 2017 19:08:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 19:08:41 +0000
Received: (qmail 32166 invoked by uid 111); 26 May 2017 19:09:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 15:09:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 May 2017 15:08:39 -0400
Date:   Fri, 26 May 2017 15:08:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 4/6] check_filename(): handle ":^" path magic
Message-ID: <20170526190839.773oeulwzxnl3x3n@sigill.intra.peff.net>
References: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We special-case "git log :/foo" to work when "foo" exists in
the working tree. But :^ (and its alias :!) do not get the
same treatment, requiring the user to supply a
disambiguating "--". Let's make them work without requiring
the user to type the "--".

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c                       |  4 ++++
 t/t4208-log-magic-pathspec.sh | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/setup.c b/setup.c
index f2a8070bd..86bb7c9a9 100644
--- a/setup.c
+++ b/setup.c
@@ -141,6 +141,10 @@ int check_filename(const char *prefix, const char *arg)
 		if (!*arg) /* ":/" is root dir, always exists */
 			return 1;
 		prefix = NULL;
+	} else if (skip_prefix(arg, ":!", &arg) ||
+		   skip_prefix(arg, ":^", &arg)) {
+		if (!*arg) /* excluding everything is silly, but allowed */
+			return 1;
 	}
 
 	if (prefix)
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 70bc64100..67250ebdc 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -52,6 +52,19 @@ test_expect_success 'git log HEAD -- :/' '
 	test_cmp expected actual
 '
 
+test_expect_success '"git log :^sub" is not ambiguous' '
+	git log :^sub
+'
+
+test_expect_success '"git log :^does-not-exist" does not match anything' '
+	test_must_fail git log :^does-not-exist
+'
+
+test_expect_success  '"git log :!" behaves the same as :^' '
+	git log :!sub &&
+	test_must_fail git log :!does-not-exist
+'
+
 test_expect_success 'command line pathspec parsing for "git log"' '
 	git reset --hard &&
 	>a &&
-- 
2.13.0.496.ge44ba89db

