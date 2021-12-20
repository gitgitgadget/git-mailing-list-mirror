Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A83C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 21:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhLTVyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 16:54:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57274 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhLTVyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 16:54:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24C0717AA38;
        Mon, 20 Dec 2021 16:54:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=95SFTPknx1Lndcs7hYOmqUetIx9zYCPRbrHfR7
        W5JYM=; b=tbh2PtYXMWXxJATCrzlH8hUYSVpo4DQeOCx3IHa83wDGNdR/t6Jz1n
        MSaam5AO7yWt1OBMZIl5clK1l3hSZhYcFfVvrHOk/L1jXwmadJs/VKyGiWDVmu9M
        SvSJw2nuPAjTQ88Q7nZM7+PIJu/eD6MUMKSk0YK2iNMo8H2ad1JIU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CD5417AA37;
        Mon, 20 Dec 2021 16:54:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3759817AA36;
        Mon, 20 Dec 2021 16:54:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH 1/2] crypto sign: add crypto-sign alias flag
References: <20211220140928.1205586-1-fs@gigacodes.de>
        <20211220140928.1205586-2-fs@gigacodes.de>
Date:   Mon, 20 Dec 2021 13:54:37 -0800
In-Reply-To: <20211220140928.1205586-2-fs@gigacodes.de> (Fabian Stelzer's
        message of "Mon, 20 Dec 2021 15:09:27 +0100")
Message-ID: <xmqqr1a7t00y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DFB3EB0-61DF-11EC-9F53-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> +--crypto-sign[=<keyid>]::
> +--no-crypto-sign::
>  --gpg-sign[=<keyid>]::
>  --no-gpg-sign::
> -	GPG-sign commits. The `keyid` argument is optional and
> -	defaults to the committer identity; if specified, it must be
> -	stuck to the option without a space. `--no-gpg-sign` is useful to
> -	countermand both `commit.gpgSign` configuration variable, and
> -	earlier `--gpg-sign`.
> +	Cryptographically sign commits. The `keyid` argument is optional and
> +	its default depends on the configured `cryptoSign.format`; if specified,
> +	it must be stuck to the option without a space. `--no-crypto-sign` is
> +	useful to countermand both `commit.gpgSign` configuration variable, and
> +	earlier `--crypto-sign`.
> +	`--(no-)gpg-sign` is a compatibility alias and has no effect on which
> +	cryptographic format will be used. This is determined by the
> +	configuration variable cryptoSign.format (see linkgit:git-config[1]).

I'd make the last three lines into a separate paragraph and nudge
users toward the new spelling if I were doing this change, e.g.

	...
	earlier `--crypto-sign`.
+
The option was originally called `--[no-]gpg-sign` and is still
supported as a synonym, but it is encouraged to migrate to use
the `--crypto-sign` option.

Not the problem with this patch, but can the format be inferred from
<keyid>?

If so, `--crypt-sign=<keyid of format X>` can choose the format X
and specify what exact key to use at the same time without the
cryptosign.format configuration variable.  But if not, the interface
leaves us in an awkward place by letting different keys easily
specified from the command line while making it impossible to
switch between GPG and SSH from the command line.

If --gpg-sign is not a mere synonym, but also implies GPG is
preferred when cryptoSign.format is not specified, that is a
different story, of course.  That makes it unnecessary to deprecate
`--gpg-sign` and in addition we need to add `--ssh-sign` option that
works similarly, which may not scale well but I do not expect we'd
add many more next to GPG and SSH, hopefully?  I dunno.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 883c16256c..2c789ff6f9 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1639,8 +1639,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
>  		OPT_CLEANUP(&cleanup_arg),
>  		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
> -		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
> +		{ OPTION_STRING, 'S', "crypto-sign", &sign_commit, N_("key-id"),
> +		  N_("cryptographically sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +		{ OPTION_STRING, 0, "gpg-sign", &sign_commit, N_("key-id"),
>  		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },

Leaving this explained as "GPG sign commit" contradicts "it is a
mere alias that does not even imply GPG is preferred when no
preference is given by the cryptoSign.format variable".

> +

Unwanted blank line before the "this is the last line of these
options" marker?

>  		/* end commit message options */
>  
>  		OPT_GROUP(N_("Commit contents options")),
