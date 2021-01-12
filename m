Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ADAC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B5B230FC
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbhALJq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:46:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:53206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbhALJq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 04:46:29 -0500
Received: (qmail 7589 invoked by uid 109); 12 Jan 2021 09:45:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 09:45:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11466 invoked by uid 111); 12 Jan 2021 09:45:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 04:45:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 04:45:47 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <X/1vy3D10wDEZNva@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:16:39PM -0500, Taylor Blau wrote:

> Generating the reverse index in memory for repositories with large packs has two
> significant drawbacks:
> 
>   - It requires allocating sizeof(struct revindex_entry) per packed object.
> 
>   - It requires us to sort the entries by their pack offset. This is implemented
>     in sort_revindex() using a radix sort, but still takes considerable time (as
>     benchmarks found in the second series demonstrate).

Or thinking about it more fundamentally: any operation which touches the
revindex is now O(nr_objects_in_repo), even if it only cares about a few
objects. Ideally this will eventually be this O(log nr_objects_in_repo);
we can't do much better than that because of object lookups (unless we
replace the .idx with a perfect hash or something).

> The goal of this series is to remove direct access of the `struct
> revindex_entry` type, as well as `struct packed_git`'s `revindex` field. The
> on-disk format will be mmap'd and accessed directly, but the format is
> sufficiently different that the whole `revindex` array can't be written as-is.

It looks good overall to me. I left a few nits around documentation and
integer types that I think are worth a re-roll, but I think after
addressing those it should be good.

-Peff
