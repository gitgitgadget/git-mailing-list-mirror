Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828CF1F4F8
	for <e@80x24.org>; Wed, 12 Oct 2016 01:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbcJLBeb (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 21:34:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:56236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752512AbcJLBea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 21:34:30 -0400
Received: (qmail 24553 invoked by uid 109); 12 Oct 2016 01:34:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 01:34:30 +0000
Received: (qmail 15957 invoked by uid 111); 12 Oct 2016 01:34:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 21:34:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2016 21:34:28 -0400
Date:   Tue, 11 Oct 2016 21:34:28 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Ram Rachum <ram@rachum.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Make `git fetch --all` parallel?
Message-ID: <20161012013428.swxmrbyxv2wo37xf@sigill.intra.peff.net>
References: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
 <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com>
 <xmqqa8ea7bsh.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
 <20161011225942.tvqbbzxglvu7lldi@sigill.intra.peff.net>
 <CAGZ79kaKOiy-HJboaujXXc66P6CLupteDw4JyPOGetREfz_q_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ79kaKOiy-HJboaujXXc66P6CLupteDw4JyPOGetREfz_q_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 04:18:15PM -0700, Stefan Beller wrote:

> >> At the very least we would need a similar thing as Jeff recently sent for the
> >> push case with objects quarantined and then made available in one go?
> >
> > I don't think so. The object database is perfectly happy with multiple
> > simultaneous writers, and nothing impacts the have/wants until actual
> > refs are written. Quarantining objects before the refs are written is an
> > orthogonal concept.
> 
> If a remote advertises its tips, we'd need to look these up (clientside) to
> decide if we have them, and I do not think we'd do that via a reachability
> check, but via direct lookup in the object data base? So I do not quite
> understand, what we gain from the atomic ref writes in e.g. remote/origin/.

It's been a while since I've dug into the fetch protocol. But I think we
cover the "do we have the objects already" check via quickfetch(), which
does do a reachability check, And then we advertise our "have" commits
by walking backwards from our ref tips, so everything there is
reachable.

Anything else would be questionable, especially under older versions of
git, as we promise only to have a complete graph for objects reachable
from the refs. Older versions of git would happily truncate unreachable
history based on the 2-week prune expiration period.

> > I'm not altogether convinced that parallel fetch would be that much
> > faster, though.
> 
> Ok, time to present data... Let's assume a degenerate case first:
> "up-to-date with all remotes" because that is easy to reproduce.
> 
> I have 14 remotes currently:
> 
> $ time git fetch --all
> real 0m18.016s
> user 0m2.027s
> sys 0m1.235s
> 
> $ time git config --get-regexp remote.*.url |awk '{print $2}' |xargs
> -P 14 -I % git fetch %
> real 0m5.168s
> user 0m2.312s
> sys 0m1.167s

So first, thank you (and Ævar) for providing real numbers. It's clear
that I was talking nonsense.

Second, I wonder where all that time is going. Clearly there's an
end-to-end latency issue, but I'm not sure where it is. Is it startup
time for git-fetch? Is it in getting and processing the ref
advertisement from the other side? What I'm wondering is if there are
opportunities to speed up the serial case (but nobody really cared
before because it doesn't matter unless you're doing 14 of them back to
back).

> > I usually just do a one-off fetch of their URL in such a case, exactly
> > because I _don't_ want to end up with a bunch of remotes. You can also
> > mark them with skipDefaultUpdate if you only care about them
> > occasionally (so you can "git fetch sbeller" when you care about it, but
> > it doesn't slow down your daily "git fetch").
> 
> And I assume you don't want the remotes because it takes time to fetch and not
> because your disk space is expensive. ;)

That, and it clogs the ref namespace. You can mostly ignore the extra
refs, but they show up in the "git checkout ..." DWIM, for example.

-Peff
