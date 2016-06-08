From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: [PATCH v4 6/6] send-email: add option --cite to quote the message body
Date: Wed,  8 Jun 2016 15:08:33 +0200
Message-ID: <20160608130833.32274-1-samuel.groot@grenoble-inp.org>
References: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
Cc: samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, gitster@pobox.com, aaron@schrab.com,
	e@80x24.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 15:09:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAdEJ-0006nV-C5
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 15:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425096AbcFHNJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 09:09:01 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:38543 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbcFHNJA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 09:09:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 6EE5F20B4;
	Wed,  8 Jun 2016 15:08:57 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8iCUFcCCW-SM; Wed,  8 Jun 2016 15:08:57 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 54BC120B2;
	Wed,  8 Jun 2016 15:08:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 518942066;
	Wed,  8 Jun 2016 15:08:57 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvU6St7HGySw; Wed,  8 Jun 2016 15:08:57 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 10BF82064;
	Wed,  8 Jun 2016 15:08:57 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.667.gf43de12
In-Reply-To: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296795>

If used with `in-reply-to=<email_file>`, cite the message body of the given
email file. Otherwise, do nothing.

If `--compose` is also set, quote the message body in the cover letter. Else,
imply `--annotate` by default and quote the message body below the triple-dash
section in the first patch only.

Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
 Documentation/git-send-email.txt |  8 ++++
 git-send-email.perl              | 81 ++++++++++++++++++++++++++++++++++++++--
 t/t9001-send-email.sh            | 32 ++++++++++++++++
 3 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 21776f0..23cbd17 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -109,6 +109,14 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
 Only necessary if --compose is also set.  If --compose
 is not set, this will be prompted for.
 
+--cite::
+	When used with `--in-reply-to=<email_file>`, quote the message body of the
+	given email file.
++
+If `--compose` is also set, the message cited will be in the cover letter. If
+`--compose` is not set, `--annotate` option is implied by default and the
+message body will be cited in the "below-triple-dash" section.
+
 --subject=<string>::
 	Specify the initial subject of the email thread.
 	Only necessary if --compose is also set.  If --compose
diff --git a/git-send-email.perl b/git-send-email.perl
index b444ea6..6877ea7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,6 +26,7 @@ use Text::ParseWords;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catfile);
+use File::Copy;
 use Error qw(:try);
 use Git;
 
@@ -56,6 +57,8 @@ git send-email --dump-aliases
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
     --in-reply-to          <file>  * Populate header fields appropriately.
+    --cite                         * Quote the message body in the cover if
+                                     --compose is set, else in the first patch.
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
@@ -161,7 +164,7 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
-	$initial_reply_to,$initial_references,$initial_subject,@files,
+	$initial_reply_to,$initial_references,$cite,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
 
 my $envelope_sender;
