From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] exclude: filter patterns by directory level
Date: Sun, 10 Mar 2013 00:20:00 -0800
Message-ID: <7vtxojd5u7.fsf@alter.siamese.dyndns.org>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 09:20:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEbUz-00047M-Ma
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 09:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab3CJIUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 04:20:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907Ab3CJIUF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Mar 2013 04:20:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE9529252;
	Sun, 10 Mar 2013 04:20:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r8ON86AC0QUo
	Tz7tNKRNCG0xMU8=; b=DxgabR7Scdury2kAU8bsvGh0jC7M6/4e14TN4Au4GwUR
	pWOarPXi/hDx8eXT74jguyxUP8U7ZUt2UuGYDhdq0nVRBpfoIvr+zmZCg6wrzMra
	mti4hY1DgYxwfpRmTSh8Gzc/tU2X3grO8fFuNHups9l1SKIA5sGnhH9S4weN214=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AmFR6c
	OWn6G0FO3xh/+5JVsx0DhEe7xRTX4x1s5T5c/B7NjskY0fm2A5f7QRTd0BnxWMKd
	6ZJsceYKVGCPmM/qgMAK8CXn6s+JsY9H/A4IXOKmtMOJDhSBJuvzEkZSqT1sh+la
	Hi7ZtG98ODLTm40CJmAP+nXibyH/y4hsAAwh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB9B89251;
	Sun, 10 Mar 2013 04:20:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B354B924F; Sun, 10 Mar 2013
 04:20:02 -0400 (EDT)
In-Reply-To: <1362896070-17456-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 10 Mar
 2013 13:14:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E8CEA6C-895B-11E2-B4AC-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217790>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> A non-basename pattern that does not contain /**/ can't match anythin=
g
> outside the attached directory. Record its directory level and avoid
> matching unless the pathname is also at the same directory level.

Without defining what a "directory level" is, the above is a bit
hard to grok, but I think you mean an entry "b/c/*.c" that appears
in "a/.gitignore" file will want to match a path that is directly
in "a/b/c" directory (and not in its subdirectories),
"a/b/x.c" at the two levels deep subdirectory or "a/b/c/d/x.c" that is
four levels deep will never match the pattern.

The logic feels sound.

> diff --git a/dir.c b/dir.c
> index 880b5e6..de7a6ba 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -360,10 +360,12 @@ static int no_wildcard(const char *string)
>  void parse_exclude_pattern(const char **pattern,
>  			   int *patternlen,
>  			   int *flags,
> -			   int *nowildcardlen)
> +			   int *nowildcardlen,
> +			   int *dirs_p)
>  {
>  	const char *p =3D *pattern;
>  	size_t i, len;
> +	int dirs;
> =20
>  	*flags =3D 0;
>  	if (*p =3D=3D '!') {
> @@ -375,12 +377,15 @@ void parse_exclude_pattern(const char **pattern=
,
>  		len--;
>  		*flags |=3D EXC_FLAG_MUSTBEDIR;
>  	}
> -	for (i =3D 0; i < len; i++) {
> +	for (i =3D 0, dirs =3D 0; i < len; i++) {
>  		if (p[i] =3D=3D '/')
> -			break;
> +			dirs++;
>  	}
> -	if (i =3D=3D len)
> +	if (!dirs)
>  		*flags |=3D EXC_FLAG_NODIR;
> +	else if (*p =3D=3D '/')
> +		dirs--;

I presume this is to compensate for a pattern like "/pat" whose
leading slash is only to anchor the pattern at the level.  Correct?

> @@ -415,11 +423,26 @@ void add_exclude(const char *string, const char=
 *base,
>  		x =3D xmalloc(sizeof(*x));
>  		x->pattern =3D string;
>  	}
> +	/*
> +	 * TODO: nowildcardlen < patternlen is a stricter than
> +	 * necessary mainly to exclude "**" that breaks directory
> +	 * boundary. Patterns like "/foo-*" should be fine.
> +	 */
> +	if ((flags & EXC_FLAG_NODIR) || nowildcardlen < patternlen)
> +		dirs =3D -1;

OK, so an entry "README" to match README in any subdirectory will
becomes (dirs < 0) and the matcher below will not short-circuit the
comparison.  Good.

> +	else {
> +		int i;
> +		for (i =3D 0; i < baselen; i++) {
> +			if (base[i] =3D=3D '/')
> +				dirs++;
> +		}
> +	}
>  	x->patternlen =3D patternlen;
>  	x->nowildcardlen =3D nowildcardlen;
>  	x->base =3D base;
>  	x->baselen =3D baselen;
>  	x->flags =3D flags;
> +	x->dirs =3D dirs;
>  	x->srcpos =3D srcpos;
>  	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
>  	el->excludes[el->nr++] =3D x;
> @@ -701,7 +724,7 @@ int match_pathname(const char *pathname, int path=
len,
>   * matched, or NULL for undecided.
>   */
>  static struct exclude *last_exclude_matching_from_list(const char *p=
athname,
> -						       int pathlen,
> +						       int pathlen, int dirs,
>  						       const char *basename,
>  						       int *dtype,
>  						       struct exclude_list *el)
> @@ -732,6 +755,9 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
>  			continue;
>  		}
> =20
> +		if (dirs >=3D 0 && x->dirs >=3D 0 && x->dirs !=3D dirs)
> +			continue;
