From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v6 26/31] git-remote-mediawiki: Put non-trivial numeric values in constants.
Date: Fri, 14 Jun 2013 15:50:34 +0200
Message-ID: <1371217839-23017-27-git-send-email-celestin.matte@ensimag.fr>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 15:51:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUPa-0001Of-HB
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab3FNNvV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:51:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33299 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965Ab3FNNvF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:51:05 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5EDp1B0011306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 15:51:01 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5EDp3aQ013444;
	Fri, 14 Jun 2013 15:51:03 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5EDoqgI016142;
	Fri, 14 Jun 2013 15:51:03 +0200
X-Mailer: git-send-email 1.8.3.1.491.g8a51f1c
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 14 Jun 2013 15:51:01 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227843>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

Non-trivial numeric values (e.g., different from 0, 1 and 2) are placed=
 in
constants at the top of the code to be easily modifiable and to make mo=
re sense

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index d1e0bb8..1cedbee 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -42,6 +42,16 @@ use constant EMPTY_MESSAGE =3D> '*Empty MediaWiki Me=
ssage*';
=20
 use constant EMPTY =3D> q{};
=20
+# Number of pages taken into account at once in submodule get_mw_page_=
list
+use constant SLICE_SIZE =3D> 50;
+
+# Number of linked mediafile to get at once in get_linked_mediafiles
+# The query is split in small batches because of the MW API limit of
+# the number of links to be returned (500 links max).
+use constant BATCH_SIZE =3D> 10;
+
+use constant HTTP_CODE_OK =3D> 200;
+
 my $remotename =3D $ARGV[0];
 my $url =3D $ARGV[1];
=20
@@ -229,13 +239,13 @@ sub get_mw_page_list {
 	my $pages =3D shift;
 	my @some_pages =3D @$page_list;
 	while (@some_pages) {
-		my $last_page =3D 50;
+		my $last_page =3D SLICE_SIZE;
 		if ($#some_pages < $last_page) {
 			$last_page =3D $#some_pages;
 		}
 		my @slice =3D @some_pages[0..$last_page];
 		get_mw_first_pages(\@slice, $pages);
-		@some_pages =3D @some_pages[51..$#some_pages];
+		@some_pages =3D @some_pages[(SLICE_SIZE + 1)..$#some_pages];
 	}
 	return;
 }
@@ -385,9 +395,7 @@ sub get_linked_mediafiles {
 	my $pages =3D shift;
 	my @titles =3D map { $_->{title} } values(%{$pages});
=20
-	# The query is split in small batches because of the MW API limit of
-	# the number of links to be returned (500 links max).
-	my $batch =3D 10;
+	my $batch =3D BATCH_SIZE;
 	while (@titles) {
 		if ($#titles < $batch) {
 			$batch =3D $#titles;
@@ -469,7 +477,7 @@ sub download_mw_mediafile {
 	my $download_url =3D shift;
=20
 	my $response =3D $mediawiki->{ua}->get($download_url);
-	if ($response->code =3D=3D 200) {
+	if ($response->code =3D=3D HTTP_CODE_OK) {
 		return $response->decoded_content;
 	} else {
 		print {*STDERR} "Error downloading mediafile from :\n";
--=20
1.8.3.rc3.49.g4e74807
