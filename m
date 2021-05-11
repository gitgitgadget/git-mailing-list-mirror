Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDFBC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FEC61626
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhEKUmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:42:03 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:53959 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKUmD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:42:03 -0400
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0579C240002;
        Tue, 11 May 2021 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620765654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJZulsNnd8P/QUN6lzfUmfNGl92rEB25HMGgRw965aU=;
        b=IHh27b4xhz8Yl/AaW63YpoNTN4fTpE/nlVqROBOTdg7VTbBP7AKlyMd8LjBfZcTfRfR8s0
        4313GHTjItSPi0H/WxofK6Cw1srSy3D6qT4+NBDKmFEayG7/HJ3ykq3Fypn5Y6C1y73hTV
        0oTNljLKItfXUfRXgXNhFgzdv48hW1ndM7CWgIHhNcAPV+Mpksf6rjnE/aWwFnAK0uLtUs
        diSWT/BdL2200aHPbSyO9WxVTZ24NdFaAmoINqxqQ3z7VlKl6H0VzyD1JmRaqUDLVCbbzv
        Yx06tTut6X7m4b7CYV1ftdE8juY/ww+PXfcA3VKsBYOEhnAaWt0NlYSNoTkj7Q==
From:   Gregory Anders <greg@gpanders.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Gregory Anders <greg@gpanders.com>
Subject: [PATCH v4] git-send-email: use ! to indicate relative path to command
Date:   Tue, 11 May 2021 14:40:44 -0600
Message-Id: <20210511204044.69047-1-greg@gpanders.com>
X-Mailer: git-send-email 2.31.1.576.g2f8a831619
In-Reply-To: <YJrZ7Hho6jrVyM7f@coredump.intra.peff.net>
References: <YJrZ7Hho6jrVyM7f@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Presently, the smtpServer config option can use a sendmail-like program
by providing an absolute path to the program as the value for this
option. However, an absolute path is not always portable and it is often
preferable to simply specify a program name and have `git-send-email`
find that program on $PATH.

For example, if a user wishes to use msmtp to send emails, they might
be able to simply use

    [sendemail]
            smtpServer = !msmtp

instead of using the full path. This is particularly useful when a
common git config file is used across multiple systems where the
absolute path to a given program may differ.

To that end, this patch allows the smtpServer config option to be
prefixed with a ! character that implements the above behavior; namely,
the specified value (sans the ! character) is used as if the user had
entered it directly on the command line.

See also https://lore.kernel.org/git/YJrH8uqzapnpNEsb@gpanders.com/.

Signed-off-by: Gregory Anders <greg@gpanders.com>
---
 Documentation/git-send-email.txt | 13 +++++++------
 git-send-email.perl              |  7 +++++--
 t/t9001-send-email.sh            | 10 ++++++++++
 3 files changed, 22 insertions(+), 8 deletions(-)

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
index 65b3035371..14cc61ace7 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2225,4 +2225,14 @@ test_expect_success $PREREQ 'test forbidSendmailVariables behavior override' '
 		HEAD^
 '
 
+test_expect_success $PREREQ 'test using a command for smtpServer with !' '
+	clean_fake_sendmail &&
+	PATH="$(pwd):$PATH" \
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="!fake.sendmail" \
+		$patches 2>errors
+'
+
 test_done
-- 
2.31.1.576.g2f8a831619

