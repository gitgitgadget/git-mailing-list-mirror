Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1797B1F6AC
	for <e@80x24.org>; Fri,  6 Jul 2018 02:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753698AbeGFCYN (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 22:24:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52414 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753640AbeGFCYM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Jul 2018 22:24:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:294b:af98:ff6d:ed6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ED52F60745;
        Fri,  6 Jul 2018 02:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530843851;
        bh=CiKf7f25pgExBy3Oiy8gn3c68qym0CWZxGuunbG3tfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=T0hb1gHzup2Ucjb2EmmyN6K6GCvNdwafcJONPYwuTyg2WitH/48M78Sa8/QuC0HTw
         qtMCqbtmxzH74UmLwF6WZK84yJ4jz8Up1rdTlWtZwzLCO+wdz4YblF9sTD2kQufJk1
         KQbLMZAMpPDePLfYS09fmzs6kedWxQzSRcTcj0ZnvkiMd5NU/FLszzaNa7uMHwhowG
         X2wDoek5kwuhpIxAcbh2ZQoFefmYkP0TD/kKNnaKVcvXm1uWtGMERcONJI1BvP4KUX
         2VZsXj7XmDpoLPmPvgjPF3udjCyJN6ieHm8NrudDJpNxXAnmahaYIziJv13sUOkLXl
         9qihXEToMFbSg2LkjLDuuDdi2J0smprrsJAMFIhc34ofNH/qYRH5911Bsleg537iEJ
         BV5B8G/I2yLwGDtxgY9VzkrMT5BPRWE1vA+S+pc3J195SUkoYgyANuwwv+y3yzXfJG
         /DA2khb6Z/TgiJde2f8WO58/oP4kzElRU12HnzqHF2j/majYpKf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Drew DeVault <sir@cmpwn.com>
Subject: [PATCH 1/3] send-email: add an auto option for transfer encoding
Date:   Fri,  6 Jul 2018 02:23:55 +0000
Message-Id: <20180706022357.739657-2-sandals@crustytoothpaste.net>
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

For most patches, using a transfer encoding of 8bit provides good
compatibility with most servers and makes it as easy as possible to view
patches.  However, there are some patches for which 8bit is not a valid
encoding: RFC 5321 specifies that a message must not have lines
exceeding 998 octets.

Add a transfer encoding value, auto, which indicates that a patch should
use 8bit where allowed and quoted-printable otherwise.  Choose
quoted-printable instead of base64, since base64-encoded plain text is
treated as suspicious by some spam filters.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-send-email.txt | 11 +++++++----
 git-send-email.perl              | 12 +++++++-----
 t/t9001-send-email.sh            | 24 ++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 4f3efde80c..385c7de9e2 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -137,15 +137,18 @@ Note that no attempts whatsoever are made to validate the encoding.
 	Specify encoding of compose message. Default is the value of the
 	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assumed.
 
---transfer-encoding=(7bit|8bit|quoted-printable|base64)::
+--transfer-encoding=(7bit|8bit|quoted-printable|base64|auto)::
 	Specify the transfer encoding to be used to send the message over SMTP.
 	7bit will fail upon encountering a non-ASCII message.  quoted-printable
 	can be useful when the repository contains files that contain carriage
 	returns, but makes the raw patch email file (as saved from a MUA) much
 	harder to inspect manually.  base64 is even more fool proof, but also
-	even more opaque.  Default is the value of the `sendemail.transferEncoding`
-	configuration value; if that is unspecified, git will use 8bit and not
-	add a Content-Transfer-Encoding header.
+	even more opaque.  auto will use 8bit when possible, and quoted-printable
+	otherwise.
++
+Default is the value of the `sendemail.transferEncoding` configuration
+value; if that is unspecified, git will use 8bit and not add a
+Content-Transfer-Encoding header.
 
 --xmailer::
 --no-xmailer::
diff --git a/git-send-email.perl b/git-send-email.perl
index 8ec70e58ed..a76953c310 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1739,9 +1739,8 @@ sub process_file {
 	}
 	if (defined $target_xfer_encoding) {
 		$xfer_encoding = '8bit' if not defined $xfer_encoding;
-		$message = apply_transfer_encoding(
+		($message, $xfer_encoding) = apply_transfer_encoding(
 			$message, $xfer_encoding, $target_xfer_encoding);
-		$xfer_encoding = $target_xfer_encoding;
 	}
 	if (defined $xfer_encoding) {
 		push @xh, "Content-Transfer-Encoding: $xfer_encoding";
@@ -1852,13 +1851,16 @@ sub apply_transfer_encoding {
 	$message = MIME::Base64::decode($message)
 		if ($from eq 'base64');
 
+	$to = ($message =~ /.{999,}/) ? 'quoted-printable' :'8bit'
+		if $to eq 'auto';
+
 	die __("cannot send message as 7bit")
 		if ($to eq '7bit' and $message =~ /[^[:ascii:]]/);
-	return $message
+	return ($message, $to)
 		if ($to eq '7bit' or $to eq '8bit');
-	return MIME::QuotedPrint::encode($message, "\n", 0)
+	return (MIME::QuotedPrint::encode($message, "\n", 0), $to)
 		if ($to eq 'quoted-printable');
-	return MIME::Base64::encode($message, "\n")
+	return (MIME::Base64::encode($message, "\n"), $to)
 		if ($to eq 'base64');
 	die __("invalid transfer encoding");
 }
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e80eacbb1b..6cdcbcb19e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -456,6 +456,30 @@ test_expect_success $PREREQ 'allow long lines with --no-validate' '
 		2>errors
 '
 
+test_expect_success $PREREQ 'short lines with auto encoding are 8bit' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="A <author@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--transfer-encoding=auto \
+		$patches &&
+	grep "Content-Transfer-Encoding: 8bit" msgtxt1
+'
+
+test_expect_success $PREREQ 'long lines with auto encoding are quoted-printable' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--transfer-encoding=auto \
+		--no-validate \
+		longline.patch \
+		2>errors &&
+	grep "Content-Transfer-Encoding: quoted-printable" msgtxt1
+'
+
 test_expect_success $PREREQ 'Invalid In-Reply-To' '
 	clean_fake_sendmail &&
 	git send-email \
