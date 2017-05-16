Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8351FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdEPRlK (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:41:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:52836 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdEPRlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:41:09 -0400
Received: (qmail 20575 invoked by uid 109); 16 May 2017 17:41:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 17:41:09 +0000
Received: (qmail 30622 invoked by uid 111); 16 May 2017 17:41:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 13:41:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 13:41:07 -0400
Date:   Tue, 16 May 2017 13:41:07 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Rannaud <eric.rannaud@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516174106.l2kmlprrimxku5vr@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <alpine.DEB.2.21.1.1705161220230.3610@virtualbox>
 <20170516161858.stp4ylwfmbgc4oid@sigill.intra.peff.net>
 <CA+zRj8Uxh1SGdVW=zz29Q4m4OnDcs665T0XtV6FiZ_qZSiG-8g@mail.gmail.com>
 <20170516171414.GC2169@alpha.vpn.ikke.info>
 <CA+zRj8WFuqaNV_6U5=VUrEmeQ_fNaRs8mKxdSd=Z0QMyGk4pHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+zRj8WFuqaNV_6U5=VUrEmeQ_fNaRs8mKxdSd=Z0QMyGk4pHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 10:29:31AM -0700, Eric Rannaud wrote:

> > It does not really work that way. Git runs in a separate process that
> > does not have access to your current shell. That's why you need to do
> > 'export -f foo'.
> >
> > If you want git to be able to ecute the foo shell function, git needs to
> > start a _new_ shell process, which reads the environment, recognize the
> > exported function and run that.
> >
> > This is not the same as git executing the command in your shell. Not
> > exported variables would not be available in this function (as it would
> > be in your equivalent).
> 
> I'm sorry, I didn't mean (or say) "my shell process". Indeed, it
> doesn't work that way. And to be clear, there is no problem with
> having to "export -f foo". The only question is how should git run the
> <cmd> passed to --exec: should it run directly or using a shell?

It's definitely "using a shell". Most things Git runs on your behalf
behave the same, but there are some exceptions due to historical warts
(that would break backwards compatibility if we switched them). E.g.,
$GIT_SSH does not use the shell, but we introduced GIT_SSH_COMMAND as an
alternative which does use the shell.

But note that "a shell" may not be necessarily be your login shell. We
always execute "/bin/sh -c" (and you can override the shell path at
build time). So your "export -f" trick only works because your /bin/sh
is a symlink to bash (or because you specifically built with the
SHELL_PATH knob pointed at bash).

-Peff
