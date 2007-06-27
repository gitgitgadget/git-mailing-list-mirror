From: Adam Roben <aroben@apple.com>
Subject: [PATCH 2/2] git-send-email: Add --thread option
Date: Tue, 26 Jun 2007 23:53:58 -0700
Message-ID: <1182927238870-git-send-email-aroben@apple.com>
References: <1182927238504-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 08:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3RPe-0006q2-1Y
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 08:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbXF0GyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 02:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbXF0GyA
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 02:54:00 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:49423 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbXF0Gx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 02:53:58 -0400
Received: from relay6.apple.com (relay6.apple.com [17.128.113.36])
	by mail-out4.apple.com (Postfix) with ESMTP id 716B2A9531A;
	Tue, 26 Jun 2007 23:53:58 -0700 (PDT)
Received: from relay6.apple.com (unknown [127.0.0.1])
	by relay6.apple.com (Symantec Mail Security) with ESMTP id 5A5A6100CD;
	Tue, 26 Jun 2007 23:53:58 -0700 (PDT)
X-AuditID: 11807124-a34e3bb0000007e2-65-468209869f6c
Received: from localhost.localdomain (int-si-a.apple.com [17.128.113.41])
	by relay6.apple.com (Apple SCV relay) with ESMTP id 444711006A;
	Tue, 26 Jun 2007 23:53:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.2.551.ga811
In-Reply-To: <1182927238504-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51023>

The --thread option controls whether the In-Reply-To header will be set on
any emails sent. The current behavior is to always set this header, so this
option is most useful in its negated form, --no-thread. This behavior can
also be controlled through the 'sendemail.threaded' config setting.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Apologies to Junio, Matthias, and Julian, who had to endure a spamming from me
 in the development of this patch.

 Documentation/git-send-email.txt |    7 +++++++
 git-send-email.perl              |   11 ++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 01bbd18..293686c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -90,6 +90,13 @@ The --cc option must be repeated for each user you want on the cc list.
         Default is the value of 'sendemail.suppressfrom' configuration value;
         if that is unspecified, default to --no-supress-from.
 
+--thread, --no-thread::
+	If this is set, the In-Reply-To header will be set on each email sent.
+	If disabled with "--no-thread", no emails will have the In-Reply-To
+	header set.
+	Default is the value of the 'sendemail.thread' configuration value;
+	if that is unspecified, default to --thread.
+
 --dry-run::
 	Do everything except actually send the emails.
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 584eda9..28659f8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -73,6 +73,9 @@ Options:
    --suppress-from Suppress sending emails to yourself if your address
                   appears in a From: line. Defaults to off.
 
+    --thread      Specify that the "In-Reply-To:" header should be set on all
+                  emails. Defaults to on.
+
    --quiet	  Make git-send-email less verbose.  One line per email
                   should be all that is output.
 
@@ -154,9 +157,10 @@ if ($@) {
 my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
-my ($chain_reply_to, $suppress_from, $signed_off_cc);
+my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc);
 
 my %config_settings = (
+    "thread" => [\$thread, 1],
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, 0],
     "signedoffcc" => [\$signed_off_cc, 1],
@@ -189,6 +193,7 @@ my $rc = GetOptions("from=s" => \$from,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
+		    "thread!" => \$thread,
 	 );
 
 unless ($rc) {
@@ -295,7 +300,7 @@ if (!defined $initial_subject && $compose) {
 	$prompting++;
 }
 
-if (!defined $initial_reply_to && $prompting) {
+if ($thread && !defined $initial_reply_to && $prompting) {
 	do {
 		$_= $term->readline("Message-ID to be used as In-Reply-To for the first email? ",
 			$initial_reply_to);
@@ -492,7 +497,7 @@ Date: $date
 Message-Id: $message_id
 X-Mailer: git-send-email $gitversion
 ";
-	if ($reply_to) {
+	if ($thread && $reply_to) {
 
 		$header .= "In-Reply-To: $reply_to\n";
 		$header .= "References: $references\n";
-- 
1.5.2.2.551.ga811
