From: Dan Nicholson <dbn.lists@gmail.com>
Subject: [PATCH] send-email: Allow sleeping between sending mails
Date: Sat,  8 Dec 2007 09:12:07 -0800
Message-ID: <1197133927-32547-1-git-send-email-dbn.lists@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 18:19:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J13Kv-0006z1-Js
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 18:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752405AbXLHRTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 12:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbXLHRTK
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 12:19:10 -0500
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:36666 "EHLO
	QMTA08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752153AbXLHRTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2007 12:19:09 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Dec 2007 12:19:09 EST
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA08.emeryville.ca.mail.comcast.net with comcast
	id N9hu1Y0040EPcho0A0Xa00; Sat, 08 Dec 2007 17:12:13 +0000
Received: from tilt.dwcab.com ([24.19.23.110])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id NHCC1Y00A2NWxCw0800000; Sat, 08 Dec 2007 17:12:13 +0000
X-Authority-Analysis: v=1.0 c=1 a=6zVKPa5DjGAA:10 a=kYJW4Vaswm8-p37THUoA:9 a=a_C5eqVa69uEoT5t3zgA:7 a=qh3M0id1FYdAPBv8JGrfvY_ursEA:4 a=MSl-tDqOz04A:10 a=A0iLbYl8zZEA:10 a=oqs56FR1YJwA:10
Received: by tilt.dwcab.com (Postfix, from userid 1000)
	id 529F014AE44; Sat,  8 Dec 2007 09:12:07 -0800 (PST)
X-Mailer: git-send-email 1.5.3.7.1112.g9758e-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67561>

Sometimes when sending many mails, the thread appears out of order for
the recipient. This adds a simple workaround by sleeping between sending
mails. This is controlled by the option --sleep, which defaults to 0.

Since the perl builtin function sleep is used, only integer granularity
is offered. GetOptions seems to perform the necessary checking for this.

Signed-off-by: Dan Nicholson <dbn.lists@gmail.com>
---
 Documentation/git-send-email.txt |    5 +++++
 git-send-email.perl              |   14 +++++++++++++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 659215a..45341db 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -71,6 +71,11 @@ The --cc option must be repeated for each user you want on the cc list.
         Default is the value of 'sendemail.signedoffcc' configuration value;
         if that is unspecified, default to --signed-off-by-cc.
 
+--sleep::
+	Specify an integer number of seconds to sleep between sending
+	mails. This can help when sending many mails at once and they
+	appear out of order for the recipient. Defaults to 0.
+
 --quiet::
 	Make git-send-email less verbose.  One line per email should be
 	all that is output.
diff --git a/git-send-email.perl b/git-send-email.perl
index 76baa8e..a105306 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -100,6 +100,9 @@ Options:
 
    --envelope-sender	Specify the envelope sender used to send the emails.
 
+   --sleep        Specify an integer number of seconds to sleep between
+                  sending mails. Defaults to 0.
+
 EOT
 	exit(1);
 }
@@ -158,6 +161,7 @@ my (@to,@cc,@initial_cc,@bcclist,@xh,
 	$initial_reply_to,$initial_subject,@files,$author,$sender,$compose,$time);
 
 my $envelope_sender;
+my $mail_index;
 
 # Example reply to:
 #$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
@@ -171,7 +175,7 @@ if ($@) {
 }
 
 # Behavior modification variables
-my ($quiet, $dry_run) = (0, 0);
+my ($quiet, $dry_run, $sleep_time) = (0, 0, 0);
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
@@ -222,6 +226,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
+		    "sleep=i" => \$sleep_time,
 	 );
 
 unless ($rc) {
@@ -669,6 +674,7 @@ X-Mailer: git-send-email $gitversion
 $reply_to = $initial_reply_to;
 $references = $initial_reply_to || '';
 $subject = $initial_subject;
+$mail_index = 0;
 
 foreach my $t (@files) {
 	open(F,"<",$t) or die "can't open file $t";
@@ -803,6 +809,12 @@ foreach my $t (@files) {
 			$references = "$message_id";
 		}
 	}
+
+	# sleep if requested and there are any mails left
+	if ($sleep_time > 0 && $mail_index < $#files) {
+		sleep $sleep_time;
+	}
+	$mail_index++;
 }
 
 if ($compose) {
-- 
1.5.3.2
