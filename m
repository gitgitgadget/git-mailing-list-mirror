Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBE1C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C967560F6E
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhGZSfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 14:35:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57009 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhGZSfB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 14:35:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04C51DD616;
        Mon, 26 Jul 2021 15:15:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E8xgf7cJXKJOjNV3LDYQSlIhq7FHICBDVCctm0
        NNflA=; b=AZozmglDzHxRAzBbdBtZmjwkp9oxWoxan4NdP+zSwByzxcKjegwqUM
        EwN6vvk9TyozIUmUdiF/tnRDmmMsIooFXE4WDPoIjGUmxaotPPUhIfaIKeo4bGSs
        F+j2eiPVNdbgnsF91bgnZ/T5nSSFD7/pqnKwV3dXCSXimBGN0wcV4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE447DD614;
        Mon, 26 Jul 2021 15:15:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67747DD613;
        Mon, 26 Jul 2021 15:15:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        Jacob Keller <jacob.keller@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v4 1/5] [GSOC] ref-filter: add obj-type check in grab
 contents
References: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
        <pull.1000.v4.git.1627270010.gitgitgadget@gmail.com>
        <0e294ff1626ef2b7992e84e8d960f5058bd39bdc.1627270010.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 12:15:27 -0700
In-Reply-To: <0e294ff1626ef2b7992e84e8d960f5058bd39bdc.1627270010.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Mon, 26 Jul 2021 03:26:46
        +0000")
Message-ID: <xmqqv94wj38w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6898D64-EE45-11EB-B4BB-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Only tag and commit objects use `grab_sub_body_contents()` to grab
> object contents in the current codebase.  We want to teach the
> function to also handle blobs and trees to get their raw data,
> without parsing a blob (whose contents looks like a commit or a tag)
> incorrectly as a commit or a tag. So it's needed to pass a
> `struct expand_data *data` instread of only `void *buf` to both
> `grab_sub_body_contents()` and `grab_values()` to be able to check
> the object type.
>
> Skip the block of code that is specific to handling commits and tags
> early when the given object is of a wrong type to help later
> addition to handle other types of objects in this function.
>
> Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>

It is not a huge deal, but are these trailers given in a sensible
order?  The order of event happened were that help and mentoring
were given, your finished version of the patch came after that to be
signed off by you, and then a reviewer gave you a reviewed-by, no?
