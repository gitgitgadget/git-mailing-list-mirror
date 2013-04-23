From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] send-email: support NNTP
Date: Tue, 23 Apr 2013 13:13:54 +0200
Organization: Samsung Poland R&D Center
Message-ID: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 13:20:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUbGi-0002tp-I9
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 13:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab3DWLUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 07:20:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:35078 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab3DWLUH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 07:20:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UUbGV-0002gu-ES
	for git@vger.kernel.org; Tue, 23 Apr 2013 13:20:03 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 13:20:03 +0200
Received: from l.stelmach by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 13:20:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 217-67-201-162.itsa.net.pl
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222142>

Enable sending patches to NNTP servers (Usenet, Gmane).
---

The patch implements support for sending messages to groups on NNTP serviers.
The patch does not (attempts not to) change the default behavior i.e. to use sendmail
and/or Net::SMTP. To use NNTP one needs to configure the server (see the help message)
and protocol ("--protocol nntp"). Then after giving --newsgroups the
message will be sent via NNTP. Like this one:

perl git-send-email.perl --protocol nntp --newsgroups gmane.comp.version-control.git --nntp-server news.gmane.org 0001-send-email-support-NNTP.patch

 git-send-email.perl |  156 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 125 insertions(+), 31 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bd13cc8..0356635 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -54,12 +54,14 @@ git send-email [options] <file | directory | rev-list options >
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
+    --newsgroups            <str>  * NNTP Newsgroups:
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
     --compose-encoding      <str>  * Encoding to assume for introduction.
     --8bit-encoding         <str>  * Encoding to assume 8bit mails if undeclared
 
   Sending:
+    --protocol              <str>  * 'smtp' or 'nntp'. Default 'smtp'.
     --envelope-sender       <str>  * Email envelope sender.
     --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
                                      is optional. Default 'localhost'.
@@ -71,6 +73,12 @@ git send-email [options] <file | directory | rev-list options >
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
     --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
+    --nntp-server       <str:int>  * Outgoing NNTP server to use. The port
+                                     is optional.
+    --nntp-server-port      <int>  * Outgoing NNTP server port.
+    --nntp-user             <str>  * Username for NNTP AUTHINFO.
+    --nntp-pass             <str>  * Password for NNTP AUTHINFO.
+    --nntp-debug            <0|1>  * Disable, enable Net::NNTP debug.
 
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
@@ -138,12 +146,14 @@ sub format_2822_time {
 my $have_email_valid = eval { require Email::Valid; 1 };
 my $have_mail_address = eval { require Mail::Address; 1 };
 my $smtp;
+my $nntp;
 my $auth;
 
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
 	$initial_reply_to,$initial_subject,@files,
-	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
+	$author,$sender,$smtp_authpass,$annotate,$compose,$time,
+	@initial_newsgroups, @newsgroups);
 
 my $envelope_sender;
 
