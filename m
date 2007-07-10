From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] send-email: extend sanitize_address_rfc822 to do rfc2047 quoting
Date: Tue, 10 Jul 2007 19:02:43 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <11840869641759-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 19:02:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8J74-0000qa-7W
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 19:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbXGJRCy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Jul 2007 13:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754371AbXGJRCx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 13:02:53 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:50611 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754189AbXGJRCx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2007 13:02:53 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I8J6w-00025D-RD; Tue, 10 Jul 2007 19:02:51 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l6AH2nje025004;
	Tue, 10 Jul 2007 19:02:49 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l6AH2mbX025003;
	Tue, 10 Jul 2007 19:02:48 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.rc0.823.gdedbf
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52093>

Without this patch I'm not able to properly send emails as I have a
non-ascii character in my name.

Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.=
de>
---
As I'm not a perl profi, someone wants to check this code.

Actually this series is a test, as it is sended with the patched send-e=
mail.

I hope it works :-)

Uwe

 git-send-email.perl |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 89f7c36..8b3d450 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -459,16 +459,30 @@ sub unquote_rfc2047 {
 	return "$_";
 }
=20
-# If an address contains a . in the name portion, the name must be quo=
ted.
+# If an address contains a non-ascii char in the name port, quote it a=
ccording
+# to rfc2047.
+# If an address contains a . in the name portion, the name must be quo=
ted using
+# double quotes.
 sub sanitize_address_rfc822
 {
 	my ($recipient) =3D @_;
-	my ($recipient_name) =3D ($recipient =3D~ /^(.*?)\s+</);
+	my ($recipient_name, $recipient_addr) =3D ($recipient =3D~ /^(.*?)(\s=
+<.*)/);
+
+	if ($recipient_name && $recipient_name =3D~ /[^-a-zA-Z0-9!*+\/ ]/ && =
$recipient_name !~ /=3D\?utf-8\?q?.*\?=3D/) {
+		$recipient_name =3D~ s/([^-a-zA-Z0-9!*+ ])/sprintf("=3D%02X", ord($1=
))/eg;
+		$recipient_name =3D~ s/ /_/;
+		$recipient_name =3D~ s/(.*)/=3D\?utf-8\?q\?$1\?=3D/;
+	}
+
 	if ($recipient_name && $recipient_name =3D~ /\./ && $recipient_name !=
~ /^".*"$/) {
-		my ($name, $addr) =3D ($recipient =3D~ /^(.*?)(\s+<.*)/);
-		$recipient =3D "\"$name\"$addr";
+		$recipient_name =3D "\"$recipient_name\"";
+	}
+
+	if ($recipient_name) {
+		return "$recipient_name$recipient_addr";
+	} else {
+		return "$recipient";
 	}
-	return $recipient;
 }
=20
 sub send_message
--=20
1.5.3.rc0.823.gdedbf
