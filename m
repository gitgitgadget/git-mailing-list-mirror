Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72251F405
	for <e@80x24.org>; Thu, 20 Dec 2018 17:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeLTRPD (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 12:15:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:47042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725799AbeLTRPD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 12:15:03 -0500
Received: (qmail 7270 invoked by uid 109); 20 Dec 2018 17:15:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 17:15:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2630 invoked by uid 111); 20 Dec 2018 17:14:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Dec 2018 12:14:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2018 12:14:38 -0500
Date:   Thu, 20 Dec 2018 12:14:38 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>, szeder.dev@gmail.com,
        Jan Palus <jpalus@fastmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t5570: drop racy test
Message-ID: <20181220171438.GA6684@sigill.intra.peff.net>
References: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
 <20181125220138.GK4883@hank.intra.tgummerer.com>
 <20181126164252.GA27711@sigill.intra.peff.net>
 <20181220164150.GB25639@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181220164150.GB25639@hank.intra.tgummerer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 04:41:50PM +0000, Thomas Gummerer wrote:

> > That doesn't really fix it, but just broadens the race window. I dunno.
> > Maybe that is enough in practice. We could do something like:
> > 
> >   repeat_with_timeout () {
> > 	local i=0
> > 	while test $i -lt 10
> > 	do
> > 		"$@" && return 0
> > 		sleep 1
> > 	done
> > 	# no success even after 10 seconds
> > 	return 1
> >   }
> > 
> >   repeat_with_timeout grep -i extended.attribute daemon.log
> > 
> > to make the pattern a bit more obvious (and make it easy to extend the
> > window arbitrarily; surely 10s is enough?).
> 
> I gave this a try, with below patch to lib-git-daemon.sh that you
> proposed in the previous thread about this racyness.  That shows
> another problem though, namely when truncating 'daemon.log' before
> running 'git ls-remote' in this test, we're not sure all 'git deamon'
> has flushed everything from previous invocations.  That may be an even
> rarer problem in practice, but still something to keep in mind.

Right, that makes sense. Making this race-proof really does require a
separate log stream for each test. I guess we'd need to be able to send
git-daemon a signal to re-open the log (which actually is not as
unreasonable as it may seem; lots of daemons have this for log
rotation).

I think getting rid of the "cat" would also help a lot here.
Unfortunately I think we use it not just for its "tee" effect, but also
to avoid startup races by checking the "Ready to rumble" line. So again,
we'd need some cooperation from git-daemon to tell us out-of-band that
it has completed its startup (e.g., by touching another file).

> Dscho also mentioned on #git-devel a while ago that he may have a look
> at actually making this test race-proof, but I guess he's been busy
> with the 2.20 release.  I'm also not sure it's worth spending a lot of
> time trying to fix this test, but I'd definitely be happy if someone
> proposes a different solution.

Yeah. I'm sure it's fixable with enough effort, but I just think there
are more interesting and important things to work on.

> --- >8 ---
> Subject: [PATCH] t5570: drop racy test

So yeah, I'm still fine with this. But...

> ---
>  t/t5570-git-daemon.sh | 13 -------------
>  1 file changed, 13 deletions(-)

This is the only user of daemon.log, so we could drop those bits from
lib-git-daemon.sh, too. That would also prevent people from adding new
tests, thinking that this was somehow not horribly racy). I.e.,
reverting 314a73d658 (t/lib-git-daemon: record daemon log, 2018-01-25).

-Peff
