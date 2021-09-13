Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F4FC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2AD860EE7
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbhIMALz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 20:11:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58402 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhIMALx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 20:11:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5779E1594F6;
        Sun, 12 Sep 2021 20:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L8l9/NAA6L6y
        mLRnjv73hoGS8nv1+mqifMSUjevblIE=; b=KPYnXL4eqBnVYxCAvkMgjpa1lQ0G
        3Rs71Pwbitm5xuufTCdSGIRLIcdjjYRnSfPp+2Q20fvMmWlkn/lKj7bSJBWHct7E
        Sva08XxenwCSPPw/QTUUIs7sO0H0EjK7btOyjMGlJD4a48yL7x175tPJpUYVVn5Z
        /ka6+iHtPc+EZ+M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 500901594F5;
        Sun, 12 Sep 2021 20:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A03721594F3;
        Sun, 12 Sep 2021 20:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] difftool: use "struct strvec" API in
 run_{dir,file}_diff()
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
        <patch-1.2-e7481eb0c0c-20210911T182009Z-avarab@gmail.com>
        <YT6BnnXeAWn8BycF@coredump.intra.peff.net>
Date:   Sun, 12 Sep 2021 17:10:34 -0700
In-Reply-To: <YT6BnnXeAWn8BycF@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 12 Sep 2021 18:39:26 -0400")
Message-ID: <xmqqlf41ibd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04B27640-1427-11EC-A792-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Sep 11, 2021 at 08:21:11PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> The underlying run_command() API can take either the "struct strvec
>> args", or a "const char **argv". Let's move to the former to use the
>> more "native" version of run_command() in both of these functions.
>
> It sounds like we're moving to use child.args (the strvec interface)
> instead of child.argv (the const char one). Which I support; I'd like t=
o
> eventually get rid of the argv interface entirely because it has
> memory-ownership semantics that are easy to get wrong.
>
> But this...
>
>> @@ -393,10 +393,8 @@ static int run_dir_diff(const char *extcmd, int s=
ymlinks, const char *prefix,
>>  	child.clean_on_exit =3D 1;
>>  	child.dir =3D prefix;
>>  	child.out =3D -1;
>> -	strvec_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
>> -		     NULL);
>> -	for (i =3D 0; i < argc; i++)
>> -		strvec_push(&child.args, argv[i]);
>> +	child.argv =3D args->v;
>> +
>
> ...is going in the opposite direction.
>
> I'd much rather see us continue to use child.args here, like:
>
>   strvec_pushv(&child.args, args->v);
>
> Though really I do think passing the strvec into run_dir_diff() is
> questionable in the first place. The caller depends on us to free the
> memory in the strvec for them, which is...subtle.
> ...
> +	strvec_push(&args, "diff");
> +	if (dir_diff)
> +		strvec_pushl(&args, "--raw", "--no-abbrev", "-z", NULL);
> +	strvec_pushv(&args, argv);
> +
>  	if (dir_diff)
> -		return run_dir_diff(extcmd, symlinks, prefix, argc, argv);
> -	return run_file_diff(prompt, prefix, argc, argv);
> +		return run_dir_diff(extcmd, symlinks, prefix, args.nr, args.v);
> +	return run_file_diff(prompt, prefix, args.nr, args.v);
>  }

Yes, I have to say that the end result of not having to rely on the
strvec type, in order to just call a main()- like function, makes it
much more pleasant read.

