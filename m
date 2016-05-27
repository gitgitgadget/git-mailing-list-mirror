From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: [WIP-PATCH 2/2] send-email: use refactored subroutine to parse patches
Date: Fri, 27 May 2016 16:01:04 +0200
Message-ID: <20160527140104.11192-3-samuel.groot@grenoble-inp.org>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
Cc: e@80x24.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	gitster@pobox.com, aaron@schrab.com,
	Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Tom RUSSELLO <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 16:01:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6IKL-0005JC-8r
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 16:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbcE0OBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 10:01:17 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:33245 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbcE0OBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 10:01:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id CFAF320F9;
	Fri, 27 May 2016 16:01:11 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yZ-omUXww87g; Fri, 27 May 2016 16:01:11 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B66D720F5;
	Fri, 27 May 2016 16:01:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id B292E2077;
	Fri, 27 May 2016 16:01:11 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aadn3d0nVLzT; Fri, 27 May 2016 16:01:11 +0200 (CEST)
Received: from wificampus-031045.grenet.fr (wificampus-031045.grenet.fr [130.190.31.45])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id B2D3C2055;
	Fri, 27 May 2016 16:01:10 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.537.gb153d2a
In-Reply-To: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295754>

Use the two subroutines `parse_email` and `parse_header` introduced in
previous commit to parse patches.

Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
 git-send-email.perl | 179 +++++++++++++++++-----------------------------------
 1 file changed, 59 insertions(+), 120 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f33a083..7bb4a2d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -161,7 +161,7 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
 	$initial_reply_to,$initial_subject,@files,
-	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
+	$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
 
 my $envelope_sender;
 
