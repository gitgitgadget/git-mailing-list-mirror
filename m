Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77389C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 22:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiIVW42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIVW4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 18:56:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB64F8C21
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 15:56:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B35F614BBC4;
        Thu, 22 Sep 2022 18:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/DZaQXrgKb7tQ0nmcyS5414L5EOm9ao8K2LTEx
        otqzQ=; b=N0FOTkIh1t5SWurwumW3hVux4FMM0av4sM4xCMS+DEs8kxGkWYG2sv
        H1cIdVZ83mMzHZ1ZZUzsy2nQUzBWsTztlc/wk1h7WV/zygk54+EYarF6a954bp28
        to/QOsQovY6ywhnxi1FD+5xZiy1da/4Dhghedu4thhBh6JhcmryVU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB98814BBC2;
        Thu, 22 Sep 2022 18:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F44114BBC1;
        Thu, 22 Sep 2022 18:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: t9210-scalar.sh fails with SANITIZE=undefined
References: <YywzNTzd72tox8Z+@coredump.intra.peff.net>
        <ff921c34-139a-9e2b-ca1f-d6f9f7213d1b@github.com>
        <Yyyzk3FVjmms7dkO@coredump.intra.peff.net>
        <50c57a60-8346-6952-93d9-432a70ef74c5@github.com>
        <YyzhR8CGu2CNQMfJ@coredump.intra.peff.net>
Date:   Thu, 22 Sep 2022 15:56:21 -0700
In-Reply-To: <YyzhR8CGu2CNQMfJ@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 22 Sep 2022 18:27:19 -0400")
Message-ID: <xmqq7d1vxbl6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C71889BC-3AC9-11ED-8FAC-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I also wondered why other versions do not have a similar problem. After
> all, cache entries contain pathnames which are going to be of varying
> lengths. But this seems telling:
>
>   $ git grep -m1 -B1 -A2 align_padding_size
>   read-cache.c-/* These are only used for v3 or lower */
>   read-cache.c:#define align_padding_size(size, len) ((size + (len) + 8) & ~7) - (size + len)
>   read-cache.c-#define align_flex_name(STRUCT,len) ((offsetof(struct STRUCT,data) + (len) + 8) & ~7)
>   read-cache.c-#define ondisk_cache_entry_size(len) align_flex_name(ondisk_cache_entry,len)
>
> So we actually pad the entries in earlier versions to align them, but
> don't in v4. I'm not sure if that was a conscious choice to save space,
> or an unintended consequence (though it is mentioned in the docs, I
> think that came after the code).

I think we didn't even have on-disk vs in-core distinction in the
early index code.  The active_cache[] array used to be an array of
pointers into the (read-only) mmapped memory, peeking into on-disk
index we just "read".  Back when v4 was introduced, that arrangement
was (thought to be) long gone---we iterated over the mmapped memory
and used create_from_disk() to munge the on-disk representation into
a machine native form.  At that point, there was no point in having
the padding---we are supposed to be using get_beXX() and stuff
without having to worry about alignment requirements.

