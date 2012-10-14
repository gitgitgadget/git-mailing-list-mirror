From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] exclude/attr: share basename matching code
Date: Sun, 14 Oct 2012 11:09:16 -0700
Message-ID: <7vzk3px6wj.fsf@alter.siamese.dyndns.org>
References: <1350215742-20761-1-git-send-email-pclouds@gmail.com>
 <1350215742-20761-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:09:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNSd2-0006qh-FA
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 20:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292Ab2JNSJU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 14:09:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109Ab2JNSJT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 14:09:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B26093CF;
	Sun, 14 Oct 2012 14:09:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=N2kM6UI0EqXp
	tketc9XeCnUSGGE=; b=qrwQwublvgntNtpxrqASEp+Umtm1QtTByPw08tGwytgD
	QiTBo40QjQRzk2n7Pgpp4/KsYszLfzyLC+8esOoKlIAsb8q6UWwKhyFrhgoBF1ZU
	DfNsaWgd6IL9vwwDaIDMjFrUEz0FGC8s/UQIbXTOEEUHWHLt2iVs7P+Sxrkn/JM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RghF+P
	NWOyrTPniPOGS/sc8vAPan+uDiuXSgnLopX/Xz50pQ8SfjBKmXsYE19XfMwdGPVI
	r+UcJ7aSy//+KI4MyUQcGFwv0xSubH72dZQLCoLzPjBPdXPbBXOe8pJBT9MOtbzG
	DI5Tkr8ifUC9KfecrOzptVkY3ftgvKpE/Ywvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECE5493CD;
	Sun, 14 Oct 2012 14:09:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19C1493C9; Sun, 14 Oct 2012
 14:09:18 -0400 (EDT)
In-Reply-To: <1350215742-20761-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 14 Oct
 2012 18:55:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 454526E4-162A-11E2-9A53-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207680>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> match_basename's declaration in dir.h does not have any description t=
o
> discourage the use of this function elsewhere as this function is
> highly tied to how excluded_from_list and path_matches work.

If you do want to discourage, please explicitly describe it as such.

I actually think it should have an API description.  The meaning of
its parameters and how you would formulate them is fairly clear and
this is a good example of a simple-and-stupid function that is
designed to do one thing and do it well.

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  attr.c | 15 ++++-----------
>  dir.c  | 37 ++++++++++++++++++++++++-------------
>  dir.h  |  2 ++
>  3 files changed, 30 insertions(+), 24 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index 0964033..a28ce0d 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -663,17 +663,10 @@ static int path_matches(const char *pathname, i=
nt pathlen,
>  	int namelen;
> =20
>  	if (pat->flags & EXC_FLAG_NODIR) {
> -		if (prefix =3D=3D pat->patternlen &&
> -		    !strcmp_icase(pattern, basename))
> -			return 1;
> -
> -		if (pat->flags & EXC_FLAG_ENDSWITH &&
> -		    pat->patternlen - 1 <=3D pathlen &&
> -		    !strcmp_icase(pattern + 1, pathname +
> -				  pathlen - pat->patternlen + 1))
> -			return 1;
> -
> -		return (fnmatch_icase(pattern, basename, 0) =3D=3D 0);
> +		return match_basename(basename,
> +				      pathlen - (basename - pathname),
> +				      pattern, prefix,
> +				      pat->patternlen, pat->flags);
>  	}
>  	/*
>  	 * match with FNM_PATHNAME; the pattern has base implicitly
> diff --git a/dir.c b/dir.c
> index 0f4aea6..42c42cd 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -530,6 +530,25 @@ static void prep_exclude(struct dir_struct *dir,=
 const char *base, int baselen)
>  	dir->basebuf[baselen] =3D '\0';
>  }
> =20
> +int match_basename(const char *basename, int basenamelen,
> +		   const char *pattern, int prefix, int patternlen,
> +		   int flags)
> +{
> +	if (prefix =3D=3D patternlen) {
> +		if (!strcmp_icase(pattern, basename))
> +			return 1;
> +	} else if (flags & EXC_FLAG_ENDSWITH) {
> +		if (patternlen - 1 <=3D basenamelen &&
> +		    !strcmp_icase(pattern + 1,
> +				  basename + basenamelen - patternlen + 1))
> +			return 1;
> +	} else {
> +		if (fnmatch_icase(pattern, basename, 0) =3D=3D 0)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>  /* Scan the list and let the last match determine the fate.
>   * Return 1 for exclude, 0 for include and -1 for undecided.
>   */
> @@ -556,19 +575,11 @@ int excluded_from_list(const char *pathname,
>  		}
> =20
>  		if (x->flags & EXC_FLAG_NODIR) {
> -			/* match basename */
> -			if (prefix =3D=3D x->patternlen) {
> -				if (!strcmp_icase(exclude, basename))
> -					return to_exclude;
> -			} else if (x->flags & EXC_FLAG_ENDSWITH) {
> -				int len =3D pathlen - (basename - pathname);
> -				if (x->patternlen - 1 <=3D len &&
> -				    !strcmp_icase(exclude + 1, basename + len - x->patternlen + =
1))
> -					return to_exclude;
> -			} else {
> -				if (fnmatch_icase(exclude, basename, 0) =3D=3D 0)
> -					return to_exclude;
> -			}
> +			if (match_basename(basename,
> +					   pathlen - (basename - pathname),
> +					   exclude, prefix, x->patternlen,
> +					   x->flags))
> +				return to_exclude;
>  			continue;
>  		}
> =20
> diff --git a/dir.h b/dir.h
> index fd5c2aa..d416c5a 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -78,6 +78,8 @@ extern int read_directory(struct dir_struct *, cons=
t char *path, int len, const
> =20
>  extern int excluded_from_list(const char *pathname, int pathlen, con=
st char *basename,
>  			      int *dtype, struct exclude_list *el);
> +extern int match_basename(const char *, int,
> +			  const char *, int, int, int);
>  struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char=
 *pathname, int len);
> =20
>  /*
