From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/25] refs: add expand_ref()
Date: Mon, 08 Feb 2016 13:27:23 -0800
Message-ID: <xmqqegcm7v0k.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-20-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:27:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aStLF-0000gG-Sc
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 22:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812AbcBHV10 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 16:27:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753082AbcBHV1Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 16:27:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1AFA4411C3;
	Mon,  8 Feb 2016 16:27:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZgCIMM5es4Uw
	XJSUSZPjX9jGiCs=; b=pfU/MUdRva7IKNV8cVLct9NQFv89MGrBWEX67ZsWfAEo
	VQGsp9uiG6K//D3WNt6LYPUlrZN/W04vuzKPmSJYJQ5FGN/wuuvkHIw+mda2QTFv
	H0BeS3vXnsNI2uvpPJsmWpmN9rLUs6qzaMxywfNx0KkcKxOFPSill8liwaCxhsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=q/mE4Q
	qnFhhLP/DVT3hoUANqqkEyFBff8bbTEfIsueyehYOOImiA10mtY88+ZUekfgG2Lp
	Me7hkIxoAnHq8DntxOJ5WIsif0WkRfxfO7UiLhZHYTjrn+tC3rO80BFrDysVvDOq
	TX1TPO/VpJiAY1MltW7aR4th0JsvjET8cLSaE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 132A1411C2;
	Mon,  8 Feb 2016 16:27:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8B42D411C1;
	Mon,  8 Feb 2016 16:27:24 -0500 (EST)
In-Reply-To: <1454576641-29615-20-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BED16072-CEAA-11E5-979F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285810>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is basically dwim_ref() without @{} support. To be used on the
> server side where we want to expand abbreviated to full ref names and
> nothing else.

It is unclear why we want to have such an expansion on the server,
though.  That is something this commit needs to justify, isn't it?

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  refs.c | 8 +++++++-
>  refs.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index e2d34b2..842e4d8 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -392,6 +392,13 @@ static char *substitute_branch_name(const char *=
*string, int *len)
>  int dwim_ref(const char *str, int len, unsigned char *sha1, char **r=
ef)
>  {
>  	char *last_branch =3D substitute_branch_name(&str, &len);
> +	int   refs_found  =3D expand_ref(str, len, sha1, ref);
> +	free(last_branch);
> +	return refs_found;
> +}
> +
> +int expand_ref(const char *str, int len, unsigned char *sha1, char *=
*ref)
> +{
>  	const char **p, *r;
>  	int refs_found =3D 0;
> =20
> @@ -417,7 +424,6 @@ int dwim_ref(const char *str, int len, unsigned c=
har *sha1, char **ref)
>  			warning("ignoring broken ref %s.", fullref);
>  		}
>  	}
> -	free(last_branch);
>  	return refs_found;
>  }
> =20
> diff --git a/refs.h b/refs.h
> index 3c3da29..31a2fa6 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -90,6 +90,7 @@ extern int resolve_gitlink_ref(const char *path, co=
nst char *refname, unsigned c
>   */
>  extern int refname_match(const char *abbrev_name, const char *full_n=
ame);
> =20
> +extern int expand_ref(const char *str, int len, unsigned char *sha1,=
 char **ref);
>  extern int dwim_ref(const char *str, int len, unsigned char *sha1, c=
har **ref);
>  extern int dwim_log(const char *str, int len, unsigned char *sha1, c=
har **ref);
