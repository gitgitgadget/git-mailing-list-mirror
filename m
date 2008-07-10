From: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
Subject: [PATCH] Added --export option to git-send-email.
Date: Thu, 10 Jul 2008 17:07:35 +0300
Message-ID: <20080710170735.4c5b237a@linux360.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: ryan@michonline.com
X-From: git-owner@vger.kernel.org Thu Jul 10 16:23:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGx2u-0008EQ-O0
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 16:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073AbYGJOV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 10:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbYGJOV4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 10:21:56 -0400
Received: from [194.117.236.238] ([194.117.236.238]:51754 "EHLO
	heracles.linux360.ro" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbYGJOV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 10:21:56 -0400
X-Greylist: delayed 677 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jul 2008 10:21:53 EDT
Received: from localhost (82-76-182-196.rdsnet.ro [82.76.182.196] (may be forged))
	(authenticated bits=0)
	by heracles.linux360.ro (8.13.1/8.13.1) with ESMTP id m6AE82UW029612
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Thu, 10 Jul 2008 17:08:04 +0300
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.1; x86_64-pc-linux-gnu)
X-Spam-Status: No, score=1.7 required=5.0 tests=AWL,BAYES_00,HELO_LOCALHOST,
	RDNS_NONE autolearn=no version=3.2.4
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on heracles.linux360.ro
X-Virus-Scanned: ClamAV 0.93/6834/Sat Apr 19 00:09:50 2008 on heracles.linux360.ro
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87974>

This option allows the user to process patches with git-send-email and then
import them into an email client, without having to send them directly. The
output format is mbox.

Signed-off-by: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
---
 Documentation/git-send-email.txt |    6 ++++++
 git-send-email.perl              |   19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index afbb294..17a59dd 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -73,6 +73,12 @@ The --cc option must be repeated for each user you want on the cc list.
         Default is the value of 'sendemail.signedoffcc' configuration value;
         if that is unspecified, default to --signed-off-by-cc.
 
+--export::
+	Do not send anything, just export the emails in mbox format. You can
+	use this if you need to import the messages into your email client,
+	for example. Overwrites the target, which must not be one of the
+	input files.
+
 --quiet::
 	Make git-send-email less verbose.  One line per email should be
 	all that is output.
diff --git a/git-send-email.perl b/git-send-email.perl
index 3564419..53539cf 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -100,6 +100,9 @@ Options:
    --thread       Specify that the "In-Reply-To:" header should be set on all
                   emails. Defaults to on.
 
+   --export	  Don't actually send emails, just export them to a mbox file.
+		  Overwrites target, which must not be one of the input files.
+
    --quiet	  Make git-send-email less verbose.  One line per email
                   should be all that is output.
 
@@ -184,6 +187,7 @@ if ($@) {
 
 # Behavior modification variables
 my ($quiet, $dry_run) = (0, 0);
+my ($export_file);
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
@@ -260,6 +264,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "suppress-from!" => \$suppress_from,
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
+		    "export=s" => \$export_file,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
@@ -691,6 +696,7 @@ sub sanitize_address
 
 }
 
+my ($out);
 sub send_message
 {
 	my @recipients = unique_email_list(@to);
@@ -741,6 +747,10 @@ X-Mailer: git-send-email $gitversion
 
 	if ($dry_run) {
 		# We don't want to send the email.
+	} elsif (defined $export_file) {
+		my $mbox_from = "From $raw_from $date";
+		$message =~ s/^(>{0,})From/>$1From/m;
+		print $out "$mbox_from\n$header\n$message";
 	} elsif ($smtp_server =~ m#^/#) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
@@ -835,6 +845,11 @@ $reply_to = $initial_reply_to;
 $references = $initial_reply_to || '';
 $subject = $initial_subject;
 
+if (defined $export_file) {
+	my $err = open $out, '>', $export_file;
+	defined $err or die "Can't open '$export_file': $!";
+}
+
 foreach my $t (@files) {
 	open(F,"<",$t) or die "can't open file $t";
 
@@ -979,6 +994,10 @@ foreach my $t (@files) {
 	$message_id = undef;
 }
 
+if (defined $export_file) {
+	close $out or warn $?;
+}
+
 if ($compose) {
 	cleanup_compose_files();
 }
-- 
1.5.6.1
