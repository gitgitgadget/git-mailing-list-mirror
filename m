Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADE1C43217
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiK2B2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiK2B17 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:27:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D112AE1
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:27:57 -0800 (PST)
Received: (qmail 11415 invoked by uid 109); 29 Nov 2022 01:27:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Nov 2022 01:27:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13495 invoked by uid 111); 29 Nov 2022 01:27:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Nov 2022 20:27:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Nov 2022 20:27:55 -0500
From:   Jeff King <peff@peff.net>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 4/4] pack-bitmap.c: trace bitmap ignore logs when
 midx-bitmap is found
Message-ID: <Y4VgG0Bu1P2NW4d5@coredump.intra.peff.net>
References: <Y3vM3GZYFy+l006d@coredump.intra.peff.net>
 <20221128123740.54250-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221128123740.54250-1-tenglong.tl@alibaba-inc.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 08:37:40PM +0800, Teng Long wrote:

> > > @@ -559,11 +557,20 @@ static int open_midx_bitmap(struct repository *r,
> > >  static int open_bitmap(struct repository *r,
> > >  		       struct bitmap_index *bitmap_git)
> > >  {
> > > +	int found = 0;
> > > +
> > >  	assert(!bitmap_git->map);
> > >
> > > -	if (!open_midx_bitmap(r, bitmap_git))
> > > -		return 0;
> > > -	return open_pack_bitmap(r, bitmap_git);
> > > +	found = !open_midx_bitmap(r, bitmap_git);
> >
> > I think we can drop the initialization of "found = 0"; that value is
> > unused, since we'll always assign to it (I think my initial attempt had
> > setting it to 1 inside the conditional).
> >
> > It's not hurting anything functionally, but it makes the code slightly
> > more confusing to read.
> 
> I agree it's not hurting here, it's OK for me to make the improvement
> here. But I have a question, do we prefer to omit the initialization
> in such scenarios if we make sure it will initialized correctly？

I don't know that we have a particular rule here, but I would say that
yes, if you know the initialization isn't used, then skip it. That
communicates the expectation to anybody reading the code. And if you're
wrong, the compiler will generally notice.

-Peff
