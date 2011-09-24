From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] send-email: auth plain/login fix
Date: Sat, 24 Sep 2011 17:49:27 +0200
Message-ID: <1316879367-1182-1-git-send-email-zbyszek@in.waw.pl>
References: <7vzkjn16n6.fsf@alter.siamese.dyndns.org>
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: gitster@pobox.com, joe@perches.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 17:50:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7UUS-0001wZ-2C
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 17:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab1IXPtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 11:49:45 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:50394 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab1IXPto (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 11:49:44 -0400
Received: from 86-85-n1.aster.pl ([85.222.86.85] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1R7UTz-00023q-06; Sat, 24 Sep 2011 17:49:39 +0200
X-Mailer: git-send-email 1.7.6.234.gb0b18.dirty
In-Reply-To: <7vzkjn16n6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182032>

git send-email was not authenticating properly when communicating over
TLS with a server supporting only AUTH PLAIN and AUTH LOGIN. This is
e.g. the standard server setup under debian with exim4 and probably
everywhere where system accounts are used.

The solution comes from this forum thread:
http://www.perlmonks.org/?node_id=904354

This patch is tested by sending it.

Before:
Net::SMTP>>> Net::SMTP(2.31)
Net::SMTP>>>   Net::Cmd(2.29)
Net::SMTP>>>     Exporter(5.64_01)
Net::SMTP>>>   IO::Socket::INET(1.31)
Net::SMTP>>>     IO::Socket(1.31)
Net::SMTP>>>       IO::Handle(1.28)
...
Net::SMTP=GLOB(0x238f668)>>> STARTTLS
Net::SMTP=GLOB(0x238f668)<<< 220 2.0.0 Ready to start TLS
Net::SMTP::SSL=GLOB(0x238f668)>>> EHLO localhost.localdomain
Net::SMTP::SSL=GLOB(0x238f668)<<< 250-yyy.yyy.yyy Hello xxx.xxx [xxx.xxx.xxx.xxx], pleased to meet you
Net::SMTP::SSL=GLOB(0x238f668)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::SSL=GLOB(0x238f668)<<< 250-PIPELINING
Net::SMTP::SSL=GLOB(0x238f668)<<< 250-8BITMIME
Net::SMTP::SSL=GLOB(0x238f668)<<< 250-SIZE 80000000
Net::SMTP::SSL=GLOB(0x238f668)<<< 250-DSN
Net::SMTP::SSL=GLOB(0x238f668)<<< 250-AUTH=LOGIN PLAIN
Net::SMTP::SSL=GLOB(0x238f668)<<< 250-AUTH LOGIN PLAIN
Net::SMTP::SSL=GLOB(0x238f668)<<< 250-DELIVERBY
Net::SMTP::SSL=GLOB(0x238f668)<<< 250 HELP
Password:
Net::SMTP::SSL=GLOB(0x238f668)>>> AUTH
Net::SMTP::SSL=GLOB(0x238f668)<<< 501 5.5.2 AUTH mechanism must be specified
5.5.2 AUTH mechanism must be specified

After:
Net::SMTP=GLOB(0x1ac4a60)>>> STARTTLS
Net::SMTP=GLOB(0x1ac4a60)<<< 220 2.0.0 Ready to start TLS
Net::SMTP::SSL=GLOB(0x1ac4a60)>>> EHLO localhost.localdomain
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 250-yyy.yyy.yyy Hello xxx.xxx [xxx.xxx.xxx.xxx], pleased to meet you
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 250-PIPELINING
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 250-8BITMIME
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 250-SIZE 80000000
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 250-DSN
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 250-AUTH=LOGIN PLAIN
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 250-AUTH LOGIN PLAIN
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 250-DELIVERBY
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 250 HELP
Password:
Net::SMTP::SSL=GLOB(0x1ac4a60)>>> AUTH LOGIN
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 334 VXNlcm5hbWU6
Net::SMTP::SSL=GLOB(0x1ac4a60)>>> emJ5c3plaw==
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 334 UGFzc3dvcmQ6
Net::SMTP::SSL=GLOB(0x1ac4a60)>>> dGVzdA==
Net::SMTP::SSL=GLOB(0x1ac4a60)<<< 535 5.7.0 authentication failed
5.7.0 authentication failed

The password is incorrect in this snippet, but the protocol works correctly.
---
 git-send-email.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git git-send-email.perl git-send-email.perl
index 37dfbe7..100fbd9 100755
--- git-send-email.perl
+++ git-send-email.perl
@@ -27,6 +27,7 @@ use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catfile);
 use Error qw(:try);
+use Authen::SASL qw(Perl);
 use Git;
 use MIME::Base64;
 
-- 
1.7.6
