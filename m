From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/7] convert.c: Use text_eol_is_crlf()
Date: Thu, 04 Feb 2016 12:13:00 -0800
Message-ID: <xmqqlh70groz.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1454608194-5417-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Feb 04 21:13:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRQH7-0003vd-Bc
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 21:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbcBDUNF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 15:13:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752655AbcBDUND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 15:13:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6347041D09;
	Thu,  4 Feb 2016 15:13:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=R6U3nPyqEyjw
	cClEwMTJ53o7DnY=; b=BZ46Ddj8Xx7y63A0e9qHntHVL0RLw6Glnj6AfSnjBFqi
	kxq4z6WuJ3BNkY0asXAbzJcOk4qilnN6EPofVhas6YWpJ540rkJ72ugf3P7JG5lH
	UcNcb6HGsbPiCxjQptIpTZGQ7UocgGNSA6ZS8THQ4caGJnbEGs5GfpTdPF/zhmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pviaze
	PLQXuS/BideJ1qvlvIfHYyBggfPw3yslfldSOddHycQ+kTQFI7PU9OkzTRJue2Pb
	U5NVtIgPVEg+IcMP+p8apKBVgwSseVVYxE7bPu3gAtqji1VM/JLryzS0J8BfYMSh
	U/IfvP4JmKBLv6+QTNpJNaDtwJpadnpabEBIE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B85441D08;
	Thu,  4 Feb 2016 15:13:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B8A9341D04;
	Thu,  4 Feb 2016 15:13:01 -0500 (EST)
In-Reply-To: <1454608194-5417-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Thu, 4 Feb 2016 18:49:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B11F9B06-CB7B-11E5-A01F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285489>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Add a helper function to find out, which line endings
> text files should get at checkout, depending on
> core.autocrlf and core.eol
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  convert.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index d0c8c66..9ffd043 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -149,6 +149,19 @@ const char *get_wt_convert_stats_ascii(const cha=
r *path)
>  	return ret;
>  }
> =20
> +static int text_eol_is_crlf(void)
> +{
> +	if (auto_crlf =3D=3D AUTO_CRLF_TRUE)
> +		return 1;
> +	else if (auto_crlf =3D=3D AUTO_CRLF_INPUT)
> +		return 0;
> +	if (core_eol =3D=3D EOL_CRLF)
> +		return 1;
> +	if (core_eol =3D=3D EOL_UNSET && EOL_NATIVE =3D=3D EOL_CRLF)
> +		return 1;
> +	return 0;
> +}
> +
>  static enum eol output_eol(enum crlf_action crlf_action)
>  {
>  	switch (crlf_action) {
> @@ -164,12 +177,7 @@ static enum eol output_eol(enum crlf_action crlf=
_action)
>  		/* fall through */
>  	case CRLF_TEXT:
>  	case CRLF_AUTO:
> -		if (auto_crlf =3D=3D AUTO_CRLF_TRUE)
> -			return EOL_CRLF;
> -		else if (auto_crlf =3D=3D AUTO_CRLF_INPUT)
> -			return EOL_LF;
> -		else if (core_eol =3D=3D EOL_UNSET)
> -			return EOL_NATIVE;
> +		return text_eol_is_crlf() ? EOL_CRLF : EOL_LF;
>  	}
>  	return core_eol;
>  }
> @@ -1378,8 +1386,9 @@ struct stream_filter *get_stream_filter(const c=
har *path, const unsigned char *s
>  	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FA=
LSE))
>  		filter =3D cascade_filter(filter, &null_filter_singleton);
> =20
> -	else if (output_eol(crlf_action) =3D=3D EOL_CRLF &&
> -		 !(crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS))
> +	else if ((crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_G=
UESS))
> +		;
> +	else if (output_eol(crlf_action) =3D=3D EOL_CRLF)
>  		filter =3D cascade_filter(filter, lf_to_crlf_filter());
> =20
>  	return filter;

I am a bit slow today so let me talk this change through aloud.

The condition under which we called cascade_filter() used to be that
output_eol(crlf_action) yields EOL_CRLF and crlf_action is not set
to one of these two values.  Now, we say if crlf_action is one of
these two values, we wouldn't call it, and then we check
output_eol().

So they do the same thing, even though it smells that this change is
outside the scope of "Add a helper and use it" theme of the patch.

While I do not think this new "split" conditions particularly easier
to read compared to the previous one, if you plan to do something
different in later patches when crlf_action is set to specific
values, ignoring what output_eol() says, a patch to implement such a
change would become easier to understand what is going on with this
preparatory rewrite.  So if such a preparatory rewrite is coming (I
haven't checked 5-7/7 yet), perhaps have this hunk as a single patch
that is separate from "add a helper text_eol_is_crlf()" patch.

By the way, your new 1/7 has s/: Remove/: remove/ applied to the
subject, but not other ones like this one.  Intended, or you forgot
to do s/: Use/: use/ here?
