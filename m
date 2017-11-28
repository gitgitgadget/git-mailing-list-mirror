Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC51720C11
	for <e@80x24.org>; Tue, 28 Nov 2017 00:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbdK1At2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 19:49:28 -0500
Received: from mail.zeus.flokli.de ([88.198.15.28]:60248 "EHLO zeus.flokli.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752536AbdK1At2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 19:49:28 -0500
Received: from localhost (unknown [185.104.140.104])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id 8DAC6390C67;
        Tue, 28 Nov 2017 00:49:26 +0000 (UTC)
From:   Florian Klink <flokli@flokli.de>
To:     git@vger.kernel.org
Cc:     flokli@flokli.de, sandals@crustytoothpaste.net, gitster@pobox.com
Subject: [PATCH v3] git-send-email: honor $PATH for sendmail binary
Date:   Tue, 28 Nov 2017 01:49:04 +0100
Message-Id: <20171128004904.13978-1-flokli@flokli.de>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171119123511.pck5aqak4yyc6367@tp.flokli.de>
References: <20171119123511.pck5aqak4yyc6367@tp.flokli.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This extends git-send-email to also consider sendmail binaries in $PATH
after checking the (fixed) list of /usr/sbin and /usr/lib, and before
falling back to localhost.

Signed-off-by: Florian Klink <flokli@flokli.de>
---
 Documentation/git-send-email.txt | 6 +++---
 git-send-email.perl              | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index bac9014ac..44db25567 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -203,9 +203,9 @@ a password is obtained using 'git-credential'.
 	specify a full pathname of a sendmail-like program instead;
 	the program must support the `-i` option.  Default value can
 	be specified by the `sendemail.smtpServer` configuration
-	option; the built-in default is `/usr/sbin/sendmail` or
-	`/usr/lib/sendmail` if such program is available, or
-	`localhost` otherwise.
+	option; the built-in default is to search for `sendmail` in
+	`/usr/sbin`, `/usr/lib/sendmail` and $PATH if such program is
+	available, falling back to `localhost` otherwise.
 
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
diff --git a/git-send-email.perl b/git-send-email.perl
index 2208dcc21..edcc6d346 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -885,7 +885,9 @@ if (defined $initial_reply_to) {
 }
 
 if (!defined $smtp_server) {
-	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
+	my @sendmail_paths = qw( /usr/sbin/sendmail /usr/lib/sendmail );
+	push @sendmail_paths, map {"$_/sendmail"} split /:/, $ENV{PATH};
+	foreach (@sendmail_paths) {
 		if (-x $_) {
 			$smtp_server = $_;
 			last;
-- 
2.15.0

