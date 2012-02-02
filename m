From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH/RFC (version B)] gitweb: Allow UTF-8 encoded CGI query
 parameters and  path_info
Date: Thu, 2 Feb 2012 21:46:46 +0100
Message-ID: <20120202214646.1b84f23e@gmail.com>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com>
	<m37h05c8c1.fsf@localhost.localdomain>
	<201202022110.07127.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:46:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt3YY-00075f-Ib
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab2BBUqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 15:46:54 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57665 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab2BBUqx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 15:46:53 -0500
Received: by eekc14 with SMTP id c14so912602eek.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 12:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=NZbMfI6A45dB/TJMgCWyXwLJtroGwrAcc8ohkN/JVk8=;
        b=QovPjMHelrD9PBlYGyqAqZFIBXZeS86HwbCUdYYwIkVlMtLAvKEXG8xSdaprMenoLi
         gzDvvmgbrC8cBKdvwk6oymotHciWgkrexAoHaUEudQhAt6/0j+y9fS3XZkVA2IKXih5N
         6fWY/qRK0mFkoYBsqInemZyzXBWg5aXIUYl10=
Received: by 10.14.99.2 with SMTP id w2mr1404847eef.69.1328215611121;
        Thu, 02 Feb 2012 12:46:51 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id b3sm13319268een.2.2012.02.02.12.46.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:46:50 -0800 (PST)
In-Reply-To: <201202022110.07127.jnareb@gmail.com>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189706>

Jakub Narebski <jnareb@gmail.com> wrote:

> Gitweb tries hard to properly process UTF-8 data, by marking output
> from git commands and contents of files as UTF-8 with to_utf8()
> subroutine.  This ensures that gitweb would print correctly UTF-8
> e.g. in 'log' and 'commit' views.
>=20
> Unfortunately it misses another source of potentially Unicode input,
> namely query parameters.  The result is that one cannot search for a
> string containing characters outside US-ASCII.  For example searching
> for "Micha=C5=82 Kiedrowicz" (containing letter '=C5=82' - LATIN SMAL=
L LETTER L
> WITH STROKE, with Unicode codepoint U+0142, represented with 0xc5 0x8=
2
> bytes in UTF-8 and percent-encoded as %C5%81) result in the following
> incorrect data in search field
>=20
> 	Micha=C3=85=C2=82 Kiedrowicz
>=20
> This is caused by CGI by default treating '0xc5 0x82' bytes as two
> characters in Perl legacy encoding latin-1 (iso-8859-1), because 's'
> query parameter is not processed explicitly as UTF-8 encoded string.
>=20
> The solution used here follows "Using Unicode in a Perl CGI script"
> article on http://www.lemoda.net/cgi/perl-unicode/index.html:
>=20
> 	use CGI;
> 	use Encode 'decode_utf8;
> 	my $value =3D params('input');
> 	$value =3D decode_utf8($value);
>=20
> This is done when filling %input_params hash; this required to move
> from explicit $cgi->param(<label>) to $input_params{<name>} in a few
> places.

I'm sorry but this doesn't work for me. I would be happy to help if you
have some questions about it.

>=20
> Alternate solution would be to simply use the '-utf8' pragma (via
> "use CGI '-utf8';"), but according to CGI.pm documentation it may
> cause problems with POST requests containing binary files... and
> it doesn't work with old CGI.pm version 3.10 from Perl v5.8.6.
>=20
> Noticed-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9cf7e71..55b2c24 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -52,7 +52,7 @@ sub evaluate_uri {
>  	# as base URL.
>  	# Therefore, if we needed to strip PATH_INFO, then we know that we =
have
>  	# to build the base URL ourselves:
> -	our $path_info =3D $ENV{"PATH_INFO"};
> +	our $path_info =3D decode_utf8($ENV{"PATH_INFO"});
>  	if ($path_info) {
>  		if ($my_url =3D~ s,\Q$path_info\E$,, &&
>  		    $my_uri =3D~ s,\Q$path_info\E$,, &&
> @@ -816,9 +816,9 @@ sub evaluate_query_params {
> =20
>  	while (my ($name, $symbol) =3D each %cgi_param_mapping) {
>  		if ($symbol eq 'opt') {
> -			$input_params{$name} =3D [ $cgi->param($symbol) ];
> +			$input_params{$name} =3D [ map { decode_utf8($_) } $cgi->param($s=
ymbol) ];
>  		} else {
> -			$input_params{$name} =3D $cgi->param($symbol);
> +			$input_params{$name} =3D decode_utf8($cgi->param($symbol));
>  		}
>  	}
>  }
> @@ -2767,7 +2767,7 @@ sub git_populate_project_tagcloud {
>  	}
> =20
>  	my $cloud;
> -	my $matched =3D $cgi->param('by_tag');
> +	my $matched =3D $input_params{'ctag'};
>  	if (eval { require HTML::TagCloud; 1; }) {
>  		$cloud =3D HTML::TagCloud->new;
>  		foreach my $ctag (sort keys %ctags_lc) {
> @@ -5282,7 +5282,7 @@ sub git_project_list_body {
> =20
>  	my $check_forks =3D gitweb_check_feature('forks');
>  	my $show_ctags  =3D gitweb_check_feature('ctags');
> -	my $tagfilter =3D $show_ctags ? $cgi->param('by_tag') : undef;
> +	my $tagfilter =3D $show_ctags ? $input_params{'ctag'} : undef;
>  	$check_forks =3D undef
>  		if ($tagfilter || $searchtext);
> =20
> @@ -6197,7 +6197,7 @@ sub git_tag {
> =20
>  sub git_blame_common {
>  	my $format =3D shift || 'porcelain';
> -	if ($format eq 'porcelain' && $cgi->param('js')) {
> +	if ($format eq 'porcelain' && $input_params{'javascript'}) {
>  		$format =3D 'incremental';
>  		$action =3D 'blame_incremental'; # for page title etc
>  	}
