Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35009C0015E
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 00:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHJA0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 20:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHJA0k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 20:26:40 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1504A171D
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 17:26:39 -0700 (PDT)
Received: (qmail 23210 invoked by uid 109); 10 Aug 2023 00:26:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Aug 2023 00:26:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3094 invoked by uid 111); 10 Aug 2023 00:26:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Aug 2023 20:26:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Aug 2023 20:26:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
Message-ID: <20230810002638.GC795985@coredump.intra.peff.net>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
 <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
 <20230809140902.GA775795@coredump.intra.peff.net>
 <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
 <xmqqzg30m3vo.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg30m3vo.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 12:07:07PM -0700, Junio C Hamano wrote:

> But I am failing to imagine how the calling side actually would look
> like.  Can we do something along the lines of
> 
>     #define OPT_CALLBACK(s, l, v, a, h, cb)
> 	.short_name = (s),
> 	.long_name = (l),
> 	.value_ ## typeof(v) = &v,
> 	.help = (h),
> 	.callback = (cb),
> 
> with a clever CPP trick?  It sounds like either too much churn or
> too much magic or both, at least to me.

Sadly, I think "typeof" is not sufficiently portable, and there is no
replacement. You'd have to do something like:

  int my_foo;
  ...
  OPT_CALLBACK('f', "foo", int, &my_foo, ...etc);

Not great, but it might not be _too_ bad given that most helpers like
OPT_BOOL() can just say "int" behind the scenes.

That said, I don't recall these void pointers being a large source of
errors in the past. So while it's a fun type-system puzzle, the
effort/reward ratio might not be favorable.

-Peff
