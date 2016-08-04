Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A011720193
	for <e@80x24.org>; Thu,  4 Aug 2016 20:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965422AbcHDUJK (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 16:09:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:54957 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965411AbcHDUJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 16:09:09 -0400
Received: (qmail 12782 invoked by uid 102); 4 Aug 2016 20:09:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 16:09:09 -0400
Received: (qmail 15563 invoked by uid 107); 4 Aug 2016 20:09:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 16:09:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 16:09:05 -0400
Date:	Thu, 4 Aug 2016 16:09:05 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: Re: [BUG?] --boundary inconsistent with path limiting
Message-ID: <20160804200905.7xdiei2yfv2aw6im@sigill.intra.peff.net>
References: <20160804194043.z4nbosr4wpbzljdl@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160804194043.z4nbosr4wpbzljdl@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 03:40:43PM -0400, Jeff King wrote:

> That makes sense to me. We omit "c" because it doesn't touch "b.t", and
> obviously include "b", which does. We _do_ include the boundary commit,
> even though it doesn't touch the path, which makes sense to me. It
> remains a boundary whether it touched the path or not, and without it,
> we get no boundary at all.
> 
> But now if I limit to "a.t", I get no output at all:
> 
>   $ git log --format='%m %s' --boundary a..c -- a.t
> 
> whereas I would have expected "- a" to show the boundary.
> 
> Is this a bug, or are my expectations wrong?

So I suppose it depends how you define "boundary" commits. In
get_revision_internal(), I see this comment:

        /*
         * boundary commits are the commits that are parents of the
         * ones we got from get_revision_1() but they themselves are
         * not returned from get_revision_1().  Before returning
         * 'c', we need to mark its parents that they could be boundaries.
         */

By that definition, obviously if we do not have any commits to show,
then we have no boundary commits. I don't think this definition is
anywhere in the user-facing documentation, though.

It still seems weird to me, and I wonder if we should show all
UNINTERESTING commits as boundaries in the case that we haven't produced
any positive commits at all. But perhaps there is a case where that
would not be desirable.

-Peff
