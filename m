From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 1/2] Make git-send-email-script ignore some unnecessary options when operating in batch mode.
Date: Mon, 5 Sep 2005 01:13:07 -0400
Message-ID: <1125897187857-git-send-email-ryan@michonline.com>
References: <11258971871874-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 07:15:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC9IC-0002sw-PF
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 07:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVIEFNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 01:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVIEFNL
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 01:13:11 -0400
Received: from mail.autoweb.net ([198.172.237.26]:19870 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1751019AbVIEFNK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 01:13:10 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EC9I5-0003jT-Io
	for git@vger.kernel.org; Mon, 05 Sep 2005 01:13:09 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EC9I4-00042t-00; Mon, 05 Sep 2005 01:13:08 -0400
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan with smtp (Exim 4.52)
	id 1EC9I3-000890-OG; Mon, 05 Sep 2005 01:13:07 -0400
In-Reply-To: <11258971871874-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8079>

Add a "--compose" option that uses $EDITOR to edit an "introductory" email to the patch series.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 git-send-email-script |   86 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 81 insertions(+), 5 deletions(-)

b3c7bf0ee80c1d207c9208972f011540b4c0528f
diff --git a/git-send-email-script b/git-send-email-script
--- a/git-send-email-script
+++ b/git-send-email-script
@@ -25,9 +25,13 @@ use Data::Dumper;
 use Email::Valid;
 
 sub unique_email_list(@);
+sub cleanup_compose_files();
+
+# Constants (essentially)
+my $compose_filename = ".msg.$$";
 
 # Variables we fill in automatically, or via prompting:
-my (@to,@cc,$initial_reply_to,$initial_subject,@files,$from);
+my (@to,@cc,$initial_reply_to,$initial_subject,@files,$from,$compose);
 
 # Behavior modification variables
 my ($chain_reply_to, $smtp_server) = (1, "localhost");
@@ -46,6 +50,7 @@ my $rc = GetOptions("from=s" => \$from,
 		    "to=s" => \@to,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
+		    "compose" => \$compose,
 	 );
 
 # Now, let's fill any that aren't set in with defaults:
@@ -69,7 +74,7 @@ while(<GITVAR>) {
 }
 close(GITVAR);
 
-
+my $prompting = 0;
 if (!defined $from) {
 	$from = $author || $committer;
 	do {
@@ -79,6 +84,7 @@ if (!defined $from) {
 
 	$from = $_;
 	print "Emails will be sent from: ", $from, "\n";
+	$prompting++;
 }
 
 if (!@to) {
@@ -88,19 +94,21 @@ if (!@to) {
 	} while (!defined $_);
 	my $to = $_;
 	push @to, split /,/, $to;
+	$prompting++;
 }
 
-if (!defined $initial_subject) {
+if (!defined $initial_subject && $compose) {
 	do {
 		$_ = $term->readline("What subject should the emails start with? ",
 			$initial_subject);
 	} while (!defined $_);
 	$initial_subject = $_;
+	$prompting++;
 }
 
-if (!defined $initial_reply_to) {
+if (!defined $initial_reply_to && $prompting) {
 	do {
-		$_= $term->readline("Message-ID to be used as In-Reply-To? ",
+		$_= $term->readline("Message-ID to be used as In-Reply-To for the first email? ",
 			$initial_reply_to);
 	} while (!defined $_);
 
@@ -112,6 +120,52 @@ if (!defined $smtp_server) {
 	$smtp_server = "localhost";
 }
 
+if ($compose) {
+	# Note that this does not need to be secure, but we will make a small
+	# effort to have it be unique
+	open(C,">",$compose_filename)
+		or die "Failed to open for writing $compose_filename: $!";
+	print C "From \n";
+	printf C "Subject: %s\n\n", $initial_subject;
+	printf C <<EOT;
+GIT: Please enter your email below.
+GIT: Lines beginning in "GIT: " will be removed.
+GIT: Consider including an overall diffstat or table of contents
+GIT: for the patch you are writing.
+
+EOT
+	close(C);
+
+	my $editor = $ENV{EDITOR};
+	$editor = 'vi' unless defined $editor;
+	system($editor, $compose_filename);
+
+	open(C2,">",$compose_filename . ".final")
+		or die "Failed to open $compose_filename.final : " . $!;
+
+	open(C,"<",$compose_filename)
+		or die "Failed to open $compose_filename : " . $!;
+
+	while(<C>) {
+		next if m/^GIT: /;
+		print C2 $_;
+	}
+	close(C);
+	close(C2);
+
+	do {
+		$_ = $term->readline("Send this email? (y|n) ");
+	} while (!defined $_);
+
+	if (uc substr($_,0,1) ne 'Y') {
+		cleanup_compose_files();
+		exit(0);
+	}
+
+	@files = ($compose_filename . ".final");
+}
+
+
 # Now that all the defaults are set, process the rest of the command line
 # arguments and collect up the files that need to be processed.
 for my $f (@ARGV) {
@@ -137,12 +191,24 @@ if (@files) {
 git-send-email-script [options] <file | directory> [... file | directory ]
 Options:
    --from         Specify the "From:" line of the email to be sent.
+
    --to           Specify the primary "To:" line of the email.
+
+   --compose      Use \$EDITOR to edit an introductory message for the
+                  patch series.
+
    --subject      Specify the initial "Subject:" line.
+                  Only necessary if --compose is also set.  If --compose
+		  is not set, this will be prompted for.
+
    --in-reply-to  Specify the first "In-Reply-To:" header line.
+                  Only used if --compose is also set.  If --compose is not
+		  set, this will be prompted for.
+
    --chain-reply-to If set, the replies will all be to the previous
                   email sent, rather than to the first email sent.
                   Defaults to on.
+
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.
 
@@ -278,6 +344,16 @@ foreach my $t (@files) {
 	make_message_id();
 }
 
+if ($compose) {
+	cleanup_compose_files();
+}
+
+sub cleanup_compose_files() {
+	unlink($compose_filename, $compose_filename . ".final");
+
+}
+
+
 
 sub unique_email_list(@) {
 	my %seen;
