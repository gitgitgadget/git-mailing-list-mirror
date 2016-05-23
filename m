From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [RFC-PATCH 1/2] send-email: new option to quote an email and reply to
Date: Mon, 23 May 2016 21:30:28 +0200
Message-ID: <1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
Cc: samuel.groot@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>,
	Tom Russello <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 21:32:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vaP-00033H-Ml
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbcEWTb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:31:56 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:56379 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbcEWTbx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:31:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B4D93254A;
	Mon, 23 May 2016 21:31:49 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NIIXZA1VJpyR; Mon, 23 May 2016 21:31:49 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id A3AC92549;
	Mon, 23 May 2016 21:31:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id A10F52077;
	Mon, 23 May 2016 21:31:49 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bQ2ubF9y93Xl; Mon, 23 May 2016 21:31:49 +0200 (CEST)
Received: from ux-305.numericable.fr (1.23.6.84.rev.sfr.net [84.6.23.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 636282066;
	Mon, 23 May 2016 21:31:49 +0200 (CEST)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295379>

From: Tom Russello <tom.russello@ensimag.grenoble-inp.fr>

This new option takes an email message file, parses it, fills the "To",
"Subject" and "Cc" fields appropriately and quote the message.
This option involves the `--compose` mode to edit the cover letter quoting the
given email.

Signed-off-by: Tom Russello <tom.russello@grenoble-inp.org>
Signed-off-by: Samuel Groot <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---

diff --git a/git-send-email.perl b/git-send-email.perl
index 6958785..784b8a6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -55,6 +55,7 @@ git send-email --dump-aliases
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
+    --quote-mail            <str>  * Email To, Cc and quote the message.
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
@@ -160,7 +161,7 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
-	$initial_reply_to,$initial_subject,@files,
+	$initial_reply_to,$quote_mail,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
 
 my $envelope_sender;
@@ -304,6 +305,7 @@ $rc = GetOptions(
 		    "sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_reply_to,
 		    "subject=s" => \$initial_subject,
+		    "quote-mail=s" => \$quote_mail,
 		    "to=s" => \@initial_to,
 		    "to-cmd=s" => \$to_cmd,
 		    "no-to" => \$no_to,
@@ -638,6 +640,98 @@ if (@files) {
 	print STDERR "\nNo patch files specified!\n\n";
 	usage();
 }
+my $message_quoted;
+if ($quote_mail) {
+	$message_quoted = "";
+	my $error = validate_patch($quote_mail);
+	$error and die "fatal: $quote_mail: $error\nwarning: no patches were sent\n";
+	$compose = 1;
+	my @header = ();
+	open my $fh, "<", $quote_mail or die "can't open file $quote_mail";
+	while(<$fh>) {
+		#for files containing crlf line endings
+		$_=~ s/\r//g;
+		last if /^\s*$/;
+		if (/^\s+\S/ and @header) {
+			chomp($header[$#header]);
+			s/^\s+/ /;
+			$header[$#header] .= $_;
+		} else {
+			push(@header, $_);
+		}
+	}
+
+	foreach(@header) {
+		my $input_format;
+		my $initial_sender = $sender || $repoauthor || $repocommitter || '';
+		if (/^From /) {
+			$input_format = 'mbox';
+			next;
+		}
+		chomp;
+		if (!defined $input_format && /^[-A-Za-z]+:\s/) {
+			$input_format = 'mbox';
+		}
+
+		if (defined $input_format && $input_format eq 'mbox') {
+			if (/^Subject:\s+(.*)$/i) {
+				my $prefix_re = "";
+				my $subject_re = $1;
+				if ($1=~/^[^Re:]/) {
+					$prefix_re = "Re: ";
+				}
+				$initial_subject = $prefix_re.$subject_re;
+			}
+			elsif (/^From:\s+(.*)$/i) {
+				push @initial_to, $1;
+			}
+			elsif (/^To:\s+(.*)$/i) {
+				foreach my $addr (parse_address_line($1)) {
+					if (!($addr eq $initial_sender)) {
+						push @initial_to, $addr;
+					}
+				}
+			} elsif (/^Cc:\s+(.*)$/i) {
+				foreach my $addr (parse_address_line($1)) {
+					my $qaddr = unquote_rfc2047($addr);
+					my $saddr = sanitize_address($qaddr);
+					if ($saddr eq $initial_sender) {
+						next if ($suppress_cc{'self'});
+					} else {
+						next if ($suppress_cc{'cc'});
+					}
+					push @initial_cc, $addr;
+				}
+			} elsif (/^Message-Id: (.*)/i) {
+				$initial_reply_to = $1;
+			}
+		} else {
+			# In the traditional
+			# "send lots of email" format,
+			# line 1 = cc
+			# line 2 = subject
+			# So let's support that, too.
+			$input_format = 'lots';
+			if (@cc == 0 && !$suppress_cc{'cc'}) {
+				push @cc, $_;
+			} elsif (!defined $initial_subject) {
+				$initial_subject = $_;
+			}
+		}
+	}
+
+	#Message body
+	while (<$fh>) {
+		#for files containing crlf line endings
+		$_=~ s/\r//g;
+		my $space="";
+		if (/^[^>]/) {
+			$space = " ";
+		}
+		$message_quoted .=  ">".$space.$_;
+	}
+
+}
 
 sub get_patch_subject {
 	my $fn = shift;
@@ -664,6 +758,7 @@ if ($compose) {
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_reply_to = $initial_reply_to || '';
+	my $tpl_quote = $message_quoted || '';
 
 	print $c <<EOT;
 From $tpl_sender # This line is ignored.
@@ -676,6 +771,8 @@ From: $tpl_sender
 Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
 
+$tpl_quote
+
 EOT
 	for my $f (@files) {
 		print $c get_patch_subject($f);
-- 
2.8.2
