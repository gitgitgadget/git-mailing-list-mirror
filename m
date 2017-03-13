Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337781FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 19:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754627AbdCMTD4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:03:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:43352 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754127AbdCMTDx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:03:53 -0400
Received: (qmail 29452 invoked by uid 109); 13 Mar 2017 19:03:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 19:03:52 +0000
Received: (qmail 20666 invoked by uid 111); 13 Mar 2017 19:04:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 15:04:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Mar 2017 15:03:49 -0400
Date:   Mon, 13 Mar 2017 15:03:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Devin Lehmacher <lehmacdj@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC][PATCH 2/3] credential-cache.c: Make git use
 XDG_CACHE_HOME for credentials
Message-ID: <20170313190349.wbg7nfmrxvvzc5zv@sigill.intra.peff.net>
References: <20170313172232.96678-1-lehmacdj@gmail.com>
 <20170313172232.96678-3-lehmacdj@gmail.com>
 <xmqqtw6xrquw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtw6xrquw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 11:09:11AM -0700, Junio C Hamano wrote:

> > +	if (home_socket)
> > +		if (file_exists(home_socket))
> > +			return home_socket;
> > +		else
> > +			free(home_socket);
> > +
> > +	return xdg_cache_home("credential/socket");
> > +}
> 
> I somehow feel that the order of precedence should be the other way
> around, though.  
> 
> If somebody really wants to use the xdg location and has a socket
> already there, using that existing socket would be the right thing
> to do.  However, when neither ~/.git-credential-cache/socket nor
> ~/.cache/git/socket exists, why should we prefer the latter over the
> former?

How would they get a socket in the xdg location if we never create one?

I think the point of this commit is that we should generally prefer the
xdg locations to ones that were simply made up by Git.

As an aside, I also wondered if stale socket files might cause us to
keep picking the "old" location forever. But it looks like
credential-cache--daemon does use a tempfile handler to make sure it
cleans up the socket afterwards (and we are checking for the actual
socket, not just the presence of the outer directory, which is good).

-Peff
