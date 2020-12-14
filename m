Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E6FC2BB48
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E3822512
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgLNXVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:21:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59656 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgLNXVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 18:21:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4A9F11B6B2;
        Mon, 14 Dec 2020 18:20:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=74Z8IIEcUivfJNCHDaVk7aIFedg=; b=Z5NloL
        ho4StyUzd8GcDho7gBkTfzj8N+TeBOIt80eWDESWWsKbHufgK81ZSXTDt7iKbey/
        hZMFT9yUlwIrQoIhCgRgUj66dCKaLqfDN6vHsDpEmqb1MLhHe2BWwvcP23DyWd8E
        WVceGkS/JlByKWQ5mJZIvv+WdScuobkbnaEIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PtN8uftAMm5xQ4t6J9tZjRLFT9sIx8Hy
        GaoFQW+o187xtdZrs7aOigbnxXMnoKiBIyxNtP4fL6UvBCGVjXOHONKgkqPD/ITT
        n+sKJCswu+y2VasLU1dY7RkAlz2YRks8/LY59VtI7KnY/vblZEaxTLMEHOIQGnBd
        E1vNU8KaJfE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ACF7211B6B1;
        Mon, 14 Dec 2020 18:20:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F14AF11B6B0;
        Mon, 14 Dec 2020 18:20:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 5/5] pull: display default warning only when non-ff
References: <20201214202647.3340193-1-gitster@pobox.com>
        <20201214202647.3340193-6-gitster@pobox.com>
        <5fd7d82a9b6ab_d44af208bb@natae.notmuch>
Date:   Mon, 14 Dec 2020 15:20:39 -0800
In-Reply-To: <5fd7d82a9b6ab_d44af208bb@natae.notmuch> (Felipe Contreras's
        message of "Mon, 14 Dec 2020 15:24:58 -0600")
Message-ID: <xmqqmtyg9dq0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB602636-3E62-11EB-89E7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> @@ -1044,7 +1045,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>>  	if (opt_rebase && merge_heads.nr > 1)
>>  		die(_("Cannot rebase onto multiple branches."));
>>  
>> -	if (rebase_unspecified && !opt_ff) {
>> +	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
>> +
>> +	if (rebase_unspecified && !opt_ff && !can_ff) {
>>  		if (opt_verbosity >= 0)
>>  			show_advice_pull_non_ff();
>>  	}
>
> I strongly predict the conditionals will end up looking similar to:
>
>   if (!can_ff) {
>           if (rebase_unspecified && !opt_ff && opt_verbosity >= 0)
>                   show_advice_pull_non_ff();
>   }
>
> But OK.

I may have failed to mention this in the cover letter, but I think
the placement of opt_ff in this part of the logic needs to be
rethought, so I strongly predict that this part will have to further
change ;-)
