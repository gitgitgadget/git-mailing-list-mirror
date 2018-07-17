Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A791F597
	for <e@80x24.org>; Tue, 17 Jul 2018 20:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGQVBV (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 17:01:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:50130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729805AbeGQVBV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 17:01:21 -0400
Received: (qmail 17228 invoked by uid 109); 17 Jul 2018 20:26:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Jul 2018 20:26:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25404 invoked by uid 111); 17 Jul 2018 20:27:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 17 Jul 2018 16:27:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jul 2018 16:27:00 -0400
Date:   Tue, 17 Jul 2018 16:27:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Andrii Dehtiarov <adehtiarov@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180717202700.GE26218@sigill.intra.peff.net>
References: <20180716203753.GE11513@aiede.svl.corp.google.com>
 <20180716210938.GF25189@sigill.intra.peff.net>
 <20180716214003.GH11513@aiede.svl.corp.google.com>
 <20180716214539.GL25189@sigill.intra.peff.net>
 <20180716220306.GI11513@aiede.svl.corp.google.com>
 <20180716224337.GB12482@sigill.intra.peff.net>
 <20180716225639.GK11513@aiede.svl.corp.google.com>
 <20180716232603.GB13570@sigill.intra.peff.net>
 <20180717015339.GL11513@aiede.svl.corp.google.com>
 <87d0vmck55.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0vmck55.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 10:59:50AM +0200, Ævar Arnfjörð Bjarmason wrote:

> That doesn't make sense to me. Just because git itself is happily
> ignoring the exit code I don't think that should mean there shouldn't be
> a meaningful exit code. Why don't you just ignore the exit code in the
> repo tool as well?
> 
> Now e.g. automation I have to see if git-gc ---auto is having issues
> can't just be 'git gc --auto || echo fail @ {hostname}' across a fleet
> of servers, but will need to start caring if stderr was emitted to.

If you're daemonizing gc, though, there are a number of cases where the
exit code is not propagated. If you really care about the outcome,
you're probably better off either:

  - doing synchronous gc's, which will still return a meaningful code
    after Jonathan's patches

  - inspecting the log yourself. I know that comes close to the un-unixy
    stderr thing. But in this case, the presence of a non-empty log is
    literally the on-disk bit for "the previous run failed". And doing
    so catches all of the daemonized cases, even the "first one" that
    you'd miss by paying attention to the immediate exit code.

    This will treat the zero-exit-code "warning" case as an error. I'm
    not against propagating the true original error code, if somebody
    wants to work on it. But I think Jonathan's patches are a strict
    improvement over the current situation, and a patch to propagate
    could come on top.

> I think you're conflating two things here in a way that (if I'm reading
> this correctly) produces a pretty bad regression for users.
> 
>  a) If we have something in the gc.log we keep yelling at users until we
>     reach the gc.logExpiry, this was the subject of my thread back in
>     January. This sucks, and should be fixed somehow.
> 
>     Maybe we should only emit the warning once, e.g. creating a
>     .git/gc.log.wasemitted marker and as long as its ctime is later than
>     the mtime on .git/gc.log we don't emit it again).
> 
>     But that also creates the UX problem that it's easy to miss this
>     message in the middle of some huge "fetch" output. Perhaps we should
>     just start emitting this as part of "git status" or something (or
>     solve the root cause, as Peff notes...).

I kind of like that "git status" suggestion. Of course many users run
"git status" more often than "git commit", so it may actually spam them
more!

>  b) We *also* use this presence of a gc.log as a marker for "we failed
>     too recently, let's not try again until after a day".
> 
> The semantics of b) are very useful, and just because they're tied up
> with a) right now, let's not throw out b) just because we're trying to
> solve a).

Yeah. In general my concern was the handling of (b), which I think this
last crop of patches is fine with. As far as showing the message
repeatedly or not, I don't have a strong opinion (it could even be
configurable, once it's split from the "marker" behavior).

> Right now one thing we do right is we always try to look at the actual
> state of the repo with too_many_packs() and too_many_loose_objects().
> 
> We don't assume the state of your repo hasn't drastically changed
> recently. That means that we do the right thing and gc when the repo
> needs it, not just because we GC'd recently enough.
> 
> With these proposed semantics we'd skip a needed GC (potentially for
> days, depending on the default) just because we recently ran one.

Yeah, I agree that deferring repeated gc's based on time is going to run
into pathological corner cases. OTOH, what we've found at GitHub is that
"gc --auto" is quite insufficient for scheduling maintenance anyway
(e.g., if a machine gets pushes to 100 separate repositories in quick
succession, you probably want to queue and throttle any associated gc).

But there are probably more mid-size sites that are big enough to have
corner cases, but not so big that "gc --auto" is hopeless. ;)

-Peff
