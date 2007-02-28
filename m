From: Michael Coleman <tutufan@gmail.com>
Subject: [PATCH] git-send-email: abort/usage on bad option
Date: Tue, 27 Feb 2007 22:47:54 -0600
Message-ID: <11726380742591-git-send-email-tutufan@gmail.com>
Cc: Michael Coleman <tutufan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 05:48:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMGjU-0006sc-P1
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 05:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbXB1Er7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 23:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbXB1Er7
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 23:47:59 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:63028 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbXB1Er6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 23:47:58 -0500
Received: by nz-out-0506.google.com with SMTP id s1so32320nze
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 20:47:57 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=FuYYEGyeJIb5mpeNcVvgN9T3T+zWpCGE436JCHUBPeIJFzjTY86mEZPIFuNGYbaBxYwtfO0tf2JojqxsaIKRwDRLtLBcpxR2xO4xyf0W9cp4n0QRqRqe8IS/BkPQ5FMl5/XRFNVKRe6FpugtJe240V0bWGv4oBkzrYrf6RrRNZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=KG2RR6D+yEHpNs8wX5Bsp5Gd6Mqb67pgzvXv7heyhmgyzHyb7nKU7EhtH18luZZmTBFHEyMobb83lCKhOIPaqaILUhHY2IxR4HiyL77tyV7b+GOnY9stEQU48fziwjpm+D3+tutbV6x30UxW8bp9AUFtlpbksv4ooEYX6sNCcng=
Received: by 10.35.9.15 with SMTP id m15mr160800pyi.1172638077492;
        Tue, 27 Feb 2007 20:47:57 -0800 (PST)
Received: from tutufan@gmail.com ( [69.154.17.234])
        by mx.google.com with ESMTP id m2sm194911nzf.2007.02.27.20.47.55;
        Tue, 27 Feb 2007 20:47:56 -0800 (PST)
Received: by tutufan@gmail.com (sSMTP sendmail emulation); Tue, 27 Feb 2007 22:47:54 -0600
X-Mailer: git-send-email 1.5.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40895>

Instead of proceeding, abort and give usage message when a bad option
is seen.
---
 git-send-email.perl |   97 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6a285bf..a71a192 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -34,6 +34,53 @@ sub readline {
 }
 package main;
 
+
+sub usage {
+	print <<EOT;
+git-send-email [options] <file | directory>...
+Options:
+   --from         Specify the "From:" line of the email to be sent.
+
+   --to           Specify the primary "To:" line of the email.
+
+   --cc           Specify an initial "Cc:" list for the entire series
+                  of emails.
+
+   --bcc          Specify a list of email addresses that should be Bcc:
+		  on all the emails.
+
+   --compose      Use \$EDITOR to edit an introductory message for the
+                  patch series.
+
+   --subject      Specify the initial "Subject:" line.
+                  Only necessary if --compose is also set.  If --compose
+		  is not set, this will be prompted for.
+
+   --in-reply-to  Specify the first "In-Reply-To:" header line.
+                  Only used if --compose is also set.  If --compose is not
+		  set, this will be prompted for.
+
+   --chain-reply-to If set, the replies will all be to the previous
+                  email sent, rather than to the first email sent.
+                  Defaults to on.
+
+   --no-signed-off-cc Suppress the automatic addition of email addresses
+                 that appear in a Signed-off-by: line, to the cc: list.
+		 Note: Using this option is not recommended.
+
+   --smtp-server  If set, specifies the outgoing SMTP server to use.
+                  Defaults to localhost.
+
+   --suppress-from Suppress sending emails to yourself if your address
+                  appears in a From: line.
+
+   --quiet	  Make git-send-email less verbose.  One line per email
+                  should be all that is output.
+
+EOT
+	exit(1);
+}
+
 # most mail servers generate the Date: header, but not all...
 sub format_2822_time {
 	my ($time) = @_;
@@ -120,6 +167,10 @@ my $rc = GetOptions("from=s" => \$from,
 		    "dry-run" => \$dry_run,
 	 );
 
+unless ($rc) {
+    usage();
+}
+
 # Verify the user input
 
 foreach my $entry (@to) {
@@ -311,50 +362,8 @@ if (@files) {
 		print $_,"\n" for (@files);
 	}
 } else {
-	print <<EOT;
-git-send-email [options] <file | directory> [... file | directory ]
-Options:
-   --from         Specify the "From:" line of the email to be sent.
-
-   --to           Specify the primary "To:" line of the email.
-
-   --cc           Specify an initial "Cc:" list for the entire series
-                  of emails.
-
-   --bcc          Specify a list of email addresses that should be Bcc:
-		  on all the emails.
-
-   --compose      Use \$EDITOR to edit an introductory message for the
-                  patch series.
-
-   --subject      Specify the initial "Subject:" line.
-                  Only necessary if --compose is also set.  If --compose
-		  is not set, this will be prompted for.
-
-   --in-reply-to  Specify the first "In-Reply-To:" header line.
-                  Only used if --compose is also set.  If --compose is not
-		  set, this will be prompted for.
-
-   --chain-reply-to If set, the replies will all be to the previous
-                  email sent, rather than to the first email sent.
-                  Defaults to on.
-
-   --no-signed-off-cc Suppress the automatic addition of email addresses
-                 that appear in a Signed-off-by: line, to the cc: list.
-		 Note: Using this option is not recommended.
-
-   --smtp-server  If set, specifies the outgoing SMTP server to use.
-                  Defaults to localhost.
-
-  --suppress-from Suppress sending emails to yourself if your address
-                  appears in a From: line.
-
-   --quiet	Make git-send-email less verbose.  One line per email should be
-		all that is output.
-
-Error: Please specify a file or a directory on the command line.
-EOT
-	exit(1);
+	print STDERR "\nNo patch files specified!\n\n";
+	usage();
 }
 
 # Variables we set as part of the loop over files
-- 
1.5.0.rc3
