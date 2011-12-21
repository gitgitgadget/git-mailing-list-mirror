From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] git-commit: add option --date-now
Date: Wed, 21 Dec 2011 15:38:37 +0000
Message-ID: <20111221153837.GC2160@beez.lab.cmartin.tk>
References: <4EF1F3AB.5080607@elegosoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Cc: git <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 16:38:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdOFj-0001xg-3h
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 16:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab1LUPim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 10:38:42 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:44082 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab1LUPil (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 10:38:41 -0500
Received: from beez.lab.cmartin.tk (145.Red-81-38-112.dynamicIP.rima-tde.net [81.38.112.145])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 518A1461B4;
	Wed, 21 Dec 2011 16:38:33 +0100 (CET)
Received: (nullmailer pid 11468 invoked by uid 1000);
	Wed, 21 Dec 2011 15:38:37 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>, git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4EF1F3AB.5080607@elegosoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187568>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2011 at 03:56:43PM +0100, Michael Schubert wrote:
> Currently, Git doesn't provide an easy way to use the current date when
> amending a commit or reusing an existing commmit with -C/-c. Therefore,
> add --date-now.

The option --reset-author also resets the date. So 'git commit
--ammend --reset-author' does what 'git commit --amend --date-now'
would do in most cases. I was surpised when I tried 'git commit
--amend --date=3Dnow' that git didn't understand 'now' as a date, which
seems like a more obvious place to fix it.

>=20
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
> ---
>  Documentation/git-commit.txt |    7 +++++--
>  builtin/commit.c             |    9 ++++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 5cc84a1..b7c6f0d 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -12,8 +12,8 @@ SYNOPSIS
>  	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=3D<author>]
> -	   [--date=3D<date>] [--cleanup=3D<mode>] [--status | --no-status]
> -	   [-i | -o] [--] [<file>...]
> +	   [--date=3D<date> | --date-now] [--cleanup=3D<mode>]
> +	   [--status | --no-status] [-i | -o] [--] [<file>...]
> =20
>  DESCRIPTION
>  -----------
> @@ -126,6 +126,9 @@ OPTIONS
>  --date=3D<date>::
>  	Override the author date used in the commit.
> =20
> +--date-now
> +	Override the author date used in the commit with the current local time.
> +
>  -m <msg>::
>  --message=3D<msg>::
>  	Use the given <msg> as the commit message.
> diff --git a/builtin/commit.c b/builtin/commit.c
> index be1ab2e..28fdf1a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -82,6 +82,7 @@ static const char *author_message, *author_message_buff=
er;
>  static char *edit_message, *use_message;
>  static char *fixup_message, *squash_message;
>  static int all, also, interactive, patch_interactive, only, amend, signo=
ff;
> +static int date_now;
>  static int edit_flag =3D -1; /* unspecified */
>  static int quiet, verbose, no_verify, allow_empty, dry_run, renew_author=
ship;
>  static int no_post_rewrite, allow_empty_message;
> @@ -134,6 +135,7 @@ static struct option builtin_commit_options[] =3D {
>  	OPT_FILENAME('F', "file", &logfile, "read message from file"),
>  	OPT_STRING(0, "author", &force_author, "author", "override author for c=
ommit"),
>  	OPT_STRING(0, "date", &force_date, "date", "override date for commit"),
> +	OPT_BOOLEAN(0, "date-now", &date_now, "override date for commit with cu=
rrent local time"),
>  	OPT_CALLBACK('m', "message", &message, "message", "commit message", opt=
_parse_m),
>  	OPT_STRING('c', "reedit-message", &edit_message, "commit", "reuse and e=
dit message from specified commit"),
>  	OPT_STRING('C', "reuse-message", &use_message, "commit", "reuse message=
 from specified commit"),
> @@ -557,7 +559,9 @@ static void determine_author_info(struct strbuf *auth=
or_ident)
>  					(lb - strlen(" ") -
>  					 (a + strlen("\nauthor "))));
>  		email =3D xmemdupz(lb + strlen("<"), rb - (lb + strlen("<")));
> -		date =3D xmemdupz(rb + strlen("> "), eol - (rb + strlen("> ")));
> +		if (!date_now)
> +			date =3D xmemdupz(rb + strlen("> "),
> +					eol - (rb + strlen("> ")));
>  	}
> =20
>  	if (force_author) {
> @@ -1018,6 +1022,9 @@ static int parse_and_validate_options(int argc, con=
st char *argv[],
>  	if (force_author && renew_authorship)
>  		die(_("Using both --reset-author and --author does not make sense"));
> =20
> +	if (force_date && date_now)
> +		die(_("Using both --date and --date-now does not make sense"));
> +
>  	if (logfile || message.len || use_message || fixup_message)
>  		use_editor =3D 0;
>  	if (0 <=3D edit_flag)
> --=20
> 1.7.8.521.g64725
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO8f19AAoJEHKRP1jG7ZzTsoUH/Rp2PIrPYvea9NSJcAqzJKyH
u8qEt66mfet5nR0aFDHw7R9+5xG99+lHbCUmvGPe4r1bTO21qfJ35WuJ5QaxnDoE
URCa7/Jicv2FoEG7tAUf2V+8D4bt8HLsMTWLClHLtNnFhgZH+yS9X6ukQFaITVCf
h3Py7k+XVrzQ4Ve9DMlRSd5+fL/KPB27+J3Yae46IjV+bhRtnHq1UTZJaV2wnTWY
cicC6VnA1S6E9rY02sLSfUzJezL5dYylNXq73GHdA+AXjCjLpx+j3CionuWE7nwY
vbztQTHOfuURayZUE+1t7WcQNfqKKIAG+MvYXmje7m1jlxVVov1MVVZyvvhA72A=
=URgO
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
