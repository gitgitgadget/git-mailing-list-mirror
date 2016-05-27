From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [RFC-PATCH v2 2/2] send-email: quote-email quotes the message body
Date: Fri, 27 May 2016 19:11:42 +0200
Message-ID: <1464369102-7551-3-git-send-email-tom.russello@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
Cc: jordan.de-gea@grenoble-inp.org, erwan.mathoniere@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, samuel.groot@grenoble-inp.org,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com,
	Tom Russello <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 19:12:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6LJA-0007nS-GH
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 19:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbcE0RMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 13:12:21 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:39265 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932836AbcE0RMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 13:12:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id DF28620FB;
	Fri, 27 May 2016 19:12:16 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M97-yK-IhNo7; Fri, 27 May 2016 19:12:16 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C890820ED;
	Fri, 27 May 2016 19:12:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id C23782077;
	Fri, 27 May 2016 19:12:16 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id clVhg9imc4r8; Fri, 27 May 2016 19:12:16 +0200 (CEST)
Received: from ux-305.grenet.fr (eduroam-032034.grenet.fr [130.190.32.34])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id A47302055;
	Fri, 27 May 2016 19:12:16 +0200 (CEST)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295773>

Take an email message file, parse it and quote the message body.

If `--compose` is set, then it will quote the message in the cover letter.
Otherwise, imply `--annotate` option and put the quoted message in the first
patch after the triple-dash.

Signed-off-by: Tom Russello <tom.russello@grenoble-inp.org>
Signed-off-by: Samuel Groot <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
Currently, `send-email` without `--compose` implies `--annotate`. The
current behavior of `--annotate` is that changes made during edition are saved
in patch files.

Keeping that behavior when using `--quote-email` populates the patch file with
the quoted message body, and the patch is saved no matter what. If the user
closes his editor and then exits `send-email`, changes will be saved.

Should we keep the current behavior for the user, keeping the changes (including
the quoted message body) in the patch, or should we discard them?


changes since v1:
	- default behaviour of the option: it is now --annotate as one may not want
	  to send a cover letter for a single patch
	- "On [date], [original author] wrote:" is added before the quoted message
	- request to trim useless parts of the cited message when `--compose` is set
	- extra blank removed when the message quoted is empty

 Documentation/git-send-email.txt |  5 ++-
 git-send-email.perl              | 79 +++++++++++++++++++++++++++++++++++++---
 t/t9001-send-email.sh            |  6 +++
 3 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 2334d69..68bbb6c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -109,7 +109,10 @@ is not set, this will be prompted for.
 --quote-email=<email_file>::
 	Reply to the given email and automatically populate the "To:", "Cc:" and
 	"In-Reply-To:" fields. If `--compose` is set, this will also fill the
-	subject field with "Re: [<email_file>'s subject]".
+	subject field with "Re: [<email_file>'s subject]" and quote the message body
+	of <email_file>. If `--compose` is not set, this will imply `--annotate`
+	option and will quote the message body of <email_file> after the triple-dash
+	in the first patch.
 
 --subject=<string>::
 	Specify the initial subject of the email thread.
diff --git a/git-send-email.perl b/git-send-email.perl
index 9df3dee..e73aa25 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,6 +26,7 @@ use Text::ParseWords;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catfile);
+use File::Copy;
 use Error qw(:try);
 use Git;
 
@@ -55,8 +56,8 @@ git send-email --dump-aliases
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
-    --quote-email           <file> * Fill the fields "To:", "Cc:", "Subject:",
-                                     "In-Reply-To" appropriately.
+    --quote-email           <file> * Fill To:, Cc:, Subject:, In-Reply-To:
+                                     appropriately and quote the message body.
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
@@ -642,11 +643,14 @@ if (@files) {
 	usage();
 }
 
