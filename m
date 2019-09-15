Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF87B1F463
	for <e@80x24.org>; Sun, 15 Sep 2019 01:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfIOBLR (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 21:11:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:50538 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726791AbfIOBLR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 21:11:17 -0400
Received: (qmail 23232 invoked by uid 109); 15 Sep 2019 01:11:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 15 Sep 2019 01:11:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28888 invoked by uid 111); 15 Sep 2019 01:13:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Sep 2019 21:13:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 14 Sep 2019 21:11:16 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
Subject: [PATCH 1/3] t5616: test cloning/fetching with sparse:oid=<oid> filter
Message-ID: <20190915011115.GA11208@sigill.intra.peff.net>
References: <20190915010942.GA19787@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190915010942.GA19787@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jon Simons <jon@jonsimons.org>

We test in t5317 that "sparse:oid" filters work with rev-list, but
there's no coverage at all confirming that they work with a fetch or
clone (and in fact, there are several bugs). Let's do a basic test that
a clone fetches the correct objects.

[jk: extracted from Jon's earlier fix patches. I also simplified the
     setup down to a single sparse file, and I added checks that we got the
     right blobs]

Signed-off-by: Jon Simons <jon@jonsimons.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5616-partial-clone.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 565254558f..0bdbc819f1 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -241,6 +241,42 @@ test_expect_success 'fetch what is specified on CLI even if already promised' '
 	! grep "?$(cat blob)" missing_after
 '
 
+test_expect_success 'setup src repo for sparse filter' '
+	git init sparse-src &&
+	git -C sparse-src config --local uploadpack.allowfilter 1 &&
+	git -C sparse-src config --local uploadpack.allowanysha1inwant 1 &&
+	test_commit -C sparse-src one &&
+	test_commit -C sparse-src two &&
+	echo /one.t >sparse-src/only-one &&
+	git -C sparse-src add . &&
+	git -C sparse-src commit -m "add sparse checkout files"
+'
+
+test_expect_failure 'partial clone with sparse filter succeeds' '
+	rm -rf dst.git &&
+	git clone --no-local --bare \
+		  --filter=sparse:oid=master:only-one \
+		  sparse-src dst.git &&
+	(
+		cd dst.git &&
+		git rev-list --objects --missing=print HEAD >out &&
+		grep "^$(git rev-parse HEAD:one.t)" out &&
+		grep "^?$(git rev-parse HEAD:two.t)" out
+	)
+'
+
+test_expect_failure 'partial clone with unresolvable sparse filter fails cleanly' '
+	rm -rf dst.git &&
+	test_must_fail git clone --no-local --bare \
+				 --filter=sparse:oid=master:no-such-name \
+				 sparse-src dst.git 2>err &&
+	test_i18ngrep "unable to access sparse blob in .master:no-such-name" err &&
+	test_must_fail git clone --no-local --bare \
+				 --filter=sparse:oid=master \
+				 sparse-src dst.git 2>err &&
+	test_i18ngrep "could not load filter specification" err
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.23.0.667.gcccf1fbb03

