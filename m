Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9849920FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 20:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcF2U6F (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 16:58:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:37929 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751504AbcF2U6D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 16:58:03 -0400
Received: (qmail 31821 invoked by uid 102); 29 Jun 2016 20:56:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Jun 2016 16:56:54 -0400
Received: (qmail 30331 invoked by uid 107); 29 Jun 2016 20:57:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Jun 2016 16:57:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Jun 2016 16:56:48 -0400
Date:	Wed, 29 Jun 2016 16:56:48 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
Message-ID: <20160629205647.GA25987@sigill.intra.peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 01:39:17PM -0700, Junio C Hamano wrote:

> > Would it make sense to refuse creating commits that have a commit date
> > prior to its parents commit date (except when the user gives a
> > `--dammit-I-know-I-break-a-wildy-used-heuristic`)?
> 
> I think that has also been discussed in the past.  I do not think it
> would help very much in practice, as projects already have up to 10
> years (and the ones migrated from CVS, even more) worth of commits
> they cannot rewrite that may record incorrect committer dates.

Yep, it has been discussed and I agree it runs into a lot of corner
cases.

> If the use of generation number can somehow be limited narrowly, we
> may be able to incrementally introduce it only for new commits, but
> I haven't thought things through, so let me do so aloud here ;-)

I think the problem is that you really _do_ want generation numbers for
old commits. One of the most obvious cases is something like "tag
--contains HEAD", because it has to examine older tags.

So your history looks something like:

  A -- B -- ... Z
        \        \
	 v1.0     HEAD

Without generation numbers (or some proxy), you have to walk the history
between B..Z to find the answer. With generation numbers, it is
immediately obvious.

So this is the ideal case for generation numbers (the worst cases are
when the things you are looking for are in branchy, close history where
the generation numbers don't tell you much; but in such cases the
walking is usually not too bad).

So I think you really do want to be able to generate and store
generation numbers after the fact. That has an added bonus that you do
not have to worry about baking incorrect values into your objects; you
do the topological walk once, and you _know_ it is correct (at least as
correct as the parent links, but that is our source of truth).

I have patches that generate and store the numbers at pack time, similar
to the way we do the reachability bitmaps. They're not production ready,
but they could probably be made so without too much effort. You wouldn't
have ready-made generation numbers for commits since the last full
repack, but you can compute them incrementally based on what you do have
at a cost linear to the unpacked commits (this is the same for bitmaps).

-Peff
