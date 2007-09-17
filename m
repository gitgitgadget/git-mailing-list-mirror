From: Felipe Balbi <felipebalbi@users.sourceforge.net>
Subject: [PATCH 1/1] git-send-email: Add a --suppress-all option
Date: Mon, 17 Sep 2007 14:33:57 -0400
Message-ID: <11900540373215-git-send-email-felipebalbi@users.sourceforge.net>
Cc: Felipe Balbi <felipe.lima@indt.org.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 20:35:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXLRh-0007mQ-4o
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 20:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757672AbXIQSeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 14:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758005AbXIQSeT
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 14:34:19 -0400
Received: from smtp.nokia.com ([131.228.20.172]:40179 "EHLO
	mgw-ext13.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757998AbXIQSeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 14:34:17 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-ext13.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l8HIXsbW010425
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 21:34:14 +0300
Received: from daebh102.NOE.Nokia.com ([10.241.35.112]) by esebh108.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 17 Sep 2007 21:33:57 +0300
Received: from mzebe101.NOE.Nokia.com ([172.18.99.71]) by daebh102.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 17 Sep 2007 13:33:53 -0500
Received: from 1BRL00624.nokia.com ([172.18.216.48]) by mzebe101.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 17 Sep 2007 14:33:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by 1BRL00624.nokia.com (Postfix) with ESMTP id 79DB710020E;
	Mon, 17 Sep 2007 14:33:57 -0400 (AMT)
X-Mailer: git-send-email 1.5.3.1.91.gd3392
X-OriginalArrivalTime: 17 Sep 2007 18:33:48.0548 (UTC) FILETIME=[49986C40:01C7F959]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58467>

From: Felipe Balbi <felipe.lima@indt.org.br>

This patch adds a --suppress-all option to avoid sending emails
to everybody but the ones listed by --to option.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 git-send-email.perl |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d8319d4..e845c5f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -88,6 +88,9 @@ Options:
    --suppress-from Suppress sending emails to yourself if your address
                   appears in a From: line. Defaults to off.
 
+   --suppress-all Suppress sending emails to everybody but addresses
+		  listed by --to option.
+
    --thread       Specify that the "In-Reply-To:" header should be set on all
                   emails. Defaults to on.
 
@@ -171,7 +174,7 @@ if ($@) {
 my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
+my ($thread, $chain_reply_to, $suppress_from, $suppress_all, $signed_off_cc, $cc_cmd);
 my ($smtp_server, $smtp_authuser, $smtp_authpass, $smtp_ssl);
 my ($identity, $aliasfiletype, @alias_files);
 
@@ -179,6 +182,7 @@ my %config_bool_settings = (
     "thread" => [\$thread, 1],
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, 0],
+    "suppressall" => [\$suppress_all, 0],
     "signedoffcc" => [\$signed_off_cc, 1],
     "smtpssl" => [\$smtp_ssl, 0],
 );
@@ -212,6 +216,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
+		    "suppress-all!" => \$suppress_all,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
@@ -662,8 +667,11 @@ foreach my $t (@files) {
 					$subject = $1;
 
 				} elsif (/^(Cc|From):\s+(.*)$/) {
-					if (unquote_rfc2047($2) eq $sender) {
-						next if ($suppress_from);
+					if (unquote_rfc2047($2)) {
+						next if ($suppress_all);
+					}
+					elsif (unquote_rfc2047($2) eq $sender) {
+						next if ($suppress_from|$suppress_all);
 					}
 					elsif ($1 eq 'From') {
 						$author = unquote_rfc2047($2);
@@ -700,7 +708,7 @@ foreach my $t (@files) {
 			}
 		} else {
 			$message .=  $_;
-			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
+			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc && !$suppress_all) {
 				my $c = $2;
 				chomp $c;
 				push @cc, $c;
-- 
1.5.3.1.91.gd3392
