Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444B520248
	for <e@80x24.org>; Wed, 27 Feb 2019 12:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfB0MCW (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 07:02:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:59716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728916AbfB0MCV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 07:02:21 -0500
Received: (qmail 30836 invoked by uid 109); 27 Feb 2019 12:02:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Feb 2019 12:02:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5100 invoked by uid 111); 27 Feb 2019 12:02:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Feb 2019 07:02:36 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Feb 2019 07:02:19 -0500
Date:   Wed, 27 Feb 2019 07:02:19 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [FIXUP] Fixup on tip of jt/http-auth-proto-v2-fix
Message-ID: <20190227120219.GA10305@sigill.intra.peff.net>
References: <20190225220841.GA3248@sigill.intra.peff.net>
 <20190225234901.65277-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225234901.65277-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 03:49:01PM -0800, Jonathan Tan wrote:

> Thanks, Peff, for noticing this. It's because the client sometimes sends
> "0000" as a single request (that is, it flushes, and then before it
> sends any data, it flushes again). And post_rpc() assumes that it can
> always read something - which is usually correct, but not in this case;
> we read in stateless_connect() first, and if we read "0000", we need to
> tell post_rpc() to not read at all.
> 
> This is a fixup on the tip of jt/http-auth-proto-v2-fix that fixes that.

Thanks, I can confirm that this makes the problem go away (and your
explanation makes perfect sense to me).

> As for why the client sends a lone "0000", I'm not sure, but that's
> outside the scope of this patch set, I think.

Yeah, that does seem odd. I noticed it on noop fetches. So after we've
done "ls-refs", would "fetch" need to send a flush to say "I don't want
anything?" I guess not, since we're stateless, and it is literally
making a new HTTP request just to say nothing.

It does seem unique to protocol v2.

-Peff
