Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047E0C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 20:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95C761413
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 20:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhGAUNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 16:13:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56231 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbhGAUNw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 16:13:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6686FD5F04;
        Thu,  1 Jul 2021 16:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Cvq4YXGuOjPZ5ptzz/4Gx5mjuF/BALFVuM3KJ
        UOd1c=; b=UGT6RyTbQyv8rKCdIsHnOqYi/4T02/ZgdbfpZHR6kvLLp/yeOdJoFc
        aLWufOtezHSgdAe2V9FrtwYgYCE158dSXJRCAzAqawgmtgsUtxd+CzZkFyXAjysb
        UBqhU2w9RMl65ylPcJcYR+Q1U5zF+ooxUObhlwifXKE0+5xWLBDnE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E9C1D5F03;
        Thu,  1 Jul 2021 16:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA3F5D5F02;
        Thu,  1 Jul 2021 16:11:20 -0400 (EDT)
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
Date:   Thu, 01 Jul 2021 13:11:20 -0700
In-Reply-To: <3aeb4d3d3ec9dc112a19a8b4adeaf213577b4028.1625155693.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Thu, 01 Jul 2021 16:08:12
        +0000")
Message-ID: <xmqqo8blrdzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8070549A-DAA8-11EB-85B7-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> After cat-file reuses the ref-filter logic, we re-implement the
> functions of --textconv and --filters options.
>
> Add members `use_textconv` and `use_filters` in struct `ref_format`,
> and use global variables `use_filters` and `use_textconv` in
> `ref-filter.c`, so that we can filter the content of the object
> in get_object().

These global variables are problematic.  The places that check them
are quite isolated, and it makes me wonder why we cannot pass a
format instance through the callchain down to get_object().

 
