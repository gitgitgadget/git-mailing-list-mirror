From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add ability to specify SMTP server port when using git-send-email.
Date: Tue, 25 Sep 2007 17:27:28 -0700
Message-ID: <7vabra2rv3.fsf@gitster.siamese.dyndns.org>
References: <1190759927-19493-1-git-send-email-glenn@rempe.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Glenn Rempe <glenn@rempe.us>
X-From: git-owner@vger.kernel.org Wed Sep 26 02:27:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaKkf-0000za-RK
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 02:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbXIZA1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 20:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbXIZA1f
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 20:27:35 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbXIZA1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 20:27:34 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4EE8F13C06F;
	Tue, 25 Sep 2007 20:27:52 -0400 (EDT)
In-Reply-To: <1190759927-19493-1-git-send-email-glenn@rempe.us> (Glenn Rempe's
	message of "Tue, 25 Sep 2007 15:38:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59199>

I'm inclined to do this on top of yours.

 * As you mentioned, ssmtp plus undocumented "server:port"
   syntax never worked.  There is no point supporting the
   combination.  Also I do not think it is worth additional
   lines of code to even say "server:port" plus --server-port
   option are not meant to be used together.

 * People who used the undocumented "server:port" syntax did not
   use the new --smtp-server-port option anyway.

 * If somebody goes over plain smtp specifies server without
   port, we can let the Net::SMTP to handle the default port.
   No need for _us_ to say that the default is 25.

 * I do not see much point insisting that port to be numeric; I
   do not know what Net::SMTP accepts, but if it accepts
   my.isp.com:smtp instead of my.isp.com:25, that is fine. This
   has the side effect of keeping people's existing set-up
   working.

 * The indentation was horrible.  Maybe your tabstop is set
   incorrectly?

 * As I am inclined not to insist on numeric port numbers,
   the additional tests become pointless.

The result is much simpler, and I think it is more readable.

---

 git-send-email.perl   |   64 +++++++++++++-----------------------------------
 t/t9001-send-email.sh |   12 ---------
 2 files changed, 18 insertions(+), 58 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 886f78f..62e1429 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -380,29 +380,6 @@ if (!defined $smtp_server) {
 	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
 }
 
-# don't allow BOTH forms of port definition to work since we can't guess which one is right.
-if (($smtp_server =~ /:\d+/) && (defined $smtp_server_port)) {
-  die "You must specify the port using either hostname:port OR --smtp-server-port but not both!"
-}
-
-# setup smtp_server var if it was passed in as host:port format
-if ( $smtp_server =~ /:\d+/) {
-  # if they do pass a host:port form then split it and use the parts
-  @smtp_host_parts = split(/:/, $smtp_server);
-  $smtp_server = $smtp_host_parts[0];
-  $smtp_server_port = $smtp_host_parts[1];
-}
-
-# setup reasonable defaults if neither host:port or --smtp-server-port were passed
-if ( !defined $smtp_server_port) {
-  if ($smtp_ssl) {
-    $smtp_server_port = 465  # SSL port
-  } else {
-    $smtp_server_port = 25  # Non-SSL port
-  }
-}
-
-
 if ($compose) {
 	# Note that this does not need to be secure, but we will make a small
 	# effort to have it be unique
@@ -632,39 +609,34 @@ X-Mailer: git-send-email $gitversion
 	} else {
 
 		if (!defined $smtp_server) {
-		  die "The required SMTP server is not properly defined."
-		}
-
-		if (!defined $smtp_server_port || !$smtp_server_port =~ /^\d+$/ ) {
-		  die "The required SMTP server port is not properly defined."
+			die "The required SMTP server is not properly defined."
 		}
 
 		if ($smtp_ssl) {
+			$smtp_server_port ||= 465; # ssmtp
 			require Net::SMTP::SSL;
-			$smtp ||= Net::SMTP::SSL->new( $smtp_server, Port => $smtp_server_port );
+			$smtp ||= Net::SMTP::SSL->new($smtp_server, Port => $smtp_server_port);
 		}
 		else {
 			require Net::SMTP;
-			$smtp ||= Net::SMTP->new($smtp_server . ":" . $smtp_server_port);
+			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
+						 ? "$smtp_server:$smtp_server_port"
+						 : $smtp_server);
 		}
 
-    # we'll get an ugly error if $smtp was undefined above.
-    # If so we'll catch it and present something friendlier.
-    if (!$smtp) {
-      die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
-    }
-
-    if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
-      $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
-    }
-
-    $smtp->mail( $raw_from ) or die $smtp->message;
-    $smtp->to( @recipients ) or die $smtp->message;
-    $smtp->data or die $smtp->message;
-    $smtp->datasend("$header\n$message") or die $smtp->message;
-    $smtp->dataend() or die $smtp->message;
-    $smtp->ok or die "Failed to send $subject\n".$smtp->message;
+		if (!$smtp) {
+			die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
+		}
 
+		if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
+			$smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
+		}
+		$smtp->mail( $raw_from ) or die $smtp->message;
+		$smtp->to( @recipients ) or die $smtp->message;
+		$smtp->data or die $smtp->message;
+		$smtp->datasend("$header\n$message") or die $smtp->message;
+		$smtp->dataend() or die $smtp->message;
+		$smtp->ok or die "Failed to send $subject\n".$smtp->message;
 	}
 	if ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d32907d..83f9470 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -41,16 +41,4 @@ test_expect_success \
     'Verify commandline' \
     'diff commandline expected'
 
-test_expect_failure 'Passing in both host:port form AND --smtp-server-port' '
-  git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server smtp.foo.com:66 --smtp-server-port 77" $patches 2>errors
-'
-
-test_expect_failure 'Passing in non-numeric server port with host:port form' '
-  git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server smtp.foo.com:bar" $patches 2>errors
-'
-
-test_expect_failure 'Passing in non-numeric server port with --smtp-server-port form' '
-  git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server smtp.foo.com --smtp-server-port bar" $patches 2>errors
-'
-
 test_done