+my $message_quoted;
 if ($quote_email) {
 	my $error = validate_patch($quote_email);
 	$error and die "fatal: $quote_email: $error\nwarning: no patches were sent\n";
 
 	my @header = ();
+	my $date;
+	my $recipient;
 
 	open my $fh, "<", $quote_email or die "can't open file $quote_email";
 
@@ -687,7 +691,8 @@ if ($quote_email) {
 				}
 				$initial_subject = $prefix_re . $subject_re;
 			} elsif (/^From:\s+(.*)$/i) {
-				push @initial_to, $1;
+				$recipient = $1;
+				push @initial_to, $recipient;
 			} elsif (/^To:\s+(.*)$/i) {
 				foreach my $addr (parse_address_line($1)) {
 					if (!($addr eq $initial_sender)) {
@@ -707,6 +712,8 @@ if ($quote_email) {
 				}
 			} elsif (/^Message-Id: (.*)/i) {
 				$initial_reply_to = $1;
+			} elsif (/^Date: (.*)/i) {
+				$date = $1;
 			}
 		} else {
 			# In the traditional
@@ -722,6 +729,23 @@ if ($quote_email) {
 			}
 		}
 	}
+
+	my $tpl_date = $date && "On $date, " || '';
+	$message_quoted = $tpl_date . $recipient . " wrote:\n";
+
+	# Quote the message body
+	while (<$fh>) {
+		# Only for files containing crlf line endings
+		s/\r//g;
+		my $space = "";
+		if (/^[^>]/) {
+			$space = " ";
+		}
+		$message_quoted .= ">" . $space . $_;
+	}
+	if (!$compose) {
+		$annotate = 1;
+	}
 }
 
 sub get_patch_subject {
@@ -749,6 +773,9 @@ if ($compose) {
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_reply_to = $initial_reply_to || '';
+	my $tpl_quote = $message_quoted &&
+		"\nGIT: Please, trim down irrelevant sections in the quoted message\n".
+		"GIT: to keep your email concise\n" . $message_quoted || '';
 
 	print $c <<EOT;
 From $tpl_sender # This line is ignored.
@@ -760,7 +787,7 @@ GIT: Clear the body content if you don't wish to send a summary.
 From: $tpl_sender
 Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
-
+$tpl_quote
 EOT
 	for my $f (@files) {
 		print $c get_patch_subject($f);
@@ -825,9 +852,51 @@ EOT
 		$compose = -1;
 	}
 } elsif ($annotate) {
-	do_edit(@files);
+	if ($quote_email) {
+		my $quote_email_filename = ($repo ?
+			tempfile(".gitsendemail.msg.XXXXXX",
+				DIR => $repo->repo_path()) :
+			tempfile(".gitsendemail.msg.XXXXXX",
+				DIR => "."))[1];
+
+		do_insert_quoted_message($quote_email_filename, $files[0]);
+
+		my $tmp = $files[0];
+		$files[0] = $quote_email_filename;
+
+		do_edit(@files);
+
+		# Erase the original patch
+		move($quote_email_filename, $tmp);
+		$files[0] = $tmp;
+	} else {
+		do_edit(@files);
+	}
 }
 
+sub do_insert_quoted_message {
+	my $tmp_file = shift;
+	my $original_file = shift;
+
+	open my $c, "<", $original_file
+	or die "Failed to open $original_file : " . $!;
+
+	open my $c2, ">", $tmp_file
+		or die "Failed to open $tmp_file : " . $!;
+
+	# Insertion after the triple-dash
+	while (<$c>) {
+		print $c2 $_;
+		last if (/^---$/);
+	}
+	print $c2 $message_quoted;
+	while (<$c>) {
+		print $c2 $_;
+	}
+
+	close $c;
+	close $c2;
+}
 sub ask {
 	my ($prompt, %arg) = @_;
 	my $valid_re = $arg{valid_re};
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 389a54c..5ab7533 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1916,6 +1916,12 @@ test_expect_success $PREREQ 'Fields with --quote-email are correct' '
 	echo "$cc_adr" | grep cc1@example.com
 '
 
+test_expect_success $PREREQ 'correct quoted message with --quote-email' '
+	grep "On Sat, 12 Jun 2010 15:53:58 +0200, author@example.com wrote:" msgtxt1 &&
+	grep "> Have you seen my previous email?" msgtxt1 &&
+	grep ">> Previous content" msgtxt1
+'
+
 test_expect_success $PREREQ 'Fields with --quote-email and --compose are correct' '
 	clean_fake_sendmail &&
 	git send-email \
-- 
2.8.2
