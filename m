Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD1FC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 19:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D35E61406
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 19:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhGAT5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 15:57:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63903 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGAT5m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 15:57:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1C21D5C80;
        Thu,  1 Jul 2021 15:55:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nVzMxIGKZYlJdSVbsmCo5PMC+FmIUJG9BZczyx
        mXQPw=; b=wfDMBYAemtR7CKNCKjePe9RW/U+2yVwH2TOZoI2ynkPfUs0c1flEfk
        yBFVHN9B7Q0lZ1e+XsTGmsOxQp40XzJ+0ASbatV64PhRzp0hVfT62wtum1pYeTUv
        9bq9WyjPF9RtFkhOWX0m0aRD+3522jg4nio1RuFoY23dI++3rl1l4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D098FD5C7F;
        Thu,  1 Jul 2021 15:55:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13B77D5C7E;
        Thu,  1 Jul 2021 15:55:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 14/15] [GSOC] cat-file: re-implement --textconv,
 --filters options
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
        <3aeb4d3d3ec9dc112a19a8b4adeaf213577b4028.1625155693.git.gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 12:55:08 -0700
In-Reply-To: <3aeb4d3d3ec9dc112a19a8b4adeaf213577b4028.1625155693.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Thu, 01 Jul 2021 16:08:12
        +0000")
Message-ID: <xmqqwnq9reqr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DCFADB8-DAA6-11EB-B01B-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "cache.h"
>  #include "parse-options.h"
> @@ -84,6 +85,9 @@ static struct expand_data {
>  	struct object_info info;
>  } oi, oi_deref;
>  
> +int use_filters;
> +int use_textconv;

With this commit in, "make sparse" dies like so:

    SP ref-filter.c
ref-filter.c:88:5: error: symbol 'use_filters' was not declared. Should it be static?
ref-filter.c:89:5: error: symbol 'use_textconv' was not declared. Should it be static?
