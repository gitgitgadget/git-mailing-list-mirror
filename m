Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3807AC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDCA61370
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbhGNUXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:23:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51797 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbhGNUXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:23:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 087A7D183E;
        Wed, 14 Jul 2021 16:20:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eDU7Y/8E7yFkKCPoBPL40metPHZl+DnMQJ1XQl
        qZhHg=; b=P1YfqVAsa4KIbFeORcVDxT870ooSnOccocXA+vqRkWzZXxxeJqyhKt
        2pEoCWJ2yhDguOWhmS45vEaNiH8sheZDFy18Yl2v4o7MSStQyYacCP8peQZj5XAy
        t939plox0znFbMfhhkzdwfyk1w8bJ/d1NwDgvEdRRKiAL3CkRsy2Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F357BD183D;
        Wed, 14 Jul 2021 16:20:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B4D4D183B;
        Wed, 14 Jul 2021 16:20:48 -0400 (EDT)
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
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 3/9] ssh signing: retrieve a default key from ssh-agent
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <b84b2812470ea45a85d624ec339f35bb0107493d.1626264613.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:20:47 -0700
In-Reply-To: <b84b2812470ea45a85d624ec339f35bb0107493d.1626264613.git.gitgitgadget@gmail.com>
        (Fabian Stelzer via GitGitGadget's message of "Wed, 14 Jul 2021
        12:10:07 +0000")
Message-ID: <xmqqr1g0ve8w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA217174-E4E0-11EB-B159-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fabian Stelzer <fs@gigacodes.de>
>
> calls ssh-add -L and uses the first key

Documentation/SubmittingPatches::[[describe-changes]].

> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  gpg-interface.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 3c9a48c8e7e..c956ed87475 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -467,6 +467,23 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  	return 0;
>  }
>  
> +/* Returns the first public key from an ssh-agent to use for signing */
> +static char *get_default_ssh_signing_key(void) {

Style.  Open and close braces around a function sit on their own
lines by themselves.

> +	struct child_process ssh_add = CHILD_PROCESS_INIT;
> +	int ret = -1;
> +	struct strbuf key_stdout = STRBUF_INIT;
> +	struct strbuf **keys;

Whose releasing the resource held by "keys" when we return?

> +	strvec_pushl(&ssh_add.args, "ssh-add", "-L", NULL);
> +	ret = pipe_command(&ssh_add, NULL, 0, &key_stdout, 0, NULL, 0);

I often load about half a dozen keys to my ssh-agent so "ssh-add -L"
will give me multi-line output.  I know you wrote "the first public
key" above, but that does not mean users who needs to have multiple
keys can be limited to use only the first key for signing.  There
should be a way to say "I may have many keys for other reasons, but
for signing I want to use this key, not the other ones".

> +	if (!ret) {
> +		keys = strbuf_split_max(&key_stdout, '\n', 2);

Let's not use strbuf_split_*() that is a horribly wrong interface.
You do not want a set of elastic buffer after splitting.  You only
are peeking the first line, no?  You are leaking keys[] array and
probably keys[1], too.

	eol = strchrnul(key_stdout.buf, '\n');
	strbuf_setlen(&key_stdout, eol - key_stdout.buf);

or something along that line, perhaps?

> +		if (keys[0])
> +			return strbuf_detach(keys[0], NULL);
> +	}
> +
> +	return "";
> +}
>  const char *get_signing_key(void)

Missing blank line after the function body.

>  {
>  	if (configured_signing_key)
