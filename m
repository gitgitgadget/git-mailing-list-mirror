From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] git-svn: Simplify calculation of GIT_DIR
Date: Sat, 03 Mar 2012 19:27:13 +0100
Message-ID: <1330799233.691.40.camel@centaur.lab.cmartin.tk>
References: <1330798107-33561-1-git-send-email-barry.wardell@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-/oAJmVES1xv0M8TB2VCy"
Cc: git@vger.kernel.org
To: Barry Wardell <barry.wardell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 19:27:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3tfw-0004n1-JW
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 19:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab2CCS0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 13:26:49 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:58287 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147Ab2CCS0t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 13:26:49 -0500
Received: from [192.168.1.17] (brln-4db9cfc3.pool.mediaWays.net [77.185.207.195])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 2AB7246082;
	Sat,  3 Mar 2012 19:26:39 +0100 (CET)
In-Reply-To: <1330798107-33561-1-git-send-email-barry.wardell@gmail.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192128>


--=-/oAJmVES1xv0M8TB2VCy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-03-03 at 18:08 +0000, Barry Wardell wrote:
> Since git-rev-parse already checks for the $GIT_DIR environment
> variable and that it returns an actual git repository, there is no
> need to repeat the checks again here.
>=20
> This also fixes a problem where git-svn did not work in cases where
> .git was a file with a gitdir: link.
> ---
>  git-svn.perl |   25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index 4334b95..cf2cef8 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -15,8 +15,6 @@ my $cmd_dir_prefix =3D eval {
>  	command_oneline([qw/rev-parse --show-prefix/], STDERR =3D> 0)
>  } || '';
> =20
> -my $git_dir_user_set =3D 1 if defined $ENV{GIT_DIR};
> -$ENV{GIT_DIR} ||=3D '.git';
>  $Git::SVN::default_repo_id =3D 'svn';
>  $Git::SVN::default_ref_id =3D $ENV{GIT_SVN_ID} || 'git-svn';
>  $Git::SVN::Ra::_log_window_size =3D 100;
> @@ -290,28 +288,9 @@ for (my $i =3D 0; $i < @ARGV; $i++) {
>  	}
>  };
> =20
> -# make sure we're always running at the top-level working directory
> +# Access an existing repository

Is there a reason making sure we're at the top-level dir isn't necessary
anymore?

>  unless ($cmd && $cmd =3D~ /(?:clone|init|multi-init)$/) {
> -	unless (-d $ENV{GIT_DIR}) {
> -		if ($git_dir_user_set) {
> -			die "GIT_DIR=3D$ENV{GIT_DIR} explicitly set, ",
> -			    "but it is not a directory\n";
> -		}
> -		my $git_dir =3D delete $ENV{GIT_DIR};
> -		my $cdup =3D undef;
> -		git_cmd_try {
> -			$cdup =3D command_oneline(qw/rev-parse --show-cdup/);
> -			$git_dir =3D '.' unless ($cdup);
> -			chomp $cdup if ($cdup);
> -			$cdup =3D "." unless ($cdup && length $cdup);
> -		} "Already at toplevel, but $git_dir not found\n";
> -		chdir $cdup or die "Unable to chdir up to '$cdup'\n";

Here you delete a chdir to the top-level directory, just as you deleted
the comment above, yet in the commit message you don't explain why this
isn't necessary anymore. Doesn't the rest of the code still assume that
it's running at the top-level dir?

> -		unless (-d $git_dir) {
> -			die "$git_dir still not found after going to ",
> -			    "'$cdup'\n";
> -		}
> -		$ENV{GIT_DIR} =3D $git_dir;
> -	}
> +	$ENV{GIT_DIR} =3D command_oneline([qw/rev-parse --git-dir/]);
>  	$_repository =3D Git->repository(Repository =3D> $ENV{GIT_DIR});
>  }
> =20



--=-/oAJmVES1xv0M8TB2VCy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJPUmKBAAoJEHKRP1jG7ZzTsEoIAIMqFpEQNmpItcHqQWP9uNcB
mN14SCA1KAfM5jUo2BZ/dXXl3ZOvPGeK7xwpvjQp9mj8Cy0Im3Q0zAWGd3AEAV7u
N/iFyKJJ/MlqcoWqoIsrMFssL0OhlntzlI4IZlcMMID7IUGzmDw10KUkT7HsOnfz
gwghNpz6xX17e8rsJ2BbZWiOQ2sIj5xBYHBaU5dNMjOyfACOA/A1mDKhh80WPdua
pz8bovS0faQR4HZaHpdyXpUeZDd4w4wbGTQFDTxQ0QIb+0I3u2LjTKNHYXbXb1EH
/RYisQSPrGxbGF8cZ18DOobJINnfU9oyhjXekGINP3J8LTFSfmeClhtwDkusOak=
=Ejrm
-----END PGP SIGNATURE-----

--=-/oAJmVES1xv0M8TB2VCy--
