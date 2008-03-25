From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii
	characters
Date: Tue, 25 Mar 2008 19:03:21 -0400
Message-ID: <20080325230321.GB17744@coredump.intra.peff.net>
References: <7caf19ae394accab538d2f94953bb62b55a2c79f.1206486012.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 00:04:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeIBg-0000GP-Ka
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 00:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbYCYXDY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 19:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbYCYXDY
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 19:03:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1619 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816AbYCYXDX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 19:03:23 -0400
Received: (qmail 6578 invoked by uid 111); 25 Mar 2008 23:03:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Mar 2008 19:03:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Mar 2008 19:03:21 -0400
Content-Disposition: inline
In-Reply-To: <7caf19ae394accab538d2f94953bb62b55a2c79f.1206486012.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78227>

We always use 'utf-8' as the encoding, since we currently
have no way of getting the information from the user.

This also refactors the quoting of recipient names, since
both processes can share the rfc2047 quoting code.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl   |   18 +++++++++++++++---
 t/t9001-send-email.sh |   15 +++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 7c4f06c..075cd0b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -501,7 +501,12 @@ if ($compose) {
 	open(C,">",$compose_filename)
 		or die "Failed to open for writing $compose_filename: $!";
 	print C "From $sender # This line is ignored.\n";
-	printf C "Subject: %s\n\n", $initial_subject;
+	print C "Subject: ",
+		($initial_subject =3D~ /[^[:ascii:]]/ ?
+		quote_rfc2047($initial_subject) :
+		$initial_subject),
+		"\n";
+	print C "\n";
 	printf C <<EOT;
 GIT: Please enter your email below.
 GIT: Lines beginning in "GIT: " will be removed.
@@ -626,6 +631,14 @@ sub unquote_rfc2047 {
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
@@ -643,8 +656,7 @@ sub sanitize_address
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
1.5.5.rc1.123.ge5f4e6
