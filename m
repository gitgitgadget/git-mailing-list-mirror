From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] send-email: teach sanitize_address to do rfc2047 quoting
Date: Mon,  6 Aug 2007 22:34:50 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <11864324902764-git-send-email-ukleinek@informatik.uni-freiburg.de>
References: <20070806083341.GA6625@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 22:35:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II9IC-0006Mj-6v
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 22:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbXHFUfE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 16:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760498AbXHFUfD
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 16:35:03 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:44630 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756322AbXHFUfA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2007 16:35:00 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1II9Hy-0003lk-6X; Mon, 06 Aug 2007 22:34:54 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l76KYqVu027249;
	Mon, 6 Aug 2007 22:34:52 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l76KYq1M027248;
	Mon, 6 Aug 2007 22:34:52 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.rc3.13.g7ab3
In-Reply-To: <20070806083341.GA6625@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55172>

Without this patch I'm not able to properly send emails as I have a
non-ascii character in my name.

I removed the _rfc822 suffix from the function name as it now does more
than rfc822 quoting.

I dug through rfc822 to do the double quoting right.  Only if that is n=
ot
possible rfc2047 quoting is applied.

Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.=
de>
Cc: Jakub Narebski <jnareb@gmail.com>
---
As Jakub critizied now the "easiest" quoting is done.

 git-send-email.perl |   39 +++++++++++++++++++++++++++++----------
 1 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f43f92f..39e433b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -289,7 +289,7 @@ sub expand_aliases {
 }
=20
 @to =3D expand_aliases(@to);
-@to =3D (map { sanitize_address_rfc822($_) } @to);
+@to =3D (map { sanitize_address($_) } @to);
 @initial_cc =3D expand_aliases(@initial_cc);
 @bcclist =3D expand_aliases(@bcclist);
=20
@@ -459,22 +459,41 @@ sub unquote_rfc2047 {
 	return "$_";
 }
=20
-# If an address contains a . in the name portion, the name must be quo=
ted.
-sub sanitize_address_rfc822
+# use the simplest quoting being able to handle the recipient
+sub sanitize_address
 {
 	my ($recipient) =3D @_;
-	my ($recipient_name) =3D ($recipient =3D~ /^(.*?)\s+</);
-	if ($recipient_name && $recipient_name =3D~ /\./ && $recipient_name !=
~ /^".*"$/) {
-		my ($name, $addr) =3D ($recipient =3D~ /^(.*?)(\s+<.*)/);
-		$recipient =3D "\"$name\"$addr";
+	my ($recipient_name, $recipient_addr) =3D ($recipient =3D~ /^(.*?)\s*=
(<.*)/);
+
+	if (not $recipient_name) {
+		return "$recipient";
+	}
+
+	# if recipient_name is already quoted, do nothing
+	if ($recipient_name =3D~ /^(".*"|=3D\?utf-8\?q\?.*\?=3D)$/) {
+		return $recipient;
+	}
+
+	# rfc2047 is needed if a non-ascii char is included
+	if ($recipient_name =3D~ /[^[:ascii:]]/) {
+		$recipient_name =3D~ s/([^-a-zA-Z0-9!*+\/])/sprintf("=3D%02X", ord($=
1))/eg;
+		$recipient_name =3D~ s/(.*)/=3D\?utf-8\?q\?$1\?=3D/;
 	}
-	return $recipient;
+
+	# double quotes are needed if specials or CTLs are included
+	elsif ($recipient_name =3D~ /[][()<>@,;:\\".\000-\037\177]/) {
+		$recipient_name =3D~ s/(["\\\r])/\\$1/;
+		$recipient_name =3D "\"$recipient_name\"";
+	}
+
+	return "$recipient_name $recipient_addr";
+
 }
=20
 sub send_message
 {
 	my @recipients =3D unique_email_list(@to);
-	@cc =3D (map { sanitize_address_rfc822($_) } @cc);
+	@cc =3D (map { sanitize_address($_) } @cc);
 	my $to =3D join (",\n\t", @recipients);
 	@recipients =3D unique_email_list(@recipients,@cc,@bcclist);
 	@recipients =3D (map { extract_valid_address($_) } @recipients);
@@ -489,7 +508,7 @@ sub send_message
 	if ($cc ne '') {
 		$ccline =3D "\nCc: $cc";
 	}
-	$from =3D sanitize_address_rfc822($from);
+	$from =3D sanitize_address($from);
 	make_message_id();
=20
 	my $header =3D "From: $from
--=20
1.5.3.rc3.13.g7ab3
