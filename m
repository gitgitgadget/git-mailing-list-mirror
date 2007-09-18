From: felipebalbi@users.sourceforge.net
Subject: [PATCH] git-send-email: Add a --cc-nobody option
Date: Tue, 18 Sep 2007 07:42:02 -0400
Message-ID: <11901157221792-git-send-email-felipebalbi@users.sourceforge.net>
Cc: Felipe Balbi <felipe.lima@indt.org.br>
To: git@vger.kernel.org, ae@op5.se
X-From: git-owner@vger.kernel.org Tue Sep 18 14:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXcGG-00067V-JZ
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 14:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756488AbXIRMc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 08:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756383AbXIRMc7
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 08:32:59 -0400
Received: from smtp.nokia.com ([131.228.20.170]:45536 "EHLO
	mgw-ext11.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbXIRMc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 08:32:58 -0400
X-Greylist: delayed 2987 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Sep 2007 08:32:57 EDT
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-ext11.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l8IBgvmV026064;
	Tue, 18 Sep 2007 14:43:04 +0300
Received: from daebh101.NOE.Nokia.com ([10.241.35.111]) by esebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Sep 2007 14:42:28 +0300
Received: from mzebe101.NOE.Nokia.com ([172.18.99.71]) by daebh101.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Sep 2007 06:42:26 -0500
Received: from 1BRL00624.nokia.com ([172.18.216.158]) by mzebe101.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Sep 2007 07:41:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by 1BRL00624.nokia.com (Postfix) with ESMTP id B152F100150;
	Tue, 18 Sep 2007 07:42:02 -0400 (AMT)
X-Mailer: git-send-email 1.5.3.1.91.gd3392
In-Reply-To: 46EF8107.1030607
References: 46EF8107.1030607
X-OriginalArrivalTime: 18 Sep 2007 11:41:53.0886 (UTC) FILETIME=[E8EC07E0:01C7F9E8]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58595>

From: Felipe Balbi <felipe.lima@indt.org.br>

This patch adds a --cc-nobody option to avoid sending emails
to everybody but the ones listed by --to option.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 git-send-email.perl |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4031e86..a5a466c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -88,6 +88,9 @@ Options:
    --suppress-from Suppress sending emails to yourself if your address
                   appears in a From: line. Defaults to off.
 
+   --cc-nobody	  Do not send emails to anyone unless explicitly listed by
+		  --to option.
+
    --thread       Specify that the "In-Reply-To:" header should be set on all
                   emails. Defaults to on.
 
@@ -171,7 +174,7 @@ if ($@) {
 my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
+my ($thread, $chain_reply_to, $suppress_from, $cc_nobody, $signed_off_cc, $cc_cmd);
 my ($smtp_server, $smtp_authuser, $smtp_authpass, $smtp_ssl);
 my ($identity, $aliasfiletype, @alias_files);
 
@@ -179,6 +182,7 @@ my %config_bool_settings = (
     "thread" => [\$thread, 1],
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, 0],
+    "ccnobody" => [\$cc_nobody, 0],
     "signedoffcc" => [\$signed_off_cc, 1],
     "smtpssl" => [\$smtp_ssl, 0],
 );
@@ -212,6 +216,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
+		    "cc-nobody!" => \$cc_nobody,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
@@ -669,8 +674,11 @@ foreach my $t (@files) {
 					$subject = $1;
 
 				} elsif (/^(Cc|From):\s+(.*)$/) {
-					if (unquote_rfc2047($2) eq $sender) {
-						next if ($suppress_from);
+					if (unquote_rfc2047($2)) {
+						next if ($cc_nobody);
+					}
+					elsif (unquote_rfc2047($2) eq $sender) {
+						next if ($suppress_from|$cc_nobody);
 					}
 					elsif ($1 eq 'From') {
 						$author = unquote_rfc2047($2);
@@ -707,7 +715,7 @@ foreach my $t (@files) {
 			}
 		} else {
 			$message .=  $_;
-			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
+			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc && !$cc_nobody) {
 				my $c = $2;
 				chomp $c;
 				push @cc, $c;
-- 
1.5.3.1.91.gd3392
