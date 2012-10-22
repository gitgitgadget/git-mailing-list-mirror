From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: =?UTF-8?q?=5BPATCH=5D=20git-send-email=3A=20use=20compose-encoding=20for=20Subject?=
Date: Mon, 22 Oct 2012 14:41:48 +0200
Message-ID: <1350909708-32241-1-git-send-email-krzysiek@podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Krzysztof Mazur <krzysiek@podlesie.net>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 14:51:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQHTJ-0003ch-7m
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 14:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab2JVMu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2012 08:50:57 -0400
Received: from [93.179.225.50] ([93.179.225.50]:42484 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753182Ab2JVMu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 08:50:57 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2012 08:50:56 EDT
Received: from geronimo.kss.ia.polsl.pl (localhost [127.0.0.1])
	by shrek.podlesie.net (Postfix) with ESMTP id 2950A42E;
	Mon, 22 Oct 2012 14:43:09 +0200 (CEST)
X-Mailer: git-send-email 1.8.0.2.g35080e9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208180>

The commit "git-send-email: introduce compose-encoding" introduced
the compose-encoding option to specify the introduction email encoding
(--compose option), but the email Subject encoding was still hardcoded
to UTF-8.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
Patch against km/send-email-compose-encoding
(commit 62e0069056ed11294c29bae25df69b6518f6339e). Cleanly applies to c=
urrent
next (commit 291341ca77d902dc76e204a3fc498a155f0ab75d)

 git-send-email.perl   |  8 ++++----
 t/t9001-send-email.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 107e814..adcb4e3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -636,15 +636,15 @@ EOT
 	my $need_8bit_cte =3D file_has_nonascii($compose_filename);
 	my $in_body =3D 0;
 	my $summary_empty =3D 1;
+	if (!defined $compose_encoding) {
+		$compose_encoding =3D "UTF-8";
+	}
 	while(<$c>) {
 		next if m/^GIT:/;
 		if ($in_body) {
 			$summary_empty =3D 0 unless (/^\n$/);
 		} elsif (/^\n$/) {
 			$in_body =3D 1;
-			if (!defined $compose_encoding) {
-				$compose_encoding =3D "UTF-8";
-			}
 			if ($need_8bit_cte) {
 				print $c2 "MIME-Version: 1.0\n",
 					 "Content-Type: text/plain; ",
@@ -658,7 +658,7 @@ EOT
 			my $subject =3D $initial_subject;
 			$_ =3D "Subject: " .
 				($subject =3D~ /[^[:ascii:]]/ ?
-				 quote_rfc2047($subject) :
+				 quote_rfc2047($subject, $compose_encoding) :
 				 $subject) .
 				"\n";
 		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 265ae04..89fceda 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -909,6 +909,20 @@ test_expect_success $PREREQ '--compose-encoding ov=
errides sendemail.composeencod
 	grep "^Content-Type: text/plain; charset=3Diso-8859-2" msgtxt1
 '
=20
+test_expect_success $PREREQ '--compose-encoding adds correct MIME for =
subject' '
+	clean_fake_sendmail &&
+	  GIT_EDITOR=3D"\"$(pwd)/fake-editor\"" \
+	  git send-email \
+	  --compose-encoding iso-8859-2 \
+	  --compose --subject utf8-s=C3=BCbj=C3=ABct \
+	  --from=3D"Example <nobody@example.com>" \
+	  --to=3Dnobody@example.com \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  $patches &&
+	grep "^fake edit" msgtxt1 &&
+	grep "^Subject: =3D?iso-8859-2?q?utf8-s=3DC3=3DBCbj=3DC3=3DABct?=3D" =
msgtxt1
+'
+
 test_expect_success $PREREQ 'detects ambiguous reference/file conflict=
' '
 	echo master > master &&
 	git add master &&
--=20
1.8.0.2.g35080e9
