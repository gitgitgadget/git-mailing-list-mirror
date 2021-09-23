Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32FAC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF95611B0
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbhIWSHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:07:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56985 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbhIWSHB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 14:07:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 221C9D6E72;
        Thu, 23 Sep 2021 14:05:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=HU7QrqD6sd3+F9RKi6rOmzSDC
        AqqBgPgrQTOfyq/7VY=; b=jYb7pDU0qTj+TmcEURraPb7s7L2wLjDuEQ4ZGWZcD
        FC+G00zT5c1ClVEVLOzga6o9WLq3v4izl79qQ23Hc7i0nx8Dir/OqQtXGb5Fgdxg
        a46U1yhyaC9Xm3Uy5gZPXKulDD8uaRUdKXRFdGCFDbc1dj/rmJnlytnugbDyfHX+
        GM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19066D6E70;
        Thu, 23 Sep 2021 14:05:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 699B1D6E6F;
        Thu, 23 Sep 2021 14:05:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 2/9] help: correct usage & behavior of "git help
 --guides"
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
        <patch-v3-2.9-e24ab59bc94-20210921T223223Z-avarab@gmail.com>
Date:   Thu, 23 Sep 2021 11:05:27 -0700
Message-ID: <xmqqwnn7yxp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D5852E42-1C98-11EC-9567-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The "We're done. Ignore any remaining args" comment added in
> 15f7d494380 (builtin/help.c: split "-a" processing into two,
> 2013-04-02) can now be removed, it's obvious that we're asserting the
> behavior with the check of "argc".

That is true for show_guides, but not for show_all, no?

> @@ -552,6 +553,11 @@ int cmd_help(int argc, const char **argv, const ch=
ar *prefix)
>  			builtin_help_usage, 0);
>  	parsed_help_format =3D help_format;
> =20
> +	/* Options that take no further arguments */
> +	if (argc && show_guides)
> +		usage_msg_opt(_("--guides cannot be combined with other options"),
> +			      builtin_help_usage, builtin_help_options);

This is a great addition. "git help -a foo" does not seem to fail,
but shouldn't it be given the same treatment before we can remove
the "We're done" comment?

>  	if (show_all) {
>  		git_config(git_help_config, NULL);
>  		if (verbose) {
> @@ -582,9 +588,6 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
> =20
>  	if (show_all || show_guides) {
>  		printf("%s\n", _(git_more_info_string));
> -		/*
> -		* We're done. Ignore any remaining args
> -		*/
>  		return 0;
>  	}
> =20
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index 5679e29c624..0525ec3ee58 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -34,6 +34,10 @@ test_expect_success 'basic help commands' '
>  	git help -a >/dev/null
>  '
> =20
> +test_expect_success 'invalid usage' '
> +	test_expect_code 129 git help -g add
> +'
> +
>  test_expect_success "works for commands and guides by default" '
>  	configure_help &&
>  	git help status &&