@@ -1431,117 +1431,57 @@ $subject = $initial_subject;
 $message_num = 0;
 
 foreach my $t (@files) {
-	open my $fh, "<", $t or die "can't open file $t";
-
-	my $author = undef;
-	my $sauthor = undef;
-	my $author_encoding;
-	my $has_content_type;
-	my $body_encoding;
-	my $xfer_encoding;
-	my $has_mime_version;
-	@to = ();
-	@cc = ();
-	@xh = ();
-	my $input_format = undef;
-	my @header = ();
 	$message = "";
 	$message_num++;
-	# First unfold multiline header fields
-	while(<$fh>) {
-		last if /^\s*$/;
-		if (/^\s+\S/ and @header) {
-			chomp($header[$#header]);
-			s/^\s+/ /;
-			$header[$#header] .= $_;
-	    } else {
-			push(@header, $_);
-		}
-	}
-	# Now parse the header
-	foreach(@header) {
-		if (/^From /) {
-			$input_format = 'mbox';
-			next;
-		}
-		chomp;
-		if (!defined $input_format && /^[-A-Za-z]+:\s/) {
-			$input_format = 'mbox';
-		}
 
-		if (defined $input_format && $input_format eq 'mbox') {
-			if (/^Subject:\s+(.*)$/i) {
-				$subject = $1;
-			}
-			elsif (/^From:\s+(.*)$/i) {
-				($author, $author_encoding) = unquote_rfc2047($1);
-				$sauthor = sanitize_address($author);
-				next if $suppress_cc{'author'};
-				next if $suppress_cc{'self'} and $sauthor eq $sender;
-				printf("(mbox) Adding cc: %s from line '%s'\n",
-					$1, $_) unless $quiet;
-				push @cc, $1;
-			}
-			elsif (/^To:\s+(.*)$/i) {
-				foreach my $addr (parse_address_line($1)) {
-					printf("(mbox) Adding to: %s from line '%s'\n",
-						$addr, $_) unless $quiet;
-					push @to, $addr;
-				}
-			}
-			elsif (/^Cc:\s+(.*)$/i) {
-				foreach my $addr (parse_address_line($1)) {
-					my $qaddr = unquote_rfc2047($addr);
-					my $saddr = sanitize_address($qaddr);
-					if ($saddr eq $sender) {
-						next if ($suppress_cc{'self'});
-					} else {
-						next if ($suppress_cc{'cc'});
-					}
-					printf("(mbox) Adding cc: %s from line '%s'\n",
-						$addr, $_) unless $quiet;
-					push @cc, $addr;
-				}
-			}
-			elsif (/^Content-type:/i) {
-				$has_content_type = 1;
-				if (/charset="?([^ "]+)/) {
-					$body_encoding = $1;
-				}
-				push @xh, $_;
-			}
-			elsif (/^MIME-Version/i) {
-				$has_mime_version = 1;
-				push @xh, $_;
-			}
-			elsif (/^Message-Id: (.*)/i) {
-				$message_id = $1;
-			}
-			elsif (/^Content-Transfer-Encoding: (.*)/i) {
-				$xfer_encoding = $1 if not defined $xfer_encoding;
-			}
-			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
-				push @xh, $_;
-			}
+	# Split email into header and body
+	open my $fh, "<", $t or die "can't open file $t";
+	my (@header, @body) = parse_email($fh);
+	close $fh;
 
+	# Parse header
+	my %parsed_header = parse_header(@header);
+	my $from = $parsed_header{"from"};
+	$subject = $parsed_header{"subject"};
+	$message_id = $parsed_header{"message_id"};
+	@to = @{$parsed_header{"to"}};
+	@cc = @{$parsed_header{"cc"}};
+	@xh = @{$parsed_header{"xh"}};
+	my %flags = %{$parsed_header{"flags"}};
+
+	# Process parsed headers
+	my ($author, $author_encoding) = unquote_rfc2047($from);
+	my $sauthor = sanitize_address($author);
+	unless ($suppress_cc{'author'} or
+		($suppress_cc{'self'} and $sauthor eq $sender)) {
+		printf("(mbox) Adding cc: %s from line 'From: %s'\n",
+			$from, $from) unless $quiet;
+		push @cc, $from;
+	}
+
+	foreach (@to) {
+		printf("(mbox) Adding to: %s from line 'To: %s'\n",
+			$_, $_) unless $quiet;
+	}
+
+	my @tmpcc = ();
+	foreach (@cc) {
+		my $qaddr = unquote_rfc2047($_);
+		my $saddr = sanitize_address($qaddr);
+		if ($saddr eq $sender) {
+			next if ($suppress_cc{'self'});
 		} else {
-			# In the traditional
-			# "send lots of email" format,
-			# line 1 = cc
-			# line 2 = subject
-			# So let's support that, too.
-			$input_format = 'lots';
-			if (@cc == 0 && !$suppress_cc{'cc'}) {
-				printf("(non-mbox) Adding cc: %s from line '%s'\n",
-					$_, $_) unless $quiet;
-				push @cc, $_;
-			} elsif (!defined $subject) {
-				$subject = $_;
-			}
+			next if ($suppress_cc{'cc'});
 		}
+		printf("(mbox) Adding cc: %s from line 'Cc: %s'\n",
+			$_, $_) unless $quiet;
+		push @tmpcc, $_;
 	}
+	@cc = @tmpcc;
+
+
 	# Now parse the message body
-	while(<$fh>) {
+	foreach (@body) {
 		$message .=  $_;
 		if (/^(Signed-off-by|Cc): (.*)$/i) {
 			chomp;
@@ -1559,18 +1499,17 @@ foreach my $t (@files) {
 				$c, $_) unless $quiet;
 		}
 	}
-	close $fh;
 
 	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
 		if defined $to_cmd;
 	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
 		if defined $cc_cmd && !$suppress_cc{'cccmd'};
 
-	if ($broken_encoding{$t} && !$has_content_type) {
-		$xfer_encoding = '8bit' if not defined $xfer_encoding;
-		$has_content_type = 1;
+	if ($broken_encoding{$t} && !$flags{"has_content_type"}) {
+		$flags{"xfer_encoding"} = '8bit' if not defined $flags{"xfer_encoding"};
+		$flags{"has_content_type"} = 1;
 		push @xh, "Content-Type: text/plain; charset=$auto_8bit_encoding";
-		$body_encoding = $auto_8bit_encoding;
+		$flags{"body_encoding"} = $auto_8bit_encoding;
 	}
 
 	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject)) {
@@ -1580,8 +1519,8 @@ foreach my $t (@files) {
 	if (defined $sauthor and $sauthor ne $sender) {
 		$message = "From: $author\n\n$message";
 		if (defined $author_encoding) {
-			if ($has_content_type) {
-				if ($body_encoding eq $author_encoding) {
+			if ($flags{"has_content_type"}) {
+				if ($flags{"body_encoding"} eq $author_encoding) {
 					# ok, we already have the right encoding
 				}
 				else {
@@ -1589,24 +1528,24 @@ foreach my $t (@files) {
 				}
 			}
 			else {
-				$xfer_encoding = '8bit' if not defined $xfer_encoding;
-				$has_content_type = 1;
+				$flags{"xfer_encoding"} = '8bit' if not defined $flags{"xfer_encoding"};
+				$flags{"has_content_type"} = 1;
 				push @xh,
 				  "Content-Type: text/plain; charset=$author_encoding";
 			}
 		}
 	}
 	if (defined $target_xfer_encoding) {
-		$xfer_encoding = '8bit' if not defined $xfer_encoding;
+		$flags{"xfer_encoding"} = '8bit' if not defined $flags{"xfer_encoding"};
 		$message = apply_transfer_encoding(
-			$message, $xfer_encoding, $target_xfer_encoding);
-		$xfer_encoding = $target_xfer_encoding;
+			$message, $flags{"xfer_encoding"}, $target_xfer_encoding);
+		$flags{"xfer_encoding"} = $target_xfer_encoding;
 	}
-	if (defined $xfer_encoding) {
-		push @xh, "Content-Transfer-Encoding: $xfer_encoding";
+	if (defined $flags{"xfer_encoding"}) {
+		push @xh, "Content-Transfer-Encoding: ".$flags{"xfer_encoding"};
 	}
-	if (defined $xfer_encoding or $has_content_type) {
-		unshift @xh, 'MIME-Version: 1.0' unless $has_mime_version;
+	if (defined $flags{"xfer_encoding"} or $flags{"has_content_type"}) {
+		unshift @xh, 'MIME-Version: 1.0' unless $flags{"has_mime_version"};
 	}
 
 	$needs_confirm = (
-- 
2.8.2.537.gb153d2a
