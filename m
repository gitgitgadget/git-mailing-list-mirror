Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFB5C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2761022D2A
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbhALJMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:12:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:53116 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730788AbhALJMk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 04:12:40 -0500
Received: (qmail 6717 invoked by uid 109); 12 Jan 2021 09:12:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 09:12:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11099 invoked by uid 111); 12 Jan 2021 09:12:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 04:12:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 04:11:59 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 13/20] packed_object_info(): convert to new revindex API
Message-ID: <X/1n36/HtqAoKXrH@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <eab7ab1f35fa9703f56a99fa539839869fe4e54c.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eab7ab1f35fa9703f56a99fa539839869fe4e54c.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:17:34PM -0500, Taylor Blau wrote:

> Convert another call of 'find_pack_revindex()' to its replacement
> 'pack_pos_to_offset()'. Likewise:
> 
>   - Avoid manipulating `struct packed_git`'s `revindex` pointer directly
>     by removing the pointer-as-array indexing.

Good.

>   - Add an additional guard to check that the offset 'obj_offset()'
>     points to a real object. This should be the case with well-behaved
>     callers to 'packed_object_info()', but isn't guarenteed.
>
>     Other blocks that fill in various other values from the 'struct
>     object_info' request handle bad inputs by setting the type to
>     'OBJ_BAD' and jumping to 'out'. Do the same when given a bad offset
>     here.

Also good. I wonder if we need to call error() here, too. The caller
will probably say something like "bad object" or whatever, but the user
will have no clue that it's related to the revindex.

That would match other parts of the function (e.g., calling into
unpack_entry() can generate lots of descriptive errors about exactly
what went wrong).

>     The previous code would have segfaulted when given a bad
>     'obj_offset' value, since 'find_pack_revindex()' would return
>     'NULL', and then the line that fills 'oi->disk_sizep' would try to
>     access 'NULL[1]' with a stride of 16 bytes (the width of 'struct
>     revindex_entry)'.

Yep. Again, I'm really happy to see these "should never happen" cases
converted to real errors or even BUG()s.

-Peff
