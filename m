From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v4] send-email: auth plain/login fix
Date: Thu, 29 Sep 2011 16:16:16 +0200
Message-ID: <20110929141616.GU10763@in.waw.pl>
References: <7v62kcz5rr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: gitster@pobox.com, joe@perches.com, git@vger.kernel.org,
	peff@peff.net
X-From: git-owner@vger.kernel.org Thu Sep 29 16:16:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9HPX-0005xW-4z
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 16:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab1I2OQW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 10:16:22 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:58502 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452Ab1I2OQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 10:16:21 -0400
Received: from zbyszek by kawka.in.waw.pl with local (Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1R9HPM-0004BM-8v; Thu, 29 Sep 2011 16:16:16 +0200
Content-Disposition: inline
In-Reply-To: <7v62kcz5rr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182397>

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

 git-send-email.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 37dfbe7..dbc435a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1098,6 +1098,10 @@ X-Mailer: git-send-email $gitversion
 		}
=20
 		if (defined $smtp_authuser) {
+			eval {
+				require Authen::SASL;
+				Authen::SASL->import(qw(Perl));
+			};
=20
 			if (!defined $smtp_authpass) {
=20
--=20
1.7.6
