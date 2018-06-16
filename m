Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F651F403
	for <e@80x24.org>; Sat, 16 Jun 2018 19:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932847AbeFPTOD (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 15:14:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:46750 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932542AbeFPTOC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 15:14:02 -0400
Received: (qmail 19398 invoked by uid 109); 16 Jun 2018 19:14:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 16 Jun 2018 19:14:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30294 invoked by uid 111); 16 Jun 2018 19:14:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 16 Jun 2018 15:14:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Jun 2018 15:14:00 -0400
Date:   Sat, 16 Jun 2018 15:14:00 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Luat Nguyen <root@l4w.io>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] ewah_read_mmap: bounds-check mmap reads
Message-ID: <20180616191400.GB8914@sigill.intra.peff.net>
References: <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615033112.GA20390@sigill.intra.peff.net>
 <20180616143513.10086-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180616143513.10086-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 16, 2018 at 04:35:13PM +0200, SZEDER Gábor wrote:

> > +	head -c 512 <$bitmap >$bitmap.tmp &&
> > +	mv $bitmap.tmp $bitmap &&
> 
> This line turns out to be problematic on OSX and ultimately causes the
> test to fail.
> 
> When OSX's 'mv's destination is read-only, it asks whether to replace
> the destination even though in the test its stdin is not a terminal
> (and thus doesn't conform to POSIX[1]).  Since the '.bitmap' file is
> read-only, and since 'mv' obviously doesn't get an affirmative
> response from /dev/null, the original '.bitmap' file is not
> overwritten, the subsequent 'git rev-list' doesn't print any error
> message, and finally 'test_i18ngrep' causes the test to fail.

Right, sorry, I should have remembered that we've run into this before.
Using "mv -f" is the standard solution. E.g., c20d4d702f (t1450: use "mv
-f" within loose object directory, 2017-01-24).

Junio, can you squash this in to jk/ewah-bounds-check~1?

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index c4ed88030c..b11bc392a8 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -338,7 +338,7 @@ test_expect_success 'truncated bitmap fails gracefully' '
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
 	test_when_finished "rm -f $bitmap" &&
 	head -c 512 <$bitmap >$bitmap.tmp &&
-	mv $bitmap.tmp $bitmap &&
+	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
 	test_i18ngrep corrupt stderr

-Peff
