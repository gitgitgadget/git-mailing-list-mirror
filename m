Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7671F406
	for <e@80x24.org>; Fri, 12 Jan 2018 18:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965133AbeALSpt (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 13:45:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:42500 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964967AbeALSps (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 13:45:48 -0500
Received: (qmail 18442 invoked by uid 109); 12 Jan 2018 18:45:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 18:45:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1368 invoked by uid 111); 12 Jan 2018 18:46:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 13:46:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 13:45:46 -0500
Date:   Fri, 12 Jan 2018 13:45:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 4/4] trace.c: be smart about what env to print in
 trace_run_command()
Message-ID: <20180112184546.GA15514@sigill.intra.peff.net>
References: <20180111094712.2551-1-pclouds@gmail.com>
 <20180112095607.18293-1-pclouds@gmail.com>
 <20180112095607.18293-5-pclouds@gmail.com>
 <20180112133355.GE27499@sigill.intra.peff.net>
 <xmqqpo6fvstf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpo6fvstf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 10:24:28AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> +		/*
> >> +		 * Do we have a sequence of "unset GIT_DIR; GIT_DIR=foo"?
> >> +		 * Then don't bother with the unset thing.
> >> +		 */
> >> +		if (i + 1 < envs.nr &&
> >> +		    !strcmp(env, envs.items[i + 1].string))
> >>  			continue;
> >
> > Are we guaranteed that "FOO" and "FOO=bar" appear next to each other in the
> > sorted list? I think "FOO123=bar" could come between.
> 
> At this point, envs is a string list whose key is FOO for both "FOO"
> (unset) and "FOO=bar" (set); "FOO123=bar" would sort after these two.

Ah, right, I didn't notice that we took just the key name.

> But I did not see anything that attempts to guarantee that "FOO"
> sorts before "FOO=bar" with string_list_sort().  If the sort used in
> the function is stable, and if the case we care about is unset
> followed by set, then the above would catch the case, but even if
> that were the case, it is unclear what we want to do when a set of
> FOO is followed by an unset of FOO.

The actual prep_childenv() code looks like it would always do
last-one-wins, so we should treat FOO as unset in that final case. But
that only kicks in on non-Windows.

On Windows we feed cmd->env straight to mingw_spawnvpe().  That ends up
in make_environment_block(), which looks like it does something similar.

It's too bad the prep code is not shared, since then we could probably
just ask _it_ which deltas it applied. I suspect it would be possible to
share it, since mingw_spawnvpe is our own compat thing (so we could
change its interface to take the whole prepared environment block). But
I won't blame Duy if he doesn't want to refactor all of the
cross-platform exec code. ;)

> And if the sort is not stable, then the above code is just simply
> broken.

Agreed.

> 
> > I also think this is a special case of a more general problem. FOO could
> > appear any number of times in the "env" array, as a deletion or with
> > multiple values. Our prep_childenv() would treat that as "last one
> > wins", I think. Could we just do the same here?
> 
> Yeah, if the last one is to set FOO=bar, then it feels sufficient to
> just check if FOO is set to bar in the original and deciding to show
> or hide; similarly if the last one is to unset FOO, it does not matter
> if the caller sets it to some other value before unsetting, so it
> feels sufficient to just check if FOO is set to anything in the
> original environment.

Yep, agreed again.

-Peff
