Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F76320C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbdK0XFY (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:05:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:41910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752429AbdK0XFX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:05:23 -0500
Received: (qmail 13934 invoked by uid 109); 27 Nov 2017 23:05:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 23:05:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7024 invoked by uid 111); 27 Nov 2017 23:05:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 27 Nov 2017 18:05:40 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Nov 2017 18:05:20 -0500
Date:   Mon, 27 Nov 2017 18:05:20 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171127230520.GA29636@sigill.intra.peff.net>
References: <20171127134716.69471-1-lars.schneider@autodesk.com>
 <20171127200932.GA558049@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171127200932.GA558049@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 08:09:32PM +0000, brian m. carlson wrote:

> > Show a message in the original terminal and get rid of it when the
> > editor returns.
> [...]
> 
> Sorry for coming to the topic so late, but it occurred to me that we
> might want to conditionalize this on an advice.* flag.  I expect there
> are some people who will never want to see this, and letting them turn
> it off would be good.

I am torn between saying "yes please, I would absolutely set such an
option myself" and "if we need advice.*, that is a good sign that the
feature is mis-designed".

Let me elaborate a bit on the latter.

My gut feeling is that this is absolutely the wrong place to put a
message like this. We don't know enough about what the editor is doing,
so we have to take pains to avoid a crufty message in the terminal,
including:

  - playing ANSI-term trickery to erase the message

  - hard-coding (!) emacsclient as a special case

And that's why I say that "advice.*" is a bad sign, because it means
those other techniques are failing, and somebody is seeing and being
annoyed by the cruft.

The right place for this message, IMHO, is for the editor itself (or a
wrapper script) to say "hey, I'm opening a new window" (like emacsclient
does).

But I also recognize that the world isn't perfect. Not all editors will
get this right, and not all users are savvy enough to set up a wrapper
script for editors which don't. So defaulting this to "on" tries to help
those cases.

If the anti-cruft techniques I mentioned above work well in practice,
then we get to have our cake and eat it, too. If they don't, then I'm
not sure if the tradeoff is worth it.

-Peff
