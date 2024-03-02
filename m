Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B96B2C870
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709409448; cv=none; b=M3u36jOLT4D4Bn5I/CWl8LogFFTnjjmS65bwD2s1SxrPKXHycaMyeEDTCTH+yGtK2lrZlT5RuDY9cdQNXijBZ5a6B9DRo+1kWqhbEoYZQ9yuHCzCMC1kJR2UDJI0A1+AZAt3aupVxmql82j6/qqblAjlx0U+f2Y0XH2RMnbz4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709409448; c=relaxed/simple;
	bh=z5WcwvoGVrWm5diLHfbxqpvi1at2to94Gl29tqlSRWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHjEwUScWxjPDS3XieKcMw/rIsDu/GXJNGguJHGKMRUFA+HJy+stMowDDfC0K+fbDsIq1OFlrR3TnxZleWDZIhqQJxWqbz9ZL9VMKs0lcF5FUE2ZYWsWwjHTqgrYxjGdtKNV2g/n4P9PKdIB+aL5NY7x6I/zLWje00eJ3x/CZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 29D01834A6E
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 20:48:06 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:1c73:7714:ea27:1649])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 0534C19F791;
	Sat,  2 Mar 2024 20:47:55 +0100 (CET)
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <avila.jn@gmail.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
Date: Sat, 02 Mar 2024 20:47:55 +0100
Message-ID: <6033073.lOV4Wx5bFT@cayenne>
In-Reply-To: <87frxam35f.fsf@osv.gnss.ru>
References:
 <xmqq34v6gswv.fsf@gitster.g> <51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
 <87frxam35f.fsf@osv.gnss.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, 1 March 2024 15:34:52 CET Sergey Organov wrote:
