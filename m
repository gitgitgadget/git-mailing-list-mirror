From: Glenn Rempe <glenn@rempe.us>
Subject: [PATCH] Add ability to specify SMTP server port when using git-send-email.
Date: Mon, 24 Sep 2007 13:34:18 -0700
Message-ID: <1190666058-10969-1-git-send-email-glenn@rempe.us>
Cc: Glenn Rempe <glenn@rempe.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 22:35:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZudW-0000yY-QI
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 22:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbXIXUe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 16:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbXIXUe1
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 16:34:27 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:22435 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbXIXUe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 16:34:26 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1512411rvb
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 13:34:26 -0700 (PDT)
Received: by 10.141.52.5 with SMTP id e5mr268696rvk.1190666065880;
        Mon, 24 Sep 2007 13:34:25 -0700 (PDT)
Received: from localhost.localdomain ( [64.142.55.11])
        by mx.google.com with ESMTPS id f21sm10408228rvb.2007.09.24.13.34.25
        (version=SSLv3 cipher=OTHER);
        Mon, 24 Sep 2007 13:34:25 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.2.83.gc6869
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59075>

Add ability to specify custom SMTP server port using
smtpserverport config value or --smtp-server-port command
line option.

Will default to port 25 if smtpssl config is set
to false or --smtp-ssl command line is unset.

Will default to port 465 if smtpssl config is set
to true or --smtp-ssl is set.

User can specify any arbitrary port number for standard or
SSL connections.

Users should be aware that sending auth info over non-ssl
connections may be unsafe.

Signed-off-by: Glenn Rempe <glenn@rempe.us>
---
 git-send-email.perl |   48 +++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4031e86..7c9c302 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -79,6 +79,10 @@ Options:
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.
 
+   --smtp-server-port If set, specifies the port on the outgoing SMTP
+   server to use. Defaults to port 25 unless --smtp-ssl is set in
+   which case it will default to port 465.
+
    --smtp-user    The username for SMTP-AUTH.
 
    --smtp-pass    The password for SMTP-AUTH.
@@ -172,7 +176,7 @@ my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
-my ($smtp_server, $smtp_authuser, $smtp_authpass, $smtp_ssl);
+my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl);
 my ($identity, $aliasfiletype, @alias_files);
 
 my %config_bool_settings = (
@@ -185,6 +189,7 @@ my %config_bool_settings = (
 
 my %config_settings = (
     "smtpserver" => \$smtp_server,
+    "smtpserverport" => \$smtp_server_port,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
     "cccmd" => \$cc_cmd,
@@ -204,6 +209,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "bcc=s" => \@bcclist,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
+		    "smtp-server-port=s" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
 		    "smtp-pass=s" => \$smtp_authpass,
 		    "smtp-ssl!" => \$smtp_ssl,
@@ -375,6 +381,14 @@ if (!defined $smtp_server) {
 	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
 }
 
+if (!defined $smtp_server_port) {
+  if ($smtp_ssl) {
+    $smtp_server_port = 465  # SSL port
+  } else {
+    $smtp_server_port = 25  # Non-SSL port
+  }
+}
+
 if ($compose) {
 	# Note that this does not need to be secure, but we will make a small
 	# effort to have it be unique
@@ -604,20 +618,32 @@ X-Mailer: git-send-email $gitversion
 	} else {
 		if ($smtp_ssl) {
 			require Net::SMTP::SSL;
-			$smtp ||= Net::SMTP::SSL->new( $smtp_server, Port => 465 );
+			$smtp ||= Net::SMTP::SSL->new( $smtp_server, Port => $smtp_server_port );
 		}
 		else {
 			require Net::SMTP;
-			$smtp ||= Net::SMTP->new( $smtp_server );
+			$smtp ||= Net::SMTP->new( $smtp_server . ":" . $smtp_server_port );
 		}
-		$smtp->auth( $smtp_authuser, $smtp_authpass )
-			or die $smtp->message if (defined $smtp_authuser);
-		$smtp->mail( $raw_from ) or die $smtp->message;
-		$smtp->to( @recipients ) or die $smtp->message;
-		$smtp->data or die $smtp->message;
-		$smtp->datasend("$header\n$message") or die $smtp->message;
-		$smtp->dataend() or die $smtp->message;
-		$smtp->ok or die "Failed to send $subject\n".$smtp->message;
+    
+    # we'll get an ugly error if $smtp was undefined above.
+    # If so we'll catch it and present something friendlier.
+    if ($smtp) {
+
+      if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
+        $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
+      }
+
+      $smtp->mail( $raw_from ) or die $smtp->message;
+      $smtp->to( @recipients ) or die $smtp->message;
+      $smtp->data or die $smtp->message;
+      $smtp->datasend("$header\n$message") or die $smtp->message;
+      $smtp->dataend() or die $smtp->message;
+      $smtp->ok or die "Failed to send $subject\n".$smtp->message;
+      
+    } else {
+      die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
+    }
+
 	}
 	if ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
-- 
1.5.3.2.83.gc6869
