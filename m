Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1FFC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 07:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC71B61055
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 07:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhFPHvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 03:51:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64790 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhFPHvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 03:51:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4709214585C;
        Wed, 16 Jun 2021 03:49:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QW8O1K3FWB/iUgivzN5LOg4nRueJgJQEgQYAyq
        i7q3E=; b=kQf7iJGPDMHCeLqWIgCjGsv6JtOcVPJZnyrsz1NNLgCd1B+ggW5/QX
        lOuKaXaz9vaKnnjwf6hfLrtBOocrOqzhGPdduIEgbSMpBix3xoZsfep2d3dMHcpB
        GaB79FzB14e3Y/G+NYQhRuSH7fJz2eDxJ4GezWlBjOLM81jvq/rzY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FEA914585B;
        Wed, 16 Jun 2021 03:49:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8BB314585A;
        Wed, 16 Jun 2021 03:49:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 6/9] [GSOC] ref-filter: introduce
 free_array_item_internal() function
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
        <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
        <d2f2563eb76ac2e2c88a76edfac7353284407ad2.1623763747.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Jun 2021 16:49:37 +0900
In-Reply-To: <d2f2563eb76ac2e2c88a76edfac7353284407ad2.1623763747.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Tue, 15 Jun 2021 13:29:02
        +0000")
Message-ID: <xmqqv96ep7u6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66E616A0-CE77-11EB-B28A-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Introduce free_array_item_internal() for freeing ref_array_item value.
> It will be called internally by free_array_item(), and it will help
> `cat-file --batch` free ref_array_item's memory later.

As a file local static function, the horrible name free_array_item()
was tolerable.  But before exposing a name like that to the outside
world, think twice if that is specific enough, and it is not.  There
are 47 different kinds of "array"s we use in the system, but this
new helper function only works with ref_array_item and not on items
in any other kinds of arrays.

> -/*  Free memory allocated for a ref_array_item */
> -static void free_array_item(struct ref_array_item *item)
> +void free_array_item_internal(struct ref_array_item *item)
>  {

And "internal" is a horrible name to have as an external name.  You
probably can come up with a more appropriate name when you imagine
yourself explaining to somebody who is relatively new to this part
of the codebase what the difference between free_array_item() and
this new helper is, where the difference comes from, why the symref
member (and no other member) is so special, etc.

I _think_ what is special is not the .symref but is the .value
field, IOW, you are trying to come up with an interface to free the
value part of ref_array_item without touching other things.  But it
is not helpful at all to readers if you do not explain why you want
to do so.  Why is the .value member so special?  The ability to
clear only the .value member without touching other members is useful
because ...?

In any case, assuming that you'd establish why the .value member is
so special to deserve an externally callable function, when external
callers do not have to be able to free the item as a whole (i.e.
free_array_item() is still file-scope static), in the proposed log
message in an updated patch, I would imagine that 

    free_ref_array_item_value()

would be a more suitable name than the _internal thing.  When it
happens, you might want to rename the static one to
free_ref_array_item() to match, even if it does not have external
callers.