> Jean-No=EBl Avila <avila.jn@gmail.com> writes:
>=20
> > Putting my documentation/translator hat:
> >
> > Le 29/02/2024 =E0 20:07, Sergey Organov a =E9crit :
> >> What -n actually does in addition to its documented behavior is
> >> ignoring of configuration variable clean.requireForce, that makes
> >> sense provided -n prevents files removal anyway.
> >>=20
> >> So, first, document this in the manual, and then modify implementation
> >> to make this more explicit in the code.
> >>=20
> >> Improved implementation also stops to share single internal variable
> >> 'force' between command-line -f option and configuration variable
> >> clean.requireForce, resulting in more clear logic.
> >>=20
> >> The error messages now do not mention -n as well, as it seems
> >> unnecessary and does not reflect clarified implementation.
> >>=20
> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> ---
> >>  Documentation/git-clean.txt |  2 ++
> >>  builtin/clean.c             | 26 +++++++++++++-------------
> >>  2 files changed, 15 insertions(+), 13 deletions(-)
> >>=20
> >> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> >> index 69331e3f05a1..662eebb85207 100644
> >> --- a/Documentation/git-clean.txt
> >> +++ b/Documentation/git-clean.txt
> >> @@ -49,6 +49,8 @@ OPTIONS
> >>  -n::
> >>  --dry-run::
> >>  	Don't actually remove anything, just show what would be done.
> >> +	Configuration variable clean.requireForce is ignored, as
> >> +	nothing will be deleted anyway.
> >
> > Please use backticks for options, configuration and environment names:
> > `clean.requireForce`
>=20
> I did consider this. However, existing text already has exactly this one
> unquoted, so I just did the same. Hopefully it will be fixed altogether
> later, or are you positive I better resend the patch with quotes?=20
>=20
> >> =20
> >>  -q::
> >>  --quiet::
> >> diff --git a/builtin/clean.c b/builtin/clean.c
> >> index d90766cad3a0..fcc50d08ee9b 100644
> >> --- a/builtin/clean.c
> >> +++ b/builtin/clean.c
> >> @@ -25,7 +25,7 @@
> >>  #include "help.h"
> >>  #include "prompt.h"
> >> =20
> >> -static int force =3D -1; /* unset */
> >> +static int require_force =3D -1; /* unset */
> >>  static int interactive;
> >>  static struct string_list del_list =3D STRING_LIST_INIT_DUP;
> >>  static unsigned int colopts;
> >> @@ -128,7 +128,7 @@ static int git_clean_config(const char *var, const=
=20
char *value,
> >>  	}
> >> =20
> >>  	if (!strcmp(var, "clean.requireforce")) {
> >> -		force =3D !git_config_bool(var, value);
> >> +		require_force =3D git_config_bool(var, value);
> >>  		return 0;
> >>  	}
> >> =20
> >> @@ -920,7 +920,7 @@ int cmd_clean(int argc, const char **argv, const c=
har=20
*prefix)
> >>  {
> >>  	int i, res;
> >>  	int dry_run =3D 0, remove_directories =3D 0, quiet =3D 0, ignored =
=3D 0;
> >> -	int ignored_only =3D 0, config_set =3D 0, errors =3D 0, gone =3D 1;
> >> +	int ignored_only =3D 0, force =3D 0, errors =3D 0, gone =3D 1;
> >>  	int rm_flags =3D REMOVE_DIR_KEEP_NESTED_GIT;
> >>  	struct strbuf abs_path =3D STRBUF_INIT;
> >>  	struct dir_struct dir =3D DIR_INIT;
> >> @@ -946,21 +946,21 @@ int cmd_clean(int argc, const char **argv, const=
=20
char *prefix)
> >>  	};
> >> =20
> >>  	git_config(git_clean_config, NULL);
> >> -	if (force < 0)
> >> -		force =3D 0;
> >> -	else
> >> -		config_set =3D 1;
> >> =20
> >>  	argc =3D parse_options(argc, argv, prefix, options,=20
builtin_clean_usage,
> >>  			     0);
> >> =20
> >> -	if (!interactive && !dry_run && !force) {
> >> -		if (config_set)
> >> -			die(_("clean.requireForce set to true and=20
neither -i, -n, nor -f given; "
> >> +	/* Dry run won't remove anything, so requiring force makes no=20
sense */
> >> +	if(dry_run)
> >> +		require_force =3D 0;
> >> +
> >> +	if (!force && !interactive) {
> >> +		if (require_force > 0)
> >> +			die(_("clean.requireForce set to true and=20
neither -f, nor -i given; "
> >> +				  "refusing to clean"));
> >> +		else if (require_force < 0)
> >> +			die(_("clean.requireForce defaults to true=20
and neither -f, nor -i given; "
> >>  				  "refusing to clean"));
> >> -		else
> >> -			die(_("clean.requireForce defaults to true=20
and neither -i, -n, nor -f given;"
> >> -				  " refusing to clean"));
> >>  	}
> >> =20
> >
> > The last two cases can be coalesced into a single case (the last one),
> > because the difference in the messages does not bring more information
> > to the user.
>=20
> Did you misread the patch? There are only 2 cases here, the last (third)
> one is marked with '-' (removed). Too easy to misread this, I'd say. New
> code is:
>=20
> 		if (require_force > 0)
> 			die(_("clean.requireForce set to true and=20
neither -f, nor -i given; "
> 				  "refusing to clean"));
> 		else if (require_force < 0)
> 			die(_("clean.requireForce defaults to true=20
and neither -f, nor -i given; "
>=20
> and is basically unchanged from the original, except reference to '-n' ha=
s=20
been
> removed. Btw, is now comma needed after -f, and isn't it better to
> substitute ':' for ';'?
>=20
> Thank you for review!
>=20
> -- Sergey Organov
>=20
>=20

Oh, sorry, I misinterpreted the patch. But yet, I'm not sure that specifyin=
g=20
that this is the default or not is really useful. If the configuration was =
set=20
to true, it is was a no-op. If set to false, no message will appear.




