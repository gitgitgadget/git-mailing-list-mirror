Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FCAC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 18:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiGASQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGASQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 14:16:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FD314082
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 11:16:27 -0700 (PDT)
Received: (qmail 9761 invoked by uid 109); 1 Jul 2022 18:16:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Jul 2022 18:16:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27637 invoked by uid 111); 1 Jul 2022 18:16:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Jul 2022 14:16:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Jul 2022 14:16:26 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH] pack-objects.h: remove outdated pahole results
Message-ID: <Yr85+tcexG2geaPP@coredump.intra.peff.net>
References: <1379af2e9d271b501ef3942398e7f159a9c77973.1656440978.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1379af2e9d271b501ef3942398e7f159a9c77973.1656440978.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 02:30:20PM -0400, Taylor Blau wrote:

> Even though this comment was written in a good spirit, it is updated
> infrequently enough that is serves to confuse rather than to encourage
> contributors to update the appropriate values when the modify the
> definition of object_entry.
> 
> For that reason, eliminate the confusion by removing the comment
> altogether.

I agree the actual numbers aren't helping anybody. We _could_ leave a
comment that says "we store a lot of these in memory; be careful of
where and how you add new fields to avoid increasing the struct size".
And then people can run "pahole" before and after their changes.

But then that is also true of other structs (like "struct object"), and
we do not bother there. So it probably is fine not to annotate this
specifically.

Speaking of which, I suspect quite a lot of memory could be saved if
"pack-objects --revs" freed the object structs it allocates during its
traversal. Unless we're generating bitmaps, I don't think they get used
again after the initial packing list is generated. At peak you'd
still be storing all of the object_entry structs alongside the objects
as you finish the traversal, but it wouldn't overlap with any memory
used for the delta search, and of course we'd be at that peak for a much
smaller time.

Not a blocker for your patch obviously, but maybe a fun experiment in an
adjacent area. Possibly even an ambitious #leftoverbits opportunity. :)

-Peff
