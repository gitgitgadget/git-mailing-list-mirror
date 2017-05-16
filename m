Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F4B1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbdEPRXM (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:23:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:52809 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbdEPRXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:23:11 -0400
Received: (qmail 19278 invoked by uid 109); 16 May 2017 17:23:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 17:23:09 +0000
Received: (qmail 30353 invoked by uid 111); 16 May 2017 17:23:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 13:23:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 13:23:07 -0400
Date:   Tue, 16 May 2017 13:23:07 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Rannaud <eric.rannaud@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516172307.36hyshwypomlsubx@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
 <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
 <20170516164124.GO27400@aiede.svl.corp.google.com>
 <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
 <20170516171540.GG79147@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170516171540.GG79147@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 10:15:40AM -0700, Brandon Williams wrote:

> > > > So I was thinking something like the patch below, though I guess
> > > > technically you could look for BASH_FUNC_$argv[0]%%, which seems to be
> > > > bash's magic variable name. I hate to get too intimate with those
> > > > details, though.
> 
> One concern with that is what about all other shells that are not BASH?
> I'm sure they use a different env var for storing functions so we may
> need to handle other shell's too? That is assuming we want to keep the
> old behavior.

Most other shells don't do function-exporting at all. Certainly dash and
most traditional bourne shells don't. I wouldn't be surprised if zsh
does. But yeah, we'd have to support them one by one (and possibly
variants across different versions of each shell). Workable, but gross.

> > When execvp(foo) falls back on ENOEXEC, it is not running "sh -c foo".
> > It is actually running "sh foo" to run the script contents. So it's
> > about letting you do:
> > 
> >   echo "no shebang line" >script
> >   chmod +x script
> >   ./script
> > 
> > And nothing to do with shell builtins.
> 
> That's correct, and is the exact behavior I was trying to mimic with the
> changes to run_command.
>   1. try executing the command.
>   2. if it fails with ENOEXEC then attempt to execute it with a shell

I think the logic here would be more like:

  1. During prepare_shell_cmd(), even if we optimize out the shell call,
     still prepare a fallback argv (since we can't allocate memory
     post-fork).

  2. In the forked child, if we get ENOENT from exec and cmd->use_shell
     is set, then exec the fallback shell argv instead. Propagate its
     results, even if it's 127.

That still means we'd prefer a $PATH copy of a command to its shell
builtin variant, but that can't be helped (and I kind of doubt anybody
would care too much).

-Peff
