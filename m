From: Thomas Rast <trast@student.ethz.ch>
Subject: =?UTF-8?q?=5BPATCH=5D=20send-email=3A=20improve=20RFC2047=20quote=20parsing?=
Date: Mon, 30 Jul 2012 21:25:40 +0200
Message-ID: <cb7aa2a8fc08df4f1d12add603ffcbc104f67823.1343676034.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christoph Miebach <christoph.miebach@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?J=C3=BCrgen=20R=C3=BChle?= <j-r@online.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 21:25:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvvbI-0005UX-VL
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 21:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab2G3TZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 15:25:52 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:50163 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508Ab2G3TZv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 15:25:51 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 30 Jul
 2012 21:25:47 +0200
Received: from thomas.inf.ethz.net (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 30 Jul
 2012 21:25:47 +0200
X-Mailer: git-send-email 1.7.12.rc0.434.gd809d0f
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202606>

The RFC2047 unquoting, used to parse email addresses in From and Cc
headers, is broken in several ways:

* It erroneously substitutes ' ' for '_' in *the whole* header, even
  outside the quoted field. [Noticed by Christoph.]

* It is too liberal in its matching, and happily matches the start of
  one quoted chunk against the end of another, or even just something
  that looks like such an end. [Noticed by Junio.]

* It fundamentally cannot cope with encodings that are not a superset
  of ASCII, nor several (incompatible) encodings in the same header.

This patch fixes the first two by doing a more careful decoding of the
=3DAB outer quoting.  Fixing the fundamental issues is left for a
future, more intrusive, patch.

Noticed-by: Christoph Miebach <christoph.miebach@web.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This is the easy part, fixed as per Junio's comment that it needs to
use a .*? match for the contents, and with a test.

 git-send-email.perl   | 10 ++++++----
 t/t9001-send-email.sh | 13 +++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ef30c55..6647137 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -862,11 +862,13 @@ sub make_message_id {
 sub unquote_rfc2047 {
 	local ($_) =3D @_;
 	my $encoding;
-	if (s/=3D\?([^?]+)\?q\?(.*)\?=3D/$2/g) {
+	s{=3D\?([^?]+)\?q\?(.*?)\?=3D}{
 		$encoding =3D $1;
-		s/_/ /g;
-		s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
-	}
+		my $e =3D $2;
+		$e =3D~ s/_/ /g;
+		$e =3D~ s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
+		$e;
+	}eg;
 	return wantarray ? ($_, $encoding) : $_;
 }
=20
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 8c12c65..0351228 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -841,6 +841,19 @@ test_expect_success $PREREQ '--compose adds MIME f=
or utf8 subject' '
 	grep "^Subject: =3D?UTF-8?q?utf8-s=3DC3=3DBCbj=3DC3=3DABct?=3D" msgtx=
t1
 '
=20
+test_expect_success $PREREQ 'utf8 author is correctly passed on' '
+	clean_fake_sendmail &&
+	test_commit weird_author &&
+	test_when_finished "git reset --hard HEAD^" &&
+	git commit --amend --author "F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd=
_?=3Dmail@example.com>" &&
+	git format-patch --stdout -1 >funny_name.patch &&
+	git send-email --from=3D"Example <nobody@example.com>" \
+	  --to=3Dnobody@example.com \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  funny_name.patch &&
+	grep "^From: F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd_?=3Dmail@exampl=
e.com>" msgtxt1
+'
+
 test_expect_success $PREREQ 'detects ambiguous reference/file conflict=
' '
 	echo master > master &&
 	git add master &&
--=20
1.7.12.rc0.434.gd809d0f
