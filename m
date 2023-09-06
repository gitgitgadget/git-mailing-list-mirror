Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ECCEE14BB
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 17:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbjIFRFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 13:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjIFRFo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 13:05:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6541F13E
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 10:05:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F4EE198A04;
        Wed,  6 Sep 2023 13:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=kFtgXIa4fvOxpo8UMGgYqIDbjTzha5837v3Te1
        EB1VM=; b=ws4WEwsFDNXpDxW3reN5jyAD/18klQrS9wvpU2kZdL3vYJIZKaYFOY
        +qXtAAKjxEZndtvey70OITp8ylRTsFwYTuzLx4yCg3ZipHyJXEkLmsusDuDGYbLY
        cZ2jiXAvqTDEWZ8amG2O+t98Hq6LDBhqJcxFhHOwJ5qCjU1Acc4rM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 081AA198A03;
        Wed,  6 Sep 2023 13:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6811E198A01;
        Wed,  6 Sep 2023 13:05:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 7/8] builtin/repack.c: drop `DELETE_PACK` macro
In-Reply-To: <559b487e2ab056c79367a673188764e4cdce3c96.1693946195.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 5 Sep 2023 16:36:56 -0400")
References: <cover.1693946195.git.me@ttaylorr.com>
        <559b487e2ab056c79367a673188764e4cdce3c96.1693946195.git.me@ttaylorr.com>
Date:   Wed, 06 Sep 2023 10:05:37 -0700
Message-ID: <xmqqh6o7nsf2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A3CF4D4-4CD7-11EE-BE77-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/repack.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

The reason being...?

> @@ -130,7 +132,7 @@ static void mark_packs_for_deletion_1(struct string_list *names,
>  		 * (if `-d` was given).
>  		 */
>  		if (!string_list_has_string(names, sha1))
> -			item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
> +			item->util = (void*)1;

Presumably the literal "1" is promoted to an appropriate type
(uintptr_t) here?


    We originally planned to use the .util member to store a bitset
    to represent various attributes for each pack, and defined
    DELETE_PACK as one of the possible bits, but over the N years of
    its existence, we never found the need for the second bit.

or something?

It is not a bad idea to demote .util from a set of bits to just a
"is it NULL?" boolean, but updating the above to something like

	#define DELETE_PACK ((void*)(uintptr_t)1)
	item->util = DELETE_PACK;

may still reap the same simplification benefit without introducing
the "what is that _one_ about?  can it be _two_ without changing the
meaning or what?" puzzlement.

Other than that, everything else in the series looked quite
straight-forward and sensible.

Thanks.


