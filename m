From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v1 27/45] Convert run_add_interactive to use struct
 pathspec
Date: Mon, 18 Mar 2013 18:26:03 +0000
Message-ID: <20130318182602.GA2164@serenity.lan>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-28-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 19:26:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHelf-00085C-8R
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 19:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab3CRS0P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Mar 2013 14:26:15 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:58439 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab3CRS0O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 14:26:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id A3C3B198003;
	Mon, 18 Mar 2013 18:26:13 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F33gzD+ULEiU; Mon, 18 Mar 2013 18:26:13 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 69BAF606501;
	Mon, 18 Mar 2013 18:26:07 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1363327620-29017-28-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218435>

On Fri, Mar 15, 2013 at 01:06:42PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> This passes the pathspec, more or less unmodified, to
> git-add--interactive. The command itself does not process pathspec. I=
t
> simply passes the pathspec to other builtin commands. So if all those
> commands support pathspec, we're good.

This breaks "git reset --keep" in a subdirectory for me.

I ran "git reset --keep <branch>" in a subdirectory and got:

    fatal: BUG: parse_pathspec cannot take no argument in this case

Bisecting points to this commit.

The simplest test case is:

    ( cd t && ../bin-wrappers/git reset --keep HEAD )

which works on master but not pu.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/add.c      | 26 ++++++++++----------------
>  builtin/checkout.c |  9 ++++-----
>  builtin/reset.c    |  8 ++++----
>  commit.h           |  2 +-
>  4 files changed, 19 insertions(+), 26 deletions(-)
>=20
> diff --git a/builtin/add.c b/builtin/add.c
> index ec6fbe3..2b20d7d 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -139,16 +139,12 @@ static void refresh(int verbose, const char **p=
athspec)
>  }
> =20
>  int run_add_interactive(const char *revision, const char *patch_mode=
,
> -			const char **pathspec)
> +			const struct pathspec *pathspec)
>  {
> -	int status, ac, pc =3D 0;
> +	int status, ac, i;
>  	const char **args;
> =20
> -	if (pathspec)
> -		while (pathspec[pc])
> -			pc++;
> -
> -	args =3D xcalloc(sizeof(const char *), (pc + 5));
> +	args =3D xcalloc(sizeof(const char *), (pathspec->nr + 6));
>  	ac =3D 0;
>  	args[ac++] =3D "add--interactive";
>  	if (patch_mode)
> @@ -156,11 +152,9 @@ int run_add_interactive(const char *revision, co=
nst char *patch_mode,
>  	if (revision)
>  		args[ac++] =3D revision;
>  	args[ac++] =3D "--";
> -	if (pc) {
> -		memcpy(&(args[ac]), pathspec, sizeof(const char *) * pc);
> -		ac +=3D pc;
> -	}
> -	args[ac] =3D NULL;
> +	for (i =3D 0; i < pathspec->nr; i++)
> +		/* pass original pathspec, to be re-parsed */
> +		args[ac++] =3D pathspec->items[i].original;
> =20
>  	status =3D run_command_v_opt(args, RUN_GIT_CMD);
>  	free(args);
> @@ -175,17 +169,17 @@ int interactive_add(int argc, const char **argv=
, const char *prefix, int patch)
>  	 * git-add--interactive itself does not parse pathspec. It
>  	 * simply passes the pathspec to other builtin commands. Let's
>  	 * hope all of them support all magic, or we'll need to limit
> -	 * the magic here. There is still a problem with prefix. But
> -	 * that'll be worked on later on.
> +	 * the magic here.
>  	 */
>  	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
>  		       PATHSPEC_PREFER_FULL |
> -		       PATHSPEC_SYMLINK_LEADING_PATH,
> +		       PATHSPEC_SYMLINK_LEADING_PATH |
> +		       PATHSPEC_PREFIX_ORIGIN,
>  		       prefix, argv);
> =20
>  	return run_add_interactive(NULL,
>  				   patch ? "--patch" : NULL,
> -				   pathspec.raw);
> +				   &pathspec);
>  }
> =20
>  static int edit_patch(int argc, const char **argv, const char *prefi=
x)
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 3c19cb4..2ddff95 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -256,7 +256,7 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
> =20
>  	if (opts->patch_mode)
>  		return run_add_interactive(revision, "--patch=3Dcheckout",
> -					   opts->pathspec.raw);
> +					   &opts->pathspec);
> =20
>  	lock_file =3D xcalloc(1, sizeof(struct lock_file));
> =20
> @@ -1115,10 +1115,9 @@ int cmd_checkout(int argc, const char **argv, =
const char *prefix)
>  		 * cannot handle. Magic mask is pretty safe to be
>  		 * lifted for new magic when opts.patch_mode =3D=3D 0.
>  		 */
> -		parse_pathspec(&opts.pathspec,
> -			       opts.patch_mode =3D=3D 0 ? 0 :
> -			       (PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP),
> -			       0, prefix, argv);
> +		parse_pathspec(&opts.pathspec, 0,
> +			       opts.patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
> +			       prefix, argv);
> =20
>  		if (!opts.pathspec.nr)
>  			die(_("invalid path specification"));
> diff --git a/builtin/reset.c b/builtin/reset.c
> index da7282e..7c6e8b6 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -216,9 +216,9 @@ static void parse_args(struct pathspec *pathspec,
>  		}
>  	}
>  	*rev_ret =3D rev;
> -	parse_pathspec(pathspec,
> -		       patch_mode ? PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP : 0,
> -		       PATHSPEC_PREFER_FULL,
> +	parse_pathspec(pathspec, 0,
> +		       PATHSPEC_PREFER_FULL |
> +		       patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
>  		       prefix, argv);
>  }
> =20
> @@ -296,7 +296,7 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
>  	if (patch_mode) {
>  		if (reset_type !=3D NONE)
>  			die(_("--patch is incompatible with --{hard,mixed,soft}"));
> -		return run_add_interactive(sha1_to_hex(sha1), "--patch=3Dreset", p=
athspec.raw);
> +		return run_add_interactive(sha1_to_hex(sha1), "--patch=3Dreset", &=
pathspec);
>  	}
> =20
>  	/* git reset tree [--] paths... can be used to
> diff --git a/commit.h b/commit.h
> index 4138bb4..9448fda 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -179,7 +179,7 @@ int in_merge_bases(struct commit *, struct commit=
 *);
> =20
>  extern int interactive_add(int argc, const char **argv, const char *=
prefix, int patch);
>  extern int run_add_interactive(const char *revision, const char *pat=
ch_mode,
> -			       const char **pathspec);
> +			       const struct pathspec *pathspec);
> =20
>  static inline int single_parent(struct commit *commit)
>  {
> --=20
> 1.8.0.rc0.19.g7bbb31d
