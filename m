From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-svn: add --ignore-paths option for fetching
Date: Sun, 25 Jan 2009 15:21:05 +0100
Message-ID: <200901251521.15591.trast@student.ethz.ch>
References: <1232864842-8841-1-git-send-email-public_vi@tut.by>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6534273.s38ksKZvR8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
X-From: git-owner@vger.kernel.org Sun Jan 25 15:22:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR5sa-0004sM-Dd
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 15:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbZAYOVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 09:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755299AbZAYOVE
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 09:21:04 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:41744 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754957AbZAYOVD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 09:21:03 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 25 Jan 2009 15:21:00 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 25 Jan 2009 15:21:00 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <1232864842-8841-1-git-send-email-public_vi@tut.by>
X-OriginalArrivalTime: 25 Jan 2009 14:21:00.0289 (UTC) FILETIME=[257FC710:01C97EF8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107062>

--nextPart6534273.s38ksKZvR8
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Vitaly "_Vi" Shukela wrote:
>=20
> Signed-off-by: Vitaly "_Vi" Shukela <public_vi@tut.by>

This would be a good place to explain why this is useful, and (if
applicable) why you chose to implement it the way you did.

> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -96,6 +96,10 @@ COMMANDS
>  	Store Git commit times in the local timezone instead of UTC.  This
>  	makes 'git-log' (even without --date=3Dlocal) show the same times
>  	that `svn log` would in the local timezone.
> +--ignore-paths=3D<regex>;;
> +	This allows one to specify regular expression that will
> +	cause skipping of all matching paths from checkout from SVN.
> +	Example: --ignore-paths=3D'^doc'
> =20
>  This doesn't interfere with interoperating with the Subversion
>  repository you cloned from, but if you wish for your local Git

You put the --ignore-paths explanation in the middle of the
=2D-localtime documentation (the last paragraph quoted still talks about
=2D-localtime).

> @@ -3245,6 +3246,15 @@ use warnings;
>  use Carp qw/croak/;
>  use File::Temp qw/tempfile/;
>  use IO::File qw//;
> +use vars qw/ $ignoreRegex/;
> +
> +# 0 -- don't ignore, 1 -- ignore
> +sub isPathIgnored($) {
> +    return 0 unless defined($ignoreRegex);
> +    my $path =3D shift;
> +    return 1 if $path =3D~ m!^$ignoreRegex!o;
> +    return 0;
> +}

This is the first function in git-svn.perl using camelCase.  Consider
sticking to the current style and spelling it is_path_ignored().

> @@ -3372,11 +3384,14 @@ sub add_file {
>  	my ($self, $path, $pb, $cp_path, $cp_rev) =3D @_;
>  	my $mode;
> =20
> +	goto out if isPathIgnored($path);
> +
>  	if (!in_dot_git($path)) {
>  		my ($dir, $file) =3D ($path =3D~ m#^(.*?)/?([^/]+)$#);
>  		delete $self->{empty}->{$dir};
>  		$mode =3D '100644';
>  	}
> +out:
>  	{ path =3D> $path, mode_a =3D> $mode, mode_b =3D> $mode,
>  	  pool =3D> SVN::Pool->new, action =3D> 'A' };
>  }

You broke the symmetry here, while all other hunks just add an
equivalent check to the existing in_dot_git().

However, the latter makes me wonder if it would be cleaner to move the
in_dot_git() test to isPathIgnored (er, is_path_ignored) too?


=46WIW, I like the feature; it seems a good way to exclude subtrees with
large blobs, and I know several SVN repos that have such a directory.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart6534273.s38ksKZvR8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl8dVsACgkQqUud07tmzP2NaQCgiHl8Mm4FZ80/BA5D4OMiQbKN
sVcAn1o01DqubZ2dhpyTYohRSACvaL8B
=KhlR
-----END PGP SIGNATURE-----

--nextPart6534273.s38ksKZvR8--
