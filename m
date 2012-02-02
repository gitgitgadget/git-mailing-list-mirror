From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC (version B)] gitweb: Allow UTF-8 encoded CGI query parameters and  path_info
Date: Thu, 2 Feb 2012 21:10:06 +0100
Message-ID: <201202022110.07127.jnareb@gmail.com>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com> <m37h05c8c1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:09:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2yK-0007PR-2K
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333Ab2BBUJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 15:09:27 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49687 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab2BBUJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:09:26 -0500
Received: by eekc14 with SMTP id c14so900453eek.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 12:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=6uF12/CiKOCKdkB7WmLzgb4SDGmkCmi5wTKGplTRuSo=;
        b=ZqIJ552y5cIA/+eORFWJ4490U8z1lgu32xKk36UPGOSX32Xp7+hY6n1RQrDv6GaPuQ
         9EpB1lpHHC1N3xcbqWCQrQllWT95taqENAG4Zau8fQIbuAecp2IipwEyqZSgkNVamF6K
         hYnbzq5qUC/ecG0f75ebUpWdDf/w/h4jEeTvc=
Received: by 10.14.47.68 with SMTP id s44mr1352505eeb.11.1328213365551;
        Thu, 02 Feb 2012 12:09:25 -0800 (PST)
Received: from [192.168.1.13] (abwd54.neoplus.adsl.tpnet.pl. [83.8.227.54])
        by mx.google.com with ESMTPS id e12sm12909601eea.5.2012.02.02.12.09.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:09:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <m37h05c8c1.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189693>

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

This is done when filling %input_params hash; this required to move
from explicit $cgi->param(<label>) to $input_params{<name>} in a few
places.

Alternate solution would be to simply use the '-utf8' pragma (via
"use CGI '-utf8';"), but according to CGI.pm documentation it may
cause problems with POST requests containing binary files... and
it doesn't work with old CGI.pm version 3.10 from Perl v5.8.6.

Noticed-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9cf7e71..55b2c24 100755
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
@@ -5282,7 +5282,7 @@ sub git_project_list_body {
=20
 	my $check_forks =3D gitweb_check_feature('forks');
 	my $show_ctags  =3D gitweb_check_feature('ctags');
-	my $tagfilter =3D $show_ctags ? $cgi->param('by_tag') : undef;
+	my $tagfilter =3D $show_ctags ? $input_params{'ctag'} : undef;
 	$check_forks =3D undef
 		if ($tagfilter || $searchtext);
=20
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
