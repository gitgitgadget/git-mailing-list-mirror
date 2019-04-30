Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B6B1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfD3WVt (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:21:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:45174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726049AbfD3WVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:21:48 -0400
Received: (qmail 28009 invoked by uid 109); 30 Apr 2019 22:21:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Apr 2019 22:21:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13248 invoked by uid 111); 30 Apr 2019 22:22:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Apr 2019 18:22:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2019 18:21:46 -0400
Date:   Tue, 30 Apr 2019 18:21:46 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?SmFyb3PFgmF3?= Honkis via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?SmFyb3PFgmF3?= Honkis <yaras6@gmail.com>
Subject: Re: [PATCH 1/1] credential: do not mask the username
Message-ID: <20190430222146.GA19492@sigill.intra.peff.net>
References: <pull.138.git.gitgitgadget@gmail.com>
 <e459e487d3848ae1b7f37676bd9d2a2f9c967430.1556575570.git.gitgitgadget@gmail.com>
 <20190429234028.GA24069@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904301753030.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904301753030.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 30, 2019 at 06:07:15PM -0400, Johannes Schindelin wrote:

> >   2. Use another tool besides askpass. I don't know of any askpass
> >      implementations that take something like our ECHO flag, but there
> >      are lots of other tools. I doubt there's any easy portable
> >      solution, though. And anyway, credential helpers are a much more
> >      advanced version of this anyway, so I'd probably steer people in
> >      that direction.
> [...]
> 
> How about inventing a new convention: we could set `GIT_ASKPASS_FLAGS`
> as an environment variable that contains whitespace-delimited flags, in
> the current instance just "echo"?
> 
> We could then teach `git-gui--askpass` to heed that.

Yeah, I almost suggested something like that for my (2) above, but I
couldn't actually find an askpass implementation that supported this
(though there are lots of general dialog tools that do).

But today I learned about git-gui--askpass. :)

So yeah, I think that is a solution in the right direction, but it may
not be helping that many people if it is specific to git-gui--askpass.

> Mind you, these days, this patch is a lot less necessary because Git for
> Windows (which is *the* platform where you'd expect no terminal to be
> available when fetching/pushing, right?) defaults to using the Git
> Credential Manager [*1*].

The no-terminal thing isn't specific to Windows. You can imagine
somebody triggering "git fetch" from any GUI on Linux that no longer has
a controlling terminal (because the GUI was spawned by a desktop manager
or some such).

But I definitely agree that credential helpers are the right way to do
fancier prompting. AFAIK your GCM is the only one which actually does
prompting (most of the rest are just key-store interfaces), but it's
definitely inbounds and was part of the original intent. For usernames,
I personally just stick mine in credential.$URL.username config, since
they're obviously not a secret. But then my habits may not match most
users. :)

> What do you think about the `GIT_ASKPASS_FLAGS` thing? It is not perfect,
> but it could be used at least in conjunction with `git-gui--askpass` (or
> with other helpers that would make use of this side channel to receive
> more information about the way they should present the question to the
> user)?

It seems perfectly reasonable to me, but if it were me, I think this:

> Alternatively, I could simply drop that patch from Git for Windows, as it
> really only concerns users who override the default, opting out of using
> Git Credential Manager.

would be the path I would take.

-Peff
