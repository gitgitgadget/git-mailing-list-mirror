From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH nd/attr-match-optim-more 2/2] attr: more matching
 optimizations from .gitignore
Date: Mon, 08 Oct 2012 22:08:18 -0700
Message-ID: <7vd30si665.fsf@alter.siamese.dyndns.org>
References: <1349749445-25397-1-git-send-email-pclouds@gmail.com>
 <1349749445-25397-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 07:08:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLS3V-0006wy-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 07:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab2JIFIY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2012 01:08:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab2JIFIW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2012 01:08:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD3634266;
	Tue,  9 Oct 2012 01:08:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ePt/Isl1M9zE
	IhiivPia8xCzVsE=; b=rQZJ4VxaZLLh9nSLAVrlZXf75b1RfJVfgUic9ckOLlhb
	bVukqsrQ4k69wB+uWoOCcvd6tmO+uxL7y+LmyZJfky0bvQMj1apWaHH4tx3sP+k/
	nT+Lw9OADexSAoXI4fo/6Ii3xoIZRrH1/Hr1SUQCjOvpBOd9IGZysNVJoSOmwoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OXAY6a
	KeRK3+fXkaAvg69M8BImjgOkl7Ca728LKhhVp6p0g/cHRk7VjR/rET/AlwRK3sI/
	tnNUehhJzmJy5z9SDI7Ra8UQJSANj8fAEWONKTvYD1ePQA9sEOHkxWGRFBfPJWva
	r3i+MfrVOkkjWpyGWowMSzSUKh4oqCii9t82I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98F904265;
	Tue,  9 Oct 2012 01:08:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8640E4263; Tue,  9 Oct 2012
 01:08:20 -0400 (EDT)
In-Reply-To: <1349749445-25397-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 9 Oct
 2012 09:24:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57ECC856-11CF-11E2-B4CE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207298>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> .gitattributes and .gitignore share the same pattern syntax but
> has separate matching implementation. Over the years, ignore's
> implementation accumulates more optimizations while attr's stays
> the same.
>
> This patch adds those optimizations to attr. Basically it tries to
> avoid fnmatch as much as possible in favor of strncmp.
>
> A few notes from this work is put in the documentation:
>
> * "!pattern" syntax is not supported in .gitattributes. Negative
>   patterns may work well for a single attribute like .gitignore. It's
>   confusing in .gitattributes are many attributes can be
>   set/unset/undefined at using the same pattern.

I think the above misses the point.

Imagine if we allowed only one attribute per line, instead of
multiple attributes on one line.
   =20
 - If you want to unset the attribute, you would write "path -attr".

 - If you want to reset the attribute to unspecified, you would
   write "path !attr".

Both are used in conjunction with some other (typically more
generic) pattern that sets, sets to a value, and/or unsets the
attribute, to countermand its effect.

If you were to allow "!path attr", what does it mean?  It obviously
is not about setting the attr to true or to a string value, but is
it countermanding an earlier set and telling us to unset the attr,
or make the attr unspecified?

That is the ambiguity issue "!pattern" syntax would introduce if it
were to be allowed in the attributes.  I think "multiple attributes
on the same line" is a red herring.

> * we support attaching attributes to directories at the syntax
>   level, but we do not really attach attributes on directory or use
>   them.

I would say "... but we do not currently use attributes on
directories."

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattri=
butes.txt
> index 80120ea..cc2ff1d 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -23,7 +23,7 @@ Each line in `gitattributes` file is of form:
>  That is, a pattern followed by an attributes list,
>  separated by whitespaces.  When the pattern matches the
>  path in question, the attributes listed on the line are given to
> -the path.
> +the path. Only files can be attached attributes to.

Symbolic links?

I would strongly suggest dropping "Only ... can be...".  You can
specify attributes to anything and check with "check-attr".  It is
just that core part does not have anything that pays attention to
attributes given to directories in the current codebase.

> @@ -56,6 +56,7 @@ When more than one pattern matches the path, a late=
r line
>  overrides an earlier line.  This overriding is done per
>  attribute.  The rules how the pattern matches paths are the
>  same as in `.gitignore` files; see linkgit:gitignore[5].
> +Unlike `.gitignore`, negative patterns are forbidden.

OK (I am debating myself if it helps the readers if we said why it
is forbidden to write such).

