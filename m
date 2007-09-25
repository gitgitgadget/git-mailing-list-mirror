From: Glenn Rempe <glenn@rempe.us>
Subject: [PATCH] Add ability to specify SMTP server port when using git-send-email.
Date: Tue, 25 Sep 2007 15:38:47 -0700
Message-ID: <1190759927-19493-1-git-send-email-glenn@rempe.us>
Cc: Glenn Rempe <glenn@rempe.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 00:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJ3W-0000Tm-R3
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 00:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbXIYWiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 18:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbXIYWiy
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 18:38:54 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:46422 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbXIYWix (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 18:38:53 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2563994wah
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 15:38:50 -0700 (PDT)
Received: by 10.114.12.9 with SMTP id 9mr8451wal.1190759929273;
        Tue, 25 Sep 2007 15:38:49 -0700 (PDT)
Received: from localhost.localdomain ( [64.142.55.11])
        by mx.google.com with ESMTPS id m5sm9472725wag.2007.09.25.15.38.48
        (version=SSLv3 cipher=OTHER);
        Tue, 25 Sep 2007 15:38:48 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.2.105.g23fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59182>

Add ability to specify custom SMTP server port using
smtpserverport config value or --smtp-server-port command
line option.

Ability to specify custom SMTP server port using
--smtp-server host:port syntax.

Will default to port 25 if smtpssl config is set
to false or --smtp-ssl command line is unset and port
is not explicitly defined.

Will default to port 465 if smtpssl config is set
to true or --smtp-ssl is set and port is not explicity
defined.

Users should be aware that sending auth info over non-ssl
connections may be unsafe or just may not work at all
depending on SMTP server config.

Added some negative test cases.

Signed-off-by: Glenn Rempe <glenn@rempe.us>
---
 git-send-email.perl   |   73 ++++++++++++++++++++++++++++++++++++++++---------
 t/t9001-send-email.sh |   12 ++++++++
 2 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4031e86..969cb39 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -77,7 +77,10 @@ Options:
                   the default section.
 
    --smtp-server  If set, specifies the outgoing SMTP server to use.
-                  Defaults to localhost.
+                  Defaults to localhost.  Port number can be specified here with
+                  hostname:port format or by using --smtp-server-port option.
+
+   --smtp-server-port Specify a port on the outgoing SMTP server to connect to.
 
    --smtp-user    The username for SMTP-AUTH.
 
@@ -172,8 +175,8 @@ my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
-my ($smtp_server, $smtp_authuser, $smtp_authpass, $smtp_ssl);
-my ($identity, $aliasfiletype, @alias_files);
+my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl);
+my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 
 my %config_bool_settings = (
     "thread" => [\$thread, 1],
@@ -185,6 +188,7 @@ my %config_bool_settings = (
 
 my %config_settings = (
     "smtpserver" => \$smtp_server,
+    "smtpserverport" => \$smtp_server_port,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
     "cccmd" => \$cc_cmd,
@@ -204,6 +208,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "bcc=s" => \@bcclist,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
+		    "smtp-server-port=s" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
 		    "smtp-pass=s" => \$smtp_authpass,
 		    "smtp-ssl!" => \$smtp_ssl,
@@ -375,6 +380,29 @@ if (!defined $smtp_server) {
 	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
 }
 
+# don't allow BOTH forms of port definition to work since we can't guess which one is right.
+if (($smtp_server =~ /:\d+/) && (defined $smtp_server_port)) {
+  die "You must specify the port using either hostname:port OR --smtp-server-port but not both!"
+}
+
+# setup smtp_server var if it was passed in as host:port format
+if ( $smtp_server =~ /:\d+/) {
+  # if they do pass a host:port form then split it and use the parts
+  @smtp_host_parts = split(/:/, $smtp_server);
+  $smtp_server = $smtp_host_parts[0];
+  $smtp_server_port = $smtp_host_parts[1];
+}
+
+# setup reasonable defaults if neither host:port or --smtp-server-port were passed
+if ( !defined $smtp_server_port) {
+  if ($smtp_ssl) {
+    $smtp_server_port = 465  # SSL port
+  } else {
+    $smtp_server_port = 25  # Non-SSL port
+  }
+}
+
+
 if ($compose) {
 	# Note that this does not need to be secure, but we will make a small
 	# effort to have it be unique
@@ -602,22 +630,41 @@ X-Mailer: git-send-email $gitversion
 		print $sm "$header\n$message";
 		close $sm or die $?;
 	} else {
+
+		if (!defined $smtp_server) {
+		  die "The required SMTP server is not properly defined."
+		}
+
+		if (!defined $smtp_server_port || !$smtp_server_port =~ /^\d+$/ ) {
+		  die "The required SMTP server port is not properly defined."
+		}
+
 		if ($smtp_ssl) {
 			require Net::SMTP::SSL;
-			$smtp ||= Net::SMTP::SSL->new( $smtp_server, Port => 465 );
+			$smtp ||= Net::SMTP::SSL->new( $smtp_server, Port => $smtp_server_port );
 		}
 		else {
 			require Net::SMTP;
-			$smtp ||= Net::SMTP->new( $smtp_server );
+			$smtp ||= Net::SMTP->new($smtp_server . ":" . $smtp_server_port);
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
+    if (!$smtp) {
+      die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
+    }
+
+    if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
+      $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
+    }
+
+    $smtp->mail( $raw_from ) or die $smtp->message;
+    $smtp->to( @recipients ) or die $smtp->message;
+    $smtp->data or die $smtp->message;
+    $smtp->datasend("$header\n$message") or die $smtp->message;
+    $smtp->dataend() or die $smtp->message;
+    $smtp->ok or die "Failed to send $subject\n".$smtp->message;
+
 	}
 	if ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 83f9470..d32907d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -41,4 +41,16 @@ test_expect_success \
     'Verify commandline' \
     'diff commandline expected'
 
+test_expect_failure 'Passing in both host:port form AND --smtp-server-port' '
+  git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server smtp.foo.com:66 --smtp-server-port 77" $patches 2>errors
+'
+
+test_expect_failure 'Passing in non-numeric server port with host:port form' '
+  git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server smtp.foo.com:bar" $patches 2>errors
+'
+
+test_expect_failure 'Passing in non-numeric server port with --smtp-server-port form' '
+  git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server smtp.foo.com --smtp-server-port bar" $patches 2>errors
+'
+
 test_done
-- 
1.5.3.2.105.g23fe
