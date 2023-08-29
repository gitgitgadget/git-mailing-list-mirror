Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B37C71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 01:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjH2BQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 21:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjH2BQP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 21:16:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E03132
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 18:16:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A20CC32ADA;
        Mon, 28 Aug 2023 21:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Gxs2W/BgJfq85gSfJXtzLJ7RAqtj9kdU8jbyH
        ULhXg=; b=ZRH8IdJxGox5XT9rx9euyDLFKCtV4eGTITTSghBRekqUNMtNikeDbz
        cO4I52Ib580x3tLyMV/xTeq6Ugy/9vfO0a8reps2U/reY6yv9HWVtvf501haOr6K
        89+PR3jKErHN2V1YRExAgsBvLrrgIejKBlWcVWA7zwTS/HkDT+KqE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A7BA32AD9;
        Mon, 28 Aug 2023 21:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2DF7E32AD8;
        Mon, 28 Aug 2023 21:16:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/22] sequencer: use repository parameter in
 short_commit_name()
References: <20230828214604.GA3830831@coredump.intra.peff.net>
        <20230828214629.GA3831137@coredump.intra.peff.net>
        <xmqqsf82g65k.fsf@gitster.g>
        <20230829004801.GA3876652@coredump.intra.peff.net>
Date:   Mon, 28 Aug 2023 18:16:06 -0700
In-Reply-To: <20230829004801.GA3876652@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 28 Aug 2023 20:48:01 -0400")
Message-ID: <xmqqh6oify21.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A16DCB0E-4609-11EE-92ED-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> but that will no longer be true with the updated code.  I'd feel
>> safer if at the beginning of the function we create a local variable
>> "struct rev_info *repo" that is initialized to opts->revs->repo and
>> use it throughout the function instead of the_repository.
>
> I'm not sure how that makes it any safer, as it would mean using the
> suspect repo pointer in more places. Unless you are proposing to do:
>
>   struct repository *r = opts->revs->repo;
>   if (!r)
> 	r = the_repository; /* or BUG() ? */

Yup, the BUG() variant was exactly what I had in mind, but without
the assert, by using opts->revs->repo more consistently, we would
make sure nobody will call us with uninitialized opts->revs->repo
now or in the future.
