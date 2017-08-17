Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75F920899
	for <e@80x24.org>; Thu, 17 Aug 2017 20:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbdHQUn7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 16:43:59 -0400
Received: from ikke.info ([178.21.113.177]:56136 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752632AbdHQUn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 16:43:59 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 67D6F440119; Thu, 17 Aug 2017 22:43:12 +0200 (CEST)
Date:   Thu, 17 Aug 2017 22:43:12 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "Carlsson, Magnus" <Magnus.Carlsson@arris.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git fetch with refspec does not include tags?
Message-ID: <20170817204312.GD3839@alpha.vpn.ikke.info>
References: <1502960406180.9006@arris.com>
 <1502960572292.1402@arris.com>
 <20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net>
 <xmqq1soagf1p.fsf@gitster.mtv.corp.google.com>
 <20170817202257.GC3839@alpha.vpn.ikke.info>
 <xmqqk222expv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk222expv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 01:38:36PM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > On Thu, Aug 17, 2017 at 12:38:58PM -0700, Junio C Hamano wrote:
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> >   # no tags, we just populate FETCH_HEAD because of the bare URL
> >> >   git fetch ../parent
> >> >
> >> >   # this does fetch tags, because we're storing the result according to
> >> >   # the configured refspec ("refs/heads/*:refs/remotes/origin/*").
> >> >   git fetch origin
> >> 
> >> The above two look good.
> >> 
> >> >   # this doesn't fetch tags, as the main command is "just" populating
> >> >   # FETCH_HEAD. But then our logic for "hey, we fetched the ref for
> >> >   # refs/remotes/origin/master, so let's update it on the side" kicks
> >> >   # in. And we end up updating FETCH_HEAD _and_ the tracking branch, but
> >> >   # not the tags. Weird.
> >> >   git fetch origin master
> >> 
> >> Yes, it looks weird, but I suspect that it is probably more correct
> >> not to fetch tags in this case.  I wonder if it would be a solution
> >> not to do the "on the side" thing---after all the user didn't tell
> >> us to update refs/remotes/origin/master with this command line.
> >
> > Isn't that how git fetch used to behave, or am I misunderstanding what
> > you mean? It used to be that git fetch <remote> <branch> would not
> > update any remote tracking branches.
> >
> > From the 1.8.4 release notes:
> >
> >> "git fetch origin master" unlike "git fetch origin" or "git fetch"
> >> did not update "refs/remotes/origin/master"; this was an early
> >> design decision to keep the update of remote tracking branches
> >> predictable, but in practice it turns out that people find it more
> >> convenient to opportunistically update them whenever we have a
> >> chance, and we have been updating them when we run "git push" which
> >> already breaks the original "predictability" anyway.
> 
> No, you are not misunderstanding anything.  The "pretend that we
> immediately turned around and fetched" done by "git push" was
> already breaking the predictability, but the change in 1.8.4 made it
> even worse.  I am saying that going back to the old behaviour may be
> one option to address the issue being discussed in this thread.
> 

Ok. The reason I'm bring this up is because we often had to tell users
in the irc channel that git fetch <remote> <branch> did not update the
remote tracking branches, which confused them, so reverting back might
reintroduce this confusion again.
