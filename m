Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2151E1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 12:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfHFM2A (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 08:28:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:35166 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726711AbfHFM2A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 08:28:00 -0400
Received: (qmail 16562 invoked by uid 109); 6 Aug 2019 12:27:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 12:27:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1286 invoked by uid 111); 6 Aug 2019 12:30:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 08:30:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 08:27:58 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] config: stop checking whether the_repository is NULL
Message-ID: <20190806122758.GC13513@sigill.intra.peff.net>
References: <20190806122601.GA21475@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806122601.GA21475@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the previous commit, our invariant that the_repository is never
NULL is restored, and we can stop being defensive in include_by_branch().

We can confirm the fix by showing that an onbranch config include will
not cause a segfault when run outside a git repository. I've put this in
t1309-early-config since it's related to the case added by 85fe0e800c
(config: work around bug with includeif:onbranch and early config,
2019-07-31), though technically the issue was with
read_very_early_config() and not read_early_config().

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c                | 2 +-
 t/t1309-early-config.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 3900e4947b..cc637363bb 100644
--- a/config.c
+++ b/config.c
@@ -275,7 +275,7 @@ static int include_by_branch(const char *cond, size_t cond_len)
 	int flags;
 	int ret;
 	struct strbuf pattern = STRBUF_INIT;
-	const char *refname = !the_repository || !the_repository->gitdir ?
+	const char *refname = !the_repository->gitdir ?
 		NULL : resolve_ref_unsafe("HEAD", 0, NULL, &flags);
 	const char *shortname;
 
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index eeb60e4143..3a0de0ddaa 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -94,4 +94,9 @@ test_expect_success 'early config and onbranch' '
 	test_with_config "[includeif \"onbranch:master\"]path=../broken"
 '
 
+test_expect_success 'onbranch config outside of git repo' '
+	test_config_global includeIf.onbranch:master.path non-existent &&
+	nongit git help
+'
+
 test_done
-- 
2.23.0.rc1.436.g24d2e81391
