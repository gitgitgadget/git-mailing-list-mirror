Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB51CC43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA8D613B5
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhELDcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:32:41 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:52729 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 23:32:40 -0400
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E8B2B240004;
        Wed, 12 May 2021 03:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620790291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/pG+whLoC/4dXrvvMZQvvAl17lsZWCVltiNHT8vSGL4=;
        b=Vo5GsB6PcY92L4pvYxezOhZF5fF+Yz4plUtFIhlrqbRMVLOAsYtwL/EsBprsmun3u3OOO6
        qKtcV6ps/BH3U/o9BMBNXR2bfLG1dm40A87gv90LURtZcq+3TUib3yRqDny/u7FdQQQ+IE
        BrlJW1hGmgFt7garzAza9ZPybsyUm9BIA65qjEsGcoJ15PgPeQa41FEZ1ae44t6pkstM8H
        trbGE4P0/UO3AGPpAqlR+sQQvdJHoXAFOWtwHrzEHCigTdCoVcWMGIPaLCKScaldVpNcPo
        V9ox7d0aKzmtiF0uIB+htNBhtAh4DDCf+JC0e1q/I5NLeP2hwM3nrRliEGinjg==
From:   Gregory Anders <greg@gpanders.com>
To:     git@vger.kernel.org
Cc:     Gregory Anders <greg@gpanders.com>
Subject: [PATCH] git-send-email: add sendmailCommand option
Date:   Tue, 11 May 2021 21:30:40 -0600
Message-Id: <20210512033039.4022-1-greg@gpanders.com>
X-Mailer: git-send-email 2.31.1.576.g12e560b5fe
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sendemail.smtpServer option currently supports using a sendmail-like
program to send emails by specifying an absolute file path. However,
this is not ideal for the following reasons:

1. It overloads the meaning of smtpServer (now a program is being used
   for the server?)
2. It doesn't allow for non-absolute paths, arguments, or arbitrary
   scripting.

Requiring an absolute path is bad for portability, as the same
program may be in different locations on different systems. If I wish
to pass arguments to my program, I have to use the smtpServerOption
option, which is cumbersome (as it must be repeated for each option)
and doesn't adhere to normal git conventions.

This patch attempts to solve these problems by introducing a new
configuration option sendemail.sendmailCommand as well as a command line
option --sendmail-cmd. The value of this option is invoked with the
standard sendmail options passed as arguments.

sendmailCommand has precedence over smtpServer. If both options are
unspecified, the default is to search for 'sendmail' in /usr/sbin,
/usr/lib, and $PATH. If not found, smtpServer is set to localhost. This
mimics the current behavior when smtpServer is unspecified.

