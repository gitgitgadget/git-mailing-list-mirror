Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC041F45F
	for <e@80x24.org>; Tue,  7 May 2019 22:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfEGWat (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 18:30:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:51014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726236AbfEGWas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 18:30:48 -0400
Received: (qmail 15934 invoked by uid 109); 7 May 2019 22:30:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 22:30:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17712 invoked by uid 111); 7 May 2019 22:31:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 18:31:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 18:30:46 -0400
Date:   Tue, 7 May 2019 18:30:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: [PATCH] t/lib-httpd: pass LSAN_OPTIONS through apache
Message-ID: <20190507223046.GA16315@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just as we instruct Apache to pass through ASAN_OPTIONS (so that
server-side Git programs it spawns will respect our options while
running the tests), we should do the same with LSAN_OPTIONS. Otherwise
trying to collect a list of leaks like:

    export LSAN_OPTIONS=exitcode=0:log_path=/tmp/lsan
    make SANITIZE=leak test

won't work for http tests (the server-side programs won't log their
leaks to the right place, and they'll prematurely die, producing a
spurious test failure).

Signed-off-by: Jeff King <peff@peff.net>
---
Found this after giving similar advice in

  https://public-inbox.org/git/20190507222601.GA976@sigill.intra.peff.net/

 t/lib-httpd/apache.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 06a81b54c7..5c1c86c193 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -76,6 +76,7 @@ PassEnv GIT_VALGRIND
 PassEnv GIT_VALGRIND_OPTIONS
 PassEnv GNUPGHOME
 PassEnv ASAN_OPTIONS
+PassEnv LSAN_OPTIONS
 PassEnv GIT_TRACE
 PassEnv GIT_CONFIG_NOSYSTEM
 PassEnv GIT_TEST_SIDEBAND_ALL
-- 
2.21.0.1314.g224b191707
