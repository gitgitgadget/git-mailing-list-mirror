Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D3F2036D
	for <e@80x24.org>; Fri, 24 Nov 2017 18:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbdKXSM5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 13:12:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:39514 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753595AbdKXSM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 13:12:56 -0500
Received: (qmail 22108 invoked by uid 109); 24 Nov 2017 18:12:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Nov 2017 18:12:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15778 invoked by uid 111); 24 Nov 2017 18:13:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 24 Nov 2017 13:13:13 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Nov 2017 13:12:54 -0500
Date:   Fri, 24 Nov 2017 13:12:54 -0500
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
Message-ID: <20171124181254.GC29190@sigill>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
 <20171121214552.GB16418@alpha.vpn.ikke.info>
 <20171123000346.GA8718@sigill>
 <alpine.LFD.2.21.1711230241260.11944@localhost.localdomain>
 <20171123135155.GA8231@sigill>
 <20171123205503.GE16418@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171123205503.GE16418@alpha.vpn.ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 09:55:03PM +0100, Kevin Daudt wrote:

> > > >   Without a disambiguating `--`, Git makes a reasonable guess. If it
> > > >   cannot guess (because your request is ambiguous), then it will error
> > > >   out.
> [...]
> > > 1) even without the "--", git can generally parse the command and do
> > > the right thing (or do a *valid* thing, given its heuristics)
> > > 
> > > 2) occasionally, without the "--", the command is really and truly
> > > ambiguous, at which point git will fail and tell you to disambiguate
> [...]
> 
> Just for completeness, as it is somewhat covered by point 1 already, but
> there are cases where there is no real ambiguity but you are required to
> add '--' to tell git that it should not look for the file in the working
> tree:

Right, I was focused on what the sentence _currently_ said, and didn't
think about other cases. The "cannot guess" case is not just due to
ambiguity, but may be due to other heuristics.

I _think_ the only one is the "does it exist in the working tree" rule
you found, but I'm not sure we'd want to commit ourselves to never
changing that.

You could make my suggestion correct by putting "e.g.," or "for example"
at the front of the parentheses. ;)

There is an open question of how carefully we want to document it, but I
think the strategy so far has been:

 - if you want to be careful, use "--"

 - if you don't, git will use black magic to guess, but that magic is
   subject to change, so don't rely on it

I don't mind documenting the current magic as long as the "don't rely on
it" part is made clear.

>   $ git show abc123 deleted_file.txt
>   fatal: ambiguous argument 'deleted_file.txt':
>   unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
> 
> There might be good reasons why this is, but I don't consider this to be
> actually ambiguous: there is no branch called 'deleted_file.txt' and git
> could know that the files exists in the mentioned commit, so it should
> be pretty clear what is meant.

For that command, yes. But when the command is "git log", do we really
want to dig through all of history to see if anybody ever mentions
"deleted_file"?

I'm not sure if we want to get into having different rules for different
contexts. Not to mention that this really mixes up the layers; you
cannot know what the whole command line means until you decide what
abc123 means and examine it, which may in turn be influenced by other
options. E.g., given:

  git log --no-merges A..B deleted_file.txt

we have to actually do the no-merges log of A..B to see if
deleted_file.txt is in there.

-Peff
