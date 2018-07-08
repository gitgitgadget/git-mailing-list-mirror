Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21791F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 22:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933155AbeGHWRa (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 18:17:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54210 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933001AbeGHWRY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 18:17:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CCB8C60746;
        Sun,  8 Jul 2018 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531088242;
        bh=2JnLIn3TZY4I5EGF9iws/+Jegy4kiDLtCwXakgXIYHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kHTBruCVA0NsUzEit7ZC1NODwEF5zVj4kP1OTTBGq62RaUq2sTPBwrkX2r5b9J6fp
         ynurvvHibuFDw4Y6gfNBKhCJy+wym2DW4AY2ZgGpDyi4/3ll35cU2Iw+tOjViniKoE
         elD6udIQxv3dgAJi9MwcYjOyYG6KQ0v3yZTyWiFC43LM2CJTwZEhBQID2S0Y+p+aQD
         B52SsDYlmfyvhSlHXsi7XkAiGy5eyc486Q8Sw3+D+FqDfPcmK8pRRhf6aIDWyTFeOK
         lGbMjRPpR1GIPJfV6moi1+/q59wEypuAidl3tLt2cTXSDWeWNiHzjCnyZS1lA/QmRy
         /og4WDBUceCNgGwDVchHFPdW4yFzvkO2Idapda4PJTXa0fF7WH28mHQ8cQdFJ4lJrv
         oka20TDoAgM42OWIMt/9Y9b6JGUYhARGH0G7NcJceRMI0I0SWZyzPHvhlD9tzFNPsx
         FV0wtt/sZGOcFz4W899C5gQgbwP75iSgKTtAA1CoVm6oRby/Y0d
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Drew DeVault <sir@cmpwn.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/4] send-email: accept long lines with suitable transfer encoding
Date:   Sun,  8 Jul 2018 22:17:11 +0000
Message-Id: <20180708221713.518276-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708221713.518276-1-sandals@crustytoothpaste.net>
References: <20180706022357.739657-1-sandals@crustytoothpaste.net>
 <20180708221713.518276-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With --validate (which is the default), we warn about lines exceeding
998 characters due to the limits specified in RFC 5322.  However, if
we're using a suitable transfer encoding (quoted-printable or base64),
we're guaranteed not to have lines exceeding 76 characters, so there's
no need to fail in this case.  The auto transfer encoding handles this
specific case, so accept it as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-send-email.txt |  7 +++++--
 git-send-email.perl              | 18 +++++++++++-------
 t/t9001-send-email.sh            | 13 +++++++++++++
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 385c7de9e2..0e648075bb 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -401,8 +401,11 @@ have been specified, in which case default to 'compose'.
 +
 --
 		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
-		*	Warn of patches that contain lines longer than 998 characters; this
-			is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
+		*	Warn of patches that contain lines longer than
+			998 characters unless a suitable transfer encoding
+			('auto', 'base64', or 'quoted-printable') is used;
+			this is due to SMTP limits as described by
+			http://www.ietf.org/rfc/rfc2821.txt.
 --
 +
 Default is the value of `sendemail.validate`; if this is not set,
diff --git a/git-send-email.perl b/git-send-email.perl
index 1736a09d21..e6bcc55827 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -645,7 +645,7 @@ sub is_format_patch_arg {
 if ($validate) {
 	foreach my $f (@files) {
 		unless (-p $f) {
-			my $error = validate_patch($f);
+			my $error = validate_patch($f, $target_xfer_encoding);
 			$error and die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
 						  $f, $error);
 		}
@@ -1879,7 +1879,7 @@ sub unique_email_list {
 }
 
 sub validate_patch {
-	my $fn = shift;
+	my ($fn, $xfer_encoding) = @_;
 
 	if ($repo) {
 		my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
@@ -1899,11 +1899,15 @@ sub validate_patch {
 		return $hook_error if $hook_error;
 	}
 
-	open(my $fh, '<', $fn)
-		or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
-	while (my $line = <$fh>) {
-		if (length($line) > 998) {
-			return sprintf(__("%s: patch contains a line longer than 998 characters"), $.);
+	# Any long lines will be automatically fixed if we use a suitable transfer
+	# encoding.
+	unless ($xfer_encoding =~ /^(?:auto|quoted-printable|base64)$/) {
+		open(my $fh, '<', $fn)
+			or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
+		while (my $line = <$fh>) {
+			if (length($line) > 998) {
+				return sprintf(__("%s: patch contains a line longer than 998 characters"), $.);
+			}
 		}
 	}
 	return;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index a35cba6a4c..1b474cca28 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -479,6 +479,19 @@ test_expect_success $PREREQ 'long lines with auto encoding are quoted-printable'
 	grep "Content-Transfer-Encoding: quoted-printable" msgtxt1
 '
 
+for enc in auto quoted-printable base64
+do
+	test_expect_success $PREREQ "--validate passes with encoding $enc" '
+		git send-email \
+			--from="Example <nobody@example.com>" \
+			--to=nobody@example.com \
+			--smtp-server="$(pwd)/fake.sendmail" \
+			--transfer-encoding=$enc \
+			--validate \
+			$patches longline.patch
+	'
+done
+
 test_expect_success $PREREQ 'Invalid In-Reply-To' '
 	clean_fake_sendmail &&
 	git send-email \
