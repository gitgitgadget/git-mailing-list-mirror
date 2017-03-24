Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6A61FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 21:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756926AbdCXViM (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 17:38:12 -0400
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:57588 "EHLO
        koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756567AbdCXViH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 17:38:07 -0400
Received: from localhost.localdomain (unknown [145.129.9.233])
        by koekblik.kaarsemaker.net (Postfix) with ESMTP id 15930802D7;
        Fri, 24 Mar 2017 22:37:30 +0100 (CET)
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2] send-email: Net::SMTP::SSL is obsolete, use only when necessary
Date:   Fri, 24 Mar 2017 22:37:32 +0100
Message-Id: <20170324213732.29932-1-dennis@kaarsemaker.net>
X-Mailer: git-send-email 2.12.0-488-gd3584ba
In-Reply-To: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
References: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Net::SMTP itself can do the necessary SSL and STARTTLS bits just fine
since version 1.28, and Net::SMTP::SSL is now deprecated. Since 1.28
isn't that old yet, keep the old code in place and use it when
necessary.

While we're in the area, mark some messages for translation that were
not yet marked as such.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 git-send-email.perl | 54 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index eea0a517f7..0d90439d9a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1353,10 +1353,12 @@ EOF
 			die __("The required SMTP server is not properly defined.")
 		}
 
+		require Net::SMTP;
+		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("1.28");
+		$smtp_domain ||= maildomain();
+
 		if ($smtp_encryption eq 'ssl') {
 			$smtp_server_port ||= 465; # ssmtp
-			require Net::SMTP::SSL;
-			$smtp_domain ||= maildomain();
 			require IO::Socket::SSL;
 
 			# Suppress "variable accessed once" warning.
@@ -1368,34 +1370,48 @@ EOF
 			# Net::SMTP::SSL->new() does not forward any SSL options
 			IO::Socket::SSL::set_client_defaults(
 				ssl_verify_params());
-			$smtp ||= Net::SMTP::SSL->new($smtp_server,
-						      Hello => $smtp_domain,
-						      Port => $smtp_server_port,
-						      Debug => $debug_net_smtp);
+
+			if ($use_net_smtp_ssl) {
+				require Net::SMTP::SSL;
+				$smtp ||= Net::SMTP::SSL->new($smtp_server,
+							      Hello => $smtp_domain,
+							      Port => $smtp_server_port,
+							      Debug => $debug_net_smtp);
+			}
+			else {
+				$smtp ||= Net::SMTP->new($smtp_server,
+							 Hello => $smtp_domain,
+							 Port => $smtp_server_port,
+							 Debug => $debug_net_smtp,
+							 SSL => 1);
+			}
 		}
 		else {
-			require Net::SMTP;
-			$smtp_domain ||= maildomain();
 			$smtp_server_port ||= 25;
 			$smtp ||= Net::SMTP->new($smtp_server,
 						 Hello => $smtp_domain,
 						 Debug => $debug_net_smtp,
 						 Port => $smtp_server_port);
 			if ($smtp_encryption eq 'tls' && $smtp) {
-				require Net::SMTP::SSL;
-				$smtp->command('STARTTLS');
-				$smtp->response();
-				if ($smtp->code == 220) {
+				if ($use_net_smtp_ssl) {
+					$smtp->command('STARTTLS');
+					$smtp->response();
+					if ($smtp->code != 220) {
+						die sprintf(__("Server does not support STARTTLS! %s"), $smtp->message);
+					}
+					require Net::SMTP::SSL;
 					$smtp = Net::SMTP::SSL->start_SSL($smtp,
 									  ssl_verify_params())
-						or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
-					$smtp_encryption = '';
-					# Send EHLO again to receive fresh
-					# supported commands
-					$smtp->hello($smtp_domain);
-				} else {
-					die sprintf(__("Server does not support STARTTLS! %s"), $smtp->message);
+						or die sprintf(__("STARTTLS failed! %s"), IO::Socket::SSL::errstr());
+				}
+				else {
+					$smtp->starttls(ssl_verify_params())
+						or die sprintf(__("STARTTLS failed! %s"), IO::Socket::SSL::errstr());
 				}
+				$smtp_encryption = '';
+				# Send EHLO again to receive fresh
+				# supported commands
+				$smtp->hello($smtp_domain);
 			}
 		}
 
-- 
2.12.0-488-gd3584ba

