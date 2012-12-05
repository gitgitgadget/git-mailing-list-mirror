From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add directory pattern matching to attributes
Date: Wed, 05 Dec 2012 15:35:58 -0800
Message-ID: <7vlidcjcm9.fsf@alter.siamese.dyndns.org>
References: <201212052310.30690.jn.avila@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Thu Dec 06 00:36:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgOVt-0006KP-9j
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 00:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab2LEXgD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2012 18:36:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab2LEXgB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2012 18:36:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2E22A03D;
	Wed,  5 Dec 2012 18:36:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=030YMoqMapWN
	NHU5w2py8fTcFhw=; b=NjuZqoGJydQQKQ/7O8lcHdu+Vjyz8asjki0znzirPmcb
	zv6KnNiiVcmKojJgYCzyNUuvMagrc2xvbvcz3a5lOREVyc0XPdzcltYKtdEIyETS
	6DPFXLjq8sPHzngNLkSReDJ8IcyimSBugB0jw2xiLzNyvRgN14gaNtVq9pIJJCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fa3p+3
	hD7sWFt1IrEPddXwtak99BWUTWOdVFFrA3ExUB2WM1msxI9ceO5c3/rYQm430nZL
	V8qRnNjR/tSjU47xjk7l7wGX3abvuaeZFyVU2Z6wHqK3LxedsvyHPwcMDpK6GX9t
	u7PILvYel/zt7Pe3RrPQ90f4+ySdlwTtMW57Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89D6DA03C;
	Wed,  5 Dec 2012 18:36:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0E01A03B; Wed,  5 Dec 2012
 18:35:59 -0500 (EST)
In-Reply-To: <201212052310.30690.jn.avila@free.fr> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message of "Wed, 5 Dec 2012 23:10:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86303814-3F34-11E2-8CBA-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211144>

"Jean-No=C3=ABl AVILA" <jn.avila@free.fr> writes:

> -static void prepare_attr_stack(const char *path)
> +static void prepare_attr_stack(const char *path, unsigned mode)
>  {
>  	struct attr_stack *elem, *info;
>  	int dirlen, len;
> @@ -645,28 +645,43 @@ static void prepare_attr_stack(const char *path=
)
>  }

Why?

The new "mode" parameter does not seem to be used in this function
at all.

>  static int path_matches(const char *pathname, int pathlen,
> -			const char *pattern,
> +			const unsigned mode, char *pattern,
>  			const char *base, int baselen)
>  {
> -	if (!strchr(pattern, '/')) {
> +	size_t len;
> +	char buf[PATH_MAX];
> +	char * lpattern =3D buf;
> +	len =3D strlen(pattern);
> +	if (PATH_MAX <=3D len)
> +		return 0;
> +	strncpy(buf,pattern,len);
> +	buf[len] =3D'\0';
> +	if (len && lpattern[len - 1] =3D=3D '/') {
> +		if (S_ISDIR(mode))
> +			lpattern[len - 1] =3D '\0';
> +		else
> +			return 0;
> +	}
> +	if (!strchr(lpattern, '/')) {
>  		/* match basename */
>  		const char *basename =3D strrchr(pathname, '/');
>  		basename =3D basename ? basename + 1 : pathname;
> -		return (fnmatch_icase(pattern, basename, 0) =3D=3D 0);
> +		return (fnmatch_icase(lpattern, basename, 0) =3D=3D 0);
>  	}
>  	/*
>  	 * match with FNM_PATHNAME; the pattern has base implicitly
>  	 * in front of it.
>  	 */
> -	if (*pattern =3D=3D '/')
> -		pattern++;
> +	if (*lpattern =3D=3D '/')
> +		lpattern++;
>  	if (pathlen < baselen ||
>  	    (baselen && pathname[baselen] !=3D '/') ||
>  	    strncmp(pathname, base, baselen))
>  		return 0;
>  	if (baselen !=3D 0)
>  		baselen++;
> -	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) =3D=
=3D 0;
> +	return fnmatch_icase(lpattern, pathname + baselen, FNM_PATHNAME) =3D=
=3D 0;
>  }

It appears to me that you are forcing the caller to tell this
function if the path is a directory, but in the attribute system,
the caller does not necessarily know if the path it is passing is
meant to be a directory or a regular file.  "check-attr" is meant to
be usable against a path that does not even exist on the working
tree, so using stat() or lstat() in it is not a solution.  In other
words, it is unfair (read: unworkable) to force it to append a
trailing slash after the path it calls this function with.

If you are interested in export-subst, all is not lost, though:

	$ git init
        $ mkdir a
        $ >a/b
        $ echo a export-ignore >.gitattributes
        $ git add a/b .gitattributes
	$ git commit -m initial
        $ git archive HEAD | tar tf -
        .gitattributes
        $ exit

You could change the "echo" to

	$ echo "a/*" export-ignore >.gitattributes

as well, but it seems to create an useless empty directory "a/" in
the output, which I think is an unrelated bug in "git archive".

This patch seems to be based on a stale codebase.  I do not think
I'd be opposed to change the sementics to allow the callers that
know that a path is a directory to optionally pass mode parameter by
ending the pathname with slash (in other words, have "git
check-attr" ask about a directory 'a' by saying "git check-attr
export-subst a/", and lose the "mode" argument in this patch), or
keep the "mode" parameter and instead allow "git check-attr" to ask
about a directory that does not exist in the working tree by a more
explicit "git check-attr --directory export-ignore a" or something.
Such an enhancement should be done on top of the current codebase.

Thanks.
