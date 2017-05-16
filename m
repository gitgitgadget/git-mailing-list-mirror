Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE901FAA8
	for <e@80x24.org>; Tue, 16 May 2017 16:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbdEPQsA (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 12:48:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:52759 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753370AbdEPQry (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 12:47:54 -0400
Received: (qmail 16694 invoked by uid 109); 16 May 2017 16:47:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 16:47:53 +0000
Received: (qmail 29538 invoked by uid 111); 16 May 2017 16:48:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 12:48:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 12:47:50 -0400
Date:   Tue, 16 May 2017 12:47:50 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Eric Rannaud <eric.rannaud@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
 <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
 <20170516164124.GO27400@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170516164124.GO27400@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 09:41:24AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Mon, May 15, 2017 at 11:25:03PM -0400, Jeff King wrote:
> 
> >> One hack would be to look for BASH_FUNC_* in the environment and disable
> >> the optimization in that case. I think that would make your case Just
> >> Work. It doesn't help other oddball cases, like:
> >>
> >>   - you're trying to run a shell builtin that behaves differently than
> >>     its exec-able counterpart
> >>
> >>   - your shell has some other mechanism for defining commands that we
> >>     would not find via exec. I don't know of one offhand. Obviously $ENV
> >>     could point to a file which defines some, but for most shells would
> >>     not read any startup files for a non-interactive "sh -c" invocation.
> >
> > So I was thinking something like the patch below, though I guess
> > technically you could look for BASH_FUNC_$argv[0]%%, which seems to be
> > bash's magic variable name. I hate to get too intimate with those
> > details, though.
> >
> > Another option is to speculatively run "foo" without the shell, and if
> > execve fails to find it, then fall back to running the shell. That would
> > catch any number of cases where the shell "somehow" finds a command that
> > we can't.
> 
> Hm.  execvp explicitly does this when it hits ENOEXEC, but not for
> ENOENT.  Do you know why that is?

When execvp(foo) falls back on ENOEXEC, it is not running "sh -c foo".
It is actually running "sh foo" to run the script contents. So it's
about letting you do:

  echo "no shebang line" >script
  chmod +x script
  ./script

And nothing to do with shell builtins.

> I think we want to behave consistently for shell builtins and for
> exported functions --- they are different sides of the same problem,
> and behaving differently between the two feels confusing.

Yes, I think ideally we'd handle it all transparently. Although I'd also
point out that Git the behavior under discussion dates back to 2009 and
this is (as far as I can recall) the first report. So documenting the
current behavior might not be that bad an option.

-Peff
