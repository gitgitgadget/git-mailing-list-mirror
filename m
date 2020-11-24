Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42130C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11A420715
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Isy33O5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbgKXWIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 17:08:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63584 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbgKXWIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 17:08:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E39BF2F54;
        Tue, 24 Nov 2020 17:08:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zZP6a6/zdQAH
        yOMY3VWzmrx4df8=; b=Isy33O5ub2PE424felLrwR9ARxCIbNChDnnRa+drwFcI
        w3uasLAYHjFhSMPhqmaV7YoWbSKVc7D2xnJN/f1QLuJfmawJ3muE6nrs733sCadC
        9sedTIFk4cw4OsvQUxQxfRMAi0Vl041sQEZDkB41RawdNe4l9Uegf7teTYNaukM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VBlh2n
        uqxkPKhTSy5vzk42cm2c2FZbuORTP9vwjHlEc0PS5+DqhHb+Kl2JdmZZCbOrojFt
        pGGEx33IXcIWXpK3tgm33KmbO/1L7y04xqritbC+AxlsP81YuilJxKtrIoVxnPxe
        v2GVb11mxk9S7wTScYMBLES7//HtJT/d7le0E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46C9EF2F52;
        Tue, 24 Nov 2020 17:08:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8501CF2F51;
        Tue, 24 Nov 2020 17:08:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Sim=C3=A3o?= Afonso <simao.afonso@powertools-tech.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] crendential-store: use timeout when locking file
References: <xmqq361v334r.fsf@gitster.c.googlers.com>
        <20201124193208.74fe4mticgkbxou3@safonso-t430>
Date:   Tue, 24 Nov 2020 14:08:01 -0800
In-Reply-To: <20201124193208.74fe4mticgkbxou3@safonso-t430> (=?utf-8?Q?=22?=
 =?utf-8?Q?Sim=C3=A3o?= Afonso"'s
        message of "Tue, 24 Nov 2020 19:32:08 +0000")
Message-ID: <xmqq4kleif26.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 85E02774-2EA1-11EB-A431-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sim=C3=A3o Afonso <simao.afonso@powertools-tech.com> writes:

> +credentialStore.fileTimeout::
> +	The length of time, in milliseconds, for git-credential-store to retr=
y
> +	when trying to lock the credentials file. Value 0 means not to retry =
at
> +	all; -1 means to try indefinitely. Default is 1000 (i.e., retry for
> +	1s).

I do not remember what was said in the first round of the review,
but I wonder if this is the best name for users.  I think it is good
enough, but do ".lockTimeout" or ".lockTimeoutMS" make it even
easier to grok, perhaps?

> diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> index 5331ab151..82284176e 100644
> --- a/builtin/credential-store.c
> +++ b/builtin/credential-store.c
> @@ -1,4 +1,5 @@
>  #include "builtin.h"
> +#include "config.h"
>  #include "lockfile.h"
>  #include "credential.h"
>  #include "string-list.h"
> @@ -58,8 +59,11 @@ static void print_line(struct strbuf *buf)
>  static void rewrite_credential_file(const char *fn, struct credential =
*c,
>  				    struct strbuf *extra)
>  {
> -	if (hold_lock_file_for_update(&credential_lock, fn, 0) < 0)
> -		die_errno("unable to get credential storage lock");
> +	int timeout_ms =3D 1000;
> +	git_config_get_int("credentialstore.filetimeout", &timeout_ms);

Please have a blank line before the first statement.

> +
> +	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeou=
t_ms) < 0)
> +		die_errno("unable to get credential storage lock in %d ms", timeout_=
ms);

Should this be die_errno()?  Looking at lock_file_timeout(), I am
not sure if the value of errno is valid in all codepaths that return
failure.

In any case, the message should be markd with _() for translation.

Other than that, it looks good.

Thanks.

>  	if (extra)
>  		print_line(extra);
>  	parse_credential_file(fn, c, NULL, print_line);

