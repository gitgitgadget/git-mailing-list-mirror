From: Adam Roben <aroben@apple.com>
Subject: [PATCH] git-send-email: Add --threaded option
Date: Tue, 26 Jun 2007 15:57:40 -0700
Message-ID: <11828986601206-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 00:57:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Jyi-0005YN-8o
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 00:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757641AbXFZW5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 18:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757433AbXFZW5m
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 18:57:42 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:57234 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756772AbXFZW5l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 18:57:41 -0400
Received: from relay7.apple.com (relay7.apple.com [17.128.113.37])
	by mail-out3.apple.com (Postfix) with ESMTP id 20DDEA52FA9;
	Tue, 26 Jun 2007 15:57:41 -0700 (PDT)
Received: from relay7.apple.com (unknown [127.0.0.1])
	by relay7.apple.com (Symantec Mail Security) with ESMTP id 0C7BC3006A;
	Tue, 26 Jun 2007 15:57:41 -0700 (PDT)
X-AuditID: 11807125-a3468bb0000007df-16-468199e46f77
Received: from localhost.localdomain (int-si-a.apple.com [17.128.113.41])
	by relay7.apple.com (Apple SCV relay) with ESMTP id B53AD30047;
	Tue, 26 Jun 2007 15:57:40 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.2.549.gaeb59-dirty
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50986>

The --threaded option controls whether the In-Reply-To header will be set on
any emails sent. The current behavior is to always set this header, so this
option is most useful in its negated form, --no-threaded. This behavior can
also be controlled through the 'sendemail.threaded' config setting.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Documentation/git-send-email.txt |    7 +++++++
 git-send-email.perl              |   25 ++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 946bd76..1f5d57d 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -86,6 +86,13 @@ The --cc option must be repeated for each user you want on the cc list.
 	Do not add the From: address to the cc: list, if it shows up in a From:
 	line.
 
+--threaded, --no-threaded::
+	If this is set, the In-Reply-To header will be set on each email sent.
+	If disabled with "--no-threaded", no emails will have the In-Reply-To
+	header set.
+	Default is the value of the 'sendemail.threaded' configuration value;
+	if that is unspecified, default to --threaded.
+
 --dry-run::
 	Do everything except actually send the emails.
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 9f75551..b8b8fe7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -74,6 +74,9 @@ Options:
    --suppress-from Suppress sending emails to yourself if your address
                   appears in a From: line.
 
+    --threaded    Specify that the "In-Reply-To:" header should be set on all
+                  emails. Defaults to on.
+
    --quiet	  Make git-send-email less verbose.  One line per email
                   should be all that is output.
 
@@ -138,8 +141,8 @@ my (@to,@cc,@initial_cc,@bcclist,@xh,
 	$initial_reply_to,$initial_subject,@files,$from,$compose,$time);
 
 # Behavior modification variables
-my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
-	$dry_run) = (1, 0, 0, 0, 0);
+my ($threaded, $chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
+	$dry_run) = (1, 1, 0, 0, 0, 0);
 my $smtp_server;
 my $envelope_sender;
 
@@ -154,9 +157,16 @@ if ($@) {
 	$term = new FakeTerm "$@: going non-interactive";
 }
 
-my $def_chain = $repo->config_bool('sendemail.chainreplyto');
-if (defined $def_chain and not $def_chain) {
-    $chain_reply_to = 0;
+my %config_settings = (
+    "threaded" => \$threaded,
+    "chainreplyto" => \$chain_reply_to,
+);
+
+foreach my $setting (keys %config_settings) {
+    my $default = $repo->config_bool("sendemail.$setting");
+    if (defined $default) {
+        $config_settings{$setting} = $default ? 1 : 0;
+    }
 }
 
 @bcclist = $repo->config('sendemail.bcc');
@@ -181,6 +191,7 @@ my $rc = GetOptions("from=s" => \$from,
 		    "no-signed-off-cc|no-signed-off-by-cc" => \$no_signed_off_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
+		    "threaded!" => \$threaded,
 	 );
 
 unless ($rc) {
@@ -287,7 +298,7 @@ if (!defined $initial_subject && $compose) {
 	$prompting++;
 }
 
-if (!defined $initial_reply_to && $prompting) {
+if ($threaded && !defined $initial_reply_to && $prompting) {
 	do {
 		$_= $term->readline("Message-ID to be used as In-Reply-To for the first email? ",
 			$initial_reply_to);
@@ -484,7 +495,7 @@ Date: $date
 Message-Id: $message_id
 X-Mailer: git-send-email $gitversion
 ";
-	if ($reply_to) {
+	if ($threaded && $reply_to) {
 
 		$header .= "In-Reply-To: $reply_to\n";
 		$header .= "References: $references\n";
-- 
1.5.2.2.549.gaeb59-dirty
