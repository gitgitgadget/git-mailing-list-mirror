From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] git-send-email: allow overriding smtp-encryption config to 'none'
Date: Wed, 15 Feb 2012 13:42:58 -0800
Message-ID: <1329342178-14540-1-git-send-email-computersforpeace@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 15 22:43:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxmd6-0000GT-5b
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 22:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab2BOVnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 16:43:07 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42871 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744Ab2BOVnF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 16:43:05 -0500
Received: by pbcun15 with SMTP id un15so1766240pbc.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 13:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=50INzBgnjEuIRhwzCkBP/o5/uQJlwRDKvHulfGbDxWc=;
        b=DU6sSZIMMF49ODdtz8cLwiwlIoJvIArxH8MjXIH111fnWpGccD2JaGt4FpyVBfCG7G
         j9AdSoiSTGlxVOQFXTZOEiSI4K2vqVxgHn+/ZC3OtWL7laJ2xB0wQzTVnJB300bCc/uq
         DQxSqH+OA9T0qSr/Z1Adn3wPU7VBbAE2ZtcSA=
Received: by 10.68.241.170 with SMTP id wj10mr7174408pbc.42.1329342185125;
        Wed, 15 Feb 2012 13:43:05 -0800 (PST)
Received: from ld-irv-0074.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPS id i1sm457506pbo.76.2012.02.15.13.43.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 13:43:04 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1.1.g24e90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190861>

According to the manpage:

 --smtp-encryption=<encryption>
        Specify the encryption to use, either ssl or tls. Any other value
	reverts to plain SMTP.  Default is the value of
        sendemail.smtpencryption.

However, if I have already set sendemail.smtpencryption but try to override
it with something like 'no', the authentication code block still tries to ask
for a password (and fails).

This patch forces $smtp_encryption to 'none' when a proper encryption type is
not provided, then checks $smtp_encryption before proceeding to authentication.

Example execution:

 $ git send-email --smtp-encryption=no --smtp-domain=<xxx> \
        --smtp-server=<xxx> --smtp-server-port=25 myfile.patch
 Password:
 Command unknown: 'AUTH' at /usr/local/libexec/git-core/git-send-email
 line 1115, <STDIN> line 1.

Tested on Git 1.7.5.4 and 1.7.9.1.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 git-send-email.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ef30c55..fa0a384 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -385,8 +385,9 @@ foreach my $setting (values %config_bool_settings) {
 	${$setting->[0]} = $setting->[1] unless (defined (${$setting->[0]}));
 }
 
-# 'default' encryption is none -- this only prevents a warning
-$smtp_encryption = '' unless (defined $smtp_encryption);
+# 'default' encryption is none
+$smtp_encryption = 'none' unless (defined $smtp_encryption);
+$smtp_encryption = 'none' unless ($smtp_encryption eq 'tls' || $smtp_encryption eq 'ssl');
 
 # Set CC suppressions
 my(%suppress_cc);
@@ -1113,7 +1114,7 @@ X-Mailer: git-send-email $gitversion
 			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
 		}
 
-		if (defined $smtp_authuser) {
+		if (defined $smtp_authuser && $smtp_encryption ne 'none') {
 			# Workaround AUTH PLAIN/LOGIN interaction defect
 			# with Authen::SASL::Cyrus
 			eval {
-- 
1.7.5.4
