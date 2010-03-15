From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH RFC] cherry: support --abbrev option
Date: Mon, 15 Mar 2010 18:08:52 +0100
Message-ID: <4B9E69A4.2080304@lsrfire.ath.cx>
References: <1268668999-4188-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 18:09:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDmt-0000K2-L7
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965491Ab0CORJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 13:09:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:60151 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965484Ab0CORI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:08:59 -0400
Received: from [10.0.1.100] (p57B7CEE7.dip.t-dialin.net [87.183.206.231])
	by india601.server4you.de (Postfix) with ESMTPSA id 3197D2F804E;
	Mon, 15 Mar 2010 18:08:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <1268668999-4188-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142222>

Am 15.03.2010 17:03, schrieb Erik Faye-Lund:
> Switch to parse-options API while we're at it.
>=20
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>=20
> I sometimes find it useful to look at the commit-subject together wit=
h
> the SHA-1s. Using --abbrev increases the chance that the lines fits o=
n
> an 80 character wide terminal, making the output easier to read.
>=20
>  builtin/log.c |   40 ++++++++++++++++++++++------------------
>  1 files changed, 22 insertions(+), 18 deletions(-)
>=20
> diff --git a/builtin/log.c b/builtin/log.c
> index b70d0f7..020d618 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1286,8 +1286,11 @@ static int add_pending_commit(const char *arg,=
 struct rev_info *revs, int flags)
>  	return -1;
>  }
> =20
> -static const char cherry_usage[] =3D
> -"git cherry [-v] [<upstream> [<head> [<limit>]]]";
> +static const char * const cherry_usage[] =3D {
> +	"git cherry [-v] [<upstream> [<head> [<limit>]]]",
> +	NULL
> +};
> +
>  int cmd_cherry(int argc, const char **argv, const char *prefix)
>  {
>  	struct rev_info revs;
> @@ -1298,26 +1301,26 @@ int cmd_cherry(int argc, const char **argv, c=
onst char *prefix)
>  	const char *upstream;
>  	const char *head =3D "HEAD";
>  	const char *limit =3D NULL;
> -	int verbose =3D 0;
> +	int verbose =3D 0, abbrev =3D 40;
> =20
> -	if (argc > 1 && !strcmp(argv[1], "-v")) {
> -		verbose =3D 1;
> -		argc--;
> -		argv++;
> -	}
> +	struct option options[] =3D {
> +		OPT__ABBREV(&abbrev),
> +		OPT__VERBOSE(&verbose),
> +		OPT_END()
> +	};

If I use --no-abbrev, do I get 0 or 40 hash chars?  I didn't actually
test it, but I suspect an "if (!abbrev) abbrev =3D 40;" is needed somew=
here.

> -	if (argc > 1 && !strcmp(argv[1], "-h"))
> -		usage(cherry_usage);
> +	argc =3D parse_options(argc, argv, prefix, options, cherry_usage,
> +	    PARSE_OPT_KEEP_UNKNOWN);

Why do you use PARSE_OPT_KEEP_UNKNOWN here?  I think the old option
parsing code lazily relied on invalid options being found out by
add_pending_commit() later.  We can be lazy again by leaving invalid
option handling to parse_options(); sure, it changes the error message,
but for the better.

Ren=E9
