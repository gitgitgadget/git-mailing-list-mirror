From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Add --dry-run option to git-send-email
Date: Tue, 10 Oct 2006 08:58:23 -0600
Message-ID: <20061010145823.GB8993@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 10 16:59:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXJ3s-00084j-3P
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 16:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWJJO6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 10:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWJJO6Y
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 10:58:24 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:5584 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932139AbWJJO6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 10:58:24 -0400
Received: by mail.parisc-linux.org (Postfix, from userid 26919)
	id 02FD5494009; Tue, 10 Oct 2006 08:58:23 -0600 (MDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28632>


Add a --dry-run option to git-send-email due to having made too many
mistakes with it in the past week.  I like having a safety catch on my
machine gun.

Signed-off-by: Matthew @ilcox <matthew@wil.cx>

--- /usr/bin/git-send-email	2006-07-29 09:52:13.000000000 -0600
+++ ./git-send-email.perl	2006-10-10 08:46:13.000000000 -0600
@@ -40,7 +40,8 @@
 	$initial_reply_to,$initial_subject,@files,$from,$compose,$time);
 
 # Behavior modification variables
-my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc) = (1, 0, 0, 0);
+my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
+	$dry_run) = (1, 0, 0, 0, 0);
 my $smtp_server;
 
 # Example reply to:
@@ -63,6 +64,7 @@
 		    "quiet" => \$quiet,
 		    "suppress-from" => \$suppress_from,
 		    "no-signed-off-cc|no-signed-off-by-cc" => \$no_signed_off_cc,
+		    "dry-run" => \$dry_run,
 	 );
 
 # Verify the user input
@@ -395,7 +397,9 @@
 		$header .= "References: $references\n";
 	}
 
-	if ($smtp_server =~ m#^/#) {
+	if ($dry_run) {
+		# We don't want to send the email.
+	} elsif ($smtp_server =~ m#^/#) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
