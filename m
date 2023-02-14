Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA78C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 17:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjBNRkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 12:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBNRkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 12:40:16 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F732227AB
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 09:40:11 -0800 (PST)
Received: (qmail 31998 invoked by uid 109); 14 Feb 2023 17:40:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Feb 2023 17:40:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3105 invoked by uid 111); 14 Feb 2023 17:40:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Feb 2023 12:40:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Feb 2023 12:40:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
Message-ID: <Y+vHebrL6Uuv+HR/@coredump.intra.peff.net>
References: <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
 <Y+rmNvfjIA/u81em@coredump.intra.peff.net>
 <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
 <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
 <xmqq7cwk955b.fsf@gitster.g>
 <CAPig+cQx24PRUsEjEcnuDtokS02SS3n_dUi8MO=WJbBazget8g@mail.gmail.com>
 <xmqq3578924s.fsf@gitster.g>
 <CAPig+cQLRDJY_9zjEu2DdZug8h9QNSUVCzDC7W65Cm=eQ-3MiQ@mail.gmail.com>
 <Y+uwW0I0k7urZ3do@coredump.intra.peff.net>
 <xmqqk00k6w08.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk00k6w08.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 08:40:23AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Oof. So it is some weird locale thing that scanf is doing. I don't even
> > want to think about what the details could be. ;)
> >
> > Since scanf is such a bad and error-prone interface in the first place
> > (and I'd actually like to put it on the banned list), what about just
> > parsing manually here?
> 
> Me likee.
> 
> This will eradicate the only use of sscanf() from the tree;
> unfortunately there is a topic that adds a new one or two back in
> flight X-<.

Sadly, not quite. There's one in test-date.c, though it would be pretty
easy to convert to strtol() or similar. But there's also an fscanf() in
builtin/gc.c. To my mind, fscanf() is even worse, as you cannot know the
size of the "%s" you're about to receive (the case here works around it
with a max-size specifier, so I don't think it's buggy, but the
contortions one must go through seem...not worth it).

-Peff
