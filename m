From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: [PATCH v4 5/6] send-email: --in-reply-to=<file> populate header fields
Date: Wed,  8 Jun 2016 15:07:36 +0200
Message-ID: <20160608130736.32163-1-samuel.groot@grenoble-inp.org>
References: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
Cc: samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, gitster@pobox.com, aaron@schrab.com,
	e@80x24.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 15:07:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAdD3-0005mJ-B2
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 15:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161540AbcFHNHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 09:07:45 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:34371 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497AbcFHNHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 09:07:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0A90025A4;
	Wed,  8 Jun 2016 15:07:42 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aJZvSZgL46et; Wed,  8 Jun 2016 15:07:41 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id EEA3C2415;
	Wed,  8 Jun 2016 15:07:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id E88262066;
	Wed,  8 Jun 2016 15:07:41 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w9EHUMFG5bv0; Wed,  8 Jun 2016 15:07:41 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 7DC002064;
	Wed,  8 Jun 2016 15:07:41 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.667.gf43de12
In-Reply-To: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296793>

Take an email message file, parse it and fill the "From", "To", "Cc",
"In-reply-to", "References" fields appropriately.

If `--compose` option is set, it will also fill the subject field with
`Re: [<email_file>'s subject]` in the introductory message.

Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
 Documentation/git-send-email.txt |  9 +++--
 git-send-email.perl              | 51 +++++++++++++++++++++++-
 t/t9001-send-email.sh            | 83 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index edbba3a..21776f0 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -84,13 +84,16 @@ See the CONFIGURATION section for 'sendemail.multiEdit'.
 	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
 	set, as returned by "git var -l".
 
---in-reply-to=<identifier>::
+--in-reply-to=<Message-Id|email_file>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
-	reply to the given Message-Id, which avoids breaking threads to
-	provide a new patch series.
+	reply to the given Message-Id (given directly by argument or via the email
+	file), which avoids breaking threads to provide a new patch series.
 	The second and subsequent emails will be sent as replies according to
 	the `--[no]-chain-reply-to` setting.
 +
+Furthermore, if the argument is an email file, parse it and populate header
+fields appropriately for the reply.
++
 So for example when `--thread` and `--no-chain-reply-to` are specified, the
 second and subsequent patches will be replies to the first one like in the
 illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
diff --git a/git-send-email.perl b/git-send-email.perl
index 9b51062..b444ea6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -55,6 +55,7 @@ git send-email --dump-aliases
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
+    --in-reply-to          <file>  * Populate header fields appropriately.
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
@@ -160,7 +161,7 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
-	$initial_reply_to,$initial_subject,@files,
+	$initial_reply_to,$initial_references,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
 
 my $envelope_sender;
@@ -639,6 +640,52 @@ if (@files) {
 	usage();
 }
 
+if ($initial_reply_to && -f $initial_reply_to) {
+	my $error = validate_patch($initial_reply_to);
+	die "fatal: $initial_reply_to: $error\nwarning: no patches were sent\n"
+		if $error;
+
+	open my $fh, "<", $initial_reply_to or die "can't open file $initial_reply_to";
+	my $mail = Git::parse_email($fh);
+	close $fh;
+
+	my $initial_sender = $sender || $repoauthor || $repocommitter || '';
+
+	my $prefix_re = "";
+	my $subject_re = $mail->{"subject"}[0];
+	if ($subject_re =~ /^[^Re:]/) {
+		$prefix_re = "Re: ";
+	}
+	$initial_subject = $prefix_re . $subject_re;
+
+	push @initial_to, $mail->{"from"}[0];
+
+	foreach my $to_addr (parse_address_line(join ",", @{$mail->{"to"}})) {
+		if (!($to_addr eq $initial_sender)) {
+			push @initial_cc, $to_addr;
+		}
+	}
+
+	if (defined $mail->{"cc"}) {
+		foreach my $cc_addr (parse_address_line(join ",", @{$mail->{"cc"}})) {
+			my $qaddr = unquote_rfc2047($cc_addr);
+			my $saddr = sanitize_address($qaddr);
+			if ($saddr eq $initial_sender) {
+				next if ($suppress_cc{'self'});
+			} else {
+				next if ($suppress_cc{'cc'});
+			}
+			push @initial_cc, $cc_addr;
+		}
+	}
+
+	$initial_reply_to = $mail->{"message-id"}[0];
+	if ($mail->{"references"}) {
+		$initial_references = join("", @{$mail->{"references"}}) .
+			" " . $initial_reply_to;
+	}
+}
+
 sub get_patch_subject {
 	my $fn = shift;
 	open (my $fh, '<', $fn);
@@ -1426,7 +1473,7 @@ Message-Id: $message_id
 }
 
 $reply_to = $initial_reply_to;
