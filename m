Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A3961FAA8
	for <e@80x24.org>; Tue, 16 May 2017 16:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbdEPQTC (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 12:19:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:52709 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdEPQTB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 12:19:01 -0400
Received: (qmail 14109 invoked by uid 109); 16 May 2017 16:19:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 16:19:01 +0000
Received: (qmail 28928 invoked by uid 111); 16 May 2017 16:19:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 12:19:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 12:18:59 -0400
Date:   Tue, 16 May 2017 12:18:59 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Rannaud <eric.rannaud@gmail.com>, git@vger.kernel.org,
        Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516161858.stp4ylwfmbgc4oid@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <alpine.DEB.2.21.1.1705161220230.3610@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1705161220230.3610@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 12:23:02PM +0200, Johannes Schindelin wrote:

> On Mon, 15 May 2017, Eric Rannaud wrote:
> 
> > It used to be possible to run a sequence like:
> > 
> >   foo() { echo X; }
> >   export -f foo
> >   git rebase --exec foo HEAD~10
> 
> It would appear to me that you used a side effect of an implementation
> detail: that `git rebase -i` was implemented entirely as a shell script.

I don't think that's true at all. He expected the user-provided "--exec"
command to be run by a shell, which seems like a reasonable thing for
Git to promise (and we already make a similar promise for most
user-provided commands that we run).  What happens in between, be it
shell or C code, doesn't matter, and the conversion away from a shell
script in this case only tickled an existing bad interaction between
"export -f" and Git's run-command code.

See my other replies for the full story.

I don't think this has anything in particular to do with git-rebase,
though. Our solutions are either:

  - declare "export -f" as too tricky for our optimization, and teach
    people about the ";" trick

  - figure out some workaround/fallback to disable the shell-skipping
    optimization in this case

-Peff
