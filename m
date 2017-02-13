Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0DE11FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbdBMVpZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:45:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:54514 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752976AbdBMVpY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:45:24 -0500
Received: (qmail 8280 invoked by uid 109); 13 Feb 2017 21:45:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 21:45:23 +0000
Received: (qmail 27421 invoked by uid 111); 13 Feb 2017 21:45:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 16:45:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 16:45:21 -0500
Date:   Mon, 13 Feb 2017 16:45:21 -0500
From:   Jeff King <peff@peff.net>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 0/5] stash: support pathspec argument
Message-ID: <20170213214521.pkjesijdlus36tnp@sigill.intra.peff.net>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170206161432.zvpsqegjspaa2l5l@sigill.intra.peff.net>
 <20170212193050.GA652@hank>
 <vpq7f4uxjmo.fsf@anie.imag.fr>
 <20170213200950.m3bcyp52wd25p737@sigill.intra.peff.net>
 <vpqo9y5lqos.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vpqo9y5lqos.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 10:35:31PM +0100, Matthieu Moy wrote:

> > Is it really that dangerous, though? The likely outcome is Git saying
> > "nope, you don't have any changes to the file named drop". Of course the
> > user may have meant something different, but I feel like "-p" is a good
> > indicator that they are interested in making an actual stash.
> 
> Indeed -p is not the best example. In the old thread, I used -q which is
> much more problematic:
> 
>   git stash -q drop => interpreted as: git stash push -q drop
>   git stash drop -q => drop with option -q

Yeah, I'd agree with that. I wouldn't propose to loosen it entirely, but
rather to treat "-p" specially.

> It's not really "dangerous" at least in this case, since we misinterpret
> a destructive command for a less destructive one, but it is rather
> confusing that changing the order between command and options change the
> behavior.
> 
> I actually find it a reasonable expectation to allow swapping commands
> and options, some programs other than git allow it.

I think we may have already crossed that bridge with "git -p stash".

Not to mention that the ordering already _is_ relevant (we disallow one
order but not the other). If we really wanted to allow swapping, it
would mean making:

  git stash -p drop

the same as:

  git stash drop -p

I actually find _that_ more confusing. It would perhaps make more sense
with something like "-q", which is more of a "global" option than a
command-specific one. But I think we'd want to whitelist such global
options (and "-p" would not be on that list).

> > The complexity is that right now, the first-level decision of "which
> > stash sub-command am I running?" doesn't know about any options. So "git
> > stash -m foo" would be rejected in the name of typo prevention, unless
> > that outer decision learns about "-m" as an option.
> 
> Ah, OK. But that's not really hard to implement: when going through the
> option list looking for non-option, shift one more time when finding -m.

No, it's not hard conceptually. It just means implementing the
option-parsing policy in two places. That's not too bad now, but if we
started using rev-parse's options helper, then I think you have corner
cases like "git stash -km foo".

My "-p" suggestion suffers from a similar problem if you treat it as
"you can omit the 'push' if you say "-p", rather than "if -p is the
first option, it is a synonym for 'push -p'".

-Peff
