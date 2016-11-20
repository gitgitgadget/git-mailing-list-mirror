Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34412021E
	for <e@80x24.org>; Sun, 20 Nov 2016 21:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbcKTVZ3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 16:25:29 -0500
Received: from greygoose-centos7.csh.rit.edu ([129.21.49.170]:46986 "EHLO
        greygoose-centos7.csh.rit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751512AbcKTVZ2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Nov 2016 16:25:28 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Nov 2016 16:25:28 EST
Received: from localhost (localhost [127.0.0.1])
        by greygoose-centos7.csh.rit.edu (Postfix) with ESMTP id 42B8D416D573
        for <git@vger.kernel.org>; Sun, 20 Nov 2016 16:18:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=csh.rit.edu; h=
        x-mailer:content-type:content-type:mime-version:message-id:date
        :date:subject:subject:from:from:received:received:received
        :received:received; s=mail; t=1479676697; x=1481491098; bh=pyg91
        0MHi5M3sRUwDsueS0KmlxRKLuHwHw4NDhujASc=; b=IynG4EgDAGZKQA/xslEyt
        9FpSnBCmIta2yOcxkuAB2L22GzCtuke2xaZUetv+KJN8vgm2sHFNHiJXIQfN8ZNc
        gbCBXgbvVSQ4l3yB9ZJ/W6Z26LQ2LCtyas8M/ZCLBqtreg/1Vrq33nV+pwlsjUW1
        gVWByDpYpt9LtI20OCP688=
X-Virus-Scanned: amavisd-new at csh.rit.edu
Received: from greygoose-centos7.csh.rit.edu ([127.0.0.1])
        by localhost (mail.csh.rit.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2r77H2osxS9k for <git@vger.kernel.org>;
        Sun, 20 Nov 2016 16:18:17 -0500 (EST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com [66.111.4.228])
        by greygoose-centos7.csh.rit.edu (Postfix) with ESMTPSA id 683C44168DE5
        for <git@vger.kernel.org>; Sun, 20 Nov 2016 16:18:17 -0500 (EST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2515120668
        for <git@vger.kernel.org>; Sun, 20 Nov 2016 16:18:17 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute7.internal (MEProxy); Sun, 20 Nov 2016 16:18:17 -0500
X-ME-Sender: <xms:GRMyWIaNYZxH_8V11i8iUx0mfYa_a32uh9YqZUTYfHj7NMZDGVvRfw>
X-Sasl-enc: azg1OONTSY/3zCMG17Xbv7mgB+k9z61JK6dEJbk7ePyD 1479676696
Received: from [192.168.1.135] (unknown [8.41.65.136])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB8F07E046
        for <git@vger.kernel.org>; Sun, 20 Nov 2016 16:18:16 -0500 (EST)
From:   "Mike Fisher" <mfisher@csh.rit.edu>
To:     git@vger.kernel.org
Subject: [PATCH] Remove dependency on deprecated Net::SMTP::SSL
Date:   Sun, 20 Nov 2016 16:18:16 -0500
Message-ID: <451E4A46-BA43-41A5-9E68-DE0D89BE676A@csh.rit.edu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Mailer: MailMate (2.0BETAr6064)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor send_message() to remove dependency on deprecated
Net::SMTP::SSL:

<http://search.cpan.org/~rjbs/Net-SMTP-SSL-1.04/lib/Net/SMTP/SSL.pm#DEPRECATED>

Signed-off-by: Mike Fisher <mfisher@csh.rit.edu>
---
  git-send-email.perl | 54 
+++++++++++++++++++++++++----------------------------
  1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index da81be4..fc166c5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1330,15 +1330,17 @@ Message-Id: $message_id
  		print $sm "$header\n$message";
  		close $sm or die $!;
  	} else {
-
  		if (!defined $smtp_server) {
  			die "The required SMTP server is not properly defined."
  		}

+		require Net::SMTP;
+		$smtp_domain ||= maildomain();
+		my $smtp_ssl = 0;
+
  		if ($smtp_encryption eq 'ssl') {
  			$smtp_server_port ||= 465; # ssmtp
-			require Net::SMTP::SSL;
-			$smtp_domain ||= maildomain();
+			$smtp_ssl = 1;
  			require IO::Socket::SSL;

  			# Suppress "variable accessed once" warning.
@@ -1347,37 +1349,31 @@ Message-Id: $message_id
  				$IO::Socket::SSL::DEBUG = 1;
  			}

-			# Net::SMTP::SSL->new() does not forward any SSL options
  			IO::Socket::SSL::set_client_defaults(
  				ssl_verify_params());
-			$smtp ||= Net::SMTP::SSL->new($smtp_server,
-						      Hello => $smtp_domain,
-						      Port => $smtp_server_port,
-						      Debug => $debug_net_smtp);
  		}
  		else {
-			require Net::SMTP;
-			$smtp_domain ||= maildomain();
  			$smtp_server_port ||= 25;
-			$smtp ||= Net::SMTP->new($smtp_server,
-						 Hello => $smtp_domain,
-						 Debug => $debug_net_smtp,
-						 Port => $smtp_server_port);
-			if ($smtp_encryption eq 'tls' && $smtp) {
-				require Net::SMTP::SSL;
-				$smtp->command('STARTTLS');
-				$smtp->response();
-				if ($smtp->code == 220) {
-					$smtp = Net::SMTP::SSL->start_SSL($smtp,
-									  ssl_verify_params())
-						or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
-					$smtp_encryption = '';
-					# Send EHLO again to receive fresh
-					# supported commands
-					$smtp->hello($smtp_domain);
-				} else {
-					die "Server does not support STARTTLS! ".$smtp->message;
-				}
+		}
+
+		$smtp ||= Net::SMTP->new($smtp_server,
+					 Hello => $smtp_domain,
+					 Port => $smtp_server_port,
+					 Debug => $debug_net_smtp,
+					 SSL => $smtp_ssl);
+
+		if ($smtp_encryption eq 'tls' && $smtp) {
+			$smtp->command('STARTTLS');
+			$smtp->response();
+			if ($smtp->code == 220) {
+				$smtp->starttls(ssl_verify_params())
+					or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
+				$smtp_encryption = '';
+				# Send EHLO again to receive fresh
+				# supported commands
+				$smtp->hello($smtp_domain);
+			} else {
+				die "Server does not support STARTTLS! ".$smtp->message;
  			}
  		}

-- 
2.9.3 (Apple Git-75)

