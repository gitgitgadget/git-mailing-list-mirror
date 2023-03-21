Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E5C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCUS2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCUS2s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:28:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D71559C4
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:27:59 -0700 (PDT)
Received: (qmail 28546 invoked by uid 109); 21 Mar 2023 18:27:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 18:27:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2774 invoked by uid 111); 21 Mar 2023 18:27:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 14:27:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 14:27:32 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 6/6] pack-bitmap.c: factor out
 `bitmap_index_seek_commit()`
Message-ID: <20230321182732.GK3119834@coredump.intra.peff.net>
References: <cover.1679342296.git.me@ttaylorr.com>
 <82049ed09e1695db644d1d4cf17557214e54dcea.1679342296.git.me@ttaylorr.com>
 <20230321181315.GH3119834@coredump.intra.peff.net>
 <ZBn0iFE5qOJKVeel@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBn0iFE5qOJKVeel@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 02:16:40PM -0400, Taylor Blau wrote:

> On Tue, Mar 21, 2023 at 02:13:15PM -0400, Jeff King wrote:
> > I'm not 100% sure on where these offsets come from. But it looks like
> > they're coming from the bitmap lookup table. In which case a bogus value
> > there should be an error(), and not a BUG(), I would think.
> 
> They do come from the lookup table, yes. I'm not sure that I agree that
> bogus values here should be an error() or a BUG(), or if I even have a
> strong preference between one and the other.

The usual philosophy we've applied is: a BUG() should not be
trigger-able, even if Git is fed bad data. A BUG() should indicate an
error in the program logic, and if we see one, there should be a code
fix that handles the case.

Whereas if I understand this correctly, if I corrupt the bitmap file on
disk, we'd trigger this BUG().

In many cases I think one could argue that it's kind of academic. But in
this case we should be able to say "oops, the bitmap file seems corrupt"
and skip using it, rather than bailing completely from the process.

> But I do think that trying to make it an error() makes it awkward for
> all of the other callers that want it to be a BUG(), since the detail of
> whether to call one or the other is private to bitmap_index_seek().
>
> We *could* open-code it, introduce a variant of bitmap_index_seek(),
> make it take an additional parameter specifying whether to call one over
> the other, *or* check the bounds ourselves before even calling
> bitmap_index_seek().

I'm mostly unconvinced of the value of bitmap_index_seek() doing
checking at all, because it is too late in most of the cases. In fact it
is only in this case that it is doing something useful, which makes me
think that the check should be open-coded here.

-Peff
