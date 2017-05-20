Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48142027B
	for <e@80x24.org>; Sat, 20 May 2017 07:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbdETHID (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 03:08:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:55132 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbdETHIC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 03:08:02 -0400
Received: (qmail 13292 invoked by uid 109); 20 May 2017 07:07:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 May 2017 07:07:59 +0000
Received: (qmail 32609 invoked by uid 111); 20 May 2017 07:08:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 May 2017 03:08:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 May 2017 03:07:57 -0400
Date:   Sat, 20 May 2017 03:07:57 -0400
From:   Jeff King <peff@peff.net>
To:     Dennis Kaarsemaker <dennis.kaarsemaker@booking.com>
Cc:     Elliott Cable <me@ell.io>, Git Mailing List <git@vger.kernel.org>,
        bmwill@google.com
Subject: Re: persistent-https, url insteadof, and `git submodule`
Message-ID: <20170520070757.jekykxagzze3t2wy@sigill.intra.peff.net>
References: <CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com>
 <1495230186.19473.7.camel@kaarsemaker.net>
 <1495230934.19473.10.camel@booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1495230934.19473.10.camel@booking.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2017 at 11:55:34PM +0200, Dennis Kaarsemaker wrote:

> > > Presumably this isn't intended behaviour?
> > 
> > It actually is. git-submodule sets GIT_PROTOCOL_FROM_USER to 0, which
> > makes git not trust any urls except http(s), git, ssh and file urls
> > unless you explicitely configure git to allow it. See the
> > GIT_ALLOW_PROTOCOL section in man git and the git-config section it
> > links to.
> 
> 33cfccbbf3 (submodule: allow only certain protocols for submodule
> fetches, 2015-09-16) says:
> [...]
>     But doing it this way is
>     simpler, and makes it much less likely that we would miss a
>     case. And since such protocols should be an exception
>     (especially because nobody who clones from them will be able
>     to update the submodules!), it's not likely to inconvenience
>     anyone in practice.

Yeah, I think the use of "insteadOf" here is a good counter-example to
the reasoning in that commit message. The submodule itself has a vanilla
protocol, so most users wouldn't need to configure anything. But
somebody who has done a blanket insteadOf now needs to explicitly allow
the protocol, too.

So one workaround is just adding:

  [protocol "persistent-https"]
  allow = always

next to the insteadOf config. And maybe that's enough. It's a little
inconvenient, but it the user has to configure something either way. And
it does give you some flexibility in deciding whether submodules get
access to their special remote helper.

The other approach is to declare that a url rewrite resets the
protocol-from-user flag to 1. IOW, since the "persistent-https" protocol
comes from our local config, it's not dangerous and we should behave as
if the user themselves gave it to us. That makes Elliott's case work out
of the box.

-Peff
