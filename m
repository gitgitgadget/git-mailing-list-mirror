Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E161F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 22:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933053AbeGHWRX (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 18:17:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54200 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933001AbeGHWRW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 18:17:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C8EC060745;
        Sun,  8 Jul 2018 22:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531088241;
        bh=a54NoLhXb+1VGZTmbmC9QAFWtrcyoiJGpB2XoAfpBXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uNYARSDkxjLuaQa5aVkKfjIvm6Xm0GDSRdgXAUKlnla18uwUHHoJ8POdro90tUHPb
         z27BRQvCs8wloNBMt/MUAL+WHo6C8Vcd39UlNndlqLgTS7QH+vN3t4eXzPd4Db9IVx
         yBDCokkAGyhOoyH+evTKfL3VeAUBMHHiHP2xvQsZ3te0EFqmJJosDvOOyPj3s6BRwp
         DBsW2iZEJwlyWiLzUR0hB1nGIYWBY1d6HUkF6rplhl4z2DzdOr/UgioaEJzVo1Y7WD
         1cV9SAMUcm2t6cNZF4j0lRovCgYXcGpkaM6Wvkt51qtG3m8kzfGnNS4zaDI+0o5mdP
         TfTgDq9IP0VbGlA8FhNwJhk19Y2nRjZICzZ+Q2MPrisgyxAPQxUp11vcBzfAQxJti3
         iCSNIbtpPGza6mthBZhQx66JgzqAY85fCB8lLeJbhg4zjkJda/1vlv92MkJBq/p1iZ
         5nYpD9sVdNkzDULhefjRmkm1Vr8wLuzxwI8N6hQz+NGTZInprxy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Drew DeVault <sir@cmpwn.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/4] send-email: add an auto option for transfer encoding
Date:   Sun,  8 Jul 2018 22:17:10 +0000
Message-Id: <20180708221713.518276-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708221713.518276-1-sandals@crustytoothpaste.net>
References: <20180706022357.739657-1-sandals@crustytoothpaste.net>
 <20180708221713.518276-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For most patches, using a transfer encoding of 8bit provides good
compatibility with most servers and makes it as easy as possible to view
patches.  However, there are some patches for which 8bit is not a valid
encoding: RFC 5322 specifies that a message must not have lines
exceeding 998 octets.

Add a transfer encoding value, auto, which indicates that a patch should
use 8bit where allowed and quoted-printable otherwise.  Choose
quoted-printable instead of base64, since base64-encoded plain text is
treated as suspicious by some spam filters.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-send-email.txt | 11 +++++++----
 git-send-email.perl              | 12 +++++++-----
 t/t9001-send-email.sh            | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+), 9 deletions(-)

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
index 8ec70e58ed..1736a09d21 100755
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
 
+	$to = ($message =~ /.{999,}/) ? 'quoted-printable' : '8bit'
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
index e80eacbb1b..a35cba6a4c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -456,6 +456,29 @@ test_expect_success $PREREQ 'allow long lines with --no-validate' '
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
+		longline.patch &&
+	grep "Content-Transfer-Encoding: quoted-printable" msgtxt1
+'
+
 test_expect_success $PREREQ 'Invalid In-Reply-To' '
 	clean_fake_sendmail &&
 	git send-email \
