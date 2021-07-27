Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB26C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF81600CD
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhG0Rmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:42:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:58896 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhG0Rmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:42:36 -0400
Received: (qmail 31100 invoked by uid 109); 27 Jul 2021 17:42:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jul 2021 17:42:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1025 invoked by uid 111); 27 Jul 2021 17:42:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jul 2021 13:42:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jul 2021 13:42:35 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YQBFi70c1wfXdKQf@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
 <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
 <YPhz+iOMu4Q7zjY4@nand.local>
 <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
 <YP8F9ttlMXwNZBam@nand.local>
 <YP8zsR+W8JeCWc1Q@nand.local>
 <YQBCjSmdOPfrnNnK@coredump.intra.peff.net>
 <YQBEIrRfcq5dhpZn@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQBEIrRfcq5dhpZn@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 01:36:34PM -0400, Taylor Blau wrote:

> > But now the internal midx writing code can never call close_midx() on
> > that, because it does not own it to close. Can we simply drop the
> > close_midx() call there?
> >
> > This would all make much more sense to me if write_midx_internal()
> > simply took a conceptually read-only midx as a parameter, and the caller
> > passed in the appropriate one (probably even using
> > prepare_multi_pack_index_one() to get it).
> 
> No, we can't drop the close_midx() call there because we must close the
> MIDX file on Windows before moving a new one into place. My feeling is
> we should always be working on the r->objects->multi_pack_index pointer,
> and calling close_object_store() there instead of close_midx().
> 
> Does that seem like a reasonable approach to you?

Yes, though I'd have said that it is the responsibility of the caller
(who knows we are operating with r->objects->multi_pack_index) to do
that closing. But maybe it's not possible if the rename-into-place
happens at too low a level.

BTW, yet another weirdness: close_object_store() will call close_midx()
on the outermost midx struct, ignoring o->multi_pack_index->next
entirely. So that's a leak, but also means we may not be closing the
midx we're interested in (since write_midx_internal() takes an
object-dir parameter, and we could be pointing to some other
object-dir's midx).

-Peff
