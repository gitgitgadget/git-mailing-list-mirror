From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH] Add sendmail -f support to git-send-email.
Date: Tue, 10 Apr 2007 15:02:13 -0700
Message-ID: <11762425341841-git-send-email-robbat2@gentoo.org>
Cc: junkio@cox.net, Robin@orbis-terrarum.net,
	H.Johnson@orbis-terrarum.net, <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 07:19:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbOPt-0002K6-LL
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbXDJWCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbXDJWCS
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:02:18 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:52303 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753932AbXDJWCR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:02:17 -0400
Received: (qmail 8793 invoked from network); 10 Apr 2007 22:02:16 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 10 Apr 2007 22:02:16 +0000
Received: (qmail 23105 invoked from network); 10 Apr 2007 15:02:14 -0700
Received: from buck-int.local.orbis-terrarum.net (HELO buck-int.orbis-terrarum.net) (172.16.9.3)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 10 Apr 2007 15:02:14 -0700
Received: (nullmailer pid 25784 invoked by uid 0);
	Tue, 10 Apr 2007 22:02:14 -0000
X-Mailer: git-send-email 1.5.1
In-Reply-To: 11762424311160-git-send-email-robbat2@gentoo.org
References: 11762424311160-git-send-email-robbat2@gentoo.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44185>

Some mailing lists use the envelope sender instead of the actual from address,
and this can be broken in git-send-email. This patch sets the -f argument to
the sendmail binary, using the address of the patch author.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 git-send-email.perl |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ae50990..2436aec 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -34,7 +34,6 @@ sub readline {
 }
 package main;
 
-
 sub usage {
 	print <<EOT;
 git-send-email [options] <file | directory>...
@@ -446,6 +445,7 @@ sub send_message
 		my ($name, $addr) = ($from =~ /^(.*?)(\s+<.*)/);
 		$from = "\"$name\"$addr";
 	}
+	my ($author_addr) = ($from =~ /^.*?\s+<(.*?)>/);
 	my $header = "From: $from
 To: $to
 Cc: $cc
@@ -462,16 +462,15 @@ X-Mailer: git-send-email $gitversion
 	if (@xh) {
 		$header .= join("\n", @xh) . "\n";
 	}
-
+	
+	my @sendmail_args = ('-f',$author_addr,'-i', map { extract_valid_address($_) } @recipients);
 	if ($dry_run) {
 		# We don't want to send the email.
 	} elsif ($smtp_server =~ m#^/#) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
-			exec($smtp_server,'-i',
-			     map { extract_valid_address($_) }
-			     @recipients) or die $!;
+			exec($smtp_server, @sendmail_args) or die $!;
 		}
 		print $sm "$header\n$message";
 		close $sm or die $?;
@@ -493,6 +492,11 @@ X-Mailer: git-send-email $gitversion
 			print "Server: $smtp_server\n";
 		} else {
 			print "Sendmail: $smtp_server\n";
+			my $s = "";
+			foreach my $a (@sendmail_args) {
+				$s .= " \'".$a."\'";
+			}
+			print "Args:$s\n";
 		}
 		print "From: $from\nSubject: $subject\nCc: $cc\nTo: $to\n\n";
 		if ($smtp) {
-- 
1.5.1
