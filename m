Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70AEB20189
	for <e@80x24.org>; Tue, 21 Jun 2016 11:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbcFULq0 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 07:46:26 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47724 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752125AbcFULqW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 07:46:22 -0400
Received: (qmail 29420 invoked from network); 21 Jun 2016 11:46:21 -0000
Received: (qmail 7903 invoked from network); 21 Jun 2016 11:46:21 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 21 Jun 2016 11:46:15 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 10/11] i18n: send-email: mark string with interpolation for translation
Date:	Tue, 21 Jun 2016 11:44:12 +0000
Message-Id: <20160621114413.9467-10-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.9.0.47.g9ba0c31
In-Reply-To: <20160621114413.9467-1-vascomalmeida@sapo.pt>
References: <20160621114413.9467-1-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark warnings, errors and other messages that are interpolated for
translation.

We must call sprintf() before calling die() and in few other
circumstances in order to interpolation take place.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-send-email.perl | 71 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e7f712e..f445a5e 100755
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
+		die sprintf __("Unknown --suppress-cc field: '%s'\n"), $entry
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
+		die sprintf __(
+"File '%s' exists but it could also be the range of commits
 to produce patches for.  Please disambiguate by...
 
-    * Saying "./$f" if you mean a file; or
-    * Giving --format-patch option if you mean a range.
-EOF
+    * Saying \"./%s\" if you mean a file; or
+    * Giving --format-patch option if you mean a range."), $f, $f;
 	} catch Git::Error::Command with {
 		# Not a valid revision.  Treat it as a filename.
 		return 0;
@@ -604,7 +606,7 @@ while (defined(my $f = shift @ARGV)) {
 		@ARGV = ();
 	} elsif (-d $f and !is_format_patch_arg($f)) {
 		opendir my $dh, $f
-			or die "Failed to opendir $f: $!";
+			or die sprintf __("Failed to opendir %s: %s"), $f, $!;
 
 		push @files, grep { -f $_ } map { catfile($f, $_) }
 				sort readdir $dh;
@@ -626,7 +628,8 @@ if ($validate) {
 	foreach my $f (@files) {
 		unless (-p $f) {
 			my $error = validate_patch($f);
-			$error and die "fatal: $f: $error\nwarning: no patches were sent\n";
+			$error and die sprintf __("fatal: %s: %s\nwarning: no patches were sent\n"),
+						  $f, $error;
 		}
 	}
 }
@@ -649,7 +652,7 @@ sub get_patch_subject {
 		return "GIT: $1\n";
 	}
 	close $fh;
-	die "No subject line in $fn ?";
+	die sprintf __("No subject line in %s ?"), $fn;
 }
 
 if ($compose) {
@@ -659,7 +662,7 @@ if ($compose) {
 		tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
 		tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
 	open my $c, ">", $compose_filename
-		or die "Failed to open for writing $compose_filename: $!";
+		or die sprintf __("Failed to open for writing %s: %s"), $compose_filename, $!;
 
 
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
@@ -690,10 +693,10 @@ EOT
 	}
 
 	open my $c2, ">", $compose_filename . ".final"
-		or die "Failed to open $compose_filename.final : " . $!;
+		or die sprintf __("Failed to open %s.final : %s"), $compose_filename, $!;
 
 	open $c, "<", $compose_filename
-		or die "Failed to open $compose_filename : " . $!;
+		or die sprintf __("Failed to open %s : %s"), $compose_filename, $!;
 
 	my $need_8bit_cte = file_has_nonascii($compose_filename);
 	my $in_body = 0;
@@ -767,7 +770,9 @@ sub ask {
 			return $resp;
 		}
 		if ($confirm_only) {
-			my $yesno = $term->readline("Are you sure you want to use <$resp> [y/N]? ");
+			# TRANSLATORS: Keep [y/N] as is.
+			my $yesno = $term->readline(
+				sprintf __("Are you sure you want to use <%s> [y/N]? "), $resp);
 			if (defined $yesno && $yesno =~ /y/i) {
 				return $resp;
 			}
@@ -846,7 +851,7 @@ my %EXPANDED_ALIASES;
 sub expand_one_alias {
 	my $alias = shift;
 	if ($EXPANDED_ALIASES{$alias}) {
-		die "fatal: alias '$alias' expands to itself\n";
+		die sprintf __("fatal: alias '%s' expands to itself\n"), $alias;
 	}
 	local $EXPANDED_ALIASES{$alias} = 1;
 	return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;
@@ -908,7 +913,7 @@ sub extract_valid_address {
 sub extract_valid_address_or_die {
 	my $address = shift;
 	$address = extract_valid_address($address);
-	die "error: unable to extract a valid address from: $address\n"
+	die sprintf(__("error: unable to extract a valid address from: %s\n"), $address)
 		if !$address;
 	return $address;
 }
@@ -916,7 +921,7 @@ sub extract_valid_address_or_die {
 sub validate_address {
 	my $address = shift;
 	while (!extract_valid_address($address)) {
-		print STDERR "error: unable to extract a valid address from: $address\n";
+		printf STDERR __("error: unable to extract a valid address from: %s\n"), $address;
 		# TRANSLATORS: Make sure to include [q] [d] [e] in your
 		# translation. The program will only accept English input
 		# at this point.
@@ -1221,7 +1226,7 @@ sub ssl_verify_params {
 		return (SSL_verify_mode => SSL_VERIFY_PEER(),
 			SSL_ca_file => $smtp_ssl_cert_path);
 	} else {
-		die "CA path \"$smtp_ssl_cert_path\" does not exist";
+		die sprintf __("CA path \"%s\" does not exist"), $smtp_ssl_cert_path;
 	}
 }
 
@@ -1383,7 +1388,7 @@ Message-Id: $message_id
 					# supported commands
 					$smtp->hello($smtp_domain);
 				} else {
-					die "Server does not support STARTTLS! ".$smtp->message;
+					die sprintf __("Server does not support STARTTLS! %s"), $smtp->message;
 				}
 			}
 		}
@@ -1440,7 +1445,7 @@ $subject = $initial_subject;
 $message_num = 0;
 
 foreach my $t (@files) {
-	open my $fh, "<", $t or die "can't open file $t";
+	open my $fh, "<", $t or die sprintf __("can't open file %s"), $t;
 
 	my $author = undef;
 	my $sauthor = undef;
@@ -1669,11 +1674,11 @@ sub recipients_cmd {
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
+	    or die sprintf __("(%s) failed to close pipe to '%s'"), $prefix, $cmd;
 	return @addresses;
 }
 
@@ -1727,10 +1732,10 @@ sub unique_email_list {
 sub validate_patch {
 	my $fn = shift;
 	open(my $fh, '<', $fn)
-		or die "unable to open $fn: $!\n";
+		or die sprintf __("unable to open %s: %s\n"), $fn, $!;
 	while (my $line = <$fh>) {
 		if (length($line) > 998) {
-			return "$.: patch contains a line longer than 998 characters";
+			return sprintf __("%s: patch contains a line longer than 998 characters"), $.;
 		}
 	}
 	return;
@@ -1739,7 +1744,7 @@ sub validate_patch {
 sub file_has_nonascii {
 	my $fn = shift;
 	open(my $fh, '<', $fn)
-		or die "unable to open $fn: $!\n";
+		or die sprintf __("unable to open %s: %s\n"), $fn, $!;
 	while (my $line = <$fh>) {
 		return 1 if $line =~ /[^[:ascii:]]/;
 	}
@@ -1749,7 +1754,7 @@ sub file_has_nonascii {
 sub body_or_subject_has_nonascii {
 	my $fn = shift;
 	open(my $fh, '<', $fn)
-		or die "unable to open $fn: $!\n";
+		or die sprintf __("unable to open %s: %s\n"), $fn, $!;
 	while (my $line = <$fh>) {
 		last if $line =~ /^$/;
 		return 1 if $line =~ /^Subject.*[^[:ascii:]]/;
-- 
2.6.6

