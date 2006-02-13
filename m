From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 1/2] send-email: Add some options for controlling how addresses are automatically
Date: Mon, 13 Feb 2006 03:22:04 -0500
Message-ID: <11398189241095-git-send-email-ryan@michonline.com>
References: <11398189232404-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 09:22:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Yyw-0002Dc-TJ
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 09:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWBMIWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 03:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWBMIWs
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 03:22:48 -0500
Received: from mail.autoweb.net ([198.172.237.26]:42689 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751346AbWBMIWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 03:22:47 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F8Yyq-0001k8-Uk; Mon, 13 Feb 2006 03:22:47 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F8Yyl-000283-MV; Mon, 13 Feb 2006 03:22:44 -0500
Received: from localhost
	([127.0.0.1] helo=mythryan2 ident=ryan)
	by mythical with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F8YyC-0002pH-9C; Mon, 13 Feb 2006 03:22:04 -0500
In-Reply-To: <11398189232404-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Spam-Score: -2.5
X-Spam-Report: Spam detection software, running on the system "h4x0r5.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Signed-off-by: Ryan Anderson <ryan@michonline.com> ---
	Documentation/git-send-email.txt | 7 +++++++ git-send-email.perl | 15
	++++++++++++--- 2 files changed, 19 insertions(+), 3 deletions(-) [...] 
	Content analysis details:   (-2.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.4 X_MAILER_SPAM          X-Mailer: header is bulk email fingerprint
	-0.0 SPF_PASS               SPF: sender matches SPF record
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	-1.3 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16053>

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 Documentation/git-send-email.txt |    7 +++++++
 git-send-email.perl              |   15 ++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

dc4ad3ef1b29ce35dc0ace4d284cfab5e594bfb7
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 00537d8..c2f52f5 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -48,6 +48,9 @@ The options available are:
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
+--no-signed-off-by-cc::
+	Do not add emails foudn in Signed-off-by: lines to the cc list.
+
 --quiet::
 	Make git-send-email less verbose.  One line per email should be
 	all that is output.
@@ -61,6 +64,10 @@ The options available are:
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
+--suppress-from::
+	Do not add the From: address to the cc: list, if it shows up in a From:
+	line.
+
 --to::
 	Specify the primary recipient of the emails generated.
 	Generally, this will be the upstream maintainer of the
diff --git a/git-send-email.perl b/git-send-email.perl
index 3f1b3ca..abffca5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -34,7 +34,7 @@ my $compose_filename = ".msg.$$";
 my (@to,@cc,$initial_reply_to,$initial_subject,@files,$from,$compose);
 
 # Behavior modification variables
-my ($chain_reply_to, $smtp_server, $quiet) = (1, "localhost", 0);
+my ($chain_reply_to, $smtp_server, $quiet, $suppress_from, $no_signed_off_cc) = (1, "localhost", 0, 0, 0);
 
 # Example reply to:
 #$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
@@ -52,6 +52,8 @@ my $rc = GetOptions("from=s" => \$from,
 		    "smtp-server=s" => \$smtp_server,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
+		    "suppress-from" => \$suppress_from,
+		    "no-signed-off-cc" => \$no_signed_off_cc,
 	 );
 
 # Now, let's fill any that aren't set in with defaults:
@@ -212,13 +214,19 @@ Options:
                   email sent, rather than to the first email sent.
                   Defaults to on.
 
+   --no-signed-off-cc Suppress the automatic addition of email addresses
+                 that appear in a Signed-off-by: line, to the cc: list.
+		 Note: Using this option is not recommended.
+
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.
 
+  --suppress-from Supress sending emails to yourself if your address
+                  appears in a From: line.
+
    --quiet	Make git-send-email less verbose.  One line per email should be
 		all that is output.
 
-
 Error: Please specify a file or a directory on the command line.
 EOT
 	exit(1);
@@ -304,6 +312,7 @@ foreach my $t (@files) {
 					$subject = $1;
 
 				} elsif (/^(Cc|From):\s+(.*)$/) {
+					next if ($2 eq $from && $suppress_from);
 					printf("(mbox) Adding cc: %s from line '%s'\n",
 						$2, $_) unless $quiet;
 					push @cc, $2;
@@ -332,7 +341,7 @@ foreach my $t (@files) {
 			}
 		} else {
 			$message .=  $_;
-			if (/^Signed-off-by: (.*)$/i) {
+			if (/^Signed-off-by: (.*)$/i && !$no_signed_off_cc) {
 				my $c = $1;
 				chomp $c;
 				push @cc, $c;
-- 
1.2.0.g6d18
