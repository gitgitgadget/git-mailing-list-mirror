Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743A8C4320A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE3160F9C
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhHCXr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 19:47:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52446 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhHCXr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 19:47:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65B371489FE;
        Tue,  3 Aug 2021 19:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X+EAZAKBxQV4PKiAkvckrLFwzAPu5JKuQnjCx7
        65pVY=; b=RwYTpVY3lIjvM9pr703ASt/fALVBurpNXcqQ/aStowAnNpSsyVYeMO
        B2Q0jQKvXF9QjSW7Lht4QV17Y7BBsqEkApQ8YbgZEUqZf9E1MuWxkr/xSG9n1CCA
        AlAg2mv4KHjzY1Ja3aat/dA5Os/doQLUuU0r7kb10rBg2DHOF1fO8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E2D61489FD;
        Tue,  3 Aug 2021 19:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A5A331489FC;
        Tue,  3 Aug 2021 19:47:12 -0400 (EDT)
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
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 6/9] ssh signing: verify signatures using ssh-keygen
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <dc092c7979618d252f7a5a0a5bbe497d8011fd5b.1627998358.git.gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 16:47:10 -0700
In-Reply-To: <dc092c7979618d252f7a5a0a5bbe497d8011fd5b.1627998358.git.gitgitgadget@gmail.com>
        (Fabian Stelzer via GitGitGadget's message of "Tue, 03 Aug 2021
        13:45:55 +0000")
Message-ID: <xmqqzgtyrszl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FEF52D4-F4B5-11EB-9F82-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 2d1f97e1ca7..05dc8e160f8 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -131,6 +131,10 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  {
>  	int status = parse_hide_refs_config(var, value, "receive");
>  
> +	if (status)
> +		return status;
> +
> +	status = git_gpg_config(var, value, NULL);
>  	if (status)
>  		return status;

Hmph, it feels a bit odd for a misconfigured "transfer.hiderefs" to
prevent GPG related configuration from getting read, but is this
because a failure from receive_pack_config() will immediately kill
the process without doing any harm to the system?  If so, the code
is good as written.

