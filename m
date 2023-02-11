Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BF1C636D3
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 02:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBKCPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 21:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKCPm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 21:15:42 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B474990
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:15:41 -0800 (PST)
Received: (qmail 21451 invoked by uid 109); 11 Feb 2023 02:15:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Feb 2023 02:15:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30368 invoked by uid 111); 11 Feb 2023 02:15:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Feb 2023 21:15:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Feb 2023 21:15:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] cache-tree: fix strbuf growth in prime_cache_tree_rec()
Message-ID: <Y+b6TAmxel48QHJa@coredump.intra.peff.net>
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
 <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
 <850c94d5-973a-335e-903f-e0ab7e52f37e@web.de>
 <xmqqwn4pgt1f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn4pgt1f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2023 at 12:33:00PM -0800, Junio C Hamano wrote:

> > strbuf_setlen() truncates the string to the directory name.  strbuf_grow() then
> > makes enough room to add that directory name again (that's what I mean with
> > "double") plus the entry path.  We don't add the directory name a second time,
> > so we don't need to make room for it.
> 
> Yeah, I think I made the same mistake number of years ago, thinking
> that strbuf_grow() was to grow the buffer to the given size, but in
> reality it is to grow the buffer by the given size, which felt a bit
> unnatural, at least to me.  I do not feel it too strongly but we
> might want to rename _grow() to _grow_by() and make _grow() call it
> while giving deprecation warning X-<.

Having been confused by that myself, I would be happy to see such a
name change.

> There are ~45 calls to strbuf_grow() in C files other than strbuf.c;
> I suspect probably a half or more of them can and should be removed
> to reduce the resulting code size without hurting anything.

My gut feeling is that your suspicion is giving strbuf_grow() users too
much credit. ;) And having looked at the first 7 grep hits, every single
one of them seemed pointless to me.

I wonder if these would make a good #leftoverbits / micro-project
candidate.

-Peff
