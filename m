Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BF5C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C632613F5
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhENPR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 11:17:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47221 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhENPR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 11:17:29 -0400
Received: (Authenticated sender: greg@gpanders.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0BA3B20002;
        Fri, 14 May 2021 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1621005377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LBe/5egYBcsfzbmAUr8RXTYH/Q5+6z3HS5OFuFDAoN8=;
        b=Hd9cBOBGKTzzKtXJ5K7REcicAs7n6PK5NibmNX+eLMJ7yu28cr6KmVxBfKxvjAXBCtx7Xx
        GsPM/OqmSX8tOeZT1xWWWlWXXpgvF0BgeWG2ov4wBN0n9+ekjwEN9Aa+/gkQBf5CPpHLSy
        k8ZBkKfo5D5bzEpiC+I12/X4hVjGwuPbO9c78RKYwWiapgfUQ1IWNdsojxSN+KoWplyIuN
        8+Sz/fWWdfnlIpiH0E8a1EKwriU+HEBpjlW28VsI3HZapOJi0fF8YuWF9UHQUVzbCLcOth
        EyQ/b5HWRiPahixVLaHzTZ70K/XkqHDlXRPO5LGnGeLhZjYEFO1xeV1rxqWwJA==
From:   Gregory Anders <greg@gpanders.com>
To:     git@vger.kernel.org
Cc:     Gregory Anders <greg@gpanders.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4] git-send-email: add option to specify sendmail command
Date:   Fri, 14 May 2021 09:15:53 -0600
Message-Id: <20210514151553.42938-1-greg@gpanders.com>
X-Mailer: git-send-email 2.31.1.576.g1878d50f81
In-Reply-To: <20210513152329.22578-1-greg@gpanders.com>
References: <20210513152329.22578-1-greg@gpanders.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sendemail.smtpServer configuration option and --smtp-server command
line option both support using a sendmail-like program to send emails by
specifying an absolute file path. However, this is not ideal for the
following reasons:

1. It overloads the meaning of smtpServer (now a program is being used
   for the server?)
2. It doesn't allow for non-absolute paths, arguments, or arbitrary
   scripting

Requiring an absolute path is bad for portability, as the same program
may be in different locations on different systems. If a user wishes to
pass arguments to their program, they have to use the smtpServerOption
option, which is cumbersome (as it must be repeated for each option) and
doesn't adhere to normal git conventions.

Introduce a new configuration option sendemail.sendmailCmd as well as a
command line option --sendmail-cmd that can be used to specify a command
(with or without arguments) or shell expression to run to send email.
The name of this option is consistent with --to-cmd and --cc-cmd. This
invocation honors the user's $PATH so that absolute paths are not
necessary. Arbitrary shell expressions are also supported, allowing
users to do basic scripting.

Give this option a higher precedence over --smtp-server and
sendemail.smtpServer, as the new interface is more flexible. For
backward compatibility, continue to support absolute paths in
--smtp-server and sendemail.smtpServer.

Signed-off-by: Gregory Anders <greg@gpanders.com>
---
 Documentation/git-send-email.txt | 25 ++++++++++++++++-------
 git-send-email.perl              | 34 +++++++++++++++++++++++++-------
 t/t9001-send-email.sh            | 31 +++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 93708aefea..3db4eab4ba 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -167,6 +167,14 @@ Sending
 	`sendemail.envelopeSender` configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
 
+--sendmail-cmd=<command>::
+	Specify a command to run to send the email. The command should
+	be sendmail-like; specifically, it must support the `-i` option.
+	The command will be executed in the shell if necessary.  Default
+	is the value of `sendemail.sendmailcmd`.  If unspecified, and if
+	--smtp-server is also unspecified, git-send-email will search
+	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
+
 --smtp-encryption=<encryption>::
 	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
 	value reverts to plain SMTP.  Default is the value of
@@ -211,13 +219,16 @@ a password is obtained using 'git-credential'.
 
 --smtp-server=<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
