From: Adam Roben <aroben@apple.com>
Subject: [PATCH 1/2] git-send-email: Add negations and config equivalents for --suppress-from and --no-signed-off-cc
Date: Tue, 26 Jun 2007 23:53:57 -0700
Message-ID: <1182927238504-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 08:54:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3RPd-0006q2-IE
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 08:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbXF0GyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 02:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbXF0Gx7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 02:53:59 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:49422 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbXF0Gx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 02:53:58 -0400
Received: from relay6.apple.com (relay6.apple.com [17.128.113.36])
	by mail-out4.apple.com (Postfix) with ESMTP id 6E29FA95319;
	Tue, 26 Jun 2007 23:53:58 -0700 (PDT)
Received: from relay6.apple.com (unknown [127.0.0.1])
	by relay6.apple.com (Symantec Mail Security) with ESMTP id 5A3E7100C7;
	Tue, 26 Jun 2007 23:53:58 -0700 (PDT)
X-AuditID: 11807124-a3ce4bb0000007e2-64-46820986a9f8
Received: from localhost.localdomain (int-si-a.apple.com [17.128.113.41])
	by relay6.apple.com (Apple SCV relay) with ESMTP id 2C3DF10025;
	Tue, 26 Jun 2007 23:53:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.2.551.ga811
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51022>

This change makes git-send-email's behavior easier to modify by adding config
equivalents for two more of git-send-email's flags.

The mapping of flag to config setting is:
--[no-]supress-from => sendemail.suppressfrom
--[no-]signed-off-cc => sendemail.signedoffcc

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Thanks to Junio for the suggestion for how to clean up the default values.

 Documentation/git-send-email.txt |   16 ++++++++++------
 git-send-email.perl              |   34 +++++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 946bd76..01bbd18 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -59,9 +59,11 @@ The --cc option must be repeated for each user you want on the cc list.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---no-signed-off-by-cc::
-	Do not add emails found in Signed-off-by: or Cc: lines to the
-	cc list.
+--signed-off-by-cc, --no-signed-off-by-cc::
+        If this is set, add emails found in Signed-off-by: or Cc: lines to the
+        cc list.
+        Default is the value of 'sendemail.signedoffbycc' configuration value;
+        if that is unspecified, default to --signed-off-by-cc.
 
 --quiet::
 	Make git-send-email less verbose.  One line per email should be
@@ -82,9 +84,11 @@ The --cc option must be repeated for each user you want on the cc list.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---suppress-from::
-	Do not add the From: address to the cc: list, if it shows up in a From:
-	line.
+--suppress-from, --no-suppress-from::
+        If this is set, do not add the From: address to the cc: list, if it
+        shows up in a From: line.
+        Default is the value of 'sendemail.suppressfrom' configuration value;
+        if that is unspecified, default to --no-supress-from.
 
 --dry-run::
 	Do everything except actually send the emails.
diff --git a/git-send-email.perl b/git-send-email.perl
index 9f75551..584eda9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -64,15 +64,14 @@ Options:
                   email sent, rather than to the first email sent.
                   Defaults to on.
 
-   --no-signed-off-cc Suppress the automatic addition of email addresses
-                 that appear in Signed-off-by: or Cc: lines to the cc:
-                 list.  Note: Using this option is not recommended.
+   --signed-off-cc Automatically add email addresses that appear in
+                 Signed-off-by: or Cc: lines to the cc: list. Defaults to on.
 
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.
 
    --suppress-from Suppress sending emails to yourself if your address
-                  appears in a From: line.
+                  appears in a From: line. Defaults to off.
 
    --quiet	  Make git-send-email less verbose.  One line per email
                   should be all that is output.
@@ -137,9 +136,6 @@ my $compose_filename = ".msg.$$";
 my (@to,@cc,@initial_cc,@bcclist,@xh,
 	$initial_reply_to,$initial_subject,@files,$from,$compose,$time);
 
-# Behavior modification variables
-my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
-	$dry_run) = (1, 0, 0, 0, 0);
 my $smtp_server;
 my $envelope_sender;
 
@@ -154,9 +150,21 @@ if ($@) {
 	$term = new FakeTerm "$@: going non-interactive";
 }
 
-my $def_chain = $repo->config_bool('sendemail.chainreplyto');
-if (defined $def_chain and not $def_chain) {
-    $chain_reply_to = 0;
+# Behavior modification variables
+my ($quiet, $dry_run) = (0, 0);
+
+# Variables with corresponding config settings
+my ($chain_reply_to, $suppress_from, $signed_off_cc);
+
+my %config_settings = (
+    "chainreplyto" => [\$chain_reply_to, 1],
+    "suppressfrom" => [\$suppress_from, 0],
+    "signedoffcc" => [\$signed_off_cc, 1],
+);
+
+foreach my $setting (keys %config_settings) {
+    my $config = $repo->config_bool("sendemail.$setting");
+    ${$config_settings{$setting}->[0]} = (defined $config) ? $config : $config_settings{$setting}->[1];
 }
 
 @bcclist = $repo->config('sendemail.bcc');
@@ -177,8 +185,8 @@ my $rc = GetOptions("from=s" => \$from,
 		    "smtp-server=s" => \$smtp_server,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
-		    "suppress-from" => \$suppress_from,
-		    "no-signed-off-cc|no-signed-off-by-cc" => \$no_signed_off_cc,
+		    "suppress-from!" => \$suppress_from,
+		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 	 );
@@ -609,7 +617,7 @@ foreach my $t (@files) {
 			}
 		} else {
 			$message .=  $_;
-			if (/^(Signed-off-by|Cc): (.*)$/i && !$no_signed_off_cc) {
+			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
 				my $c = $2;
 				chomp $c;
 				push @cc, $c;
-- 
1.5.2.2.551.ga811
