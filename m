Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F892202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 21:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbdGEV2I (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 17:28:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:60426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752978AbdGEV2H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 17:28:07 -0400
Received: (qmail 22520 invoked by uid 109); 5 Jul 2017 21:27:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 21:27:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10567 invoked by uid 111); 5 Jul 2017 21:28:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 17:28:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jul 2017 17:27:57 -0400
Date:   Wed, 5 Jul 2017 17:27:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 2/6] t1414: document some reflog-walk oddities
Message-ID: <20170705212757.3ygxiasbi2e7v27p@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
 <xmqqh8yqix7p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8yqix7p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 05, 2017 at 10:56:42AM -0700, Junio C Hamano wrote:

> >   1. The fake parents are used for commit selection and
> >      display. So for example, "--merges" or "--no-merges"
> >      are useful, because the history appears as a linear
> 
> s/useful/useless/ perhaps?

Oops, yes ("not useful" is probably what I was going for).

> > +test_expect_success 'set up some reflog entries' '
> > +	test_commit one &&
> > +	test_commit two &&
> > +	git checkout -b side HEAD^ &&
> > +	test_commit three &&
> > +	git merge --no-commit master &&
> > +	echo evil-merge-content >>one.t &&
> > +	test_tick &&
> > +	git commit --no-edit -a
> > +'
> 
> Mental note: logically, what we want to see in the log are:
> 
>     master:  one-->two
>     side:                one-->three-->(evil)
>     HEAD:    one-->two-->one-->three-->(evil)
> 
> where the middle one in HEAD is "switching from master to side".

Yeah. I was tempted to document that, but I think the expect.all mostly
does that for HEAD (and I don't really check the others). The grossest
thing is this numeric selection:

> > +test_expect_failure 'pathspec limiting handles merges' '
> > +	sed -n "1p;3p;5p" expect.all >expect &&

I tried to think of an easy way to pick them out by name but couldn't
come up with one. I don't know if that sed invocation deserves a comment
or not.

> > +	do_walk -- one.t >actual &&
> > +	test_cmp expect actual
> > +'
> 
> OK (it was a bit tricky to see why the topmost one should, but the
> evilness of the merge makes it eligible).

Yeah, that was why I added the evilness. A more real-world test would
perhaps be a file with an actual conflict that got resolved (but not
matching either parent exactly). I actually started by adding the evil
content to "three", which is a bit closer. But it passes even without
the patch, because the diff to the first parent still matches.

So I dunno. I think it's OK as is. My main goal was just to make sure
that my TREESAME hackery catches both normal and merge commits.

> > +test_expect_failure 'walking multiple reflogs shows both' '
> > +	{
> > +		do_walk HEAD &&
> > +		do_walk side
> > +	} >expect &&
> > +	do_walk HEAD side >actual &&
> > +	test_cmp expect actual
> > +'
> 
> I somehow find this one a bit iffy.  
> 
> The order that commits appear in the "walk from HEAD and side at the
> same time" may want to be different from what this test expects.
> "rev-list --since=3.days -g master next", for example, would want to
> refrain from reading the reflog of 'master' for all 90 days before
> switching to the reflog of 'next', no?

I did make the ordering intentional. We process each reflog sequentially
in turn. I don't think it would be wrong to interleave them by date, but
I actually think it's useful for somebody who switches that behavior to
consciously update the test. Maybe it's worth calling out in the commit
message.

I stopped short of actually documenting and guaranteeing that behavior
to the user. I don't know how comfortable we would be changing it later.

(As an aside, I also prowled through the documentation looking for any
guarantees we make to the user about the fake-parent thing, but I
couldn't find any. So I considered its user-visible effects an unwanted
side effect of the implementation).

-Peff
