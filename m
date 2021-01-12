Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10B5C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F4422DD3
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390705AbhALJhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:37:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:53174 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389440AbhALJhv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 04:37:51 -0500
Received: (qmail 7341 invoked by uid 109); 12 Jan 2021 09:37:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 09:37:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11348 invoked by uid 111); 12 Jan 2021 09:37:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 04:37:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 04:37:09 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 20/20] pack-revindex.c: avoid direct revindex access in
 'offset_to_pack_pos()'
Message-ID: <X/1txTIxV4pYt0Xo@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <eada1ffcfafc3fb57de80626e368672cb8b22318.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eada1ffcfafc3fb57de80626e368672cb8b22318.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:18:06PM -0500, Taylor Blau wrote:

> To prepare for on-disk reverse indexes, remove a spot in
> 'offset_to_pack_pos()' that looks at the 'revindex' array in 'struct
> packed_git'.
> 
> Even though this use of the revindex pointer is within pack-revindex.c,
> this clean up is still worth doing. Since the 'revindex' pointer will be
> NULL when reading from an on-disk reverse index (instead the
> 'revindex_data' pointer will be mmaped to the 'pack-*.rev' file), this
> call-site would have to include a conditional to lookup the offset for
> position 'mi' each iteration through the search.
> 
> So instead of open-coding 'pack_pos_to_offset()', call it directly from
> within 'offset_to_pack_pos()'.

This definitely makes sense in the long run. I could take or leave it as
a final patch in _this_ series (as opposed to the first patch in a
subsequent series adding the rev files).

>  	do {
>  		const unsigned mi = lo + (hi - lo) / 2;
> -		if (revindex[mi].offset == ofs) {
> +		off_t got = pack_pos_to_offset(p, mi);


They're both constant-time, so performance should be the same big-O. The
function has extra BUG() checks. I doubt those are measurable in
practice, though.

-Peff
