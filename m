From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFCv2 (version B)] gitweb: Allow UTF-8 encoded CGI query parameters and  path_info
Date: Fri, 3 Feb 2012 13:44:54 +0100
Message-ID: <201202031344.55750.jnareb@gmail.com>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com> <201202022357.29569.jnareb@gmail.com> <20120203083935.5d9d4b18@mkiedrowicz.ivo.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 13:44:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtIVR-0001Bf-KB
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 13:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab2BCMoR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 07:44:17 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50686 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab2BCMoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 07:44:16 -0500
Received: by eekc14 with SMTP id c14so1128297eek.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 04:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=vyb773AlkQKMtD4D0s8gM/FuVlPITbzAEpQrWyutKvY=;
        b=deeH6GXmBNJW/KE076LT4fonC5XM7xOSUZPGT+cy/fqDn8OFRAFIQK2myIE5y24akp
         U4m24CyfpT04h/cuVXkMLK14YiRFbQein5R+ehR9VRonepe0OeyJUHRnTrjuOgBXZX3A
         NX0O4i7QPWnBHd6uAvxAyDtgGyenxCLbVkuYQ=
Received: by 10.14.135.140 with SMTP id u12mr2213936eei.73.1328273054489;
        Fri, 03 Feb 2012 04:44:14 -0800 (PST)
Received: from [192.168.1.13] (abvn4.neoplus.adsl.tpnet.pl. [83.8.211.4])
        by mx.google.com with ESMTPS id o49sm21501175eeb.7.2012.02.03.04.44.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 04:44:13 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120203083935.5d9d4b18@mkiedrowicz.ivo.pl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189755>

Gitweb tries hard to properly process UTF-8 data, by marking output
from git commands and contents of files as UTF-8 with to_utf8()
subroutine.  This ensures that gitweb would print correctly UTF-8
e.g. in 'log' and 'commit' views.

Unfortunately it misses another source of potentially Unicode input,
namely query parameters.  The result is that one cannot search for a
string containing characters outside US-ASCII.  For example searching
for "Micha=C5=82 Kiedrowicz" (containing letter '=C5=82' - LATIN SMALL =
LETTER L
WITH STROKE, with Unicode codepoint U+0142, represented with 0xc5 0x82
bytes in UTF-8 and percent-encoded as %C5%81) result in the following
incorrect data in search field

	Micha=C3=85=C2=82 Kiedrowicz

This is caused by CGI by default treating '0xc5 0x82' bytes as two
characters in Perl legacy encoding latin-1 (iso-8859-1), because 's'
query parameter is not processed explicitly as UTF-8 encoded string.

The solution used here follows "Using Unicode in a Perl CGI script"
article on http://www.lemoda.net/cgi/perl-unicode/index.html:

	use CGI;
	use Encode 'decode_utf8;
	my $value =3D params('input');
	$value =3D decode_utf8($value);

Decoding UTF-8 is done when filling %input_params hash and $path_info
variable; the former required to move from explicit $cgi->param(<label>=
)
to $input_params{<name>} in a few places, which is a good idea anyway.

Another required change was to add -override=3D>1 parameter to
$cgi->textfield() invocation (in search form).  Otherwise CGI would
use values from query string if it is present, filling value from
$cgi->param... without decode_utf8().  As we are using value of
appropriate parameter anyway, -override=3D>1 doesn't change the
situation but makes gitweb fill search field correctly.

Alternate solution would be to simply use the '-utf8' pragma (via
"use CGI '-utf8';"), but according to CGI.pm documentation it may
cause problems with POST requests containing binary files... and
it requires CGI 3.31 (I think), released with perl v5.8.9.

Noticed-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
On Fri, 3 Feb 2012, Michal Kiedrowicz wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

