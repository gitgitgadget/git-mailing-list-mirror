Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705BC1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 04:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeJaNU3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 09:20:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:33754 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728663AbeJaNU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 09:20:28 -0400
Received: (qmail 7476 invoked by uid 109); 31 Oct 2018 04:24:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Oct 2018 04:24:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7095 invoked by uid 111); 31 Oct 2018 04:23:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 31 Oct 2018 00:23:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2018 00:24:05 -0400
Date:   Wed, 31 Oct 2018 00:24:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jon Simons <jon@jonsimons.org>
Subject: [PATCH 1/2] ls-remote: do not send ref prefixes for patterns
Message-ID: <20181031042405.GA5503@sigill.intra.peff.net>
References: <20181031042318.GA5347@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181031042318.GA5347@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since b4be74105f (ls-remote: pass ref prefixes when requesting a
remote's refs, 2018-03-15), "ls-remote foo" will pass "refs/heads/foo",
"refs/tags/foo", etc to the transport code in an attempt to let the
other side reduce the size of its advertisement.

Unfortunately this is not correct, as ls-remote patterns do not follow
the usual ref lookup rules, and are in fact tail-matched. So we could
find "refs/heads/foo" or "refs/heads/a/much/deeper/foo" or even
"refs/another/hierarchy/foo".

Since we can't pass a prefix and there's not yet a v2 extension for
matching wildcards, we must disable this feature to keep the same
behavior as v1.

Reported-by: Jon Simons <jon@jonsimons.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/ls-remote.c  | 8 --------
 t/t5512-ls-remote.sh | 9 +++++++++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 6a0cdec30d..5faa8459d9 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -88,15 +88,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		int i;
 		pattern = xcalloc(argc, sizeof(const char *));
 		for (i = 1; i < argc; i++) {
-			const char *glob;
 			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
-
-			glob = strchr(argv[i], '*');
-			if (glob)
-				argv_array_pushf(&ref_prefixes, "%.*s",
-						 (int)(glob - argv[i]), argv[i]);
-			else
-				expand_ref_prefix(&ref_prefixes, argv[i]);
 		}
 	}
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index bc5703ff9b..ca1b7e5bc1 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -302,4 +302,13 @@ test_expect_success 'ls-remote works outside repository' '
 	nongit git ls-remote dst.git
 '
 
+test_expect_success 'ls-remote patterns work with all protocol versions' '
+	git for-each-ref --format="%(objectname)	%(refname)" \
+		refs/heads/master refs/remotes/origin/master >expect &&
+	git -c protocol.version=1 ls-remote . master >actual.v1 &&
+	test_cmp expect actual.v1 &&
+	git -c protocol.version=2 ls-remote . master >actual.v2 &&
+	test_cmp expect actual.v2
+'
+
 test_done
-- 
2.19.1.1298.g19f18f2a22