-$references = $initial_reply_to || '';
+$references = $initial_references || $initial_reply_to || '';
 $subject = $initial_subject;
 $message_num = 0;
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index aca7d5c..7591342 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1892,4 +1892,87 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'setup expect' '
+	cat >email <<-\EOF
+	Subject: subject goes here
+	From: author@example.com
+	To: to1@example.com
+	Cc: cc1@example.com, cc2@example.com,
+     cc3@example.com
+	Date: Sat, 12 Jun 2010 15:53:58 +0200
+	Message-Id: <author_123456@example.com>
+	References: <firstauthor_654321@example.com>
+        <secondauthor_01546567@example.com>
+        <thirdauthor_1395838@example.com>
+
+	Have you seen my previous email?
+	> Previous content
+	EOF
+'
+
+test_expect_success $PREREQ 'Fields with --in-reply-to are correct' '
+	clean_fake_sendmail &&
+	git send-email \
+		--in-reply-to=email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		-2 \
+		2>errors &&
+	grep "From: Example <nobody@example.com>" msgtxt1 &&
+	grep "In-Reply-To: <author_123456@example.com>" msgtxt1 &&
+	to_adr=$(awk "/^To: /{flag=1}/^Cc: /{flag=0} flag {print}" msgtxt1) &&
+	cc_adr=$(awk "/^Cc: /{flag=1}/^Subject: /{flag=0} flag {print}" msgtxt1) &&
+	ref_adr=$(awk "/^References: /{flag=1}/^MIME-Version: /{flag=0} flag {print}" \
+		msgtxt1) &&
+	echo "$to_adr" | grep author@example.com &&
+	echo "$cc_adr" | grep to1@example.com &&
+	echo "$cc_adr" | grep cc1@example.com &&
+	echo "$cc_adr" | grep cc2@example.com &&
+	echo "$cc_adr" | grep cc3@example.com &&
+	echo "$ref_adr" | grep "<firstauthor_654321@example.com>" &&
+	echo "$ref_adr" | grep "<secondauthor_01546567@example.com>" &&
+	echo "$ref_adr" | grep "<thirdauthor_1395838@example.com>" &&
+	echo "$ref_adr" | grep "<author_123456@example.com>" &&
+	echo "$ref_adr" | grep -v "References: <author_123456@example.com>"
+'
+
+test_expect_success $PREREQ 'Fields with --in-reply-to and --compose are correct' '
+	clean_fake_sendmail &&
+	git send-email \
+		--in-reply-to=email \
+		--compose \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		-1 \
+		2>errors &&
+	grep "From: Example <nobody@example.com>" msgtxt1 &&
+	grep "In-Reply-To: <author_123456@example.com>" msgtxt1 &&
+	grep "Subject: Re: subject goes here" msgtxt1 &&
+	to_adr=$(awk "/^To: /{flag=1}/^Cc: /{flag=0} flag {print}" msgtxt1) &&
+	cc_adr=$(awk "/^Cc: /{flag=1}/^Subject: /{flag=0} flag {print}" msgtxt1) &&
+	ref_adr=$(awk "/^References: /{flag=1}/^MIME-Version: /{flag=0} flag {print}" \
+		msgtxt1) &&
+	echo "$to_adr" | grep author@example.com &&
+	echo "$cc_adr" | grep to1@example.com &&
+	echo "$cc_adr" | grep cc1@example.com &&
+	echo "$cc_adr" | grep cc2@example.com &&
+	echo "$cc_adr" | grep cc3@example.com &&
+	echo "$ref_adr" | grep "<firstauthor_654321@example.com>" &&
+	echo "$ref_adr" | grep "<secondauthor_01546567@example.com>" &&
+	echo "$ref_adr" | grep "<thirdauthor_1395838@example.com>" &&
+	echo "$ref_adr" | grep "<author_123456@example.com>" &&
+	echo "$ref_adr" | grep -v "References: <author_123456@example.com>"
+'
+
+test_expect_success $PREREQ 'Re: written only once with --in-reply-to and --compose ' '
+	git send-email \
+		--in-reply-to=msgtxt1 \
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
2.8.2.537.gb153d2a
