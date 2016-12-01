Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38B31FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 18:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbcLAS1l (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 13:27:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59738 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751676AbcLAS1j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 13:27:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB1FC51A73;
        Thu,  1 Dec 2016 13:27:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+oMy9UabpiZZ
        eL/M46jwLLnDBgg=; b=eK/8HYSe6SuKfZYPyQP4gKr0yZEONozVkv1xoxddDRyJ
        lLrpyIjM+Tm/ZZpfwL42382zLoAJBNdJZwJV2xEFN6SUQgcIYraDGd9nq45M2VaQ
        e5vYgP641IjHqF6WtmjtAh1xEbXfO1E+8kEmJo8+rGl7jPvFpC7Uw+OaQuQOf7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LEO/8E
        8YqnENCJDHz1uD1lmW2ygd+1l55WwowjfKIBykT/s5QH2NVIQTR8XAzdHH5G7db5
        edGXPtf/gy1Y+wWTU0ND0bzQsdmWjmpU3dVIpRp9ENLdsncvNT/kYHoZPoQw/k39
        f/5rndWv2MsRu96K/sukninSY2tmfaEyUEp9U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D423E51A71;
        Thu,  1 Dec 2016 13:27:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5877451A70;
        Thu,  1 Dec 2016 13:27:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, eevee.reply@veekun.com
Subject: Re: [PATCH v2 1/1] convert: git cherry-pick -Xrenormalize did not work
References: <6a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com>
        <20161130170232.19685-1-tboegi@web.de>
Date:   Thu, 01 Dec 2016 10:27:37 -0800
In-Reply-To: <20161130170232.19685-1-tboegi@web.de> (tboegi@web.de's message
        of "Wed, 30 Nov 2016 18:02:32 +0100")
Message-ID: <xmqq1sxrbj3a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D66CF70E-B7F3-11E6-AB19-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Working with a repo that used to be all CRLF. At some point it
> was changed to all LF, with `text=3Dauto` in .gitattributes.
> Trying to cherry-pick a commit from before the switchover fails:
>
> $ git cherry-pick -Xrenormalize <commit>
>     fatal: CRLF would be replaced by LF in [path]
>
> Commit 65237284 "unify the "auto" handling of CRLF" introduced
> a regression:
>
> Whenever crlf_action is CRLF_TEXT_XXX and not CRLF_AUTO_XXX,
> SAFE_CRLF_RENORMALIZE was feed into check_safe_crlf().
> This is wrong because here everything else than SAFE_CRLF_WARN is
> treated as SAFE_CRLF_FAIL.
>
> Call check_safe_crlf() only if checksafe is SAFE_CRLF_WARN or SAFE_CRLF=
_FAIL.
>
> Reported-by: Eevee (Lexy Munroe) <eevee@veekun.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

I think the description and the code match with each other much
better and the resulting code explains what is going on more
clearly.  Thanks---will queue.

>  convert.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index be91358..f8e4dfe 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -281,13 +281,13 @@ static int crlf_to_git(const char *path, const ch=
ar *src, size_t len,
>  		/*
>  		 * If the file in the index has any CR in it, do not convert.
>  		 * This is the new safer autocrlf handling.
> +		   - unless we want to renormalize in a merge or cherry-pick
>  		 */
> -		if (checksafe =3D=3D SAFE_CRLF_RENORMALIZE)
> -			checksafe =3D SAFE_CRLF_FALSE;
> -		else if (has_cr_in_index(path))
> +		if ((checksafe !=3D SAFE_CRLF_RENORMALIZE) && has_cr_in_index(path))
>  			convert_crlf_into_lf =3D 0;
>  	}
> -	if (checksafe && len) {
> +	if ((checksafe =3D=3D SAFE_CRLF_WARN ||
> +	    (checksafe =3D=3D SAFE_CRLF_FAIL)) && len) {
>  		struct text_stat new_stats;
>  		memcpy(&new_stats, &stats, sizeof(new_stats));
>  		/* simulate "git add" */
