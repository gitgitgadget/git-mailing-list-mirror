Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FD8C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFD9223E8
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbhALJH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:07:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:53102 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730466AbhALJH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 04:07:27 -0500
Received: (qmail 6586 invoked by uid 109); 12 Jan 2021 09:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 09:06:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11032 invoked by uid 111); 12 Jan 2021 09:06:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 04:06:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 04:06:46 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 09/20] try_partial_reuse(): convert to new revindex API
Message-ID: <X/1mpl/ZmL4NPIEm@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <54f4ad329f56808432549aa885f2847d5c9a8ac6.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54f4ad329f56808432549aa885f2847d5c9a8ac6.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:17:17PM -0500, Taylor Blau wrote:

> Remove another instance of direct revindex manipulation by calling
> 'pack_pos_to_offset()' instead (the caller here does not care about the
> index position of the object at position 'pos').
> 
> Somewhat confusingly, the subsequent call to unpack_object_header()
> takes a pointer to &offset and then updates it with a new value. But,
> try_partial_reuse() cares about the offset of both the base's header and
> contents. The existing code made a copy of the offset field, and only
> addresses and manipulates one of them.
> 
> Instead, store the return of pack_pos_to_offset twice: once in header
> and another in offset. Header will be left untouched, but offset will be
> addressed and modified by unpack_object_header().

I had to read these second two paragraphs a few times to parse them.
Really we are just replacing revidx->offset with "header", and "offset"
retains its same role within the function.

So it's definitely doing the right thing, but it makes more sense to me
as:

  Note that we cannot just use the existing "offset" variable to store
  the value we get from pack_pos_to_offset(). It is incremented by
  unpack_object_header(), but we later need the original value. Since
  we'll no longer have revindex->offset to read it from, we'll store
  that in a separate variable ("header" since it points to the entry's
  header bytes).

Another option would be to just call pack_pos_to_offset() again for the
later call. Like the code it's replacing, it's constant-time anyway. But
I think the "header" variable actually makes things more readable.

-Peff
