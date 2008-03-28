From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii
	characters
Date: Fri, 28 Mar 2008 17:29:01 -0400
Message-ID: <20080328212900.GB9656@coredump.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 22:29:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfM8y-0006rz-Fo
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 22:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbYC1V3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2008 17:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755782AbYC1V3F
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 17:29:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2230 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755778AbYC1V3F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 17:29:05 -0400
Received: (qmail 8156 invoked by uid 111); 28 Mar 2008 21:29:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 28 Mar 2008 17:29:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2008 17:29:01 -0400
Content-Disposition: inline
In-Reply-To: <20080328212700.GA9529@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78442>

We always use 'utf-8' as the encoding, since we currently
have no way of getting the information from the user.

This also refactors the quoting of recipient names, since
both processes can share the rfc2047 quoting code.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl   |   19 +++++++++++++++++--
 t/t9001-send-email.sh |   15 +++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 7c4f06c..d0f9d4a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -536,6 +536,14 @@ EOT
 		if (!$in_body && /^MIME-Version:/i) {
 			$need_8bit_cte =3D 0;
 		}
+		if (!$in_body && /^Subject: ?(.*)/i) {
+			my $subject =3D $1;
+			$_ =3D "Subject: " .
+				($subject =3D~ /[^[:ascii:]]/ ?
+				 quote_rfc2047($subject) :
+				 $subject) .
+				"\n";
+		}
 		print C2 $_;
 	}
 	close(C);
@@ -626,6 +634,14 @@ sub unquote_rfc2047 {
 	return wantarray ? ($_, $encoding) : $_;
 }
=20
+sub quote_rfc2047 {
+	local $_ =3D shift;
+	my $encoding =3D shift || 'utf-8';
+	s/([^-a-zA-Z0-9!*+\/])/sprintf("=3D%02X", ord($1))/eg;
+	s/(.*)/=3D\?$encoding\?q\?$1\?=3D/;
+	return $_;
+}
+
 # use the simplest quoting being able to handle the recipient
 sub sanitize_address
 {
@@ -643,8 +659,7 @@ sub sanitize_address
=20
 	# rfc2047 is needed if a non-ascii char is included
 	if ($recipient_name =3D~ /[^[:ascii:]]/) {
-		$recipient_name =3D~ s/([^-a-zA-Z0-9!*+\/])/sprintf("=3D%02X", ord($=
1))/eg;
-		$recipient_name =3D~ s/(.*)/=3D\?utf-8\?q\?$1\?=3D/;
+		$recipient_name =3D quote_rfc2047($recipient_name);
 	}
=20
 	# double quotes are needed if specials or CTLs are included
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e222c49..a4bcd28 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -210,4 +210,19 @@ test_expect_success '--compose respects user mime =
type' '
 	! grep "^Content-Type: text/plain; charset=3Dutf-8" msgtxt1
 '
=20
+test_expect_success '--compose adds MIME for utf8 subject' '
+	clean_fake_sendmail &&
+	echo y | \
+	  GIT_EDITOR=3D$(pwd)/fake-editor \
+	  GIT_SEND_EMAIL_NOTTY=3D1 \
+	  git send-email \
+	  --compose --subject utf8-s=C3=BCbj=C3=ABct \
+	  --from=3D"Example <nobody@example.com>" \
+	  --to=3Dnobody@example.com \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  $patches &&
+	grep "^fake edit" msgtxt1 &&
+	grep "^Subject: =3D?utf-8?q?utf8-s=3DC3=3DBCbj=3DC3=3DABct?=3D" msgtx=
t1
+'
+
 test_done
--=20
1.5.5.rc1.141.g50ecd.dirty
