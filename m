Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF35AC07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00D56113E
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbhGSWao (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:30:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59067 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441936AbhGSW1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 18:27:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AD5DE09F7;
        Mon, 19 Jul 2021 19:07:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dOWGJF0izLzkXCemxgh9icYocUWCTGyadpw1mV
        oD5a0=; b=YjuMMGqDlZW4XR5jIorzagvXbh0eO8zn0eWdysi+b/i+FNcHcsyPQL
        T0Z6GUmJNzaupDHX+Irovk2FYvYsXQnYEpmcNCYoN8nvnKZr7RyQF/WTFa9VHdVh
        6bQHVJmrWsVpzr2v+tW14xR02PdeW+bp7lZreNqhCNAuHk5MYfS24=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00AA8E09F5;
        Mon, 19 Jul 2021 19:07:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F2A2E09F3;
        Mon, 19 Jul 2021 19:07:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: Re: [PATCH v4 1/9] ssh signing: preliminary refactoring and clean-up
References: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
        <b4b0e2bac1c7f8680877f3eae176b2335b607975.1626701596.git.gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 16:07:45 -0700
In-Reply-To: <b4b0e2bac1c7f8680877f3eae176b2335b607975.1626701596.git.gitgitgadget@gmail.com>
        (Fabian Stelzer via GitGitGadget's message of "Mon, 19 Jul 2021
        13:33:08 +0000")
Message-ID: <xmqqfsw9kim6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 216653AE-E8E6-11EB-909D-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 127aecfc2b0..31cf4ba3938 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -15,6 +15,12 @@ struct gpg_format {
>  	const char *program;
>  	const char **verify_args;
>  	const char **sigs;
> +	int (*verify_signed_buffer)(struct signature_check *sigc,
> +				    struct gpg_format *fmt, const char *payload,
> +				    size_t payload_size, const char *signature,
> +				    size_t signature_size);
> +	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
> +			   const char *signing_key);
>  };

Thanks for a pleasant read.  Looking good.
