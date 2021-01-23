Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FDFC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 00:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3D223B6A
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 00:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbhAWAJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 19:09:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:36056 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbhAWAJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 19:09:29 -0500
Received: (qmail 15825 invoked by uid 109); 23 Jan 2021 00:08:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Jan 2021 00:08:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20574 invoked by uid 111); 23 Jan 2021 00:08:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Jan 2021 19:08:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Jan 2021 19:08:30 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 4/8] builtin/pack-objects.c: respect
 'pack.writeReverseIndex'
Message-ID: <YAto/ndOVfKSkizS@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <68bde3ea972f5b3753d7e9063d0490c67c74709b.1610576805.git.me@ttaylorr.com>
 <YAtmb7wXQse76kJi@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAtmb7wXQse76kJi@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 06:57:35PM -0500, Jeff King wrote:

> > +	if (!strcmp(k, "pack.writereverseindex")) {
> > +		if (git_config_bool(k, v))
> > +			pack_idx_opts.flags |= WRITE_REV;
> > +		else
> > +			pack_idx_opts.flags &= ~WRITE_REV;
> > +		return 0;
> > +	}
> 
> This turned out delightfully simple. And I guess this is the "why is
> WRITE_REV" caller I asked about from patch 2. It is
> finish_tmp_packfile() where the magic happens. That unconditionally
> calls write_rev_file(), but it's a noop if WRITE_REV isn't specified.
> 
> Makes sense.

Oh, one subtlety here: this is in pack-objects itself, _not_ in
git-repack. This has bit us before with options like
repack.writebitmaps, which was originally pack.writebitmaps and
introduced all sorts of awkwardness (because pack-objects serves many
other purposes besides repacks).

I think this _might_ be OK, because we wouldn't even hit the code-paths
that handle this unless we are also writing a .idx (and really, the
point is that the two should always be written together or not at all).

So probably it's fine, but I wonder if we should err on the side of
conservatism by saying that pack-objects will not change behavior
without receiving a new command-line option, and that repack should
trigger that option. I dunno. I guess that it makes it weird with
respect to index-pack, which wants to see a very low-level option, too.
So maybe this is the best way forward.

(Sorry for being non-committal; I'm mostly thinking out loud).

-Peff
