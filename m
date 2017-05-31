Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F7A2027C
	for <e@80x24.org>; Wed, 31 May 2017 04:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750966AbdEaEux (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 00:50:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:60380 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbdEaEux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 00:50:53 -0400
Received: (qmail 14878 invoked by uid 109); 31 May 2017 04:50:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 04:50:53 +0000
Received: (qmail 1678 invoked by uid 111); 31 May 2017 04:51:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 00:51:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 00:50:52 -0400
Date:   Wed, 31 May 2017 00:50:52 -0400
From:   Jeff King <peff@peff.net>
To:     Elliott Cable <me@ell.io>
Cc:     Dennis Kaarsemaker <dennis.kaarsemaker@booking.com>,
        Git Mailing List <git@vger.kernel.org>, bmwill@google.com
Subject: Re: persistent-https, url insteadof, and `git submodule`
Message-ID: <20170531045051.ctoo7sv3f66xurdf@sigill.intra.peff.net>
References: <CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com>
 <1495230186.19473.7.camel@kaarsemaker.net>
 <1495230934.19473.10.camel@booking.com>
 <20170520070757.jekykxagzze3t2wy@sigill.intra.peff.net>
 <CAPZ477PoSXqahxaQVpO+m==vng==o4vQahrg_WA8Oeh7wmoW0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPZ477PoSXqahxaQVpO+m==vng==o4vQahrg_WA8Oeh7wmoW0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 11:22:37AM -0500, Elliott Cable wrote:

> Hi! Thanks for the responses (I hope reply-all isn't bad mailing-list
> etiquette? Feel free to yell at with a direct reply!). For whatever it's
> worth, as a random user, here's my thoughts:

No, reply-all is the preferred method on this list.

> > The other approach is to declare that a url rewrite resets the
> > protocol-from-user flag to 1. IOW, since the "persistent-https" protocol
> > comes from our local config, it's not dangerous and we should behave as
> > if the user themselves gave it to us. That makes Elliott's case work out
> > of the box.
> 
> Well, now that I'm aware of security concerns, `GIT_PROTOCOL_FROM_USER`
> and `GIT_ALLOW_PROTOCOL`, and so on, I wouldn't *at all* expect
> `insteadOf` to disable that behaviour. Instead, one of two things seems
> like a more ideal solution:
> 
> 1. Most simply, better documentation: mention `GIT_PROTOCOL_FROM_USER`
>    explicitly in the documentation of/near `insteadOf`, most
>    particularly in the README for `contrib/persistent-https`.
> 
> 2. Possibly, special-case “higher-security” porcelain (like
>    `git-submodule`, as described in 33cfccbbf3) to ignore `insteadOf`
>    rewrite-rules without additional, special configuration. This way,
>    `git-submodule` works for ignorant users (like me) out of the box,
>    just as it previously did, and there's no possible security
>    compramise.

After my other email, I was all set to write a patch to set
"from_user=1" when we rewrite a URL. But I think it actually is a bit
risky, because we don't know which parts of the URL are
security-sensitive versus which parts were rewritten. A modification of
a tainted string doesn't necessarily untaint it (but sometimes it does,
as in your case).

We could actually have a flag as part of the rewrite config, like:

  [url "persistent-https"]
  insteadOf = "https"
  untaint = true

but I don't think that really buys anything. If you know about the
problem, you could just as easily do:

  [url "persistent-https"]
  insteadOf = "https"
  [protocol "persistent-https"]
  allow = always

It really is an issue of the user knowing about the problem (and how to
solve it), and I don't think we can get around that securely. So better
documentation probably is the right solution.

I'll see if I can cook something up.

-Peff
