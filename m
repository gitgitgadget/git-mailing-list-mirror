Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19CFC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9D620720
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGIXAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:00:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:53716 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgGIXAj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 19:00:39 -0400
Received: (qmail 6345 invoked by uid 109); 9 Jul 2020 23:00:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jul 2020 23:00:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26583 invoked by uid 111); 9 Jul 2020 23:00:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jul 2020 19:00:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jul 2020 19:00:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH/RFC] config: default to protocol v2
Message-ID: <20200709230038.GB664420@coredump.intra.peff.net>
References: <20200707053805.GB784740@google.com>
 <20200708045008.GC2303891@coredump.intra.peff.net>
 <xmqq7dve2etl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dve2etl.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 08, 2020 at 08:42:46AM -0700, Junio C Hamano wrote:

> I am afraid that "there probably aren't other" may be overly
> optimistic, as the bug in 2.26 crippled the negotiation logic and
> forced it to punt, which was so severe that it would have hidden any
> other bugs in the negotiation logic.  If there is another bug in v2
> negotiation logic that makes the sender to omit objects that should
> be sent, it would not have been observed in 2.26 because the effect
> of the more severe bug was to cripple the negotiation logic itself
> and to make it punt, sending more objects all the way down the
> history.  Now, with that larger bug fixed post 2.26, we can start to
> see if there are other bugs hidden by it.

I half-agree with this. The negotiation logic wasn't completely broken,
and usually did the right thing. It was only the max_in_vain counting
that was wrong. So definitely there could be another bug lurking that
was hidden by that failure, and/or our fix could be incomplete. But I
think we can have some confidence that there aren't other show-stopping
bugs (in the negotiation code or elsewhere in v2) that showed up in
other situations (and the real-world success reports we already got for
that particular bug are also encouraging).

So I'm not especially worried about having a repeat of the v2.26
situation (but I agree it's not impossible).

> In any case, we've learned in 2.26 that it is unlikely that such
> bugs would be uncovered until v2 is made the default again in a
> released version to be used by more users.
> 
> So, let's flip the default in -rc0; we can revert if we see
> something funny in 2.28.1 in the worst case.

And obviously I'm fine with this, given that my assessment of the risk
is even less than yours. :)

-Peff
