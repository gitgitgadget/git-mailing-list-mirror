Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB9C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiGUQbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiGUQbv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:31:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FA789A45
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:31:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B61D21A9895;
        Thu, 21 Jul 2022 12:31:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/M2KP0naNViyy1K3p+X819ICgbrU4QoHOaRwl9
        2Lh+U=; b=mR/3cbdnvsIEm1R0cyJmAyJjTjjaVW+zArtw9CVw+PXPccSDhQ5fBl
        kk4m7nPvoVOIB4iUNumKdtjgML/0457gJ8YD5Q9gNUl+j43+g9qQyKPfdYi9UUI/
        KjAN1PlOiX2CGdsCS73J9l66x3MDWncr1UMMPRkE8I0xGhJdMzbdY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB2C01A9894;
        Thu, 21 Jul 2022 12:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85C871A9890;
        Thu, 21 Jul 2022 12:31:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 6/7] merge: ensure we can actually restore pre-merge
 state
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <887967c1f3fd6f03cf1d0bb3c19ed16819541092.1658391391.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 09:31:44 -0700
In-Reply-To: <887967c1f3fd6f03cf1d0bb3c19ed16819541092.1658391391.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 21 Jul 2022
        08:16:30 +0000")
Message-ID: <xmqq35eul95b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C5B3CE4-0912-11ED-86B8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/merge.c b/builtin/merge.c
> index f807bf335bd..11bb4bab0a1 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1686,12 +1686,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	 * tree in the index -- this means that the index must be in
>  	 * sync with the head commit.  The strategies are responsible
>  	 * to ensure this.
> +	 *
> +	 * Stash away the local changes so that we can try more than one
> +	 * and/or recover from merge strategies bailing while leaving the
> +	 * index and working tree polluted.
>  	 */

Makes sense.  We may want to special-case strategies that are known
not to have the buggy "leave contaminated tree when bailing out"
behaviour to avoid waste.  I expect that more than 99.99% of the
time people are feeding a single other commit to ort or recursive,
and if these are known to be safe, a lot will be saved by not saving
"just in case".  But that can be left for later, after the series
solidifies.

Thanks.

> -	if (use_strategies_nr == 1 ||
> -	    /*
> -	     * Stash away the local changes so that we can try more than one.
> -	     */
> -	    save_state(&stash))
> +	if (save_state(&stash))
>  		oidclr(&stash);
>  
>  	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
