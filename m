From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] send-email: auth plain/login fix
Date: Thu, 29 Sep 2011 19:02:45 +0200
Message-ID: <1317315765-5471-1-git-send-email-zbyszek@in.waw.pl>
References: <1317308474.1854.8.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: gitster@pobox.com, joe@perches.com, git@vger.kernel.org,
	peff@peff.net
X-From: git-owner@vger.kernel.org Thu Sep 29 19:03:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9K0y-0007WM-7k
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 19:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105Ab1I2RDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 13:03:11 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:36203 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754998Ab1I2RDK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 13:03:10 -0400
Received: from 86-85-n1.aster.pl ([85.222.86.85] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1R9K0p-0004rD-BG; Thu, 29 Sep 2011 19:03:07 +0200
X-Mailer: git-send-email 1.7.6.234.g266fc.dirty
In-Reply-To: <1317308474.1854.8.camel@Joe-Laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182414>

git send-email was not authenticating properly when communicating over
TLS with a server supporting only AUTH PLAIN and AUTH LOGIN. This is
e.g. the standard server setup under debian with exim4 and probably
everywhere where system accounts are used.

The problem (only?) exists when libauthen-sasl-cyrus-perl
(Authen::SASL::Cyrus) is installed. Importing Authen::SASL::Perl
makes Authen::SASL use the perl implementation which works
better.

The solution is based on this forum thread:
http://www.perlmonks.org/?node_id=3D904354.

This patch is tested by sending it. Without this fix, the interaction w=
ith
the server failed like this:

$ git send-email --smtp-encryption=3Dtls --smtp-server=3D... --smtp-deb=
ug=3D1 change1.patch
=2E..
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 250-AUTH LOGIN PLAIN
Password:
Net::SMTP::SSL=3DGLOB(0x238f668)>>> AUTH
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 501 5.5.2 AUTH mechanism must be sp=
ecified
5.5.2 AUTH mechanism must be specified

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v2:  - the import is performed only if it will be used
v3:  - the import is performed only if it will be used, and failure is =
ignored
v4:  - improved commit message
v5:  - comment in code

 git-send-email.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 98ab33a..f2a6e46 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1095,6 +1095,12 @@ X-Mailer: git-send-email $gitversion
 		}
=20
 		if (defined $smtp_authuser) {
+			# Workaround AUTH PLAIN/LOGIN interaction defect
+			# with Authen::SASL::Cyrus
+			eval {
+				require Authen::SASL;
+				Authen::SASL->import(qw(Perl));
+			};
=20
 			if (!defined $smtp_authpass) {
=20
--=20
1.7.6