The option is passed to Perl's `exec()` function, which automatically
determines whether or not to invoke a shell. If shell metacharacters are
detected, then a shell is used; otherwise, the command is invoked
directly. This means that e.g.

    [sendemail]
            sendmailCommand = f() { if [ "$(uname -s) = Darwin ]; then sendmail "$@"; else postfix "$@"; fi; };f

will be executed in a shell (as expected), while

    [sendemail]
            sendmailCommand = msmtp

will be executed directly.

This change deprecates the use of absolute paths in 
sendemail.smtpServer, although support is kept for backward
compatibility.
---

Note that this patch is incompatible with (and supersedes) the patch
discussed here: 

    https://public-inbox.org/git/YJs2RceLliGHI5TX@gpanders.com/T/#t

 Documentation/git-send-email.txt |  39 ++++---
 git-send-email.perl              |  30 ++++--
 t/t9001-send-email.sh            | 169 ++++++++++++++++++-------------
 3 files changed, 140 insertions(+), 98 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 93708aefea..d9fe8cb7c0 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -159,13 +159,23 @@ Sending
 ~~~~~~~
 
 --envelope-sender=<address>::
-	Specify the envelope sender used to send the emails.
-	This is useful if your default address is not the address that is
-	subscribed to a list. In order to use the 'From' address, set the
-	value to "auto". If you use the sendmail binary, you must have
-	suitable privileges for the -f parameter.  Default is the value of the
-	`sendemail.envelopeSender` configuration variable; if that is
-	unspecified, choosing the envelope sender is left to your MTA.
+	Specify the envelope sender used to send the emails.  This is
+	useful if your default address is not the address that is
+	subscribed to a list. In order to use the 'From' address, set
+	the value to "auto". If you use the sendmail binary, you must
+	have suitable privileges for the -f parameter.  Default is the
+	value of the `sendemail.envelopeSender` configuration variable;
+	if that is unspecified, choosing the envelope sender is left to
+	your MTA.
+
+--sendmail-cmd=<command>::
+	Specify a command to run to send the email. The command should
+	be compatible with `sendmail` as the arguments are passed
+	directly.  The command will be executed in the shell if
+	necessary.  Default is the value of `sendemail.sendmailCommand`.
+	If unspecified, and if --smtp-server is also unspecified,
+	git-send-email will search for `sendmail` in `/usr/sbin`,
+	`/usr/lib` and $PATH if such a program is available.
 
 --smtp-encryption=<encryption>::
 	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
@@ -211,13 +221,14 @@ a password is obtained using 'git-credential'.
 
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
+
+	For backward compatibility, this option can also specify a full
+	pathname of a sendmail-like program instead; the program must
+	support the `-i` option.  Prefer using `--sendmail-cmd` instead.
 
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
diff --git a/git-send-email.perl b/git-send-email.perl
index 175da07d94..cecca03ed1 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -70,6 +70,7 @@ sub usage {
 
   Sending:
     --envelope-sender       <str>  * Email envelope sender.
+    --sendmail-cmd          <str>  * Shell command to run to send email.
     --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
                                      is optional. Default 'localhost'.
     --smtp-server-option    <str>  * Outgoing SMTP server option to use.
@@ -252,6 +253,7 @@ sub do_edit {
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
+my ($sendmail_command);
 # Variables with corresponding config settings & hardcoded defaults
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 my $thread = 1;
@@ -299,6 +301,7 @@ sub do_edit {
     "assume8bitencoding" => \$auto_8bit_encoding,
     "composeencoding" => \$compose_encoding,
     "transferencoding" => \$target_xfer_encoding,
+    "sendmailcommand" => \$sendmail_command,
 );
 
 my %config_path_settings = (
@@ -432,6 +435,7 @@ sub read_config {
 		    "no-bcc" => \$no_bcc,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
+		    "sendmail-cmd=s" => \$sendmail_command,
 		    "smtp-server=s" => \$smtp_server,
 		    "smtp-server-option=s" => \@smtp_server_options,
 		    "smtp-server-port=s" => \$smtp_server_port,
@@ -1008,11 +1012,14 @@ sub expand_one_alias {
 	push @sendmail_paths, map {"$_/sendmail"} split /:/, $ENV{PATH};
 	foreach (@sendmail_paths) {
 		if (-x $_) {
-			$smtp_server = $_;
+			$sendmail_command ||= $_;
 			last;
 		}
 	}
-	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
+
+	if (!defined $sendmail_command) {
+		$smtp_server = 'localhost'; # could be 127.0.0.1, too... *shrug*
+	}
 }
 
 if ($compose && $compose > 0) {
@@ -1490,14 +1497,15 @@ sub send_message {
 
 	unshift (@sendmail_parameters, @smtp_server_options);
 
+	if (file_name_is_absolute($smtp_server)) {
+		# Preserved for backward compatibility
+		$sendmail_command ||= $smtp_server;
+	}
+
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif (file_name_is_absolute($smtp_server)) {
-		my $pid = open my $sm, '|-';
-		defined $pid or die $!;
-		if (!$pid) {
-			exec($smtp_server, @sendmail_parameters) or die $!;
-		}
+	} elsif (defined $sendmail_command) {
+		open my $sm, '|-', "$sendmail_command @sendmail_parameters";
 		print $sm "$header\n$message";
 		close $sm or die $!;
 	} else {
@@ -1592,14 +1600,14 @@ sub send_message {
 		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
 	} else {
 		print($dry_run ? __("Dry-OK. Log says:\n") : __("OK. Log says:\n"));
-		if (!file_name_is_absolute($smtp_server)) {
+		if (defined $sendmail_command) {
+			print "Sendmail: $sendmail_command ".join(' ',@sendmail_parameters)."\n";
+		} else {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
 			foreach my $entry (@recipients) {
 			    print "RCPT TO:<$entry>\n";
 			}
-		} else {
-			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
 		}
 		print $header, "\n";
 		if ($smtp) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 65b3035371..82a3efb987 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -57,7 +57,7 @@ test_no_confirm () {
 		git send-email \
 		--from="Example <from@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$@ \
 		$patches >stdout &&
 		! grep "Send this email" stdout &&
@@ -94,7 +94,7 @@ test_expect_success $PREREQ 'No confirm with sendemail.confirm=never' '
 '
 
 test_expect_success $PREREQ 'Send patches' '
-	git send-email --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+	git send-email --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --sendmail-cmd="\"$(pwd)/fake.sendmail\"" $patches 2>errors
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -112,7 +112,7 @@ test_expect_success $PREREQ 'Verify commandline' '
 
 test_expect_success $PREREQ 'Send patches with --envelope-sender' '
 	clean_fake_sendmail &&
-	git send-email --envelope-sender="Patch Contributor <patch@example.com>" --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+	git send-email --envelope-sender="Patch Contributor <patch@example.com>" --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --sendmail-cmd="\"$(pwd)/fake.sendmail\"" $patches 2>errors
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -132,7 +132,7 @@ test_expect_success $PREREQ 'Verify commandline' '
 
 test_expect_success $PREREQ 'Send patches with --envelope-sender=auto' '
 	clean_fake_sendmail &&
-	git send-email --envelope-sender=auto --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+	git send-email --envelope-sender=auto --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --sendmail-cmd="\"$(pwd)/fake.sendmail\"" $patches 2>errors
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -178,7 +178,7 @@ test_expect_success $PREREQ 'cc trailer with various syntax' '
 	EOF
 	clean_fake_sendmail &&
 	git send-email -1 --to=recipient@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" &&
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" &&
 	test_cmp expected-cc commandline1
 '
 
@@ -197,7 +197,7 @@ test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output' '
 	clean_fake_sendmail &&
 	git send-email -1 --to=recipient@example.com \
 		--cc-cmd=./expected-cc-script.sh \
-		--smtp-server="$(pwd)/fake.sendmail" &&
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" &&
 	test_cmp expected-cc commandline1
 '
 
@@ -252,7 +252,7 @@ test_suppress_self () {
 		--to=nobody@example.com \
 		--cc-cmd=./cccmd-sed \
 		--suppress-cc=self \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		suppress-self-$3.patch &&
 
 	mv msgtxt1 msgtxt1-$3 &&
@@ -338,7 +338,7 @@ test_expect_success $PREREQ 'Prompting works' '
 	(echo "to@example.com" &&
 	 echo ""
 	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches \
 		2>errors &&
 		grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
@@ -352,7 +352,7 @@ test_expect_success $PREREQ,AUTOIDENT 'implicit ident is allowed' '
 	sane_unset GIT_COMMITTER_NAME &&
 	sane_unset GIT_COMMITTER_EMAIL &&
 	GIT_SEND_EMAIL_NOTTY=1 git send-email \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		--to=to@example.com \
 		$patches </dev/null 2>errors
 	)
@@ -366,7 +366,7 @@ test_expect_success $PREREQ,!AUTOIDENT 'broken implicit ident aborts send-email'
 	sane_unset GIT_COMMITTER_EMAIL &&
 	GIT_SEND_EMAIL_NOTTY=1 && export GIT_SEND_EMAIL_NOTTY &&
 	test_must_fail git send-email \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		--to=to@example.com \
 		$patches </dev/null 2>errors &&
 	test_i18ngrep "tell me who you are" errors
@@ -389,7 +389,7 @@ test_expect_success $PREREQ 'tocmd works' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to-cmd=./tocmd-sed \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		tocmd.patch \
 		&&
 	grep "^To: tocmd@example.com" msgtxt1
@@ -403,7 +403,7 @@ test_expect_success $PREREQ 'cccmd works' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--cc-cmd=./cccmd-sed \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		cccmd.patch \
 		&&
 	grep "^	cccmd@example.com" msgtxt1
@@ -423,7 +423,7 @@ test_expect_success $PREREQ 'reject long lines' '
 	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		--transfer-encoding=8bit \
 		$patches longline.patch \
 		2>actual &&
@@ -443,7 +443,7 @@ test_expect_success $PREREQ 'Author From: in message body' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches &&
 	sed "1,/^\$/d" <msgtxt1 >msgbody1 &&
 	grep "From: A <author@example.com>" msgbody1
@@ -454,7 +454,7 @@ test_expect_success $PREREQ 'Author From: not in message body' '
 	git send-email \
 		--from="A <author@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches &&
 	sed "1,/^\$/d" <msgtxt1 >msgbody1 &&
 	! grep "From: A <author@example.com>" msgbody1
@@ -464,7 +464,7 @@ test_expect_success $PREREQ 'allow long lines with --no-validate' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		--no-validate \
 		$patches longline.patch \
 		2>errors
@@ -475,7 +475,7 @@ test_expect_success $PREREQ 'short lines with auto encoding are 8bit' '
 	git send-email \
 		--from="A <author@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		--transfer-encoding=auto \
 		$patches &&
 	grep "Content-Transfer-Encoding: 8bit" msgtxt1
@@ -486,7 +486,7 @@ test_expect_success $PREREQ 'long lines with auto encoding are quoted-printable'
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		--transfer-encoding=auto \
 		--no-validate \
 		longline.patch &&
@@ -500,7 +500,7 @@ test_expect_success $PREREQ 'carriage returns with auto encoding are quoted-prin
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		--transfer-encoding=auto \
 		--no-validate \
 		cr.patch &&
@@ -513,7 +513,7 @@ do
 		git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
-			--smtp-server="$(pwd)/fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 			--transfer-encoding=$enc \
 			--validate \
 			$patches longline.patch
@@ -533,7 +533,7 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		--validate \
 		longline.patch 2>actual &&
 	test_path_is_file my-hooks.ran &&
@@ -552,7 +552,7 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		--validate \
 		longline.patch 2>actual &&
 	test_path_is_file my-hooks.ran &&
@@ -571,7 +571,7 @@ do
 		git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
-			--smtp-server="$(pwd)/fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 			--transfer-encoding=$enc \
 			$patches &&
 		grep "Content-Transfer-Encoding: $enc" msgtxt1
@@ -584,7 +584,7 @@ test_expect_success $PREREQ 'Invalid In-Reply-To' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--in-reply-to=" " \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches \
 		2>errors &&
 	! grep "^In-Reply-To: < *>" msgtxt1
@@ -596,7 +596,7 @@ test_expect_success $PREREQ 'Valid In-Reply-To when prompting' '
 	 echo "To Example <to@example.com>" &&
 	 echo ""
 	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches 2>errors &&
 	! grep "^In-Reply-To: < *>" msgtxt1
 '
@@ -609,7 +609,7 @@ test_expect_success $PREREQ 'In-Reply-To without --chain-reply-to' '
 		--to=nobody@example.com \
 		--no-chain-reply-to \
 		--in-reply-to="$(cat expect)" \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches $patches $patches \
 		2>errors &&
 	# The first message is a reply to --in-reply-to
@@ -631,7 +631,7 @@ test_expect_success $PREREQ 'In-Reply-To with --chain-reply-to' '
 		--to=nobody@example.com \
 		--chain-reply-to \
 		--in-reply-to="$(cat expect)" \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches $patches $patches \
 		2>errors &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
@@ -658,7 +658,7 @@ test_expect_success $PREREQ '--compose works' '
 	--compose --subject foo \
 	--from="Example <nobody@example.com>" \
 	--to=nobody@example.com \
-	--smtp-server="$(pwd)/fake.sendmail" \
+	--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 	$patches \
 	2>errors
 '
@@ -992,7 +992,7 @@ test_confirm () {
 		git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$@ $patches >stdout &&
 	grep "Send this email" stdout
 }
@@ -1034,7 +1034,7 @@ test_expect_success $PREREQ 'confirm detects EOF (inform assumes y)' '
 		git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
-			--smtp-server="$(pwd)/fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 			outdir/*.patch </dev/null
 '
 
@@ -1046,7 +1046,7 @@ test_expect_success $PREREQ 'confirm detects EOF (auto causes failure)' '
 		test_must_fail git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
-			--smtp-server="$(pwd)/fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 			$patches </dev/null
 '
 
@@ -1058,7 +1058,7 @@ test_expect_success $PREREQ 'confirm does not loop forever' '
 		yes "bogus" | test_must_fail git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
-			--smtp-server="$(pwd)/fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 			$patches
 '
 
@@ -1069,7 +1069,7 @@ test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
 	git send-email \
 	--from="Example <nobody@example.com>" \
 	--to=nobody@example.com \
-	--smtp-server="$(pwd)/fake.sendmail" \
+	--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 	outdir/*.patch &&
 	grep "^	" msgtxt1 |
 	grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
@@ -1085,7 +1085,7 @@ test_expect_success $PREREQ '--compose adds MIME for utf8 body' '
 		--compose --subject foo \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches &&
 	grep "^utf8 body" msgtxt1 &&
 	grep "^Content-Type: text/plain; charset=UTF-8" msgtxt1
@@ -1108,7 +1108,7 @@ test_expect_success $PREREQ '--compose respects user mime type' '
 		--compose --subject foo \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches &&
 	grep "^utf8 body" msgtxt1 &&
 	grep "^Content-Type: text/plain; charset=iso-8859-1" msgtxt1 &&
@@ -1122,7 +1122,7 @@ test_expect_success $PREREQ '--compose adds MIME for utf8 subject' '
 		--compose --subject utf8-sübjëct \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches &&
 	grep "^fake edit" msgtxt1 &&
 	grep "^Subject: =?UTF-8?q?utf8-s=C3=BCbj=C3=ABct?=" msgtxt1
@@ -1136,7 +1136,7 @@ test_expect_success $PREREQ 'utf8 author is correctly passed on' '
 	git format-patch --stdout -1 >funny_name.patch &&
 	git send-email --from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		funny_name.patch &&
 	grep "^From: Füñný Nâmé <odd_?=mail@example.com>" msgtxt1
 '
@@ -1149,7 +1149,7 @@ test_expect_success $PREREQ 'utf8 sender is not duplicated' '
 	git format-patch --stdout -1 >funny_name.patch &&
 	git send-email --from="Füñný Nâmé <odd_?=mail@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		funny_name.patch &&
 	grep "^From: " msgtxt1 >msgfrom &&
 	test_line_count = 1 msgfrom
@@ -1166,7 +1166,7 @@ test_expect_success $PREREQ 'sendemail.composeencoding works' '
 		--compose --subject foo \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches &&
 	grep "^utf8 body" msgtxt1 &&
 	grep "^Content-Type: text/plain; charset=iso-8859-1" msgtxt1
@@ -1183,7 +1183,7 @@ test_expect_success $PREREQ '--compose-encoding works' '
 		--compose --subject foo \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches &&
 	grep "^utf8 body" msgtxt1 &&
 	grep "^Content-Type: text/plain; charset=iso-8859-1" msgtxt1
@@ -1201,7 +1201,7 @@ test_expect_success $PREREQ '--compose-encoding overrides sendemail.composeencod
 		--compose --subject foo \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches &&
 	grep "^utf8 body" msgtxt1 &&
 	grep "^Content-Type: text/plain; charset=iso-8859-2" msgtxt1
@@ -1215,7 +1215,7 @@ test_expect_success $PREREQ '--compose-encoding adds correct MIME for subject' '
 		--compose --subject utf8-sübjëct \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$patches &&
 	grep "^fake edit" msgtxt1 &&
 	grep "^Subject: =?iso-8859-2?q?utf8-s=C3=BCbj=C3=ABct?=" msgtxt1
@@ -1465,7 +1465,7 @@ test_expect_success $PREREQ 'ASCII subject is not RFC2047 quoted' '
 	clean_fake_sendmail &&
 	echo bogus |
 	git send-email --from=author@example.com --to=nobody@example.com \
-			--smtp-server="$(pwd)/fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
 	grep "Subject" msgtxt1 >actual &&
@@ -1484,7 +1484,7 @@ test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
 	clean_fake_sendmail &&
 	echo |
 	git send-email --from=author@example.com --to=nobody@example.com \
-			--smtp-server="$(pwd)/fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 			email-using-8bit >stdout &&
 	grep "do not declare a Content-Transfer-Encoding" stdout &&
 	grep email-using-8bit stdout &&
@@ -1498,7 +1498,7 @@ test_expect_success $PREREQ 'sendemail.8bitEncoding works' '
 	git config sendemail.assume8bitEncoding UTF-8 &&
 	echo bogus |
 	git send-email --from=author@example.com --to=nobody@example.com \
-			--smtp-server="$(pwd)/fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 			email-using-8bit >stdout &&
 	egrep "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
@@ -1509,7 +1509,7 @@ test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
 	git config sendemail.assume8bitEncoding "bogus too" &&
 	echo bogus |
 	git send-email --from=author@example.com --to=nobody@example.com \
-			--smtp-server="$(pwd)/fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
 	egrep "Content|MIME" msgtxt1 >actual &&
@@ -1538,7 +1538,7 @@ test_expect_success $PREREQ '--8bit-encoding also treats subject' '
 	clean_fake_sendmail &&
 	echo bogus |
 	git send-email --from=author@example.com --to=nobody@example.com \
-			--smtp-server="$(pwd)/fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
 	grep "Subject" msgtxt1 >actual &&
@@ -1563,7 +1563,7 @@ test_expect_success $PREREQ '--transfer-encoding overrides sendemail.transferEnc
 	test_must_fail git -c sendemail.transferEncoding=8bit \
 		send-email \
 		--transfer-encoding=7bit \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		email-using-8bit \
 		2>errors >out &&
 	grep "cannot send message as 7bit" errors &&
@@ -1574,7 +1574,7 @@ test_expect_success $PREREQ 'sendemail.transferEncoding via config' '
 	clean_fake_sendmail &&
 	test_must_fail git -c sendemail.transferEncoding=7bit \
 		send-email \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		email-using-8bit \
 		2>errors >out &&
 	grep "cannot send message as 7bit" errors &&
@@ -1585,7 +1585,7 @@ test_expect_success $PREREQ 'sendemail.transferEncoding via cli' '
 	clean_fake_sendmail &&
 	test_must_fail git send-email \
 		--transfer-encoding=7bit \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		email-using-8bit \
 		2>errors >out &&
 	grep "cannot send message as 7bit" errors &&
@@ -1602,7 +1602,7 @@ test_expect_success $PREREQ '8-bit and sendemail.transferencoding=quoted-printab
 	clean_fake_sendmail &&
 	git send-email \
 		--transfer-encoding=quoted-printable \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		email-using-8bit \
 		2>errors >out &&
 	sed "1,/^$/d" msgtxt1 >actual &&
@@ -1619,7 +1619,7 @@ test_expect_success $PREREQ '8-bit and sendemail.transferencoding=base64' '
 	clean_fake_sendmail &&
 	git send-email \
 		--transfer-encoding=base64 \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		email-using-8bit \
 		2>errors >out &&
 	sed "1,/^$/d" msgtxt1 >actual &&
@@ -1645,7 +1645,7 @@ test_expect_success $PREREQ 'convert from quoted-printable to base64' '
 	clean_fake_sendmail &&
 	git send-email \
 		--transfer-encoding=base64 \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		email-using-qp \
 		2>errors >out &&
 	sed "1,/^$/d" msgtxt1 >actual &&
@@ -1675,7 +1675,7 @@ test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=quoted-printabl
 	clean_fake_sendmail &&
 	git send-email \
 		--transfer-encoding=quoted-printable \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		email-using-crlf \
 		2>errors >out &&
 	sed "1,/^$/d" msgtxt1 >actual &&
@@ -1692,7 +1692,7 @@ test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=base64' '
 	clean_fake_sendmail &&
 	git send-email \
 		--transfer-encoding=base64 \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		email-using-crlf \
 		2>errors >out &&
 	sed "1,/^$/d" msgtxt1 >actual &&
@@ -1710,7 +1710,7 @@ test_expect_success $PREREQ 'refusing to send cover letter template' '
 	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		outdir/0002-*.patch \
 		outdir/0000-*.patch \
 		outdir/0001-*.patch \
@@ -1727,7 +1727,7 @@ test_expect_success $PREREQ '--force sends cover letter template anyway' '
 		--force \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		outdir/0002-*.patch \
 		outdir/0000-*.patch \
 		outdir/0001-*.patch \
@@ -1750,7 +1750,7 @@ test_cover_addresses () {
 		--from="Example <nobody@example.com>" \
 		--no-to --no-cc \
 		"$@" \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		outdir/0000-*.patch \
 		outdir/0001-*.patch \
 		outdir/0002-*.patch \
@@ -1789,7 +1789,7 @@ test_expect_success $PREREQ 'escaped quotes in sendemail.aliasfiletype=mutt' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=sbd \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		outdir/0001-*.patch \
 		2>errors >out &&
 	grep "^!somebody@example\.org!$" commandline1 &&
@@ -1804,7 +1804,7 @@ test_expect_success $PREREQ 'sendemail.aliasfiletype=mailrc' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=sbd \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		outdir/0001-*.patch \
 		2>errors >out &&
 	grep "^!somebody@example\.org!$" commandline1
@@ -1818,7 +1818,7 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=sbd \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		outdir/0001-*.patch \
 		2>errors >out &&
 	grep "^!someone@example\.org!$" commandline1
@@ -1929,7 +1929,7 @@ test_sendmail_aliases () {
 		git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=alice --to=bcgrp \
-			--smtp-server="$(pwd)/fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 			outdir/0001-*.patch \
 			2>errors >out &&
 		for i in $expect
@@ -1995,7 +1995,7 @@ test_expect_success $PREREQ 'alias support in To header' '
 	git format-patch --stdout -1 --to=sbd >aliased.patch &&
 	git send-email \
 		--from="Example <nobody@example.com>" \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		aliased.patch \
 		2>errors >out &&
 	grep "^!someone@example\.org!$" commandline1
@@ -2009,7 +2009,7 @@ test_expect_success $PREREQ 'alias support in Cc header' '
 	git format-patch --stdout -1 --cc=sbd >aliased.patch &&
 	git send-email \
 		--from="Example <nobody@example.com>" \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		aliased.patch \
 		2>errors >out &&
 	grep "^!someone@example\.org!$" commandline1
@@ -2025,7 +2025,7 @@ test_expect_success $PREREQ 'tocmd works with aliases' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to-cmd=./tocmd-sed \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		tocmd.patch \
 		2>errors >out &&
 	grep "^!someone@example\.org!$" commandline1
@@ -2041,7 +2041,7 @@ test_expect_success $PREREQ 'cccmd works with aliases' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--cc-cmd=./cccmd-sed \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		cccmd.patch \
 		2>errors >out &&
 	grep "^!someone@example\.org!$" commandline1
@@ -2053,7 +2053,7 @@ do_xmailer_test () {
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=someone@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		$params \
 		0001-*.patch \
 		2>errors >out &&
@@ -2148,6 +2148,29 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'test using relative path with sendmailCommand' '
+	clean_fake_sendmail &&
+	PATH="$(pwd):$PATH" \
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--sendmail-cmd="fake.sendmail" \
+		HEAD~2 &&
+	test_path_is_file commandline1 &&
+	test_path_is_file commandline2
+'
+
+test_expect_success $PREREQ 'test using shell with sendmailCommand' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--sendmail-cmd="[ 1 -eq 1 ] && \"$(pwd)/fake.sendmail\"" \
+		HEAD~2 &&
+	test_path_is_file commandline1 &&
+	test_path_is_file commandline2
+'
+
 test_expect_success $PREREQ 'invoke hook' '
 	mkdir -p .git/hooks &&
 
@@ -2174,7 +2197,7 @@ test_expect_success $PREREQ 'invoke hook' '
 		git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
-			--smtp-server="$(pwd)/../fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/../fake.sendmail\"" \
 			../0001-add-main.patch &&
 
 		# Verify error message when a patch is rejected by the hook
@@ -2182,7 +2205,7 @@ test_expect_success $PREREQ 'invoke hook' '
 		test_must_fail git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
-			--smtp-server="$(pwd)/../fake.sendmail" \
+			--sendmail-cmd="\"$(pwd)/../fake.sendmail\"" \
 			../another.patch 2>err &&
 		test_i18ngrep "rejected by sendemail-validate hook" err
 	)
@@ -2192,7 +2215,7 @@ test_expect_success $PREREQ 'test that send-email works outside a repo' '
 	nongit git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		"$(pwd)/0001-add-main.patch"
 '
 
@@ -2201,7 +2224,7 @@ test_expect_success $PREREQ 'test that sendmail config is rejected' '
 	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		HEAD^ 2>err &&
 	test_i18ngrep "found configuration options for '"'"sendmail"'"'" err
 '
@@ -2211,7 +2234,7 @@ test_expect_success $PREREQ 'test that sendmail config rejection is specific' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		HEAD^
 '
 
@@ -2221,7 +2244,7 @@ test_expect_success $PREREQ 'test forbidSendmailVariables behavior override' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--smtp-server="$(pwd)/fake.sendmail" \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
 		HEAD^
 '
 
-- 
2.31.1.576.g12e560b5fe

