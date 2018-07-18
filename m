Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814691F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeGRSBU (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:01:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:51222 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731344AbeGRSBT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:01:19 -0400
Received: (qmail 8755 invoked by uid 109); 18 Jul 2018 17:22:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 17:22:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 552 invoked by uid 111); 18 Jul 2018 17:22:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 13:22:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 13:22:25 -0400
Date:   Wed, 18 Jul 2018 13:22:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Andrii Dehtiarov <adehtiarov@google.com>
Subject: Re: [PATCH 3/3] gc: do not return error for prior errors in
 daemonized mode
Message-ID: <20180718172225.GA2677@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180717065151.GA177907@aiede.svl.corp.google.com>
 <20180717065740.GD177907@aiede.svl.corp.google.com>
 <20180717201348.GD26218@sigill.intra.peff.net>
 <xmqqk1psldkx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1psldkx.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 09:21:18AM -0700, Junio C Hamano wrote:

> > I still think that "repo" should probably stop respecting the exit code.
> > But that's no excuse for Git not to have a sensible exit code in the
> > first place.
> 
> I am not yet convinced that this last step to exit with 0 is a good
> change, even though I can understand that it would be more
> convenient, as there currently is no easy way for the calling script
> to tell two error cases apart.
> 
> I think the "sensible exit code" you mention would be something like
> "1 for hard error, 2 for 'I am punting as I see there were previous
> errors---you may want to examine your repository'".  
> 
> If we did that from day one and documented that behaviour, nobody
> would have complained, but adopting that suddenly is of course a
> breaking change.
> 
> Perhaps we should exit with 2 (not 0) in that "previous error" case
> by default, and then have a configuration knob to turn that 2 into 0
> for those who cannot easily modify the calling script?  That way, we
> by default will *not* break those who have been paying attention to
> zero-ness of the exit status, we allow those who want to treat this
> "prior error" case as if there were no error with just a knob, and
> then those who are willing to update their script can tell two cases
> by the exit status and act differently.

I think we have been exiting non-zero with "previous errors" for some
time with the daemonizing code. It was just spelled "-1" instead of "2".
So just jumping right there does not mean any regression from the
current state, I don't think (but it also does not fix existing scripts
like "repo" that check the code).

I agree the config you suggest would give people the tools to make that
case work. But it somehow rubs me the wrong way. Can you imagine the
perspective of a user who is told "oh, your script breaks? Just try
setting this option to ignore error codes in this one particular
situation". It feels like a weird hack, because it is.

It's also still inconsistent in the daemonize case. The run that yields
the error won't return a non-zero exit. But the next run will exit with
"2".

-Peff
