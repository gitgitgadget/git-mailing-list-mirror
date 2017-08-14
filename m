Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B374A20899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbdHNRhr (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:37:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50470 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750910AbdHNRhq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 13:37:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1486BAD5AA;
        Mon, 14 Aug 2017 13:37:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=k4rXa9ZKwTFu
        hVfI87YwteYO0QQ=; b=wzoYuHP8N09o2jQB1VvewDROuIKLUoDssnlF+cpH/zwU
        MF/yNvMOoxdtGlcGku6I+ojGkVYCuIsOCAzTdKagRQsYePv8PsA9ax/4DFu53e0H
        ZRzjKPYjT0S5vddF9cTQ6+8IT/KUQml+NJNx3t+7DOsa8jEZh4JaeECA2tv3rQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vcEaWF
        FBXqsK/sBgFHxAZZmEH5e20tGRZAAmH53b05CDR+JfsUkZEWm/IsNlRAsDUefX5e
        9S0Zr31EDr2fiw+9vxqRMtWkCy566w3XPXf9zmV2ofx/CNEpyFnIatOyRaCHkAd0
        y04ZEDGJ68pY6ulzFYAPKBZICeyFBItvwRiM4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B7B6AD5A9;
        Mon, 14 Aug 2017 13:37:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64502AD5A5;
        Mon, 14 Aug 2017 13:37:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH/RFC] File commited with CRLF should roundtrip diff and apply
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
        <20170812145625.31560-1-tboegi@web.de>
Date:   Mon, 14 Aug 2017 10:37:43 -0700
In-Reply-To: <20170812145625.31560-1-tboegi@web.de> (tboegi@web.de's message
        of "Sat, 12 Aug 2017 16:56:25 +0200")
Message-ID: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 47A413E8-8117-11E7-8A7E-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> When a file had been commited with CRLF and core.autocrlf is true,
> the following does not roundtrip, `git apply` fails:
>
> printf "Added line\r\n" >>file &&
> git diff >patch &&
> git checkout -- . &&
> git apply patch

Should this tweak be in effect when we are paying attention to the
contents of the index?  Or does it matter only when we are doing
"git apply" without either "--index" or "--cache"? =20

The fact that the new flag that is passed from load_preimage() down
to read_old_data(), the latter of which is only about the "behave as
a better 'patch -p1', ignoring the index" mode, hints that this
should not affect anything when we are paying attention to the
index, but then calling the load_patch_target() helper with a very
generic CR_AT_EOL flag looks a bit misleading, by making it appear
as if the caller is telling all three cases to do the funny CR
business.  I wonder if we instead want to pass the "patch" structure
down the callchain and have _only_ read_old_data() pay attention to
the has_crlf bit in it---that way, it becomes more obvious what is
going on.

I also notice that read_old_data() still passes &the_index to
convert_to_git().  Can we fix convert_to_git() further to allow NULL
as the istate parameter when we tell it not to look at the index ( I
am reading your passing SAFE_CRLF_KEEP and SAFE_CRLF_FALSE as a way
for the caller to tell that the caller knows what it wants already
and does not want covnert_to_git() to look at the index)?

With or without CR in the patch, I do not see any reason for the
codepath from read_old_data() down to the convert API to look at the
index, ever, as read_old_data() is called only when (!state->cached
&& !state->check_index), i.e. when we are working as a better 'patch
-p1' without even having to know that we are in a Git repository, by
load_patch_target().

> diff --git a/apply.c b/apply.c
> index f2d599141d..63455cd65f 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -220,6 +220,7 @@ struct patch {
>  	unsigned int recount:1;
>  	unsigned int conflicted_threeway:1;
>  	unsigned int direct_to_threeway:1;
> +	unsigned int has_crlf:1;
>  	struct fragment *fragments;
>  	char *result;
>  	size_t resultsize;
> @@ -1662,6 +1663,17 @@ static void check_whitespace(struct apply_state =
*state,
>  	record_ws_error(state, result, line + 1, len - 2, state->linenr);
>  }
> =20
> +/* Check if the patch has context lines with CRLF or
> +   the patch wants to remove lines with CRLF */

Style.

> +static void check_old_for_crlf(struct patch *patch, const char *line, =
int len)
> +{
> +	if (len >=3D 2 && line[len-1] =3D=3D '\n' && line[len-2] =3D=3D '\r')=
 {
> +		patch->ws_rule |=3D WS_CR_AT_EOL;
> +		patch->has_crlf =3D 1;
> +	}
> +}

I am wondering where the discrepancy between the names (old crlf
here, as opposed to "struct patch" that says "has_crlf" implying it
does not care which side between old and new has one) comes from.

Is the intention that you only care about what is expected of the
preimage? =20

> @@ -1712,11 +1724,13 @@ static int parse_fragment(struct apply_state *s=
tate,
>  			if (!deleted && !added)
>  				leading++;
>  			trailing++;
> +			check_old_for_crlf(patch, line, len);
>  			if (!state->apply_in_reverse &&
>  			    state->ws_error_action =3D=3D correct_ws_error)
>  				check_whitespace(state, line, len, patch->ws_rule);
>  			break;

If check_old is about "we care about the lines that are supposed to
match what currently exist in the target file to be patched", then
the call to it also must pay attention to apply_in_reverse.  What
appears on '+' lines in a patch will become the "expected old
contents the patched target is supposed to have" when we are running
"apply -R".

>  		case '-':
> +			check_old_for_crlf(patch, line, len);
>  			if (state->apply_in_reverse &&
>  			    state->ws_error_action !=3D nowarn_ws_error)
>  				check_whitespace(state, line, len, patch->ws_rule);

Likewise.

Thanks for working on this; unlike the previous one I commented, I
think this one I can sort of see how this is an approach to fix it.


