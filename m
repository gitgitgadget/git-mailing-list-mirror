From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] fetch: plug two leaks on error exit in store_updated_refs
Date: Fri, 07 Oct 2011 08:59:10 +0200
Message-ID: <4E8EA33E.5020009@lsrfire.ath.cx>
References: <20111007014136.GB10839@localhost> <4E8E98A7.8010008@lsrfire.ath.cx> <CALUzUxp4Eo7j=kM7YPJbj70-rwuyFK5V1mZZMY7vBwwPYWS6gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Wilson <cwilson@vigilantsw.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 08:59:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC4Oz-00026Y-8k
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 08:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758285Ab1JGG7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 02:59:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:56393 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab1JGG7U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 02:59:20 -0400
Received: from [192.168.2.104] (p4FFDBCAF.dip.t-dialin.net [79.253.188.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 420502F804A;
	Fri,  7 Oct 2011 08:59:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CALUzUxp4Eo7j=kM7YPJbj70-rwuyFK5V1mZZMY7vBwwPYWS6gQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183062>

Am 07.10.2011 08:49, schrieb Tay Ray Chuan:
> How about reusing the function's cleanup calls, like this?

Yes, that's better.

> -- >8 --
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index fc254b6..56267c4 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -423,8 +423,10 @@ static int store_updated_refs(const char
> *raw_url, const char *remote_name,
>  	else
>  		url =3D xstrdup("foreign");
>=20
> -	if (check_everything_connected(ref_map, 0))
> -		return error(_("%s did not send all necessary objects\n"), url);
> +	if (check_everything_connected(ref_map, 0)) {
> +		rc =3D error(_("%s did not send all necessary objects\n"), url);
> +		goto abort;
> +	}
>=20
>  	for (rm =3D ref_map; rm; rm =3D rm->next) {
>  		struct ref *ref =3D NULL;
> @@ -506,12 +508,15 @@ static int store_updated_refs(const char
> *raw_url, const char *remote_name,
>  				fprintf(stderr, " %s\n", note);
>  		}
>  	}
> -	free(url);
> -	fclose(fp);
> +
>  	if (rc & STORE_REF_ERROR_DF_CONFLICT)
>  		error(_("some local refs could not be updated; try running\n"
>  		      " 'git remote prune %s' to remove any old, conflicting "
>  		      "branches"), remote_name);
> +
> +abort:
> +	free(url);
> +	fclose(fp);
>  	return rc;
>  }
>=20

Micro-nit: If you start the label with a space ("+ abort:") then the
code continues to play nice with git grep -W.

Ren=E9
