Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EAFC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 21:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5701161039
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 21:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhG1V3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 17:29:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59207 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhG1V3G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 17:29:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E868EE481D;
        Wed, 28 Jul 2021 17:29:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=70+pUJwDnBZan1JblmJu+vFbgTOm3LiUMJEHoA
        j+2Wc=; b=qgWF2/ASj3Fcc9C+9xJVqJLGS/oPOUUCg71EEDLpVb9dezILmA+PBg
        031s1oQR3AjlxmYK3Kkz2WKIbivRcNCKCPjYMAmoezu7cH9GUrlzypR/tlOQAQqs
        4BymW+3QTUJOPv38HfJwyTrGu7CGFdmdLCzA45qJbza6lBX0kCV14=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8153E481C;
        Wed, 28 Jul 2021 17:29:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23E38E481B;
        Wed, 28 Jul 2021 17:29:02 -0400 (EDT)
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
Subject: Re: [PATCH v6 3/9] ssh signing: retrieve a default key from ssh-agent
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <071e6173d8e418349d94fea97624e8cee9f1dde5.1627501009.git.gitgitgadget@gmail.com>
Date:   Wed, 28 Jul 2021 14:29:01 -0700
In-Reply-To: <071e6173d8e418349d94fea97624e8cee9f1dde5.1627501009.git.gitgitgadget@gmail.com>
        (Fabian Stelzer via GitGitGadget's message of "Wed, 28 Jul 2021
        19:36:43 +0000")
Message-ID: <xmqqim0u86w2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3E9E062-EFEA-11EB-A654-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fabian Stelzer <fs@gigacodes.de>
>
> if user.signingkey is not set and a ssh signature is requested we call
> ssh-add -L and use the first key we get
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  gpg-interface.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)

I would have expected that this also would become a method call into
*use_format object (instead of dispatching on use_format->name), but
let's not go overboard.  I think this is good enough for now.


> diff --git a/gpg-interface.c b/gpg-interface.c
> index c131977b347..3afacb48900 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -470,11 +470,35 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  	return 0;
>  }
>  
> +/* Returns the first public key from an ssh-agent to use for signing */
> +static char *get_default_ssh_signing_key(void)
> +{
> +	struct child_process ssh_add = CHILD_PROCESS_INIT;
> +	int ret = -1;
> +	struct strbuf key_stdout = STRBUF_INIT;
> +	struct strbuf **keys;
> +
> +	strvec_pushl(&ssh_add.args, "ssh-add", "-L", NULL);
> +	ret = pipe_command(&ssh_add, NULL, 0, &key_stdout, 0, NULL, 0);
> +	if (!ret) {
> +		keys = strbuf_split_max(&key_stdout, '\n', 2);
> +		if (keys[0])
> +			return strbuf_detach(keys[0], NULL);
> +	}
> +
> +	strbuf_release(&key_stdout);
> +	return "";
> +}
> +
>  const char *get_signing_key(void)
>  {
>  	if (configured_signing_key)
>  		return configured_signing_key;
> -	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
> +	if (!strcmp(use_format->name, "ssh")) {
> +		return get_default_ssh_signing_key();
> +	} else {
> +		return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
> +	}
>  }
>  
>  int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
