From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 1/2] git-send-email-script - Fix loops that limit emails to unique values to be pedantically correct.
Date: Tue, 2 Aug 2005 21:45:22 -0400
Message-ID: <1123033522656-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 03:50:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E08Mr-0006wF-Nj
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 03:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVHCBqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 21:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVHCBpb
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 21:45:31 -0400
Received: from mail.autoweb.net ([198.172.237.26]:20701 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261954AbVHCBpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 21:45:25 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E08Jv-0007wD-B3; Tue, 02 Aug 2005 21:45:23 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E08U3-0003eh-00; Tue, 02 Aug 2005 21:55:51 -0400
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan with smtp (Exim 4.52)
	id 1E08Ju-0006XK-ND; Tue, 02 Aug 2005 21:45:22 -0400
In-Reply-To: 
X-Mailer: git-send-email-script
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Email addresses aren't generally case sensitive in the real world, but
technically, they *can* be.  So, let's do the right thing.

Additionally, fix the generated message-id to have the right template used.

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 git-send-email-script |   35 ++++++++++++++++++++++++-----------
 1 files changed, 24 insertions(+), 11 deletions(-)

8e791ded8877746b82432f2b53f871197a3c3901
diff --git a/git-send-email-script b/git-send-email-script
--- a/git-send-email-script
+++ b/git-send-email-script
@@ -24,6 +24,8 @@ use Getopt::Long;
 use Data::Dumper;
 use Email::Valid;
 
+sub unique_email_list(@);
+
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,$initial_reply_to,$initial_subject,@files,$from);
 
@@ -138,8 +140,9 @@ Options:
    --to	          Specify the primary "To:" line of the email.
    --subject      Specify the initial "Subject:" line.
    --in-reply-to  Specify the first "In-Reply-To:" header line.
-   --chain-reply-to If set, the replies will all be to the first
-   		  email sent, rather than to the last email sent.
+   --chain-reply-to If set, the replies will all be to the previous
+   		  email sent, rather than to the first email sent.
+		  Defaults to on.
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.
 
@@ -161,7 +164,7 @@ our ($message_id, $cc, %mail, $subject, 
 
 # We'll setup a template for the message id, using the "from" address:
 my $message_id_from = Email::Valid->address($from);
-my $message_id_template = "<%s-git-send-email-$from>";
+my $message_id_template = "<%s-git-send-email-$message_id_from>";
 
 sub make_message_id
 {
@@ -178,10 +181,7 @@ $cc = "";
 
 sub send_message
 {
-	my %to;
-	$to{lc(Email::Valid->address($_))}++ for (@to);
-
-	my $to = join(",", keys %to);
+	my $to = join (", ", unique_email_list(@to));
 
 	%mail = (	To	=>	$to,
 			From	=>	$from,
@@ -267,10 +267,7 @@ foreach my $t (@files) {
 	}
 	close F;
 
-	my %clean_ccs;
-	$clean_ccs{lc(Email::Valid->address($_))}++ for @cc;
-
-	$cc = join(",", keys %clean_ccs);
+	$cc = join(", ", unique_email_list(@cc));
 
 	send_message();
 
@@ -281,3 +278,19 @@ foreach my $t (@files) {
 	make_message_id();
 #	$subject = "Re: ".$initial_subject;
 }
+
+
+sub unique_email_list(@) {
+	my %seen;
+	my @emails;
+
+	foreach my $entry (@_) {
+		my $clean = Email::Valid->address($entry);
+		next if $seen{$clean}++;
+		push @emails, $entry;
+	}
+	return @emails;
+}
+
+
+
