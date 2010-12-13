From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/19] tree_entry_interesting: support depth limit
Date: Mon, 13 Dec 2010 10:10:51 -0800
Message-ID: <7vwrnd1r2s.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 19:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSCru-00018p-Do
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 19:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757768Ab0LMSLA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 13:11:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553Ab0LMSK7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 13:10:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45D012F3F;
	Mon, 13 Dec 2010 13:11:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=/VJ994zsikCdtF7b8v+3vMTw7
	Xk=; b=k/4zBntbkbcuNdWX6bp/jnWsbr11TS2wiwINjA1i7mkHsNoKF3WX4tlkh
	KlRHF0Ut/gN5QxlmG/BKzZT6XewpaM89jJxOdtL4nVrxfwUz+djT8kTfbxJ169EM
	zJHNr9UZlwirqX/pOG2OSJEzfsMCgWmhe58lWOvVE+sr7SsVDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=tICAVWCyptiXqpoz/wm
	a41Ezdn1UbnHnDlj70UJUpqHVhR92zpe3Be+J5Nk3zaVjbdvkkKgyKUP/JLDGgc1
	l7XH8d9xzoyL8Ydt6/79Jbgo66qHDPC8P0xT7VCwtwWcwiZqmeGgEpXD0CDnqKht
	JRxyxDHdJNqyliSCOBnt8hME=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2327D2F3E;
	Mon, 13 Dec 2010 13:11:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D849C2F3D; Mon, 13 Dec 2010
 13:11:18 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 63FEA5BC-06E4-11E0-9C0B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163577>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/dir.c b/dir.c
> index 0987d0c..bb5076c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -71,6 +71,21 @@ int fill_directory(struct dir_struct *dir, const c=
har **pathspec)
>  	return len;
>  }
> =20
> +int within_depth(const char *name, int namelen,
> +			int depth, int max_depth)
> +{
> +	const char *cp =3D name, *cpe =3D name + namelen;
> +
> +	while (cp < cpe) {
> +		if (*cp++ !=3D '/')
> +			continue;
> +		depth++;
> +		if (depth > max_depth)
> +			return 0;
> +	}
> +	return 1;
> +}

Makes me almost suspect that it may make more sense to keep track of th=
e
"depth" in a similar way as "base" and "baselen" as "traversal state" o=
n
the side of the caller so that you do not have to scan the string for
slashes over and over again.  But given the codeflow, doing so might ma=
ke
the result look too ugly, so I won't recommend that without thinking,
though.

> diff --git a/tree-walk.c b/tree-walk.c
> index 40a4657..d28de30 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -558,9 +559,17 @@ int tree_entry_interesting(const struct name_ent=
ry *entry,
>  	int pathlen;
>  	int never_interesting =3D -1;
> =20
> -	if (!ps || !ps->nr)
> +	if (!ps)
>  		return 1;
> =20
> +	if (!ps->nr) {
> +		if (!ps->recursive || ps->max_depth =3D=3D -1)
> +			return 1;
> +		return !!within_depth(base, baselen,
> +				      !!S_ISDIR(entry->mode),
> +				      ps->max_depth);
> +	}

This gives different behaviour to between callers that give you NULL as
pathspec and callers that give you a pathspec with zero elements.  Is t=
his
intended?  What is the use case (iow, what does an end user give from t=
he
command line to experience this difference)?

> @@ -571,7 +580,13 @@ int tree_entry_interesting(const struct name_ent=
ry *entry,
>  			if (!match_dir_prefix(base, baselen, match, matchlen))
>  				/* Just a random prefix match */
>  				continue;
> -			return 2;
> +
> +			if (!ps->recursive || ps->max_depth =3D=3D -1)
> +				return 2;
> +
> +			return !!within_depth(base+matchlen+1, baselen-matchlen-1,
> +					      !!S_ISDIR(entry->mode),
> +					      ps->max_depth);
>  		}

If two pathspecs that overlap with each other (e.g. "Documentation/" an=
d
"Documentation/technical") are given, and if the shorter one comes befo=
re
the longer one in ps[], wouldn't this give you an unexpected result?  W=
hen
inspecting "Documentation/technical/api/foo.txt" with depth limit of 2,=
 if
you didn't have "Documentation/" pathspec, you count "api/foo.txt"
relative to "Documentation/technical", declare that the path is within
limit, and show it.  But if you have "Documentation/" in ps[], you look=
 at
it, decide "technical/api/foo.txt" is too deep and return false without
even looking at "Documentation/technical" that may appear later in ps[]=
,
no?