> diff --git a/attr.c b/attr.c
> index e7caee4..7e85f82 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -115,6 +115,13 @@ struct attr_state {
>  	const char *setto;
>  };
> =20
> +struct pattern {
> +	const char *pattern;
> +	int patternlen;
> +	int nowildcardlen;
> +	int flags;		/* EXC_FLAG_* */
> +};
> +
>  /*
>   * One rule, as from a .gitattributes file.
>   *
> @@ -131,7 +138,7 @@ struct attr_state {
>   */
>  struct match_attr {
>  	union {
> -		char *pattern;
> +		struct pattern pat;
>  		struct git_attr *attr;
>  	} u;
>  	char is_macro;
> @@ -241,9 +248,17 @@ static struct match_attr *parse_attr_line(const =
char *line, const char *src,
>  	if (is_macro)
>  		res->u.attr =3D git_attr_internal(name, namelen);
>  	else {
> -		res->u.pattern =3D (char *)&(res->state[num_attr]);
> -		memcpy(res->u.pattern, name, namelen);
> -		res->u.pattern[namelen] =3D 0;
> +		char *p =3D (char *)&(res->state[num_attr]);
> +		memcpy(p, name, namelen);
> +		p[namelen] =3D 0;

This is inherited from the original code, but *res is calloc(3)ed
so the above memcpy() automatically NUL terminates this string.

> +		res->u.pat.pattern =3D p;
> +		parse_exclude_pattern(&res->u.pat.pattern,
> +				      &res->u.pat.patternlen,
> +				      &res->u.pat.flags,
> +				      &res->u.pat.nowildcardlen);
> +		if (res->u.pat.flags & EXC_FLAG_NEGATIVE)
> +			die(_("Negative patterns are forbidden in git attributes\n"
> +			      "Use '\\!' for literal leading exclamation."));
>  	}
>  	res->is_macro =3D is_macro;
>  	res->num_attr =3D num_attr;
> @@ -640,25 +655,55 @@ static void prepare_attr_stack(const char *path=
)
> =20
>  static int path_matches(const char *pathname, int pathlen,
>  			const char *basename,
> -			const char *pattern,
> +			const struct pattern *pat,
>  			const char *base, int baselen)
>  {
> -	if (!strchr(pattern, '/')) {
> +	const char *pattern =3D pat->pattern;
> +	int prefix =3D pat->nowildcardlen;
> +	const char *name;
> +	int namelen;
> +
> +	if (pat->flags & EXC_FLAG_NODIR) {
> +		if (prefix =3D=3D pat->patternlen &&
> +		    !strcmp_icase(pattern, basename))
> +			return 1;

At some point, we should rename strcmp_icase and strncmp_icase to
make it clear that

 (1) they are not about "strings"; and
 (2) icase is not always in effect.

They are about comparing pathnames and that is the reason why
depending on core.ignorecase settings we sometimes do _icase()
comparison.  The same issue is shared with fnmatch_icase() but
"fnmatch_" prefix hints that the helper is not about matching
general strings so it is with lessor problem compared with other
two.

> +		if (pat->flags & EXC_FLAG_ENDSWITH &&
> +		    pat->patternlen - 1 <=3D pathlen &&
> +		    !strcmp_icase(pattern + 1, pathname +
> +				  pathlen - pat->patternlen + 1))
> +			return 1;
> +
>  		return (fnmatch_icase(pattern, basename, 0) =3D=3D 0);
>  	}
>  	/*
>  	 * match with FNM_PATHNAME; the pattern has base implicitly
>  	 * in front of it.
>  	 */
> -	if (*pattern =3D=3D '/')
> +	if (*pattern =3D=3D '/') {
>  		pattern++;
> +		prefix--;
> +	}
> +
> +	/*
> +	 * note: unlike excluded_from_list, baselen here does not
> +	 * contain the trailing slash
> +	 */
> +
>  	if (pathlen < baselen ||
>  	    (baselen && pathname[baselen] !=3D '/') ||
>  	    strncmp(pathname, base, baselen))

This is probably strncmp_icase(), which is to be renamed to
something more sensible.

>  		return 0;
> -	if (baselen !=3D 0)
> -		baselen++;
> -	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) =3D=
=3D 0;
> +
> +	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;

I think this "- 1" is what the above "note: unlike excluded_from..."
refers to, but then isn't a same adjustment necessary to the "if"
condition we see above that compares pathlen and baselen???

> +	name =3D pathname + pathlen - namelen;
> +
> +	/* if the non-wildcard part is longer than the remaining
> +	   pathname, surely it cannot match */

Style.

> +	if (!namelen || prefix > namelen)
> +		return 0;
> +
> +	return fnmatch_icase(pattern, name, FNM_PATHNAME) =3D=3D 0;
>  }
