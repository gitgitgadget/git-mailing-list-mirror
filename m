Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8288DC433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 16:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688E520707
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 16:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHaQuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:50:21 -0400
Received: from mimir.eigenstate.org ([206.124.132.107]:32979 "EHLO
        mimir.eigenstate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgHaQuU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 12:50:20 -0400
Received: from abbatoir.fios-router.home (pool-74-101-2-6.nycmny.fios.verizon.net [74.101.2.6])
        by mimir.eigenstate.org (OpenSMTPD) with ESMTPSA id 9818e714 (TLSv1.2:ECDHE-RSA-AES256-SHA:256:NO);
        Mon, 31 Aug 2020 09:50:20 -0700 (PDT)
Message-ID: <C9978BD24477BD4A7FE2D3A014436D8D@eigenstate.org>
To:     peff@peff.net, ori@eigenstate.org
CC:     gitster@pobox.com, l.s.r@web.de, git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
Date:   Mon, 31 Aug 2020 09:50:18 -0700
From:   ori@eigenstate.org
In-Reply-To: <20200831092946.GA2812764@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Sun, Aug 30, 2020 at 09:15:10AM -0700, Junio C Hamano wrote:
> 
>> René Scharfe <l.s.r@web.de> writes:
>> 
>> >> Will that work? I'd expect that modern pack files end up being
>> >> offset deltas, rather than reference deltas.
>> >
>> > True, but going down all the way would work:
>> 
>> Perhaps, but I'd rather use pack-objects to prepare the repository
>> with no-delta-base-offset to force ref deltas.
> 
> Yeah, that seems like a much better test setup.
> 
> It does raise an interesting question, though. I had imagined we would
> limit the depth of all delta chains here, not just ref-deltas. But it is
> true that ofs deltas can't cycle. Without cycles, neither type can go on
> indefinitely (they are limited by the number of entries in the
> packfile). I could see arguments going either way:

Yeah -- that's what I'd implemented. I was just thinking that I'd want to
test the issue that caused the problem in the first place, but it's the
same code path either way.

I like the idea of limiting to the total number of objects in the
pack. If we do that, we don't need a knob at all, since if we need
more objects in the stack than are in the pack, it's obviously
invalid.

That does eliminate an obvious way to test things, and we'd need
to provide in an invalid pack file.

