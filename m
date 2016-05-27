From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [RFC-PATCH v2 1/2] send-email: quote-email populates the fields
Date: Fri, 27 May 2016 19:11:41 +0200
Message-ID: <1464369102-7551-2-git-send-email-tom.russello@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
Cc: jordan.de-gea@grenoble-inp.org, erwan.mathoniere@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, samuel.groot@grenoble-inp.org,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com,
	Tom Russello <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 19:12:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6LJ9-0007nS-P3
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 19:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbcE0RMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 13:12:19 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:60258 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932831AbcE0RMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 13:12:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 43CDB20F9;
	Fri, 27 May 2016 19:12:16 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u383HI-fIMkP; Fri, 27 May 2016 19:12:16 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 22D2420ED;
	Fri, 27 May 2016 19:12:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 169C12077;
	Fri, 27 May 2016 19:12:16 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BceFoW6hlKBw; Fri, 27 May 2016 19:12:16 +0200 (CEST)
Received: from ux-305.grenet.fr (eduroam-032034.grenet.fr [130.190.32.34])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id DEE8A2055;
	Fri, 27 May 2016 19:12:15 +0200 (CEST)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295774>

Take an email message file, parse it and fill the "To", "Cc" and
"In-Reply-To" fields appropriately.

If `--compose` option is set, it will also fill the subject field with
"Re: [<email_file>'s subject]".

Signed-off-by: Tom Russello <tom.russello@grenoble-inp.org>
Signed-off-by: Samuel Groot <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
As it is said in the cover letter, the file git-send-email.perl is being
refactored therefore the parsing section with nested if's is ought to
change.

changes since v1:
	- option's name changed and is now --quote-email
	- original From: becomes To:, original To:'s become Cc: and original
	  Cc:'s stay Cc:
	- coding style improved
	- documentation for the option
	- more tests

 Documentation/git-send-email.txt |  5 +++
 git-send-email.perl              | 87 +++++++++++++++++++++++++++++++++++++++-
 t/t9001-send-email.sh            | 61 ++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 771a7b5..2334d69 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -106,6 +106,11 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
 Only necessary if --compose is also set.  If --compose
 is not set, this will be prompted for.
 
+--quote-email=<email_file>::
+	Reply to the given email and automatically populate the "To:", "Cc:" and
+	"In-Reply-To:" fields. If `--compose` is set, this will also fill the
+	subject field with "Re: [<email_file>'s subject]".
+
 --subject=<string>::
 	Specify the initial subject of the email thread.
 	Only necessary if --compose is also set.  If --compose
diff --git a/git-send-email.perl b/git-send-email.perl
index 6958785..9df3dee 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -55,6 +55,8 @@ git send-email --dump-aliases
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
+    --quote-email           <file> * Fill the fields "To:", "Cc:", "Subject:",
+                                     "In-Reply-To" appropriately.
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
@@ -160,7 +162,7 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
-	$initial_reply_to,$initial_subject,@files,
+	$initial_reply_to,$quote_email,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
 
 my $envelope_sender;
@@ -304,6 +306,7 @@ $rc = GetOptions(
 		    "sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_reply_to,
 		    "subject=s" => \$initial_subject,
+		    "quote-email=s" => \$quote_email,
 		    "to=s" => \@initial_to,
 		    "to-cmd=s" => \$to_cmd,
 		    "no-to" => \$no_to,
@@ -639,6 +642,88 @@ if (@files) {
 	usage();
 }
 
+if ($quote_email) {
+	my $error = validate_patch($quote_email);
+	$error and die "fatal: $quote_email: $error\nwarning: no patches were sent\n";
+
+	my @header = ();
+
+	open my $fh, "<", $quote_email or die "can't open file $quote_email";
+
+	# Get the email header
+	while (<$fh>) {
+		# For files containing crlf line endings
+		s/\r//g;
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
+	# Parse the header
+	foreach (@header) {
+		my $input_format;
+		my $initial_sender = $sender || $repoauthor || $repocommitter || '';
+
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
+				if ($1 =~ /^[^Re:]/) {
+					$prefix_re = "Re: ";
+				}
+				$initial_subject = $prefix_re . $subject_re;
+			} elsif (/^From:\s+(.*)$/i) {
+				push @initial_to, $1;
+			} elsif (/^To:\s+(.*)$/i) {
+				foreach my $addr (parse_address_line($1)) {
+					if (!($addr eq $initial_sender)) {
+						push @initial_cc, $addr;
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
+}
+
 sub get_patch_subject {
 	my $fn = shift;
 	open (my $fh, '<', $fn);
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index b3355d2..389a54c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1885,4 +1885,65 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'setup expect' '
+	cat >email <<-\EOF
+	Message-Id: <author_123456@example.com>
+	From: author@example.com
+	To: to1@example.com
+	Cc: cc1@example.com
+	Date: Sat, 12 Jun 2010 15:53:58 +0200
+	Subject: subject goes here
+
+	Have you seen my previous email?
+	> Previous content
+	EOF
+'
+
+test_expect_success $PREREQ 'Fields with --quote-email are correct' '
+	clean_fake_sendmail &&
+	git send-email \
+		--quote-email=email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		-1 \
+		2>errors &&
+	grep "From: Example <nobody@example.com>" msgtxt1 &&
+	grep "In-Reply-To: <author_123456@example.com>" msgtxt1 &&
+	to_adr=$(awk "/^To: /,/^Cc: /" msgtxt1) &&
+	cc_adr=$(awk "/^Cc: /,/^Date /" msgtxt1) &&
+	echo "$to_adr" | grep author@example.com &&
+	echo "$cc_adr" | grep to1@example.com &&
+	echo "$cc_adr" | grep cc1@example.com
+'
+
+test_expect_success $PREREQ 'Fields with --quote-email and --compose are correct' '
+	clean_fake_sendmail &&
+	git send-email \
+		--quote-email=email \
+		--compose \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		-1 \
+		2>errors &&
+	grep "From: Example <nobody@example.com>" msgtxt1 &&
+	grep "In-Reply-To: <author_123456@example.com>" msgtxt1 &&
+	grep "Subject: Re: subject goes here" msgtxt1 &&
+	to_adr=$(awk "/^To: /,/^Cc: /" msgtxt1) &&
+	cc_adr=$(awk "/^Cc: /,/^Date /" msgtxt1) &&
+	echo "$to_adr" | grep author@example.com &&
+	echo "$cc_adr" | grep to1@example.com &&
+	echo "$cc_adr" | grep cc1@example.com
+'
+
+test_expect_success $PREREQ 'Re: written only once with --quote-email and --compose ' '
+	git send-email \
+		--quote-email=msgtxt1 \
+		--compose \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		-1 \
+		2>errors &&
+	grep "Subject: Re: subject goes here" msgtxt3
+'
+
 test_done
-- 
2.8.2
