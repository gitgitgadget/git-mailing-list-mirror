From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] git-remote-mediawiki: fix encoding issue for UTF-8 media files
Date: Wed, 23 Apr 2014 16:34:29 +0200
Message-ID: <1398263669-16594-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1398263669-16594-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 23 17:08:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcymS-0006ns-8k
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 17:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbaDWPIA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Apr 2014 11:08:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58023 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757181AbaDWPH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 11:07:56 -0400
X-Greylist: delayed 1987 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Apr 2014 11:07:55 EDT
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3NEYg5g016443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Apr 2014 16:34:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3NEYium029112;
	Wed, 23 Apr 2014 16:34:44 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1WcyG4-0004KR-AZ; Wed, 23 Apr 2014 16:34:44 +0200
X-Mailer: git-send-email 1.9.2.667.ge5b74e1
In-Reply-To: <1398263669-16594-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 23 Apr 2014 16:34:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3NEYg5g016443
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1398868483.07565@SPUnEwuTH9IN/jj9AYjchQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246846>

When a media file contains valid UTF-8, git-remote-mediawiki tried to b=
e
too clever about the encoding, and the call to utf8::downgrade() on the
downloaded content was failing with

  Wide character in subroutine entry at git-remote-mediawiki line 583.

Instead, use $response->decode() to apply decoding linked to the
Content-Encoding: header, and return the content without attempting any
charset decoding.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl          |  7 ++++++-
 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh | 19 ++++++++++++=
+++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 3f8d993..8dd74a9 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -461,7 +461,12 @@ sub download_mw_mediafile {
=20
 	my $response =3D $mediawiki->{ua}->get($download_url);
 	if ($response->code =3D=3D HTTP_CODE_OK) {
-		return $response->decoded_content;
+		# It is tempting to return
+		# $response->decoded_content({charset =3D> "none"}), but
+		# when doing so, utf8::downgrade($content) fails with
+		# "Wide character in subroutine entry".
+		$response->decode();
+		return $response->content();
 	} else {
 		print {*STDERR} "Error downloading mediafile from :\n";
 		print {*STDERR} "URL: ${download_url}\n";
diff --git a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh b/con=
trib/mw-to-git/t/t9363-mw-to-git-export-import.sh
index 5a03739..3ff3a09 100755
--- a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
+++ b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
@@ -58,6 +58,25 @@ test_expect_success 'git clone works on previously c=
reated wiki with media files
 	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt
 '
=20
+test_expect_success 'git push can upload media (File:) files containin=
g valid UTF-8' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir &&
+	(
+		cd mw_dir &&
+		"$PERL_PATH" -e "print STDOUT \"UTF-8 content: =C3=A9=C3=A8=C3=A0=C3=
=A9=C3=AA=E2=82=AC.\";" >Bar.txt &&
+		git add Bar.txt &&
+		git commit -m "add a text file with UTF-8 content" &&
+		git push
+	)
+'
+
+test_expect_success 'git clone works on previously created wiki with m=
edia files containing valid UTF-8' '
+	test_when_finished "rm -rf mw_dir mw_dir_clone" &&
+	git clone -c remote.origin.mediaimport=3Dtrue \
+		mediawiki::'"$WIKI_URL"' mw_dir_clone &&
+	test_cmp mw_dir_clone/Bar.txt mw_dir/Bar.txt
+'
+
 test_expect_success 'git push & pull work with locally renamed media f=
iles' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir &&
--=20
1.9.2.667.ge5b74e1
