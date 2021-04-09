Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBD5C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 21:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6953C610A7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 21:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhDIVSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 17:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhDIVSb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 17:18:31 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AF9C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 14:18:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618003094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QZTru6dMmP+EcVF2752dQReh0ZgksAjLv9D/+YamGko=;
        b=Gj6PsjaIsTgw1v8g197RoYV0mBYA7pDyt07E4kdwA/wtKSvrCIx68AaAHYcGLSMM9R3ck9
        x4b7A2ASVVL8kKaftKbdG5UtXQFMpRIk4/T0OjV1LGbzTcb/+tQrnCDuv4BqU25S+DSFCm
        MHJVoL5rjhIqcesAwSWcUqoG1gmk7jSP3AMQaEcmlFHHtRFuLtB9s5Zl3DmJjMaEjZyZ+h
        OYlKFBFGuHykY0hzf7ZuNQa05Ler4o7JxJhFl60dFAQhSn+BdRIEHaW/D+xMVfGx28pnKL
        S6CIsvRca3PdCKNn8I1gKsGgsjjoetSCiHxef2KVwWl3kbOEieL02C0VxPQyig==
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH] send-email: clarify SMTP encryption settings
Date:   Fri,  9 Apr 2021 17:18:12 -0400
Message-Id: <20210409211812.3869-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The present options are misleading; "ssl" enables generic, "modern" SSL
support, which could use either SSL or TLS; and "tls" enables the
SMTP-specific (and deprecated) STARTTLS protocol.

This changes the canonical config options to "ssl/tls" and "starttls",
updates the docs to explain the options in more detail, and updates
git-send-email to accept either form.
---
 Documentation/git-send-email.txt | 11 ++++++++---
 git-send-email.perl              |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 93708aefea..3597935e41 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -168,9 +168,14 @@ Sending
 	unspecified, choosing the envelope sender is left to your MTA.
 
 --smtp-encryption=<encryption>::
-	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
-	value reverts to plain SMTP.  Default is the value of
-	`sendemail.smtpEncryption`.
+	Specify the encryption to use, either 'ssl/tls' or 'starttls', whichever
+	is recommended by your email service provider.  SSL/TLS is typically
+	used on port 465 and is preferred if available.  STARTTLS is typically
+	used on port 25 or 587. Any other value reverts to plain SMTP.  The
+	default is the value of `sendemail.smtpEncryption`.
++
+For legacy reasons, 'ssl' is accepted for 'ssl/tls' and 'tls' is accepted for
+'starttls'.
 
 --smtp-domain=<FQDN>::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
diff --git a/git-send-email.perl b/git-send-email.perl
index f5bbf1647e..34fdf587bd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1503,7 +1503,7 @@ sub send_message {
 		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("2.34");
 		$smtp_domain ||= maildomain();
 
-		if ($smtp_encryption eq 'ssl') {
+		if ($smtp_encryption eq 'ssl' || $smtp_encryption eq 'ssl/tls') {
 			$smtp_server_port ||= 465; # ssmtp
 			require IO::Socket::SSL;
 
@@ -1538,7 +1538,7 @@ sub send_message {
 						 Hello => $smtp_domain,
 						 Debug => $debug_net_smtp,
 						 Port => $smtp_server_port);
-			if ($smtp_encryption eq 'tls' && $smtp) {
+			if (($smtp_encryption eq 'tls' || $smtp_encryption eq 'starttls') && $smtp) {
 				if ($use_net_smtp_ssl) {
 					$smtp->command('STARTTLS');
 					$smtp->response();
-- 
2.31.1

