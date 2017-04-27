Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD091FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 05:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbdD0FwR (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 01:52:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:41031 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753525AbdD0FwO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 01:52:14 -0400
Received: (qmail 23214 invoked by uid 109); 27 Apr 2017 05:52:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 05:52:12 +0000
Received: (qmail 8641 invoked by uid 111); 27 Apr 2017 05:52:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 01:52:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Apr 2017 01:52:09 -0400
Date:   Thu, 27 Apr 2017 01:52:09 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 35/53] Convert the verify_pack callback to struct
 object_id
Message-ID: <20170427055209.ock533opgzans6ew@sigill.intra.peff.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
 <20170423213453.253425-36-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170423213453.253425-36-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 09:34:35PM +0000, brian m. carlson wrote:

> Make the verify_pack_callback take a pointer to struct object_id.

That sounds good.

> Use a
> struct object_id to hold the pack checksum, even though it is not
> strictly an object ID.  Doing so ensures resilience against future hash
> size changes, and allows us to remove hard-coded assumptions about how
> big the buffer needs to be.

But this part seems questionable to me. Sure, we may change the pack
checksum in the future. But there is a reasonable chance that it won't
follow the same rules for selecting a hash as object_id. And even if it
does, calling it object_id just seems misleading.

What's the gain in converting it here? I know we want to get rid of the
bare "20", but we could switch it out for GIT_SHA1_RAWSZ. I suspect you
prefer in the long run to get rid of even those GIT_SHA1_RAWSZ defines,
though.  Could we define a new struct csumfile_hash, csumfile_cmp, etc
(and arguably change the name of "struct sha1file" and friends).  They'd
be boring wrappers around sha1 now, but I think the endgame will involve
us being able to read multiple versions of packs, with distinct
checksum algorithms.

> Also, use a union to convert the pointer from nth_packed_object_sha1 to
> to a pointer to struct object_id.  This behavior is compatible with GCC
> and clang and explicitly sanctioned by C11.  The alternatives are to
> just perform a cast, which would run afoul of strict aliasing rules, but
> should just work, and changing the pointer into an instance of struct
> object_id and copying the value.  The latter operation could seriously
> bloat memory usage on fsck, which already uses a lot of memory on some
> repositories.

Nasty, but it's probably the least-bad option.

-Peff
