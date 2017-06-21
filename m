Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6939420401
	for <e@80x24.org>; Wed, 21 Jun 2017 19:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdFUT0j (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:26:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:47878 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751108AbdFUT0i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:26:38 -0400
Received: (qmail 6166 invoked by uid 109); 21 Jun 2017 19:26:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 19:26:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26708 invoked by uid 111); 21 Jun 2017 19:26:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 15:26:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 15:26:36 -0400
Date:   Wed, 21 Jun 2017 15:26:36 -0400
From:   Jeff King <peff@peff.net>
To:     Christian =?utf-8?B?UsO2c2No?= <christian@croesch.de>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] add--interactive: handle EOF in prompt_yesno
Message-ID: <20170621192636.e5odne2lojuq63gm@sigill.intra.peff.net>
References: <20170621192315.3umx4lszvzwjffnb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170621192315.3umx4lszvzwjffnb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prompt_yesno function loops indefinitely waiting for a
"y" or "n" response. But it doesn't handle EOF, meaning
that we can end up in an infinite loop of reading EOF from
stdin. One way to simulate that is with:

  echo e | GIT_EDITOR='echo corrupt >' git add -p

Let's break out of the loop and propagate the undef to the
caller. Without modifying the callers that effectively turns
it into a "no" response. This is reasonable for both of the
current callers, and it leaves room for any future caller to
check for undef explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 79d675b5b..fc722fe8a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1136,6 +1136,7 @@ sub prompt_yesno {
 	while (1) {
 		print colored $prompt_color, $prompt;
 		my $line = prompt_single_character;
+		return undef unless defined $line;
 		return 0 if $line =~ /^n/i;
 		return 1 if $line =~ /^y/i;
 	}
-- 
2.13.1.792.g159074dab

