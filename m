Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAD3C4708F
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591FC613DC
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCCMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:12:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61148 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 22:12:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8EF3C469B;
        Wed,  2 Jun 2021 22:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NQR+XMAkARh6JEzRqPABbQKvpmeR2LuqTFo+Xw
        C4Zgk=; b=jXat5FabS6EO7PqBYW8y3pBi+YVtT2rpp/BWYJIYIKk2PWjaB+C8to
        I9CrYH8cEkNY5A2JP1bxbSjjHn2xWWgXvRZVkAHJVB824MyvEn06fsS4IwohnfmL
        vooNev2wX9p+AcxsGTw8j5kuZ1Z56PaMIZ54YneCHA0Kh+vKi69l0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B090DC469A;
        Wed,  2 Jun 2021 22:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C15DC4699;
        Wed,  2 Jun 2021 22:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add obj-type check in grab contents
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
        <97955705c22e00a718a8de7555ab7e0e401e792e.1622558243.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Jun 2021 11:10:31 +0900
In-Reply-To: <97955705c22e00a718a8de7555ab7e0e401e792e.1622558243.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Tue, 01 Jun 2021 14:37:22
        +0000")
Message-ID: <xmqq1r9j7l60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E010FA3E-C410-11EB-A5CB-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  /* See grab_values */
> -static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
> +static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf,
> +				   struct object *obj)

Neither this step or the next change needs anything but type member
of the 'obj' (and 'buf' is coming from oi.content of the result of
asking about that same 'obj').

I wonder if we should do one of the following:

 (1) stop passing "void *buf" and instead "struct expand_data
     *data", and use "data->content" to access "buf", which would
     allow you to access "data->type" to perform the added check.

 (2) instead of adding "struct obj *obj" to the parameters, just add
     "enum object_type type", as that is the only thing you need.

Obviously (2) is with lessor impact, but if it can be done safely
without breaking the code [*], (1) would probably be a much more
preferrable direction to go in the longer term.

    Side note [*].  A caller is allowed to choose to feed "buf" that
    is different from "oi.content" (perhaps buf may sometimes want
    to be a utf-8 recoded version of oi.content for certain types of
    objects) with the current system, but if we pass expand_data
    throughout the callchain, such a caller is broken, for example.

