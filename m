Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0BD1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 22:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeKHHfq (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 02:35:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:44086 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727790AbeKHHfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 02:35:42 -0500
Received: (qmail 11751 invoked by uid 109); 7 Nov 2018 22:03:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Nov 2018 22:03:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18796 invoked by uid 111); 7 Nov 2018 22:02:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Nov 2018 17:02:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Nov 2018 17:03:20 -0500
Date:   Wed, 7 Nov 2018 17:03:20 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
Message-ID: <20181107220320.GA8970@sigill.intra.peff.net>
References: <pull.66.git.gitgitgadget@gmail.com>
 <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
 <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
 <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org>
 <20181107204142.GA30078@sigill.intra.peff.net>
 <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 07, 2018 at 10:36:52PM +0100, Johannes Sixt wrote:

> Am 07.11.18 um 21:41 schrieb Jeff King:
> > On Wed, Nov 07, 2018 at 07:52:28PM +0100, Johannes Sixt wrote:
> > > Do I understand correctly, that you use a leading slash as an indicator to
> > > construct a path relative to system_path(). How about a "reserved" user
> > > name? For example,
> > > 
> > >    [http] sslcert = ~system_path/what/ever
> > > 
> > > although a more unique name, perhaps with some punctuation, may be
> > > desirable.
> > 
> > It's syntactically a bit further afield, but something like:
> > 
> >    [http]
> >    sslcert = $RUNTIME_PREFIX/what/ever
> > 
> > would make sense to me, and is a bit less subtle than the fake user. I
> > don't know if that would confuse people into thinking that we
> > interpolate arbitrary environment variables, though.
> 
> The expansion of a fake user name would have to go in expand_user_path(), a
> fake variable name would have to be expanded elsewhere. Now, Dscho mentions
> in the cover letter that his patch has already seen some field testing ("has
> been 'in production' for a good while"). So, we have gained some confidence
> that the point where the substitution happens, in expand_user_path(), is
> suitable. Therefore, I have slight preference for a fake user.

I don't think that necessarily needs to limit us. expand_user_path() is
named that because right now it just expands "~". But there's no reason
it couldn't be used for general expansion. The problem in the original
patch is that it expands _even when the user has not asked us to do it_.
Looking at the callers, most of them would be fine with the new
expansion (the only exception is the one in daemon.c, though it manually
checks for "~" already).

Now I agree that the new function would probably need a better name, at
which point you could easily have a function expand_path() which just
wraps expand_user_path().

All that said, if we're just interested in allowing this for config,
then we already have such a wrapper function: git_config_pathname().

So I don't think it's a big deal to implement it in any of these ways.
It's much more important to get the syntax right, because that's
user-facing and will be with us forever.

-Peff
