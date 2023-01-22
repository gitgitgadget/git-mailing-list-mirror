Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6099BC38142
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 22:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjAVWCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 17:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjAVWCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 17:02:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829DF15C90
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 14:02:08 -0800 (PST)
Received: (qmail 7601 invoked by uid 109); 22 Jan 2023 22:02:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Jan 2023 22:02:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 922 invoked by uid 111); 22 Jan 2023 22:02:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Jan 2023 17:02:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Jan 2023 17:02:06 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] tree-walk: disallow overflowing modes
Message-ID: <Y82yXskkgH00vaGy@coredump.intra.peff.net>
References: <d673fde7-7eb2-6306-86b6-1c1a4c988ee8@web.de>
 <Y8zquGar3rLyRdTp@coredump.intra.peff.net>
 <044bdc8f-fdc9-dfd2-6cbb-941513467524@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <044bdc8f-fdc9-dfd2-6cbb-941513467524@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 22, 2023 at 11:03:38AM +0100, René Scharfe wrote:

> Am 22.01.23 um 08:50 schrieb Jeff King:
> > On Sat, Jan 21, 2023 at 10:36:09AM +0100, René Scharfe wrote:
> >
> >> When parsing tree entries, reject mode values that don't fit into an
> >> unsigned int.
> >
> > Seems reasonable. I don't think you can cause any interesting mischief
> > here, but it's cheap to check, and finding data problems earlier rather
> > than later is always good.
> >
> > Should it be s/unsigned int/uint16_t/, though?
> 
> "mode" is declared as unsigned int, and I was more concerned with
> overflowing that.

Doh, I just did "vim -t get_mode" and ended up in the near-identical
version in fast-import.c, which uses uint16_t. Maybe it would want the
same treatment. ;)

> We could be more strict and reject everything that oversteps
> S_IFMT|ALLPERMS, but the latter is not defined everywhere.  But
> permission bits are well-known, so the magic number 07777 should be
> recognizable enough.  Like this?

It feels like this level of check should be happening in the fsck
caller. In particular, it's nice for this parsing layer to err on the
forgiving side, because the way you get out of these situations often
involves something like "git ls-tree | git mktree".

So in that sense, even pushing the overflow detection into the fsck
would be nice, but of course it's hard to do, since we have no way to
represent the overflowed value. I guess we could have a "be more
careful" flag that the fsck code would pass, but I'm not sure it's worth
the added complexity.

-Peff
