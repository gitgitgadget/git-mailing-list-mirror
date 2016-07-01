Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5781FE4E
	for <e@80x24.org>; Fri,  1 Jul 2016 03:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbcGADYA (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 23:24:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:38678 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751863AbcGADX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 23:23:59 -0400
Received: (qmail 17169 invoked by uid 102); 1 Jul 2016 03:17:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 23:17:19 -0400
Received: (qmail 12782 invoked by uid 107); 1 Jul 2016 03:17:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 23:17:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 23:17:12 -0400
Date:	Thu, 30 Jun 2016 23:17:12 -0400
From:	Jeff King <peff@peff.net>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
Message-ID: <20160701031711.GA4832@sigill.intra.peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net>
 <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net>
 <5774F4C7.805@gmail.com>
 <CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 11:12:52AM -0700, Linus Torvalds wrote:

> I do think that it's ok to cache generation numbers somewhere if there
> is an algorithm that can make use of them, but every time this comes
> up, it's just not been important enough to make a big deal and a new
> incompatible object format for it. The committer date is preexisting
> and has existing pseudo-generation-number usage, so..improving on the
> quality of it sounds like a good idea.

If you are OK with a cache, I don't think one needs to change the object
format at all. It can be computed on the fly, and is purely a local
optimization.

> The first step should probably be to make fsck warn about the existing
> cases of "commit has older date than parents". Something like the
> attached patch, perhaps?

I have mixed feelings on this, because it forces the user to confront
the issue at a time that's potentially very far from when it actually
happened (and often when it is not their fault).

I expect most people don't run fsck at all under normal circumstances,
so it is only when they have a problem of some sort that they would see
this warning at all. It would kick in and prevent objects being
transferred when things like receive.fsckObjects are configured, but
it's not on by default. GitHub does enable it, so pushing there is often
the first notification people get about any kind of problem.

This is a general problem with all fsck-driven warnings (people may
fetch without realizing they're getting breakage, and such objects may
get years of history built on top). But I think it can be even worse
with timestamps, because the broken state may not even be recognizable
when you first fetch the troublesome object.

E.g., imagine somebody else has their clock set forward, and you fetch
from them. Their object by itself is not broken. It is only when you
want to commit on top of it, with the correct clock, that the broken
state is created (and then, we cannot know whether it is your clock or
the original committer's clock that is bad).

So I think it would be more productive to put a check like this in "git
commit" rather than (or perhaps in addition to) fsck. That prevents
us creating the broken relationship, but it does still mean the user may
have to to go back and tell the original committer that their clock was
broken.

You could also have the fsck check look not only for out-of-order
commits, but also commits in the future (from the perspective of the
receiver). That would reject such broken commits before they even hit
your repository (though again, it is unclear in such a case if the
commit is broken or the clock of the checker).

> +static void fsck_commit_date(struct fsck_options *options, struct commit *commit)
> +{
> +	struct commit_list *p;
> +
> +	for (p = commit->parents; p; p = p->next) {
> +		struct commit *parent = p->item;
> +		if (commit->date < parent->date)
> +			report(options, &commit->object, FSCK_MSG_DATE_ORDERING, "Bad commit date ordering with parent");
> +	}
> +}

I didn't test it, but I suspect this won't work reliably, as we do not
always have the parents parsed during an fsck check (e.g., during
"index-pack --strict").

-Peff
