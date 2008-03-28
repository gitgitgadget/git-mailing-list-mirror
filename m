From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] send-email: specify content-type of --compose body
Date: Fri, 28 Mar 2008 17:28:33 -0400
Message-ID: <20080328212833.GA9656@coredump.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 22:29:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfM8U-0006iW-P3
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 22:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbYC1V2h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2008 17:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755778AbYC1V2g
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 17:28:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4341 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682AbYC1V2g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 17:28:36 -0400
Received: (qmail 7972 invoked by uid 111); 28 Mar 2008 21:28:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 28 Mar 2008 17:28:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2008 17:28:33 -0400
Content-Disposition: inline
In-Reply-To: <20080328212700.GA9529@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78441>

If the compose message contains non-ascii characters, then
we assume it is in utf-8 and include the appropriate MIME
headers. If the user has already included a MIME-Version
header, then we assume they know what they are doing and
don't add any headers.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl   |   24 ++++++++++++++++++++++++
 t/t9001-send-email.sh |   44 +++++++++++++++++++++++++++++++++++++++++=
+++
 2 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9e568bf..7c4f06c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -520,8 +520,22 @@ EOT
 	open(C,"<",$compose_filename)
 		or die "Failed to open $compose_filename : " . $!;
=20
+	my $need_8bit_cte =3D file_has_nonascii($compose_filename);
+	my $in_body =3D 0;
 	while(<C>) {
 		next if m/^GIT: /;
+		if (!$in_body && /^\n$/) {
+			$in_body =3D 1;
+			if ($need_8bit_cte) {
+				print C2 "MIME-Version: 1.0\n",
+					 "Content-Type: text/plain; ",
+					   "charset=3Dutf-8\n",
+					 "Content-Transfer-Encoding: 8bit\n";
+			}
+		}
+		if (!$in_body && /^MIME-Version:/i) {
+			$need_8bit_cte =3D 0;
+		}
 		print C2 $_;
 	}
 	close(C);
@@ -958,3 +972,13 @@ sub validate_patch {
 	}
 	return undef;
 }
+
+sub file_has_nonascii {
+	my $fn =3D shift;
+	open(my $fh, '<', $fn)
+		or die "unable to open $fn: $!\n";
+	while (my $line =3D <$fh>) {
+		return 1 if $line =3D~ /[^[:ascii:]]/;
+	}
+	return 0;
+}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c0973b4..e222c49 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -166,4 +166,48 @@ test_expect_success 'second message is patch' '
 	grep "Subject:.*Second" msgtxt2
 '
=20
+test_expect_success '--compose adds MIME for utf8 body' '
+	clean_fake_sendmail &&
+	(echo "#!/bin/sh" &&
+	 echo "echo utf8 body: =C3=A0=C3=A9=C3=AC=C3=B6=C3=BA >>\$1"
+	) >fake-editor-utf8 &&
+	chmod +x fake-editor-utf8 &&
+	echo y | \
+	  GIT_EDITOR=3D$(pwd)/fake-editor-utf8 \
+	  GIT_SEND_EMAIL_NOTTY=3D1 \
+	  git send-email \
+	  --compose --subject foo \
+	  --from=3D"Example <nobody@example.com>" \
+	  --to=3Dnobody@example.com \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  $patches &&
+	grep "^utf8 body" msgtxt1 &&
+	grep "^Content-Type: text/plain; charset=3Dutf-8" msgtxt1
+'
+
+test_expect_success '--compose respects user mime type' '
+	clean_fake_sendmail &&
+	(echo "#!/bin/sh" &&
+	 echo "(echo MIME-Version: 1.0"
+	 echo " echo Content-Type: text/plain\\; charset=3Diso-8859-1"
+	 echo " echo Content-Transfer-Encoding: 8bit"
+	 echo " echo Subject: foo"
+	 echo " echo "
+	 echo " echo utf8 body: =C3=A0=C3=A9=C3=AC=C3=B6=C3=BA) >\$1"
+	) >fake-editor-utf8-mime &&
+	chmod +x fake-editor-utf8-mime &&
+	echo y | \
+	  GIT_EDITOR=3D$(pwd)/fake-editor-utf8-mime \
+	  GIT_SEND_EMAIL_NOTTY=3D1 \
+	  git send-email \
+	  --compose --subject foo \
+	  --from=3D"Example <nobody@example.com>" \
+	  --to=3Dnobody@example.com \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  $patches &&
+	grep "^utf8 body" msgtxt1 &&
+	grep "^Content-Type: text/plain; charset=3Diso-8859-1" msgtxt1 &&
+	! grep "^Content-Type: text/plain; charset=3Dutf-8" msgtxt1
+'
+
 test_done
--=20
1.5.5.rc1.141.g50ecd.dirty
