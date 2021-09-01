Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B7BC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 10:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC3960FED
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 10:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhIAKEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 06:04:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:36216 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhIAKED (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 06:04:03 -0400
Received: (qmail 16429 invoked by uid 109); 1 Sep 2021 10:03:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Sep 2021 10:03:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5504 invoked by uid 111); 1 Sep 2021 10:03:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Sep 2021 06:03:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Sep 2021 06:03:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YS9P2j1FoI5Q+ZLX@coredump.intra.peff.net>
References: <xmqq35qymrcn.fsf@gitster.g>
 <xmqqy28qlcow.fsf@gitster.g>
 <YSVuUYFh7lmhNlEy@nand.local>
 <xmqqo89jbf49.fsf@gitster.g>
 <YSko4OwwPb7MwEMa@nand.local>
 <xmqq4kb797xc.fsf@gitster.g>
 <YSwhNxqAS8JajA7p@nand.local>
 <22366f81-65a6-55d1-706c-59f877127be0@gmail.com>
 <YS3AKhQJjMrFm1JO@coredump.intra.peff.net>
 <xmqqk0k1wp3x.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0k1wp3x.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 09:33:38AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> I think taking a look to see if ../config exists to use the data
> >> might be helpful for some cases, but should not be a blocker for
> >> completing the requested operation. The config from the non-alternate
> >> repo should be sufficient for this (somewhat strange) case.
> >
> > Yes, agreed. We have long supported these kind of "bare" alternates, and
> > I wouldn't be surprised if they are in wide use (though I do wonder how
> > folks actually modify them, since most commands that touch objects
> > really do want to be in a repository).
> 
> I kind of find the above two somewhat surprising, but I am willing
> to go with the less safer option if that is what people want.
> 
> It has been perfectly OK in the pre-alternative-hash-algorithms
> world, but we no longer live in such a world, so we'd need to come
> up with a way to keep using alternates in a safer way.

I think the point is that most people _do_ still live in that world.
They have not started using the new hash algorithm yet, and what they
have been doing for years will continue to work. Likewise, once they
switch, things will continue to work as long as each repo's alternates
use the same hash.

So my reasoning was less "this is useful, and a good idea" and more "it
works now, and will probably continue to work OK in practice, so taking
it away will probably bother people".

Now if somebody wants to make an argument that they are not actually
workable now, I could buy that. ;) You cannot even run "pack-objects"
without a repository, though it is not too hard to copy the result
around.

> > But I suspect all of this is moot for now, beyond being able to return a
> > nicer error message. The rest of the code is not at all ready to handle
> > packs with two different hashes in the same process.
> 
> I do not think it is all that urgent to make it possible for packs
> with different algorithms to be used.  It is sufficient to _ignore_
> (or error out) configured odb that is incompatible with the current
> repository.

Yes, I think that would be an improvement. I just don't find it all that
urgent, since they're likely to get an error anyway (just probably one
that is more mysterious). Given the work involved to even detect the
situation, it doesn't seem like that high a priority to me.

-Peff
