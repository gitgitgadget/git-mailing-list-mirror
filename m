Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89832022A
	for <e@80x24.org>; Tue,  8 Nov 2016 12:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbcKHMMG (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 07:12:06 -0500
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:43142 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933255AbcKHMLw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 07:11:52 -0500
Received: (qmail 6980 invoked from network); 8 Nov 2016 12:11:50 -0000
Received: (qmail 10111 invoked from network); 8 Nov 2016 12:11:50 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Nov 2016 12:11:50 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 14/16] i18n: send-email: mark string with interpolation for translation
Date:   Tue,  8 Nov 2016 11:08:21 -0100
Message-Id: <20161108120823.11204-15-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.rc0.23.g8236252
In-Reply-To: <20161108120823.11204-1-vascomalmeida@sapo.pt>
References: <20161108120823.11204-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark warnings, errors and other messages that are interpolated for
translation.

We call sprintf() before calling die() and in few other circumstances in
order to replace the values on the placeholders.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-send-email.perl | 90 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 982c6c076..5c014258b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -279,10 +279,13 @@ sub signal_handler {
 	# tmp files from --compose
 	if (defined $compose_filename) {
 		if (-e $compose_filename) {
-			print "'$compose_filename' contains an intermediate version of the email you were composing.\n";
+			printf __("'%s' contains an intermediate version ".
+				  "of the email you were composing.\n"),
+				  $compose_filename;
 		}
 		if (-e ($compose_filename . ".final")) {
-			print "'$compose_filename.final' contains the composed email.\n"
+			printf __("'%s.final' contains the composed email.\n"),
+				  $compose_filename;
 		}
 	}
 
@@ -431,7 +434,7 @@ $smtp_encryption = '' unless (defined $smtp_encryption);
 my(%suppress_cc);
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
-		die "Unknown --suppress-cc field: '$entry'\n"
+		die sprintf(__("Unknown --suppress-cc field: '%s'\n"), $entry)
 			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)$/;
 		$suppress_cc{$entry} = 1;
 	}
@@ -460,7 +463,7 @@ my $confirm_unconfigured = !defined $confirm;
 if ($confirm_unconfigured) {
 	$confirm = scalar %suppress_cc ? 'compose' : 'auto';
 };
-die "Unknown --confirm setting: '$confirm'\n"
+die sprintf(__("Unknown --confirm setting: '%s'\n"), $confirm)
 	unless $confirm =~ /^(?:auto|cc|compose|always|never)/;
 
 # Debugging, print out the suppressions.
@@ -492,16 +495,16 @@ my %aliases;
 sub parse_sendmail_alias {
 	local $_ = shift;
 	if (/"/) {
-		print STDERR "warning: sendmail alias with quotes is not supported: $_\n";
+		printf STDERR __("warning: sendmail alias with quotes is not supported: %s\n"), $_;
 	} elsif (/:include:/) {
-		print STDERR "warning: `:include:` not supported: $_\n";
+		printf STDERR __("warning: `:include:` not supported: %s\n"), $_;
 	} elsif (/[\/|]/) {
-		print STDERR "warning: `/file` or `|pipe` redirection not supported: $_\n";
+		printf STDERR __("warning: `/file` or `|pipe` redirection not supported: %s\n"), $_;
 	} elsif (/^(\S+?)\s*:\s*(.+)$/) {
 		my ($alias, $addr) = ($1, $2);
 		$aliases{$alias} = [ split_addrs($addr) ];
 	} else {
-		print STDERR "warning: sendmail line is not recognized: $_\n";
+		printf STDERR __("warning: sendmail line is not recognized: %s\n"), $_;
 	}
 }
 