> > Is it what you mean by "this doesn't work for me", i.e. working
> > search, garbage in search field?
>=20
> I mean "garbage in search field". Search works even without the patch
> (at least on Debian with git-1.7.7.3, perl-5.10.1 and CGI-3.43; I
> don't have my notebook nearby at the moment to check).
[...]

> > Damn.  If we use $cgi->textfield(-name =3D> "s", -value =3D> $searc=
htext)
> > like in gitweb, CGI.pm would read $cgi->param("s") by itself -
> > without decoding.=20
>=20
> Makes sense. When I tried calling to_utf8() in the line that defines
> textfield (this was my first approach to this problem), it haven't
> changed anything.

Yes, and it doesn't makes sense in gitweb case - we use value of=20
$cgi->param("s") as default value of text field anyway, but in
Unicode-aware way.
=20
> > To skip this we need to pass -force=3D>1  or
> > -override=3D>1 (i.e. further changes to gitweb).

This patch does this. =20

Does it make work for you?

> > -utf8 pragma works with more modern CGI.pm, but does not with 3.10.

-utf8 pragma was added in CVS revision 1.238 of CGI.pm, which I think
is present in CGI 3.31, released with perl v5.8.9.  Theoretically gitwe=
b
maintains backward compatibility with perl v5.8.3 or something=20
("use 5.008;" but IIRC 5.8.3 is needed for correct Unicde handling anyw=
ay).

 gitweb/gitweb.perl |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9cf7e71..bd5fff9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -52,7 +52,7 @@ sub evaluate_uri {
 	# as base URL.
 	# Therefore, if we needed to strip PATH_INFO, then we know that we ha=
ve
 	# to build the base URL ourselves:
-	our $path_info =3D $ENV{"PATH_INFO"};
+	our $path_info =3D decode_utf8($ENV{"PATH_INFO"});
 	if ($path_info) {
 		if ($my_url =3D~ s,\Q$path_info\E$,, &&
 		    $my_uri =3D~ s,\Q$path_info\E$,, &&
@@ -816,9 +816,9 @@ sub evaluate_query_params {
=20
 	while (my ($name, $symbol) =3D each %cgi_param_mapping) {
 		if ($symbol eq 'opt') {
-			$input_params{$name} =3D [ $cgi->param($symbol) ];
+			$input_params{$name} =3D [ map { decode_utf8($_) } $cgi->param($sym=
bol) ];
 		} else {
-			$input_params{$name} =3D $cgi->param($symbol);
+			$input_params{$name} =3D decode_utf8($cgi->param($symbol));
 		}
 	}
 }
@@ -2767,7 +2767,7 @@ sub git_populate_project_tagcloud {
 	}
=20
 	my $cloud;
-	my $matched =3D $cgi->param('by_tag');
+	my $matched =3D $input_params{'ctag'};
 	if (eval { require HTML::TagCloud; 1; }) {
 		$cloud =3D HTML::TagCloud->new;
 		foreach my $ctag (sort keys %ctags_lc) {
@@ -3873,7 +3873,7 @@ sub print_search_form {
 	                       -values =3D> ['commit', 'grep', 'author', 'com=
mitter', 'pickaxe']) .
 	      $cgi->sup($cgi->a({-href =3D> href(action=3D>"search_help")}, "=
?")) .
 	      " search:\n",
-	      $cgi->textfield(-name =3D> "s", -value =3D> $searchtext) . "\n"=
 .
+	      $cgi->textfield(-name =3D> "s", -value =3D> $searchtext, -overr=
ide =3D> 1) . "\n" .
 	      "<span title=3D\"Extended regular expression\">" .
 	      $cgi->checkbox(-name =3D> 'sr', -value =3D> 1, -label =3D> 're'=
,
 	                     -checked =3D> $search_use_regexp) .
@@ -5282,7 +5282,7 @@ sub git_project_list_body {
=20
 	my $check_forks =3D gitweb_check_feature('forks');
 	my $show_ctags  =3D gitweb_check_feature('ctags');
-	my $tagfilter =3D $show_ctags ? $cgi->param('by_tag') : undef;
+	my $tagfilter =3D $show_ctags ? $input_params{'ctag'} : undef;
 	$check_forks =3D undef
 		if ($tagfilter || $searchtext);
=20
@@ -5994,7 +5994,7 @@ sub git_project_list {
 	}
 	print $cgi->startform(-method =3D> "get") .
 	      "<p class=3D\"projsearch\">Search:\n" .
-	      $cgi->textfield(-name =3D> "s", -value =3D> $searchtext) . "\n"=
 .
+	      $cgi->textfield(-name =3D> "s", -value =3D> $searchtext, -overr=
ide =3D> 1) . "\n" .
 	      "</p>" .
 	      $cgi->end_form() . "\n";
 	git_project_list_body(\@list, $order);
@@ -6197,7 +6197,7 @@ sub git_tag {
=20
 sub git_blame_common {
 	my $format =3D shift || 'porcelain';
-	if ($format eq 'porcelain' && $cgi->param('js')) {
+	if ($format eq 'porcelain' && $input_params{'javascript'}) {
 		$format =3D 'incremental';
 		$action =3D 'blame_incremental'; # for page title etc
 	}
--=20
1.7.6
