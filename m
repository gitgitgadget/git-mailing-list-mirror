Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5601D1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 04:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbeJaNVE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 09:21:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33764 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728663AbeJaNVE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 09:21:04 -0400
Received: (qmail 7486 invoked by uid 109); 31 Oct 2018 04:24:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Oct 2018 04:24:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7112 invoked by uid 111); 31 Oct 2018 04:23:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 31 Oct 2018 00:23:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2018 00:24:42 -0400
Date:   Wed, 31 Oct 2018 00:24:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jon Simons <jon@jonsimons.org>
Subject: [PATCH 2/2] ls-remote: pass heads/tags prefixes to transport
Message-ID: <20181031042441.GB5503@sigill.intra.peff.net>
References: <20181031042318.GA5347@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181031042318.GA5347@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike its arbitrary text patterns, the --heads and --tags
options to ls-remote are true prefixes. We can pass this
information to the transport code. If the v2 protocol is in
use, that will reduce the size of the ref advertisement.

Note that the test added here succeeds both before and after
the patch. This is an optimization, not a bug-fix; it's just
making sure we didn't break anything.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/ls-remote.c  | 5 +++++
 t/t5512-ls-remote.sh | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 5faa8459d9..1d7f1f5ce2 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -92,6 +92,11 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (flags & REF_TAGS)
+		argv_array_push(&ref_prefixes, "refs/tags/");
+	if (flags & REF_HEADS)
+		argv_array_push(&ref_prefixes, "refs/heads/");
+
 	remote = remote_get(dest);
 	if (!remote) {
 		if (dest)
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index ca1b7e5bc1..91ee6841c1 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -311,4 +311,13 @@ test_expect_success 'ls-remote patterns work with all protocol versions' '
 	test_cmp expect actual.v2
 '
 
+test_expect_success 'ls-remote prefixes work with all protocol versions' '
+	git for-each-ref --format="%(objectname)	%(refname)" \
+		refs/heads/ refs/tags/ >expect &&
+	git -c protocol.version=1 ls-remote --heads --tags . >actual.v1 &&
+	test_cmp expect actual.v1 &&
+	git -c protocol.version=2 ls-remote --heads --tags . >actual.v2 &&
+	test_cmp expect actual.v2
+'
+
 test_done
-- 
2.19.1.1298.g19f18f2a22
