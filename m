Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EADD1F744
	for <e@80x24.org>; Thu, 30 Jun 2016 09:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbcF3JOz (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 05:14:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:38284 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751565AbcF3JOy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 05:14:54 -0400
Received: (qmail 32035 invoked by uid 102); 30 Jun 2016 09:14:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:14:56 -0400
Received: (qmail 6774 invoked by uid 107); 30 Jun 2016 09:15:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:15:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 05:14:51 -0400
Date:	Thu, 30 Jun 2016 05:14:51 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 6/5] t5000: use test_match_signal
Message-ID: <20160630091451.GA24964@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160630090614.GA16725@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 05:06:14AM -0400, Jeff King wrote:

> The one thing that isn't fixed is the use of "141" to test for sigpipe
> death. That should use test_match_signal, but that topic just got
> re-rolled, too.

And here's what the patch for that looks like (which can be applied if
this topic and jk/test-match-signal are merged).

-- >8 --
Subject: t5000: use test_match_signal

We are testing for sigpipe death from git, and doing so
portably requires using our test helper.

Signed-off-by: Jeff King <peff@peff.net>
---

Of course this does not help Windows at all, because we removed the "3"
check from jk/test-match-signal. So this new test will probably need to
be dealt with by Windows folks, one way or another (either extending
test_match_signal, or just skipping the exit code check under the MINGW
prereq).

 t/t5000-tar-tree.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 96d208d..6950d7d 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -365,8 +365,7 @@ test_expect_success 'generate tar with huge size' '
 		git archive HEAD
 		echo $? >exit-code
 	} | test_copy_bytes 4096 >huge.tar &&
-	echo 141 >expect &&
-	test_cmp expect exit-code
+	test_match_signal 13 "$(cat exit-code)"
 '
 
 test_expect_success TAR_HUGE 'system tar can read our huge size' '
-- 
2.9.0.317.g65b4e7c

