From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] send-email: do not barf when Term::ReadLine does not
 like your terminal
Date: Mon, 03 Jul 2006 18:44:44 -0700
Message-ID: <44A9C80C.90407@michonline.com>
References: <7vpsgn1ue8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC52772B77E83B7653000EC21"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 03:45:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxZym-0001f5-HQ
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 03:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWGDBp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 21:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWGDBp3
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 21:45:29 -0400
Received: from h4x0r5.com ([70.85.31.202]:1809 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751220AbWGDBp3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 21:45:29 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythryan.michonline.com)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FxZyd-0004Vg-0F; Mon, 03 Jul 2006 18:45:23 -0700
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.62)
	(envelope-from <ryan@michonline.com>)
	id 1FxZy7-0003JO-SB; Mon, 03 Jul 2006 18:44:51 -0700
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsgn1ue8.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23236>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC52772B77E83B7653000EC21
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> As long as we do not need to readline from the terminal, we
> should not barf when starting up the program.  Without this
> patch, t9001 test on Cygwin occasionally died with the following
> error message:
>
> Unable to get Terminal Size. The TIOCGWINSZ ioctl didn't work. The COLU=
MNS and LINES environment variables didn't work. The resize program didn'=
t work. at /usr/lib/perl5/vendor_perl/5.8/cygwin/Term/ReadKey.pm line 362=
=2E
> Compilation failed in require at /usr/lib/perl5/vendor_perl/5.8/Term/Re=
adLine/Perl.pm line 58.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
>
>  * I do not use send-email myself that often so extra sets of
>    eyeballs are appreciated.
>  =20
Looks fine to me.

Acked-by: Ryan Anderson <ryan@michonline.com>

(I personally would have put the package declaration at the end of the
file, but it's not significant enough for me to send a patch, heh.)


>  git-send-email.perl   |   18 +++++++++++++++++-
>  t/t9001-send-email.sh |   11 +++++++----
>  2 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index c5d9e73..b04b8f4 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -22,6 +22,17 @@ use Term::ReadLine;
>  use Getopt::Long;
>  use Data::Dumper;
> =20
> +package FakeTerm;
> +sub new {
> +	my ($class, $reason) =3D @_;
> +	return bless \$reason, shift;
> +}
> +sub readline {
> +	my $self =3D shift;
> +	die "Cannot use readline on FakeTerm: $$self";
> +}
> +package main;
> +
>  # most mail servers generate the Date: header, but not all...
>  $ENV{LC_ALL} =3D 'C';
>  use POSIX qw/strftime/;
> @@ -46,7 +57,12 @@ my $smtp_server;
>  # Example reply to:
>  #$initial_reply_to =3D ''; #<20050203173208.GA23964@foobar.com>';
> =20
> -my $term =3D new Term::ReadLine 'git-send-email';
> +my $term =3D eval {
> +	new Term::ReadLine 'git-send-email';
> +};
> +if ($@) {
> +	$term =3D new FakeTerm "$@: going non-interactive";
> +}
> =20
>  # Begin by accumulating all the variables (defined above), that we wil=
l end up
>  # needing, first, from the command line:
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index a61da1e..e9ea33c 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -25,10 +25,13 @@ test_expect_success \
>       git add fake.sendmail
>       GIT_AUTHOR_NAME=3D"A" git commit -a -m "Second."'
> =20
> -test_expect_success \
> -    'Extract patches and send' \
> -    'git format-patch -n HEAD^1
> -     git send-email -from=3D"Example <nobody@example.com>" --to=3Dnobo=
dy@example.com --smtp-server=3D"$(pwd)/fake.sendmail" ./0001*txt'
> +test_expect_success 'Extract patches' '
> +    patches=3D`git format-patch -n HEAD^1`
> +'
> +
> +test_expect_success 'Send patches' '
> +     git send-email -from=3D"Example <nobody@example.com>" --to=3Dnobo=
dy@example.com --smtp-server=3D"$(pwd)/fake.sendmail" $patches 2>errors
> +'
> =20
>  cat >expected <<\EOF
>  !nobody@example.com!
>  =20


--=20

Ryan Anderson
  sometimes Pug Majere



--------------enigC52772B77E83B7653000EC21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqcgTfhVDhkBuUKURAmkCAKCjoYUxJj2GacJufmF/+hV3iq3O1gCfQdtb
sgc2jCo2G/ZGfB+V/r2P7E0=
=H6vO
-----END PGP SIGNATURE-----

--------------enigC52772B77E83B7653000EC21--
