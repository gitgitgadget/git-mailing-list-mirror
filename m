Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB111CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjJKWtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjJKWtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:49:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DBEA4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:49:15 -0700 (PDT)
Received: (qmail 20311 invoked by uid 109); 11 Oct 2023 22:49:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 22:49:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11075 invoked by uid 111); 11 Oct 2023 22:49:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 18:49:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 18:49:14 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/20] chunk-format: note that pair_chunk() is unsafe
Message-ID: <20231011224914.GF518221@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009205823.GA3282181@coredump.intra.peff.net>
 <ZSXiJZFnmpzAmuwx@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSXiJZFnmpzAmuwx@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023 at 07:45:41PM -0400, Taylor Blau wrote:

> On Mon, Oct 09, 2023 at 04:58:23PM -0400, Jeff King wrote:
> > There are no callers of the "safe" version yet, but we'll add some in
> > subsequent patches.
> 
> Makes sense.
> 
> > +int pair_chunk_unsafe(struct chunkfile *cf,
> > +		      uint32_t chunk_id,
> > +		      const unsigned char **p)
> >  {
> > -	return read_chunk(cf, chunk_id, pair_chunk_fn, p);
> > +	size_t dummy;
> > +	return pair_chunk(cf, chunk_id, p, &dummy);
> 
> I have always disliked functions that require you to pass a non-NULL
> pointer to some value that you may or may not want to have that function
> fill out. So I was going to suggest something along the lines of
> "pair_chunk() should tolerate a NULL fourth argument instead of filling
> out the size unconditionally".
> 
> But that's (a) the whole point of the series ;-), and (b) unnecessary,
> since this function is going to go away entirely by the end of the
> series, too.

Yeah, for the record, I think a dummy variable like this is usually a
code smell. And it truly is a "problem" here, because we are
intentionally doing the unsafe and stupid thing. :)

-Peff
