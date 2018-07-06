Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3AF21F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 02:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753782AbeGFCYR (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 22:24:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52430 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753703AbeGFCYO (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Jul 2018 22:24:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:294b:af98:ff6d:ed6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AC54C60745;
        Fri,  6 Jul 2018 02:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530843853;
        bh=ghB3i76YL5t2sxowsgxBOmoDu+Pp1VuIkbtCdM6CxOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yWyKN3B4QkrVHwxfpkbay44Q9j+rHCACNRerD3ZdYzCCPPpAZ3LT7E0lMJZcDVOHa
         r+Hxz+Ep0K6wN0KdtMDMm0qKZopHsbbF+bnV7kkp7/Jfw3SjDz55ybSk3jzRt0RqWb
         441FesfgT/yCzRm1L5UwV1c1ag7FjuWF+veMETAKMZFJ4kLElYeX/wQDXSi5e+CRhU
         JSPhznFWeX+vseg4OqFCP9B7WWg2SHAbMhghJA4gMSLIBuq6Sfba6oCk77hrB+MGs1
         NoYQ8Ub7Lj23R7QPYBlmZJOPQVKnRwrtIqq3O+SBbSTZCbE6VpHtsM9c5iXmxUqI/l
         3zquJgIJw1xQBUGKCL/GSi1qpPxruVrC2MtXTrtQxsKkXN9pXMfnc0jRKpKMt7hkvd
         cngKdq/RiX4R0HUeMhGaoMwOo4he4R76nkBuEHka4rkT3572iUIQC2xVP5u3ufEm26
         kZIWXsiluYV8xCaFvUNskd2ZdLGmD2c/sZXT61oWQAYOOXV0gkM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Drew DeVault <sir@cmpwn.com>
Subject: [PATCH 3/3] send-email: automatically determine transfer-encoding
Date:   Fri,  6 Jul 2018 02:23:57 +0000
Message-Id: <20180706022357.739657-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.132.g7d961b6d40
In-Reply-To: <20180706022357.739657-1-sandals@crustytoothpaste.net>
References: <20180706022357.739657-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git send-email, when invoked without a --transfer-encoding option, sends
8bit data without a MIME version or a transfer encoding.  This has
several downsides.

First, unless the transfer encoding is specified, it defaults to 7bit,
meaning that non-ASCII data isn't allowed.  Second, if lines longer than
998 bytes are used, we will send an message that is invalid according to
RFC 5321.  The --validate option, which is the default, catches this
issue, but it isn't clear to many people how to resolve this.

To solve these issues, default the transfer encoding to "auto", so that
we explicitly specify 8bit encoding when lines don't exceed 998 bytes
and quoted-printable otherwise.  This means that we now always emit
Content-Transfer-Encoding and MIME-Version headers, so remove the
conditionals from this portion of the code.

It is unlikely that the unconditional inclusion of these two headers
will affect the deliverability of messages in anything but a positive
way, since MIME is already widespread and well understood by most email
programs.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-send-email.txt |  3 +--
 git-send-email.perl              | 18 ++++++------------
 t/t9001-send-email.sh            | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f44fb4b81e..1a240b52fc 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -147,8 +147,7 @@ Note that no attempts whatsoever are made to validate the encoding.
 	otherwise.
 +
 Default is the value of the `sendemail.transferEncoding` configuration
-value; if that is unspecified, git will use 8bit and not add a
-Content-Transfer-Encoding header.
+value; if that is unspecified, default to `auto`.
 
 --xmailer::
 --no-xmailer::
diff --git a/git-send-email.perl b/git-send-email.perl
index 4ea30c4070..c4fae17787 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -231,7 +231,7 @@ sub do_edit {
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
-my ($target_xfer_encoding);
+my $target_xfer_encoding = 'auto';
 
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 
@@ -1737,17 +1737,11 @@ sub process_file {
 			}
 		}
 	}
-	if (defined $target_xfer_encoding) {
-		$xfer_encoding = '8bit' if not defined $xfer_encoding;
-		($message, $xfer_encoding) = apply_transfer_encoding(
-			$message, $xfer_encoding, $target_xfer_encoding);
-	}
-	if (defined $xfer_encoding) {
-		push @xh, "Content-Transfer-Encoding: $xfer_encoding";
-	}
-	if (defined $xfer_encoding or $has_content_type) {
-		unshift @xh, 'MIME-Version: 1.0' unless $has_mime_version;
-	}
+	$xfer_encoding = '8bit' if not defined $xfer_encoding;
+	($message, $xfer_encoding) = apply_transfer_encoding(
+		$message, $xfer_encoding, $target_xfer_encoding);
+	push @xh, "Content-Transfer-Encoding: $xfer_encoding";
+	unshift @xh, 'MIME-Version: 1.0' unless $has_mime_version;
 
 	$needs_confirm = (
 		$confirm eq "always" or
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 6a0ace386b..7edce50e65 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -225,6 +225,8 @@ X-Mailer: X-MAILER-STRING
 In-Reply-To: <unique-message-id@example.com>
 References: <unique-message-id@example.com>
 Reply-To: Reply <reply@example.com>
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -415,6 +417,7 @@ test_expect_success $PREREQ 'reject long lines' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
+		--transfer-encoding=8bit \
 		$patches longline.patch \
 		2>errors &&
 	grep longline.patch errors
@@ -610,6 +613,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -654,6 +659,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -689,6 +696,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -715,6 +724,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -749,6 +760,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -780,6 +793,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -811,6 +826,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -846,6 +863,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -874,6 +893,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