@@ -192,7 +202,9 @@ sub do_edit {
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
-my ($to_cmd, $cc_cmd);
+my ($to_cmd, $cc_cmd, $newsgroups_cmd);
+my ($email_protocol) = 'smtp';
+my ($nntp_server, $nntp_server_port, $nntp_authuser, $nntp_authpass);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
@@ -202,6 +214,7 @@ my ($auto_8bit_encoding);
 my ($compose_encoding);
 
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
+my ($debug_net_nntp) = 0;		# Net::NNTP, see send_message()
 
 my $not_set_by_user = "true but not set by the user";
 
@@ -235,6 +248,13 @@ my %config_settings = (
     "from" => \$sender,
     "assume8bitencoding" => \$auto_8bit_encoding,
     "composeencoding" => \$compose_encoding,
+    "nntpserver" => \$nntp_server,
+    "nntpserverport" => \$nntp_server_port,
+    "nntpuser" => \$nntp_authuser,
+    "nntppass" => \$nntp_authpass,
+    "protocol" => \$email_protocol,
+    "newsgroups" => \@initial_newsgroups,
+    "newsgroupscmd" => \$newsgroups_cmd,
 );
 
 my %config_path_settings = (
@@ -291,6 +311,7 @@ my $rc = GetOptions("h" => \$help,
 		    "to-cmd=s" => \$to_cmd,
 		    "no-to" => \$no_to,
 		    "cc=s" => \@initial_cc,
+		    "cc-cmd=s" => \$cc_cmd,
 		    "no-cc" => \$no_cc,
 		    "bcc=s" => \@bcclist,
 		    "no-bcc" => \$no_bcc,
@@ -304,11 +325,18 @@ my $rc = GetOptions("h" => \$help,
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
+		    "newsgroups=s" => \@initial_newsgroups,
+		    "newsgroups-cmd" => \$newsgroups_cmd,
+		    "nntp-server=s" => \$nntp_server,
+		    "nntp-server-port=s" => \$nntp_server_port,
+		    "nntp-user=s" => \$nntp_authuser,
+		    "nntp-pass:s" => \$nntp_authpass,
+		    "nntp-debug:i" => \$debug_net_nntp,
+		    "protocol=s" => \$email_protocol,
 		    "identity=s" => \$identity,
 		    "annotate!" => \$annotate,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
-		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
@@ -390,6 +418,24 @@ foreach my $setting (values %config_bool_settings) {
 	${$setting->[0]} = $setting->[1] unless (defined (${$setting->[0]}));
 }
 
+unless ($email_protocol eq 'smtp' || $email_protocol eq 'nntp') {
+	die "Unsupported protocol: $email_protocol";
+}
+
+# Transport specific setup
+my ($email_authuser, $email_authpass);
+if ($email_protocol eq 'nntp') {
+    $email_authuser = $nntp_authuser;
+    $email_authuser = $nntp_authuser;
+    @initial_to = @initial_cc = @bcclist = ();
+    $to_cmd = $cc_cmd = undef;
+    $no_cc = $no_bcc = 1;
+} else {
+    $email_authuser = $smtp_authuser;
+    $email_authpass = $smtp_authpass;
+    $newsgroups_cmd = undef;
+}
+
 # 'default' encryption is none -- this only prevents a warning
 $smtp_encryption = '' unless (defined $smtp_encryption);
 
@@ -668,8 +714,8 @@ EOT
 		} elsif (/^From:\s*(.+)\s*$/i) {
 			$sender = $1;
 			next;
-		} elsif (/^(?:To|Cc|Bcc):/i) {
-			print "To/Cc/Bcc fields are not interpreted yet, they have been ignored\n";
+		} elsif (/^(?:To|Cc|Bcc|Newsgroup):/i) {
+			print "To/Cc/Bcc/Newsgroup fields are not interpreted yet, they have been ignored\n";
 			next;
 		}
 		print $c2 $_;
@@ -761,12 +807,21 @@ if (!defined $sender) {
 }
 
 my $prompting = 0;
-if (!@initial_to && !defined $to_cmd) {
+
+if ($email_protocol eq 'smtp' && !@initial_to && !defined $to_cmd) {
 	my $to = ask("Who should the emails be sent to (if any)? ",
 		     default => "",
 		     valid_re => qr/\@.*\./, confirm_only => 1);
 	push @initial_to, parse_address_line($to) if defined $to; # sanitized/validated later
 	$prompting++;
+} elsif ($email_protocol eq 'nntp' &&
+	 !@initial_newsgroups &&
+	 !defined $newsgroups_cmd) {
+	my $newsgroup = ask("Which newsgroups should the message be sent to (if any)? ",
+		     default => "",
+		     valid_re => qr/[\x20-\x7f]+/, confirm_only => 1);
+	push @initial_newsgroups, $newsgroup if defined $newsgroup; # sanitized/validated later
+	$prompting++;
 }
 
 sub expand_aliases {
@@ -802,7 +857,7 @@ if (defined $initial_reply_to) {
 	$initial_reply_to = "<$initial_reply_to>" if $initial_reply_to ne '';
 }
 
-if (!defined $smtp_server) {
+if ($email_protocol eq 'smtp' && !defined $smtp_server) {
 	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
 		if (-x $_) {
 			$smtp_server = $_;
@@ -1048,41 +1103,56 @@ sub maildomain {
 	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
 }
 
-sub smtp_host_string {
-	if (defined $smtp_server_port) {
-		return "$smtp_server:$smtp_server_port";
+sub email_host_string {
+	if ($email_protocol eq 'nntp') {
+		if (defined $nntp_server_port) {
+			return "$nntp_server:$nntp_server_port";
+		} else {
+			return $nntp_server;
+		}
+
 	} else {
-		return $smtp_server;
+		if (defined $smtp_server_port) {
+			return "$smtp_server:$smtp_server_port";
+		} else {
+			return $smtp_server;
+		}
 	}
 }
 
 # Returns 1 if authentication succeeded or was not necessary
 # (smtp_user was not specified), and 0 otherwise.
 
-sub smtp_auth_maybe {
-	if (!defined $smtp_authuser || $auth) {
+sub email_auth_maybe {
+	if (!defined $email_authuser || $auth) {
 		return 1;
 	}
 
 	# Workaround AUTH PLAIN/LOGIN interaction defect
 	# with Authen::SASL::Cyrus
-	eval {
-		require Authen::SASL;
-		Authen::SASL->import(qw(Perl));
-	};
+	if ($email_protocol eq 'smtp') {
+		eval {
+			require Authen::SASL;
+			Authen::SASL->import(qw(Perl));
+		};
+	}
 
 	# TODO: Authentication may fail not because credentials were
 	# invalid but due to other reasons, in which we should not
 	# reject credentials.
 	$auth = Git::credential({
-		'protocol' => 'smtp',
-		'host' => smtp_host_string(),
-		'username' => $smtp_authuser,
+		'protocol' => $email_protocol,
+		'host' => email_host_string(),
+		'username' => $email_authuser,
 		# if there's no password, "git credential fill" will
 		# give us one, otherwise it'll just pass this one.
-		'password' => $smtp_authpass
+		'password' => $email_authpass
 	}, sub {
 		my $cred = shift;
+		if ($email_protocol eq 'nntp') {
+			return !!$nntp->authinfo($cred->{'username'},
+						 $cred->{'password'});
+		}
 		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
 	});
 
@@ -1099,7 +1169,7 @@ sub send_message {
 		      not grep { $cc eq $_ || $_ =~ /<\Q${cc}\E>$/ } @recipients
 		    }
 	       @cc);
-	my $to = join (",\n\t", @recipients);
+	my $to = join (",\n\t", (($email_protocol eq 'nntp') ? @newsgroups : @recipients));
 	@recipients = unique_email_list(@recipients,@cc,@bcclist);
 	@recipients = (map { extract_valid_address_or_die($_) } @recipients);
 	my $date = format_2822_time($time++);
@@ -1117,12 +1187,17 @@ sub send_message {
 	make_message_id() unless defined($message_id);
 
 	my $header = "From: $sanitized_sender
-To: $to${ccline}
 Subject: $subject
 Date: $date
 Message-Id: $message_id
 X-Mailer: git-send-email $gitversion
 ";
+	if ($email_protocol eq 'nntp') {
+		$header = "Newsgroups: $to\n" . $header;
+	} else {
+		$header = "To: $to${ccline}\n" . $header;
+	}
+
 	if ($reply_to) {
 
 		$header .= "In-Reply-To: $reply_to\n";
@@ -1174,6 +1249,18 @@ X-Mailer: git-send-email $gitversion
 
 	if ($dry_run) {
 		# We don't want to send the email.
+	} elsif ($email_protocol eq 'nntp') {
+		if (!defined $nntp_server) {
+			die "The requires NNTP server is not properly defined."
+		}
+		require Net::NNTP;
+		$nntp =  Net::NNTP->new(email_host_string(),
+		                        Debug => $debug_net_nntp);
+		email_auth_maybe or die $nntp->message;
+		$nntp->post or die $nntp->message;
+		$nntp->datasend("$header\n$message") or die $nntp->message;
+		$nntp->dataend() or die $nntp->message;
+		$nntp->code eq "240" or die "Failed to send $subject\n".$nntp->message;
 	} elsif ($smtp_server =~ m#^/#) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
@@ -1195,11 +1282,10 @@ X-Mailer: git-send-email $gitversion
 			$smtp ||= Net::SMTP::SSL->new($smtp_server,
 						      Hello => $smtp_domain,
 						      Port => $smtp_server_port);
-		}
-		else {
+		} else {
 			require Net::SMTP;
 			$smtp_domain ||= maildomain();
-			$smtp ||= Net::SMTP->new(smtp_host_string(),
+			$smtp ||= Net::SMTP->new(email_host_string(),
 						 Hello => $smtp_domain,
 						 Debug => $debug_net_smtp);
 			if ($smtp_encryption eq 'tls' && $smtp) {
@@ -1227,7 +1313,7 @@ X-Mailer: git-send-email $gitversion
 			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
 		}
 
-		smtp_auth_maybe or die $smtp->message;
+		email_auth_maybe or die $smtp->message;
 
 		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
@@ -1240,7 +1326,9 @@ X-Mailer: git-send-email $gitversion
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
 	} else {
 		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
-		if ($smtp_server !~ m#^/#) {
+		if ($email_protocol eq 'nntp') {
+			print "Server: $nntp_server\n";
+		} elsif ($smtp_server !~ m#^/#) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
 			foreach my $entry (@recipients) {
@@ -1250,9 +1338,10 @@ X-Mailer: git-send-email $gitversion
 			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
 		}
 		print $header, "\n";
-		if ($smtp) {
-			print "Result: ", $smtp->code, ' ',
-				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
+		my $transport = $nntp || $smtp;
+		if ($transport) {
+			print "Result: ", $transport->code, ' ',
+				($transport->message =~ /\n([^\n]+\n)$/s), "\n";
 		} else {
 			print "Result: OK\n";
 		}
@@ -1383,6 +1472,9 @@ foreach my $t (@files) {
 	}
 	close $fh;
 
+	push @newsgroups, recipients_cmd("newsgroups-cmd", "newsgroups",
+					 $newsgroups_cmd, $t)
+		if defined $newsgroups_cmd;
 	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
 		if defined $to_cmd;
 	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
@@ -1430,6 +1522,7 @@ foreach my $t (@files) {
 	@to = validate_address_list(sanitize_address_list(@to));
 	@cc = validate_address_list(sanitize_address_list(@cc));
 
+	@newsgroups = (@initial_newsgroups, @newsgroups);
 	@to = (@initial_to, @to);
 	@cc = (@initial_cc, @cc);
 
@@ -1479,6 +1572,7 @@ sub cleanup_compose_files {
 }
 
 $smtp->quit if $smtp;
+$nntp->quit if $nntp;
 
 sub unique_email_list {
 	my %seen;
-- 
1.7.9.5
