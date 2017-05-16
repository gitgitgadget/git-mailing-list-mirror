Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B853201A4
	for <e@80x24.org>; Tue, 16 May 2017 17:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbdEPROQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:14:16 -0400
Received: from ikke.info ([178.21.113.177]:48240 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbdEPROP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:14:15 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 2D2D94400AE; Tue, 16 May 2017 19:14:14 +0200 (CEST)
Date:   Tue, 16 May 2017 19:14:14 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Eric Rannaud <eric.rannaud@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516171414.GC2169@alpha.vpn.ikke.info>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <alpine.DEB.2.21.1.1705161220230.3610@virtualbox>
 <20170516161858.stp4ylwfmbgc4oid@sigill.intra.peff.net>
 <CA+zRj8Uxh1SGdVW=zz29Q4m4OnDcs665T0XtV6FiZ_qZSiG-8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+zRj8Uxh1SGdVW=zz29Q4m4OnDcs665T0XtV6FiZ_qZSiG-8g@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 09:59:03AM -0700, Eric Rannaud wrote:
> On Tue, May 16, 2017 at 9:18 AM, Jeff King <peff@peff.net> wrote:
> > On Tue, May 16, 2017 at 12:23:02PM +0200, Johannes Schindelin wrote:
> >> It would appear to me that you used a side effect of an implementation
> >> detail: that `git rebase -i` was implemented entirely as a shell script.
> >
> > I don't think that's true at all. He expected the user-provided "--exec"
> > command to be run by a shell, which seems like a reasonable thing for
> > Git to promise (and we already make a similar promise for most
> > user-provided commands that we run).  What happens in between, be it
> 
> As a "user", my expectation was simply that the command would be run
> not just in "a shell", but in *my* shell (or the shell that calls git,
> maybe). So I don't see any portability question with respect to Git.
> My script that uses git rebase --exec may not be portable, but that's
> my problem.
> 
> When I use "git rebase --exec <cmd>" I'm basically writing a "foreach
> commit in range { <cmd> }" in my shell. Same idea with git bisect run.
> 
> A transparent optimization that tries execve() then falls back to the
> user's shell sounds like a good idea.

It does not really work that way. Git runs in a separate process that
does not have access to your current shell. That's why you need to do
'export -f foo'.

If you want git to be able to ecute the foo shell function, git needs to
start a _new_ shell process, which reads the environment, recognize the
exported function and run that.

This is not the same as git executing the command in your shell. Not
exported variables would not be available in this function (as it would
be in your equivalent).