@@ -582,13 +585,12 @@ sub is_format_patch_arg {
 		if (defined($format_patch)) {
 			return $format_patch;
 		}
-		die(<<EOF);
-File '$f' exists but it could also be the range of commits
+		die sprintf(__(
+"File '%s' exists but it could also be the range of commits
 to produce patches for.  Please disambiguate by...
 
-    * Saying "./$f" if you mean a file; or
-    * Giving --format-patch option if you mean a range.
-EOF
+    * Saying \"./%s\" if you mean a file; or
+    * Giving --format-patch option if you mean a range."), $f, $f);
 	} catch Git::Error::Command with {
 		# Not a valid revision.  Treat it as a filename.
 		return 0;
@@ -604,7 +606,7 @@ while (defined(my $f = shift @ARGV)) {
 		@ARGV = ();
 	} elsif (-d $f and !is_format_patch_arg($f)) {
 		opendir my $dh, $f
-			or die "Failed to opendir $f: $!";
+			or die sprintf(__("Failed to opendir %s: %s"), $f, $!);
 
 		push @files, grep { -f $_ } map { catfile($f, $_) }
 				sort readdir $dh;
@@ -628,7 +630,8 @@ if ($validate) {
 	foreach my $f (@files) {
 		unless (-p $f) {
 			my $error = validate_patch($f);
-			$error and die "fatal: $f: $error\nwarning: no patches were sent\n";
+			$error and die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
+						  $f, $error);
 		}
 	}
 }
@@ -651,7 +654,7 @@ sub get_patch_subject {
 		return "GIT: $1\n";
 	}
 	close $fh;
-	die "No subject line in $fn ?";
+	die sprintf(__("No subject line in %s ?"), $fn);
 }
 
 if ($compose) {
@@ -661,7 +664,7 @@ if ($compose) {
 		tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
 		tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
 	open my $c, ">", $compose_filename
-		or die "Failed to open for writing $compose_filename: $!";
+		or die sprintf(__("Failed to open for writing %s: %s"), $compose_filename, $!);
 
 
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
@@ -692,10 +695,10 @@ EOT
 	}
 
 	open my $c2, ">", $compose_filename . ".final"
-		or die "Failed to open $compose_filename.final : " . $!;
+		or die sprintf(__("Failed to open %s.final : %s"), $compose_filename, $!);
 
 	open $c, "<", $compose_filename
-		or die "Failed to open $compose_filename : " . $!;
+		or die sprintf(__("Failed to open %s : %s"), $compose_filename, $!);
 
 	my $need_8bit_cte = file_has_nonascii($compose_filename);
 	my $in_body = 0;
@@ -769,7 +772,9 @@ sub ask {
 			return $resp;
 		}
 		if ($confirm_only) {
-			my $yesno = $term->readline("Are you sure you want to use <$resp> [y/N]? ");
+			my $yesno = $term->readline(
+				# TRANSLATORS: please keep [y/N] as is.
+				sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
 			if (defined $yesno && $yesno =~ /y/i) {
 				return $resp;
 			}
@@ -811,9 +816,9 @@ if (!defined $auto_8bit_encoding && scalar %broken_encoding) {
 if (!$force) {
 	for my $f (@files) {
 		if (get_patch_subject($f) =~ /\Q*** SUBJECT HERE ***\E/) {
-			die "Refusing to send because the patch\n\t$f\n"
+			die sprintf(__("Refusing to send because the patch\n\t%s\n"
 				. "has the template subject '*** SUBJECT HERE ***'. "
-				. "Pass --force if you really want to send.\n";
+				. "Pass --force if you really want to send.\n"), $f);
 		}
 	}
 }
@@ -848,7 +853,7 @@ my %EXPANDED_ALIASES;
 sub expand_one_alias {
 	my $alias = shift;
 	if ($EXPANDED_ALIASES{$alias}) {
-		die "fatal: alias '$alias' expands to itself\n";
+		die sprintf(__("fatal: alias '%s' expands to itself\n"), $alias);
 	}
 	local $EXPANDED_ALIASES{$alias} = 1;
 	return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;
@@ -910,7 +915,7 @@ sub extract_valid_address {
 sub extract_valid_address_or_die {
 	my $address = shift;
 	$address = extract_valid_address($address);
-	die "error: unable to extract a valid address from: $address\n"
+	die sprintf(__("error: unable to extract a valid address from: %s\n"), $address)
 		if !$address;
 	return $address;
 }
@@ -918,7 +923,7 @@ sub extract_valid_address_or_die {
 sub validate_address {
 	my $address = shift;
 	while (!extract_valid_address($address)) {
-		print STDERR "error: unable to extract a valid address from: $address\n";
+		printf STDERR __("error: unable to extract a valid address from: %s\n"), $address;
 		# TRANSLATORS: Make sure to include [q] [d] [e] in your
 		# translation. The program will only accept English input
 		# at this point.
@@ -1223,7 +1228,7 @@ sub ssl_verify_params {
 		return (SSL_verify_mode => SSL_VERIFY_PEER(),
 			SSL_ca_file => $smtp_ssl_cert_path);
 	} else {
-		die "CA path \"$smtp_ssl_cert_path\" does not exist";
+		die sprintf(__("CA path \"%s\" does not exist"), $smtp_ssl_cert_path);
 	}
 }
 
@@ -1384,14 +1389,14 @@ Message-Id: $message_id
 					# supported commands
 					$smtp->hello($smtp_domain);
 				} else {
-					die "Server does not support STARTTLS! ".$smtp->message;
+					die sprintf(__("Server does not support STARTTLS! %s"), $smtp->message);
 				}
 			}
 		}
 
 		if (!$smtp) {
-			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
-			    "VALUES: server=$smtp_server ",
+			die __("Unable to initialize SMTP properly. Check config and use --smtp-debug."),
+			    " VALUES: server=$smtp_server ",
 			    "encryption=$smtp_encryption ",
 			    "hello=$smtp_domain",
 			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
@@ -1408,10 +1413,10 @@ Message-Id: $message_id
 			$smtp->datasend("$line") or die $smtp->message;
 		}
 		$smtp->dataend() or die $smtp->message;
-		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
+		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
 	}
 	if ($quiet) {
-		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
+		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
 	} else {
 		print($dry_run ? __("Dry-OK. Log says:\n") : __("OK. Log says:\n"));
 		if (!file_name_is_absolute($smtp_server)) {
@@ -1441,7 +1446,7 @@ $subject = $initial_subject;
 $message_num = 0;
 
 foreach my $t (@files) {
-	open my $fh, "<", $t or die "can't open file $t";
+	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
 
 	my $author = undef;
 	my $sauthor = undef;
@@ -1663,18 +1668,18 @@ sub recipients_cmd {
 
 	my @addresses = ();
 	open my $fh, "-|", "$cmd \Q$file\E"
-	    or die "($prefix) Could not execute '$cmd'";
+	    or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
 	while (my $address = <$fh>) {
 		$address =~ s/^\s*//g;
 		$address =~ s/\s*$//g;
 		$address = sanitize_address($address);
 		next if ($address eq $sender and $suppress_cc{'self'});
 		push @addresses, $address;
-		printf("($prefix) Adding %s: %s from: '%s'\n",
-		       $what, $address, $cmd) unless $quiet;
+		printf(__("(%s) Adding %s: %s from: '%s'\n"),
+		       $prefix, $what, $address, $cmd) unless $quiet;
 		}
 	close $fh
-	    or die "($prefix) failed to close pipe to '$cmd'";
+	    or die sprintf(__("(%s) failed to close pipe to '%s'"), $prefix, $cmd);
 	return @addresses;
 }
 
@@ -1728,10 +1733,10 @@ sub unique_email_list {
 sub validate_patch {
 	my $fn = shift;
 	open(my $fh, '<', $fn)
-		or die "unable to open $fn: $!\n";
+		or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 	while (my $line = <$fh>) {
 		if (length($line) > 998) {
-			return "$.: patch contains a line longer than 998 characters";
+			return sprintf(__("%s: patch contains a line longer than 998 characters"), $.);
 		}
 	}
 	return;
@@ -1747,10 +1752,11 @@ sub handle_backup {
 	    (substr($file, 0, $lastlen) eq $last) &&
 	    ($suffix = substr($file, $lastlen)) !~ /^[a-z0-9]/i) {
 		if (defined $known_suffix && $suffix eq $known_suffix) {
-			print "Skipping $file with backup suffix '$known_suffix'.\n";
+			printf(__("Skipping %s with backup suffix '%s'.\n"), $file, $known_suffix);
 			$skip = 1;
 		} else {
-			my $answer = ask("Do you really want to send $file? (y|N): ",
+			# TRANSLATORS: please keep "[y|N]" as is.
+			my $answer = ask(sprintf(__("Do you really want to send %s? [y|N]: "), $file),
 					 valid_re => qr/^(?:y|n)/i,
 					 default => 'n');
 			$skip = ($answer ne 'y');
@@ -1778,7 +1784,7 @@ sub handle_backup_files {
 sub file_has_nonascii {
 	my $fn = shift;
 	open(my $fh, '<', $fn)
-		or die "unable to open $fn: $!\n";
+		or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 	while (my $line = <$fh>) {
 		return 1 if $line =~ /[^[:ascii:]]/;
 	}
@@ -1788,7 +1794,7 @@ sub file_has_nonascii {
 sub body_or_subject_has_nonascii {
 	my $fn = shift;
 	open(my $fh, '<', $fn)
-		or die "unable to open $fn: $!\n";
+		or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 	while (my $line = <$fh>) {
 		last if $line =~ /^$/;
 		return 1 if $line =~ /^Subject.*[^[:ascii:]]/;
-- 
2.11.0.rc0.23.g8236252

