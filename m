Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93716C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7298760FE8
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhE1EiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 00:38:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56986 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhE1EiG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 00:38:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60F72143960;
        Fri, 28 May 2021 00:36:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Mph0oBuA4bgEfnyRpD7M/FTzSQp0blP04MwSZ
        +KLzs=; b=hbxHzsoiII3PadmdwWSXMq+K/OZRftsprMdXxDZ29w7SMSjAHkc2kU
        44abjN7ywA4et2e/+lg0oQuSKCFRDtsa/KSZMljFoNun0mc8DW48UVfqmV9Jr/VI
        ytJJoh8l8NOi1FH5Lu6xfMBRfj5Lc12ewASXdKBBqCN9o6wVrrhyM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58FAA14395F;
        Fri, 28 May 2021 00:36:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E44714395E;
        Fri, 28 May 2021 00:36:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] ref-filter: add %(header) atom
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
        <aa6d73f3e526f416ee1e4e332e9ca3119efba0e8.1622126603.git.gitgitgadget@gmail.com>
Date:   Fri, 28 May 2021 13:36:27 +0900
In-Reply-To: <aa6d73f3e526f416ee1e4e332e9ca3119efba0e8.1622126603.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Thu, 27 May 2021 14:43:22
        +0000")
Message-ID: <xmqqpmxb79v8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45678BAC-BF6E-11EB-9CC1-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  		struct {
>  			enum { RAW_BARE, RAW_LENGTH } option;
>  		} raw_data;
> +		struct {
> +			enum { H_BARE, H_LENGTH } option;
> +		} header;

Raw does not use R_{BARE,LENGTH} and uses raw_data member.  Header
should follow suit unless there is a compelling reason not to, no?

		struct {
			enum { HEADER_BARE, HEADER_LENGTH } option;
		} header_data;

perhaps?

> @@ -1372,6 +1389,15 @@ static void grab_raw_data(struct atom_value *val, int deref, void *buf, unsigned
>  				    &bodypos, &bodylen, &nonsiglen,
>  				    &sigpos, &siglen);
>  
> +		if (starts_with(name, "header")) {
> +			size_t header_len = subpos - (const char *)buf - 1;

Hmph, is this correct?  I would expect that the "header" part of a
commit or a tag object excludes the blank line after the header
fields.  In other words, the "header" would be separated by a blank
line from the "body", and that separating blank line is not part of
"header" or "body".

Otherwise, if there is a user of %(header), it needs to be coded to
ignore the last blank line but has to diagnose it as an error if
there is a blank line before that.

> +			if (atom->u.header.option == H_BARE) {
> +				v->s = xmemdupz(buf, header_len);
> +			} else if (atom->u.header.option == H_LENGTH)
> +				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)header_len);
> +			continue;
> +		}
> +
>  		if (atom->u.contents.option == C_SUB)
>  			v->s = copy_subject(subpos, sublen);
>  		else if (atom->u.contents.option == C_SUB_SANITIZE) {
