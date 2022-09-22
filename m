Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA85ECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 22:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIVWQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIVWQP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 18:16:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F0596775
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 15:16:13 -0700 (PDT)
Received: (qmail 9312 invoked by uid 109); 22 Sep 2022 22:16:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 22:16:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8484 invoked by uid 111); 22 Sep 2022 22:16:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 18:16:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 18:16:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai <johncai86@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/3] fsck: free tree buffers after walking unreachable
 objects
Message-ID: <YyzerG/hXFCsI7Lt@coredump.intra.peff.net>
References: <Yyw0PSVe3YTQGgRS@coredump.intra.peff.net>
 <Yyw031PqCyYlEqCX@coredump.intra.peff.net>
 <xmqqa66rz20q.fsf@gitster.g>
 <YyywSdrWO61Kza0e@coredump.intra.peff.net>
 <xmqq5yhfyztm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yhfyztm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 12:27:33PM -0700, Junio C Hamano wrote:

> > As a side note, IMHO having tree->buffer at all is a mistake, because it
> > leads to exactly this kind of confusion about when the buffer should be
> > discarded. We'd be better off having all callers parse directly into a
> > local buffer, and then clean up when they're done.
> 
> Yeah, tree-walk.c users woud use tree_desc structure anyway, and
> instead of having a moving pointer that points into a separate thing
> (i.e. tree->buffer), it could have its own copy of the "whole buffer"
> that can be used to free when it is done iterating over entries.
> 
> > .... But that's obviously a much bigger change.
> 
> Yup.

I took a (very) brief stab at this, out of curiosity. The sticking point
becomes obvious very quickly: how do we get the buffer to the caller? If
you are calling parse_tree(), we can add new out-parameters to provide
the buffer. But something like parse_object() is just returning an
object struct, and we have to stuff anything we want to communicate to
the caller inside the polymorphic struct which contains it.

We could split the concept of "parse" away from "get the buffer"
entirely, but then we have a potential slowdown. The "parse" functions
really want to open the object contents and check the hash (and removing
that in the general case would probably break part of fsck, at least).
So we'd end up inflating the object contents twice, which would probably
have a measurable impact.

I don't plan on digging any further on it for now, so this is just a
note for future people who do. :)

-Peff