-	`smtp.example.com` or a raw IP address).  Alternatively it can
-	specify a full pathname of a sendmail-like program instead;
-	the program must support the `-i` option.  Default value can
-	be specified by the `sendemail.smtpServer` configuration
-	option; the built-in default is to search for `sendmail` in
-	`/usr/sbin`, `/usr/lib` and $PATH if such program is
-	available, falling back to `localhost` otherwise.
+	`smtp.example.com` or a raw IP address).  If unspecified, and if
+	`--sendmail-cmd` is also unspecified, the default is to search
+	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH if such a
+	program is available, falling back to `localhost` otherwise.
++
+For backward compatibility, this option can also specify a full pathname
+of a sendmail-like program instead; the program must support the `-i`
+option.  This method does not support passing arguments or using plain
+command names.  For those use cases, consider using `--sendmail-cmd`
+instead.
 
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
diff --git a/git-send-email.perl b/git-send-email.perl
index 175da07d94..dbb144aa11 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -70,6 +70,7 @@ sub usage {
 
   Sending:
     --envelope-sender       <str>  * Email envelope sender.
+    --sendmail-cmd          <str>  * Command to run to send email.
     --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
                                      is optional. Default 'localhost'.
     --smtp-server-option    <str>  * Outgoing SMTP server option to use.
@@ -252,6 +253,7 @@ sub do_edit {
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
+my ($sendmail_cmd);
 # Variables with corresponding config settings & hardcoded defaults
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 my $thread = 1;
@@ -299,6 +301,7 @@ sub do_edit {
     "assume8bitencoding" => \$auto_8bit_encoding,
     "composeencoding" => \$compose_encoding,
     "transferencoding" => \$target_xfer_encoding,
+    "sendmailcmd" => \$sendmail_cmd,
 );
 
 my %config_path_settings = (
@@ -432,6 +435,7 @@ sub read_config {
 		    "no-bcc" => \$no_bcc,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
+		    "sendmail-cmd=s" => \$sendmail_cmd,
 		    "smtp-server=s" => \$smtp_server,
 		    "smtp-server-option=s" => \@smtp_server_options,
 		    "smtp-server-port=s" => \$smtp_server_port,
@@ -1003,16 +1007,19 @@ sub expand_one_alias {
 	$reply_to = sanitize_address($reply_to);
 }
 
-if (!defined $smtp_server) {
+if (!defined $sendmail_cmd && !defined $smtp_server) {
 	my @sendmail_paths = qw( /usr/sbin/sendmail /usr/lib/sendmail );
 	push @sendmail_paths, map {"$_/sendmail"} split /:/, $ENV{PATH};
 	foreach (@sendmail_paths) {
 		if (-x $_) {
-			$smtp_server = $_;
+			$sendmail_cmd = $_;
 			last;
 		}
 	}
-	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
+
+	if (!defined $sendmail_cmd) {
+		$smtp_server = 'localhost'; # could be 127.0.0.1, too... *shrug*
+	}
 }
 
 if ($compose && $compose > 0) {
@@ -1492,11 +1499,17 @@ sub send_message {
 
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif (file_name_is_absolute($smtp_server)) {
+	} elsif (defined $sendmail_cmd || file_name_is_absolute($smtp_server)) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
-			exec($smtp_server, @sendmail_parameters) or die $!;
+			if (defined $sendmail_cmd) {
+				exec ("sh", "-c", "$sendmail_cmd \"\$@\"", "-", @sendmail_parameters)
+					or die $!;
+			} else {
+				exec ($smtp_server, @sendmail_parameters)
+					or die $!;
+			}
 		}
 		print $sm "$header\n$message";
 		close $sm or die $!;
@@ -1592,14 +1605,21 @@ sub send_message {
 		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
 	} else {
 		print($dry_run ? __("Dry-OK. Log says:\n") : __("OK. Log says:\n"));
-		if (!file_name_is_absolute($smtp_server)) {
+		if (!defined $sendmail_cmd && !file_name_is_absolute($smtp_server)) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
 			foreach my $entry (@recipients) {
 			    print "RCPT TO:<$entry>\n";
 			}
 		} else {
-			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
+			my $sm;
+			if (defined $sendmail_cmd) {
+				$sm = $sendmail_cmd;
+			} else {
+				$sm = $smtp_server;
+			}
+
+			print "Sendmail: $sm ".join(' ',@sendmail_parameters)."\n";
 		}
 		print $header, "\n";
 		if ($smtp) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 65b3035371..d771eb9297 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2148,6 +2148,37 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'test using command name with --sendmail-cmd' '
+	clean_fake_sendmail &&
+	PATH="$(pwd):$PATH" \
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--sendmail-cmd="fake.sendmail" \
+		HEAD^ &&
+	test_path_is_file commandline1
+'
+
+test_expect_success $PREREQ 'test using arguments with --sendmail-cmd' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--sendmail-cmd='\''"$(pwd)/fake.sendmail" -f nobody@example.com'\'' \
+		HEAD^ &&
+	test_path_is_file commandline1
+'
+
+test_expect_success $PREREQ 'test shell expression with --sendmail-cmd' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--sendmail-cmd='\''f() { "$(pwd)/fake.sendmail" "$@"; };f'\'' \
+		HEAD^ &&
+	test_path_is_file commandline1
+'
+
 test_expect_success $PREREQ 'invoke hook' '
 	mkdir -p .git/hooks &&
 
-- 
2.31.1.576.g1878d50f81

