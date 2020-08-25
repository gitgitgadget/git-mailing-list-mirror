Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5733EC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229192076C
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHYReu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:34:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:40226 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgHYRes (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 13:34:48 -0400
Received: (qmail 1440 invoked by uid 109); 25 Aug 2020 17:34:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 17:34:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30384 invoked by uid 111); 25 Aug 2020 17:34:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 13:34:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 13:34:46 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825173446.GE1414394@coredump.intra.peff.net>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
 <c78b3108-b760-d252-9428-6f03549fea11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c78b3108-b760-d252-9428-6f03549fea11@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 12:18:42PM -0400, Derrick Stolee wrote:

> The best I can see is that prepare_midx_pack() will return 1 if the
> pack no longer exists, and this would cause a die("error preparing
> packfile from multi-pack-index") in nth_midxed_pack_entry(), killing
> the following stack trace:
> 
> + find_pack_entry():packfile.c
>  + fill_midx_entry():midx.c
>   + nth_midxed_pack_entry():midx.c
> 
> Perhaps that die() is a bit over-zealous since we could return 1
> through this stack and find_pack_entry() could continue searching
> for the object in the packed_git list. However, it could start
> returning false _negatives_ if there were duplicates of the object
> in the multi-pack-index but only the latest copy was deleted (and
> the object does not appear in a pack-file outside of the multi-
> pack-index).

Hmm, yeah.

I thought this code is already doing the right thing, because I'd expect
the is_pack_valid() call later in nth_midxed_pack_entry() to be where we
notice the problem. But add_packed_git() does stat the packfile and
return an error.

So that die() really ought to be just "return 0". The caller already has
to (and does) handle similar errors (including that the pack went away
after we added it to the packed_git list, or that it exists but has
bogus data, etc).

-Peff
