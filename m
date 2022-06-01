Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE0DC43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 18:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiFAShr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiFAShq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 14:37:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06967891B
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 11:37:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7EC3F1868E7;
        Wed,  1 Jun 2022 14:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wHvf+nccli1b
        B+JROOAdq+qyHmG9Tsq3O2E0VBRYa+A=; b=Nh8uGEIVEt4SWEmiOb1DNmKOBlYt
        IGvxS/AitTvazxuseCa3jTvKwTtN7yndtRW1G209F00F68lAZ9VFtt4i4hgLyYBo
        2oqwGt5HIYS8xPoLlH5k2p/9+88eUO4xhYS1U6fR3tlbHLmurN2+NFb6xJ1mpFcE
        zxz/XUruNkgITLA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76C301868E6;
        Wed,  1 Jun 2022 14:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B3721868E5;
        Wed,  1 Jun 2022 14:37:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 1/6] common-main.o: move non-trace2 exit() behavior
 out of trace2.c
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
        <patch-v2-1.6-d446e4679d4-20220531T164806Z-avarab@gmail.com>
Date:   Wed, 01 Jun 2022 11:37:39 -0700
In-Reply-To: <patch-v2-1.6-d446e4679d4-20220531T164806Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 31 May
 2022 18:58:43
        +0200")
Message-ID: <xmqqv8tks00c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EB2B69DA-E1D9-11EC-8B3C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/common-main.c b/common-main.c
> index 29fb7452f8a..bb0100f6024 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -56,9 +56,24 @@ int main(int argc, const char **argv)
>  	result =3D cmd_main(argc, argv);
> =20
>  	/*
> -	 * We define exit() to call trace2_cmd_exit_fl() in
> -	 * git-compat-util.h. Whether we reach this or exit()
> +	 * We define exit() to call common_exit(), which will in turn
> +	 * call trace2_cmd_exit_fl(). Whether we reach this or exit()
>  	 * elsewhere we'll always run our trace2 exit handler.
>  	 */

I was expecting to see this comment to speak in a more generic terms
(i.e. "after the main processing is done, we clean up after
ourselves, either by exiting cmd_main and coming here or explicitly
calling exit()"), now we have introduced common_exit().

>  	exit(result);
>  }
> +
> +int common_exit(const char *file, int line, int code)
> +{
> +	/*
> +	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
> +	 * to e.g. turn -1 into 255. On a POSIX system this is
> +	 * redundant, see exit(3) and wait(2), but as it doesn't harm
> +	 * anything there we don't need to guard this with an "ifdef".
> +	 */
> +	code &=3D 0xff;

And I expected that the trace2 specific comment, if it is still
needed, would migrate here before this call.

Not huge enough to cause a reroll, but if there are other reasons to
see an updated version, it would be good to fix it while at it.

> +	trace2_cmd_exit_fl(file, line, code);
> +
> +	return code;
> +}

> +/**
> + * The exit() function is defined as common_exit() in
> + * git-compat-util.h.
> + *
> + * Intercepting the exit() allows us to hook in at-exit behavior, such
> + * emitting trace2 logging before calling the real exit().
> + */
> +int common_exit(const char *file, int line, int code);

Nicely explained.

Thanks.
