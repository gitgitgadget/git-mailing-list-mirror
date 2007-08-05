From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] send-email: let sanitize_address_rfc822 do rfc2047 quoting
Date: Sun,  5 Aug 2007 22:09:08 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <11863445481996-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 22:09:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHmPf-0003CP-Uk
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 22:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761478AbXHEUJQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 5 Aug 2007 16:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761428AbXHEUJQ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 16:09:16 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:37705 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760284AbXHEUJN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 16:09:13 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IHmPX-0006dW-D2; Sun, 05 Aug 2007 22:09:11 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l75K99tW018646;
	Sun, 5 Aug 2007 22:09:09 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l75K99df018645;
	Sun, 5 Aug 2007 22:09:09 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.rc3.13.g7ab3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55068>

Without this patch I'm not able to properly send emails as I have a
non-ascii character in my name.

The former version tried to fix-up the real name part with double quote=
s
if it includes a '.'.  I removed this as rfc2047 can handle a dot, too.

Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.=
de>
---
Hello,

I already sent a similar patch that was discussed a bit[1], but was not=
 taken.

The list of allowed character was taken from Python's email package.

Comparing with the former version I removed the quoting as described in
the 2nd paragraph of the log and now I only test $recipient_name once.

I will try to send this patch with next + this patch.  I think it shoul=
d
work in principle, but --suppress-from is not honored.  I will take a
look on this issue later.

Best regards
Uwe

[1] http://thread.gmane.org/gmane.comp.version-control.git/52093

 git-send-email.perl |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f43f92f..5785e29 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -459,16 +459,27 @@ sub unquote_rfc2047 {
 	return "$_";
 }
=20
-# If an address contains a . in the name portion, the name must be quo=
ted.
+# The name part of an address must consist only of alnum chars, space =
and a few
+# others.
+# If it contains a "forbidden" char in the name port, quote it accordi=
ng to
+# rfc2047.
 sub sanitize_address_rfc822
 {
 	my ($recipient) =3D @_;
-	my ($recipient_name) =3D ($recipient =3D~ /^(.*?)\s+</);
-	if ($recipient_name && $recipient_name =3D~ /\./ && $recipient_name !=
~ /^".*"$/) {
-		my ($name, $addr) =3D ($recipient =3D~ /^(.*?)(\s+<.*)/);
-		$recipient =3D "\"$name\"$addr";
+	my ($recipient_name, $recipient_addr) =3D ($recipient =3D~ /^(.*?)(\s=
+<.*)/);
+
+	if ($recipient_name) {
+		if ($recipient_name =3D~ /[^-a-zA-Z0-9!*+\/ ]/ && $recipient_name !~=
 /=3D\?utf-8\?q?.*\?=3D/) {
+			$recipient_name =3D~ s/([^-a-zA-Z0-9!*+\/ ])/sprintf("=3D%02X", ord=
($1))/eg;
+			$recipient_name =3D~ s/ /_/;
+			$recipient_name =3D~ s/(.*)/=3D\?utf-8\?q\?$1\?=3D/;
+		}
+
+		return "$recipient_name$recipient_addr";
+
+	} else {
+		return "$recipient";
 	}
-	return $recipient;
 }
=20
 sub send_message
--=20
1.5.3.rc3.13.g7ab3
