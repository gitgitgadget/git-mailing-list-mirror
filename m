Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D67DC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B494613C6
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEKXxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 19:53:02 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:51567 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKXxC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 19:53:02 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 9A1B1CC732
        for <git@vger.kernel.org>; Tue, 11 May 2021 23:50:07 +0000 (UTC)
X-Originating-IP: 73.26.133.58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620776986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sqhWx24YygsGuwdv01q6qLtIWYzu34eU+Ll3eqH/Zwk=;
        b=PXvYobJmgPk8neQEMrQB/LEne9wkpxPrdLWzJ9SFEC0pw4skJDgIc4NutSRfLC3suWCYyU
        kz5WzEBQWvbxpvYaiXTZsr0NSPEK0dDuD9awFQlJObZ3Z/ijRRzje3Dkr/TamQK3MX/43V
        pHKcrJkud2mRF31Grzl/OhGBBi5g35vmW8T8QuNOcjXIttlgYKpbF9i9pqsaaqrECxjqP7
        8MWR2CY4Imc1AtdWzmGAVYH54m53EGk7v9YfS4Osk2O+SoPv3HJfKf14aPrlhOFWPtcjul
        CU5gCfkHfoKTv3VAWKI1YW2xNSuAIDL883fid4RwB4cQoqbF8c3CBb9992T4zA==
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 1C479FF803;
        Tue, 11 May 2021 23:49:44 +0000 (UTC)
From:   Gregory Anders <greg@gpanders.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>
Subject: [PATCH v5] git-send-email: use ! to indicate relative path to command
Date:   Tue, 11 May 2021 17:49:35 -0600
Message-Id: <20210511234935.65147-1-greg@gpanders.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511204044.69047-1-greg@gpanders.com>
References: <20210511204044.69047-1-greg@gpanders.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sendemail.smtpServer configuration option and the '--smtp-server'
command line option can name a program to use by providing an absolute
path to the program. However, an absolute path is not always portable
and it is often preferable to simply specify a program name and have
'git-send-email' find that program on $PATH.

For example, if a user wishes to use msmtp to send emails, they might
be able to simply use

    [sendemail]
            smtpServer = !msmtp

instead of using the full path. This is particularly useful when a
common git config file is used across multiple systems where the
absolute path to a given program may differ.

To that end, this patch allows both the configuration and command line
options to be prefixed with a '!' character to indicate that the
specified command should be found on $PATH, as if the user had entered
it directly on the command line.

Signed-off-by: Gregory Anders <greg@gpanders.com>
---
Diff from v4:

* Update the test with suggestions from Jeff King (this should fix 
  erroneous test failures caused by patch files being deleted by earlier 
  tests)
* Reword the commit message with feedback from Jeff King and Junio 
  Hamano

 Documentation/git-send-email.txt | 13 +++++++------
 git-send-email.perl              |  7 +++++--
 t/t9001-send-email.sh            | 12 ++++++++++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 93708aefea..418e66c703 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -212,12 +212,13 @@ a password is obtained using 'git-credential'.
 --smtp-server=<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  Alternatively it can
-	specify a full pathname of a sendmail-like program instead;
-	the program must support the `-i` option.  Default value can
-	be specified by the `sendemail.smtpServer` configuration
-	option; the built-in default is to search for `sendmail` in
-	`/usr/sbin`, `/usr/lib` and $PATH if such program is
-	available, falling back to `localhost` otherwise.
+	specify a sendmail-like program instead, either by a full
+	path-name or by prefixing the program name with `!`.  The
+	program must support the `-i` option.  Default value can be
+	specified by the `sendemail.smtpServer` configuration option;
+	the built-in default is to search for `sendmail` in `/usr/sbin`,
+	`/usr/lib` and $PATH if such program is available, falling back
+	to `localhost` otherwise.
 
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
diff --git a/git-send-email.perl b/git-send-email.perl
index 175da07d94..022dcf0999 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1492,11 +1492,14 @@ sub send_message {
 
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif (file_name_is_absolute($smtp_server)) {
+	} elsif (file_name_is_absolute($smtp_server) || $smtp_server =~ /^!/) {
+		my $prog = $smtp_server;
+		$prog =~ s/^!//;
+
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
-			exec($smtp_server, @sendmail_parameters) or die $!;
+			exec($prog, @sendmail_parameters) or die $!;
 		}
 		print $sm "$header\n$message";
 		close $sm or die $!;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 65b3035371..31d25b32b5 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2148,6 +2148,18 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'test using a command for smtpServer with !' '
+	clean_fake_sendmail &&
+	PATH="$(pwd):$PATH" \
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="!fake.sendmail" \
+		HEAD~2 2>errors &&
+	test_path_is_file commandline1 &&
+	test_path_is_file commandline2
+'
+
 test_expect_success $PREREQ 'invoke hook' '
 	mkdir -p .git/hooks &&
 
-- 
2.31.1

