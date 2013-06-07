From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 20/22] git-remote-mediawiki: Put non-trivial numeric values in constants.
Date: Fri,  7 Jun 2013 23:42:21 +0200
Message-ID: <1370641344-4253-21-git-send-email-celestin.matte@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4Rl-0008Pr-BD
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808Ab3FGVna convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:43:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55323 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756783Ab3FGVnY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:43:24 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57LhDJZ003320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:43:13 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57LhGFB029638;
	Fri, 7 Jun 2013 23:43:16 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRv019409;
	Fri, 7 Jun 2013 23:43:15 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 23:43:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57LhDJZ003320
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246198.04028@JtYLR40YOyTz2Yi1aI7Ovg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226728>

Non-trivial numeric values (e.g., different from 0, 1 and 2) are placed=
 in
constants at the top of the code to be easily modifiable and to make mo=
re sense

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   20 ++++++++++++++-----=
-
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index e6dc6db..94a0411 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -43,6 +43,16 @@ Readonly my $EMPTY_MESSAGE =3D> '*Empty MediaWiki Me=
ssage*';
=20
 Readonly my $EMPTY =3D> q{};
=20
+# Number of pages taken into account at once in submodule get_mw_page_=
list
+Readonly my $SLICE_SIZE =3D> 50;
+
+# Number of linked mediafile to get at once in get_linked_mediafiles
+# The query is split in small batches because of the MW API limit of
+# the number of links to be returned (500 links max).
+Readonly my $BATCH_SIZE =3D> 10;
+
+Readonly my $HTTP_CODE_OK =3D> 200;
+
 if (@ARGV !=3D 2) {
 	exit_error_usage();
 }
@@ -226,13 +236,13 @@ sub get_mw_page_list {
 	my $pages =3D shift;
 	my @some_pages =3D @$page_list;
 	while (@some_pages) {
-		my $last_page =3D 50;
+		my $last_page =3D $SLICE_SIZE;
 		if ($#some_pages < $last_page) {
 			$last_page =3D $#some_pages;
 		}
 		my @slice =3D @some_pages[0..$last_page];
 		get_mw_first_pages(\@slice, $pages);
-		@some_pages =3D @some_pages[51..$#some_pages];
+		@some_pages =3D @some_pages[($SLICE_SIZE + 1)..$#some_pages];
 	}
 	return;
 }
@@ -388,9 +398,7 @@ sub get_linked_mediafiles {
 	my $pages =3D shift;
 	my @titles =3D map { $_->{title} } values(%{$pages});
=20
-	# The query is split in small batches because of the MW API limit of
-	# the number of links to be returned (500 links max).
-	my $batch =3D 10;
+	my $batch =3D $BATCH_SIZE;
 	while (@titles) {
 		if ($#titles < $batch) {
 			$batch =3D $#titles;
@@ -472,7 +480,7 @@ sub download_mw_mediafile {
 	my $download_url =3D shift;
=20
 	my $response =3D $mediawiki->{ua}->get($download_url);
-	if ($response->code =3D=3D 200) {
+	if ($response->code =3D=3D $HTTP_CODE_OK) {
 		return $response->decoded_content;
 	} else {
 		print {*STDERR} "Error downloading mediafile from :\n";
--=20
1.7.9.5
