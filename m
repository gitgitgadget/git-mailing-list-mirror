Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF7CB201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 17:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030342AbdKRRwu (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 12:52:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:33552 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965970AbdKRRws (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 12:52:48 -0500
Received: (qmail 19963 invoked by uid 109); 18 Nov 2017 17:52:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 18 Nov 2017 17:52:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1149 invoked by uid 111); 18 Nov 2017 17:53:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sat, 18 Nov 2017 12:53:03 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Nov 2017 12:52:46 -0500
Date:   Sat, 18 Nov 2017 12:52:46 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: avoid "write_in_full(fd, buf, len) != len"
 pattern
Message-ID: <20171118175246.puaepnyw3u4a33dy@sigill.intra.peff.net>
References: <20171115124043.17147-1-phillip.wood@talktalk.net>
 <20171117220633.6yoovfgpbr3rsykr@sigill.intra.peff.net>
 <f3038984-1cd8-e11f-61fd-10bf0cc33e2d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3038984-1cd8-e11f-61fd-10bf0cc33e2d@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 18, 2017 at 11:20:04AM +0100, René Scharfe wrote:

> Am 17.11.2017 um 23:06 schrieb Jeff King:
> > There's one more case in write_section() that uses "==". That's not
> > actually wrong, but I wonder if we'd want to make it "< 0" for
> > consistency.
> 
> Actually it *is* wrong.

Thanks for digging, I didn't look beyond that single line.

> -- >8 --
> Subject: [PATCH] config: flip return value of write_section()
> 
> d9bd4cbb9cc (config: flip return value of store_write_*()) made
> write_section() follow the convention of write(2) to return -1 on error
> and the number of written bytes on success.  3b48045c6c7 (Merge branch
> 'sd/branch-copy') changed it back to returning 0 on error and 1 on
> success, but left its callers still checking for negative values.
> 
> Let write_section() follow the convention of write(2) again to meet the
> expectations of its callers.

Yikes. It looks like this slipped by on the tests because we always
check "< 0" in the callers, not non-zero. So success would not look like
failure, but failure would look like success. And write failure does not
happen regularly in the test suite.

So this looks correct, and well-explained.

> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

I'm not sure I deserve a reported-by if I say "it looks fine" but am
totally wrong. ;)

-Peff
