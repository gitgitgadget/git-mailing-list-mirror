From: Michael Wagner <mail@mwagner.org>
Subject: Re: [PATCH] gitweb: Harden UTF-8 handling in generated links
Date: Wed, 4 Jun 2014 17:41:29 +0200
Message-ID: <20140604154128.GA28549@localhost.localdomain>
References: <20140514184145.GA25699@localhost.localdomain>
 <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
 <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
 <20140515050820.GA30785@localhost.localdomain>
 <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
 <20140515184808.GA7964@localhost.localdomain>
 <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
 <53849FB2.7000701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 18:00:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsDbc-0000bQ-IM
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 18:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbaFDP7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 11:59:17 -0400
Received: from caelum.uberspace.de ([95.143.172.212]:47397 "EHLO
	caelum.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbaFDP7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 11:59:16 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jun 2014 11:59:16 EDT
Received: (qmail 5689 invoked from network); 4 Jun 2014 15:52:33 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by caelum.uberspace.de with SMTP; 4 Jun 2014 15:52:33 -0000
Content-Disposition: inline
In-Reply-To: <53849FB2.7000701@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250745>

On Tue, May 27, 2014 at 04:22:42PM +0200, Jakub Nar=C4=99bski wrote:
> W dniu 2014-05-15 21:28, Jakub Nar=C4=99bski pisze:
> > On Thu, May 15, 2014 at 8:48 PM, Michael Wagner <accounts@mwagner.o=
rg> wrote:
> >> On Thu, May 15, 2014 at 10:04:24AM +0100, Peter Krefting wrote:
> >>> Michael Wagner:
>=20
> >> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> >> index a9f57d6..f1414e1 100755
> >> --- a/gitweb/gitweb.perl
> >> +++ b/gitweb/gitweb.perl
> >> @@ -7138,7 +7138,7 @@ sub git_tree {
> >>          my @entries =3D ();
> >>          {
> >>                  local $/ =3D "\0";
> >> -               open my $fd, "-|", git_cmd(), "ls-tree", '-z',
> >> +               open my $fd, "-|encoding(UTF-8)", git_cmd(), "ls-t=
ree", '-z',
> >>                          ($show_sizes ? '-l' : ()), @extra_options=
, $hash
> >>                          or die_error(500, "Open git-ls-tree faile=
d");
> >=20
> > Or put
> >=20
> >                     binmode $fd, ':utf8';
> >=20
> > like in the rest of the code.
> >=20
> >>                  @entries =3D map { chomp; $_ } <$fd>;
> >>
> >=20
> > Even better solution would be to use
> >=20
> >      use open IN =3D> ':encoding(utf-8)';
> >=20
> > at the beginning of gitweb.perl, once and for all.
>=20
> Or harden esc_param / esc_path_info the same way esc_html
> is hardened against missing ':utf8' flag.
>=20
> -- >8 --=20
> Subject: [PATCH] gitweb: Harden UTF-8 handling in generated links
>=20
> esc_html() ensures that its input is properly UTF-8 encoded and marke=
d
> as UTF-8 with to_utf8().  Make esc_param() (used for query parameters
> in generated URLs), esc_path_info() (for escaping path_info
> components) and esc_url() use it too.
>=20
> This hardens gitweb against errors in UTF-8 handling; because
> to_utf8() is idempotent it won't change correct output.
>=20
> Reported-by: Michael Wagner <accounts@mwagner.org>
> Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a9f57d6..77e1312 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1548,8 +1548,11 @@ sub to_utf8 {
>  sub esc_param {
>  	my $str =3D shift;
>  	return undef unless defined $str;
> +
> +	$str =3D to_utf8($str);
>  	$str =3D~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
>  	$str =3D~ s/ /\+/g;
> +
>  	return $str;
>  }
> =20
> @@ -1558,6 +1561,7 @@ sub esc_path_info {
>  	my $str =3D shift;
>  	return undef unless defined $str;
> =20
> +	$str =3D to_utf8($str);
>  	# path_info doesn't treat '+' as space (specially), but '?' must be=
 escaped
>  	$str =3D~ s/([^A-Za-z0-9\-_.~();\/;:@&=3D +]+)/CGI::escape($1)/eg;
> =20
> @@ -1568,8 +1572,11 @@ sub esc_path_info {
>  sub esc_url {
>  	my $str =3D shift;
>  	return undef unless defined $str;
> +
> +	$str =3D to_utf8($str);
>  	$str =3D~ s/([^A-Za-z0-9\-_.~();\/;?:@&=3D ]+)/CGI::escape($1)/eg;
>  	$str =3D~ s/ /\+/g;
> +
>  	return $str;
>  }
> =20
> --=20
> 1.7.1
>=20
>=20

While trying to view a "blob_plain" of "G=C3=BCtekritierien.txt", a 404=
 error
occured. "git_get_hash_by_path" tries to resolve the hash with the wron=
g
filename (git ls-tree -z HEAD -- G=C3=83=C2=BCtekriterien.txt) and fail=
s.

The filename needs the correct encoding. Something like this is probabl=
y
needed for all filenames and should be done at a prior stage:
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 77e1312..e4a50e7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4725,7 +4725,7 @@ sub git_print_tree_entry {
                }
                print " | " .
                        $cgi->a({-href =3D> href(action=3D>"blob_plain"=
, hash_base=3D>$hash_base,
-                                              file_name=3D>"$basedir$t=
->{'name'}")},
+                                              file_name=3D>"$basedir" =
=2E to_utf8($t->{'name'}))},=20
                                "raw");
                print "</td>\n";

--=20
1.7.1
