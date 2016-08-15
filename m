Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700A81F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 18:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbcHOSnT (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:43:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:55657 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750791AbcHOSnS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:43:18 -0400
Received: (qmail 3285 invoked by uid 109); 15 Aug 2016 18:43:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 18:43:18 +0000
Received: (qmail 17928 invoked by uid 111); 15 Aug 2016 18:43:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 14:43:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 14:43:15 -0400
Date:	Mon, 15 Aug 2016 14:43:15 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly
 platform-independent
Message-ID: <20160815184315.cyhln2bxg465lq2l@sigill.intra.peff.net>
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
 <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com>
 <xmqq4m6mhsvj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m6mhsvj.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 09:57:52AM -0700, Junio C Hamano wrote:

> I wonder if we already have a good mechanism to allow a project and
> its participants (say, "me") to declare "in this project, pathnames
> must conform to this rule" and help them avoid creating a tree that
> violates the rule customized to their project.
> 
> I guess "write_index_as_tree()" would be one of the central places
> to hook into and that covers an individual contributor or a patch
> applier who ends up adding offending paths to the project, as well
> as a merge made in response to a pull request (unless it is a
> fast-forward) [*1*].  The pre-receive hook can also be used to
> inspect and reject an attempt to push an offending tree into the
> history.
> 
> Such a mechanism would allow a project that wants participation by
> folks with case insensitive filesystems to ensure that they do not
> create a directory that has both xt_TCPMSS.h and xt_tcpmss.h at the
> same time, for example, but the mechanism needs to allow visibility
> into more than just a single path when the custom check is made
> (e.g. a hook run in "write_index_as_tree()" can see all entries in
> the index to make the decision; if we were to also hook into
> "add_to_index()", the hook must be able to see other entries in the
> index to which the new entry is being added).

I am not convinced this mechanism needs to be built into git. Because it
happens to be about filenames, git at least has a hope of making sense
of the various project rules.

But conceptually, I don't think this is really any different than "don't
check in code which does not build on platform X", or "do not check in
code that does not meet our style guide". We already have general hooks
where such checks can be made[1], and this could be checked in the same
place.

I actually think the whitespace-checking done by diff and apply is in a
similar boat, though it is useful in practice. OTOH, I think primarily
it is used as a tool to feed information to policy hooks, rather than as
an enforcement mechanism itself (maybe --whitespace=fix on apply is an
exception there, though).

-Peff

[1] Obviously we have pre-commit for local enforcement and pre-receive
    for central enforcement. But people with workflows around CI-style
    tests would want to be able to fetch, check "does this meet our
    policy", and return a yes/no answer on whether the result is OK to
    merge.
