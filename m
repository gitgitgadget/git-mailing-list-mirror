Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259831FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 05:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750849AbcLEFkp (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 00:40:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:51540 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbcLEFko (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 00:40:44 -0500
Received: (qmail 25944 invoked by uid 109); 5 Dec 2016 05:40:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 05:40:15 +0000
Received: (qmail 1853 invoked by uid 111); 5 Dec 2016 05:40:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 00:40:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 00:40:13 -0500
Date:   Mon, 5 Dec 2016 00:40:13 -0500
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: Should reset_revision_walk clear more flags?
Message-ID: <20161205054013.taosbwjamxiwzocn@sigill.intra.peff.net>
References: <20161204230958.h3ilhueqqptv253u@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161204230958.h3ilhueqqptv253u@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2016 at 08:09:58AM +0900, Mike Hommey wrote:

> While trying to use the revision walking API twice in a row, I noticed
> that the second time for the same setup would not yield the same result.
> In my case, it turns out I was requesting boundaries, and
> reset_revision_walk() is not resetting CHILD_SHOWN and BOUNDARY, both
> required to be reset for the second revision walk to work.
> 
> So the question is, are consumers supposed to reset those flags on their
> own, or should reset_revision_walk clear them?

I would think that reset_revision_walk() should reset any flags set by
the revision-walking code (so anything set by calling init_revisions(),
and then either a call into list_objects() or repeated calls of
get_revision()).

Which I think would include both of the flags you mentioned, along with
others like SYMMETRIC_LEFT, PATCHSAME, etc. Probably really everything
mentioned in revision.h, which should be summed up as ALL_REV_FLAGS.
Some callsites already seem to feed that to clear_commit_marks().

I doubt you can go too wrong by clearing more flags. It's possible that
some caller is relying on a flag _not_ being cleared between two
traversals, but in that case it should probably be using
clear_commit_marks() or clear_object_flags() explicitly to make it clear
what it expects to be saved.

-Peff
