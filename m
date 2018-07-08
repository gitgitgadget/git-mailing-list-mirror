Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0E51F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 22:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeGHWR2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 18:17:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54218 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933084AbeGHWRZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 18:17:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 160BA60747;
        Sun,  8 Jul 2018 22:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531088244;
        bh=ZxG7Q2v1LcKFhNVhIBykAzXo0ZW/nzdThUwsWFRiLFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yOke+n2iw1WdyDx7LmpjFyEoC/fpbyEaKjJVGk8pNphAMZMXOSvsG2A3hUoOSvYQR
         go7ZUyfzGBgzAooOEzHkuVjAFcjjnuol3WCSIMn5DTHQH64/QCcP7VHM3ltijtXXqG
         YIuJFRJaBN8wUTKGWoKGtJT9BUh2VkqyivXh+S4uRBsWnLbLpl0Ojx7C0bMuSgHQ2i
         t9kMjVl7aq8oNYPiREyc6wLOfZ6lr/To1imGHreYaUcwI5BplzB3gXZ3dw06IkoSzB
         kH39g4C8i0N1SXGm5c2CMsKwFtBCqOWg/xe+FkGi6aPO0C2xxEVkrqMZBrH1bKh2kd
         UK3yyAXEcMMB45InvAeWCat9C6J2jf3DWU3qWwRpk/dgTCzgRGjw7N/0TDqD7zHAEr
         YmTC6eIpgmbe9dTVSKjcygcQautoxmCVviH0EFXzno5ezdfBkQURK5lkVd5xx9bJgo
         hP14Lum7rjctf/hbzFXMKe1OWNHC8NNew1r+/UNn3MQDtHVNfM+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Drew DeVault <sir@cmpwn.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/4] send-email: automatically determine transfer-encoding
Date:   Sun,  8 Jul 2018 22:17:12 +0000
Message-Id: <20180708221713.518276-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708221713.518276-1-sandals@crustytoothpaste.net>
References: <20180706022357.739657-1-sandals@crustytoothpaste.net>
 <20180708221713.518276-1-sandals@crustytoothpaste.net>
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
RFC 5322.  The --validate option, which is the default, catches this
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
index 0e648075bb..2f32dbf16d 100644
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
index e6bcc55827..f4c07908d2 100755
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
index 1b474cca28..1da282c415 100755
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
@@ -609,6 +612,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -653,6 +658,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -688,6 +695,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -714,6 +723,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -748,6 +759,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -779,6 +792,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -810,6 +825,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -845,6 +862,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
@@ -873,6 +892,8 @@ Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
 
 Result: OK
 EOF