@@ -305,6 +308,7 @@ $rc = GetOptions(
 		    "sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_reply_to,
 		    "subject=s" => \$initial_subject,
+		    "cite" => \$cite,
 		    "to=s" => \@initial_to,
 		    "to-cmd=s" => \$to_cmd,
 		    "no-to" => \$no_to,
@@ -640,6 +644,7 @@ if (@files) {
 	usage();
 }
 
+my $message_cited;
 if ($initial_reply_to && -f $initial_reply_to) {
 	my $error = validate_patch($initial_reply_to);
 	die "fatal: $initial_reply_to: $error\nwarning: no patches were sent\n"
@@ -658,7 +663,8 @@ if ($initial_reply_to && -f $initial_reply_to) {
 	}
 	$initial_subject = $prefix_re . $subject_re;
 
-	push @initial_to, $mail->{"from"}[0];
+	my $recipient = $mail->{"from"}[0];
+	push @initial_to, $recipient;
 
 	foreach my $to_addr (parse_address_line(join ",", @{$mail->{"to"}})) {
 		if (!($to_addr eq $initial_sender)) {
@@ -684,6 +690,25 @@ if ($initial_reply_to && -f $initial_reply_to) {
 		$initial_references = join("", @{$mail->{"references"}}) .
 			" " . $initial_reply_to;
 	}
+
+	if ($cite) {
+		my $date = $mail->{"date"}[0];
+		my $tpl_date =  $date && "On $date, " || '';
+		$message_cited = $tpl_date . $recipient . " wrote:\n";
+
+		# Quote the message body
+		foreach (@{$mail->{"body"}}) {
+			my $space = "";
+			if (/^[^>]/) {
+				$space = " ";
+			}
+			$message_cited .= ">" . $space . $_;
+		}
+
+		if (!$compose) {
+			$annotate = 1;
+		}
+	}
 }
 
 sub get_patch_subject {
@@ -711,6 +736,9 @@ if ($compose) {
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_reply_to = $initial_reply_to || '';
+	my $tpl_quote = $message_cited &&
+		"\nGIT: Please, trim down irrelevant sections in the cited message\n".
+		"GIT: to keep your email concise.\n" . $message_cited || '';
 
 	print $c <<EOT;
 From $tpl_sender # This line is ignored.
@@ -722,7 +750,7 @@ GIT: Clear the body content if you don't wish to send a summary.
 From: $tpl_sender
 Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
-
+$tpl_quote
 EOT
 	for my $f (@files) {
 		print $c get_patch_subject($f);
@@ -787,7 +815,52 @@ EOT
 		$compose = -1;
 	}
 } elsif ($annotate) {
-	do_edit(@files);
+	if ($message_cited) {
+		my $cite_email_filename = ($repo ?
+			tempfile(".gitsendemail.msg.XXXXXX",
+				DIR => $repo->repo_path()) :
+			tempfile(".gitsendemail.msg.XXXXXX",
+				DIR => "."))[1];
+
+		# Insertion in a temporary file to keep the original file clean
+		# in case of cancellation/error.
+		do_insert_cited_message($cite_email_filename, $files[0]);
+
+		my $tmp = $files[0];
+		$files[0] = $cite_email_filename;
+
+		do_edit(@files);
+
+		# Erase the original patch if the edition went well
+		move($cite_email_filename, $tmp);
+		$files[0] = $tmp;
+	} else {
+		do_edit(@files);
+	}
+}
+
+sub do_insert_cited_message {
+	my $tmp_file = shift;
+	my $original_file = shift;
+
+	open my $c, "<", $original_file
+	or die "Failed to open $original_file: " . $!;
+
+	open my $c2, ">", $tmp_file
+		or die "Failed to open $tmp_file: " . $!;
+
+	# Insertion after the triple-dash
+	while (<$c>) {
+		print $c2 $_;
+		last if (/^---$/);
+	}
+	print $c2 $message_cited;
+	while (<$c>) {
+		print $c2 $_;
+	}
+
+	close $c;
+	close $c2;
 }
 
 sub ask {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 7591342..29e28f2 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1915,6 +1915,7 @@ test_expect_success $PREREQ 'Fields with --in-reply-to are correct' '
 	git send-email \
 		--in-reply-to=email \
 		--from="Example <nobody@example.com>" \
+		--cite \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		-2 \
 		2>errors &&
@@ -1936,10 +1937,22 @@ test_expect_success $PREREQ 'Fields with --in-reply-to are correct' '
 	echo "$ref_adr" | grep -v "References: <author_123456@example.com>"
 '
 
+test_expect_success $PREREQ 'correct cited message with --in-reply-to' '
+	msg_cited=$(grep -A 3 "^---$" msgtxt1) &&
+	echo "$msg_cited" | grep "On Sat, 12 Jun 2010 15:53:58 +0200, author@example.com wrote:" &&
+	echo "$msg_cited" | grep "> Have you seen my previous email?" &&
+	echo "$msg_cited" | grep ">> Previous content"
+'
+
+test_expect_success $PREREQ 'second patch body is not modified by --in-reply-to' '
+	! grep "Have you seen my previous email?" msgtxt2
+'
+
 test_expect_success $PREREQ 'Fields with --in-reply-to and --compose are correct' '
 	clean_fake_sendmail &&
 	git send-email \
 		--in-reply-to=email \
+		--cite \
 		--compose \
 		--from="Example <nobody@example.com>" \
 		--smtp-server="$(pwd)/fake.sendmail" \
@@ -1967,6 +1980,7 @@ test_expect_success $PREREQ 'Fields with --in-reply-to and --compose are correct
 test_expect_success $PREREQ 'Re: written only once with --in-reply-to and --compose ' '
 	git send-email \
 		--in-reply-to=msgtxt1 \
+		--cite \
 		--compose \
 		--from="Example <nobody@example.com>" \
 		--smtp-server="$(pwd)/fake.sendmail" \
@@ -1975,4 +1989,22 @@ test_expect_success $PREREQ 'Re: written only once with --in-reply-to and --comp
 	grep "Subject: Re: subject goes here" msgtxt3
 '
 
+test_expect_success $PREREQ 'correct cited message with --in-reply-to and --compose' '
+	grep "> On Sat, 12 Jun 2010 15:53:58 +0200, author@example.com wrote:" msgtxt3 &&
+	grep ">> Have you seen my previous email?" msgtxt3 &&
+	grep ">>> Previous content" msgtxt3
+'
+
+test_expect_success $PREREQ 'Message is not cited with only --in-reply-to' '
+	clean_fake_sendmail &&
+	git send-email \
+		--in-reply-to=email \
+		--compose \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		-1 \
+		2>errors &&
+	! grep "Have you seen my previous email?" msgtxt1
+'
+
 test_done
-- 
2.8.2.537.gb153d2a
