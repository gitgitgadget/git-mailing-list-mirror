Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADE8C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B4A60698
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhJUSef (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:34:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63450 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUSef (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 14:34:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78FE8FCAD5;
        Thu, 21 Oct 2021 14:32:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NJjbVRz5YC5PJfem5Bd6eKN9GCZMvz1AA5SE5q
        4UhSY=; b=DF/eG1esZj9L4Fw+bpi2ddV0w/G/icnFFbJNLtrZF7wYfSE9q45TRs
        qeuxl1pSV6jBOqVY9XcAReT5pBMGTkyUkhd9pfqcA54T3qPC35I8SBxko6MG60hE
        sIj+H2sFm8jajF0nRdvYuPkUo/7+TL3Q3Azosc7EWvqjniI7DntaA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F380FCAD4;
        Thu, 21 Oct 2021 14:32:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C3B77FCAD3;
        Thu, 21 Oct 2021 14:32:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/11] pack-bitmap.c: more aggressively free in
 free_bitmap_index()
References: <cover.1634787555.git.me@ttaylorr.com>
        <e65ac7deb5973b8209e8d94ad9140e005e22c44e.1634787555.git.me@ttaylorr.com>
        <CAPig+cToh_8x+72-g6cdvt559N4GqKwfmBDE9BxTpkXOFrRbsA@mail.gmail.com>
Date:   Thu, 21 Oct 2021 11:32:16 -0700
In-Reply-To: <CAPig+cToh_8x+72-g6cdvt559N4GqKwfmBDE9BxTpkXOFrRbsA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 21 Oct 2021 01:10:26 -0400")
Message-ID: <xmqqy26mkz4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 385853CC-329D-11EC-9BF8-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Oct 20, 2021 at 11:40 PM Taylor Blau <me@ttaylorr.com> wrote:
>> The function free_bitmap_index() is somewhat lax in what it frees. There
>> are two notable examples:
>>
>>   - While it does call kh_destroy_oid_map on the "bitmaps" map (which
>>     maps) commit OIDs to their corresponding bitmaps, the bitmaps
>>     themselves are not freed. Note here that we recycle already-freed
>>     ewah_bitmaps into a pool, but these are handled correctly by
>>     ewah_pool_free().
>
> The parentheses placement seems off; it's not clear what the intent
> is. Perhaps either move the closing parenthesis to just before the
> comma or drop them altogether.

Yeah, I think we can do without them and the sentence becomes
clearer (we can add a comma before "which", too).

>>   - We never bother to free the extended index's "positions" map, which
>>     we always allocate in load_bitmap().
>>
>> Fix both of these.
>>
>> Signed-off-by: Taylor Blau <me@ttaylorr.com>
