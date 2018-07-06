Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918761F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 02:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753779AbeGFCYQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 22:24:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52420 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753560AbeGFCYN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Jul 2018 22:24:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:294b:af98:ff6d:ed6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DA10F60102;
        Fri,  6 Jul 2018 02:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530843852;
        bh=qIFQHelP821Mv6TDQcgw7jK/xBI+yVHeNcJkNWvnmvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Y1m8co26LzlgNtStJv90NxdGx8PANpk1M6Vt1yFHrfuhNl5G40sJ0AJXD/1sJl1yb
         QwPsfX0MwqtXyu6LMjzHnunZC866gg/DdeNCCPQfEQN93wc0dTZgzWrbXJ/eZBHQ8g
         WJMXrgUISfBPLuZe4gbEc3jLxtBlFxkIO0W0zcUaBwG0t7nke3GQ88zGTqf4+88k1d
         EQzJjaQSXkIkCHdoNWqdSdiErdE+kJ04W6DLz+iqkWpbqB8butfO98MCFOmYkOkaQQ
         iIzqNwibv68UMyyhG1DD+kOVwrsRn2LxOk+ZuYi90BQgCNnJoUPLY196ACWZuA75dE
         hboyIuLDg1Rm9NNUb0m6snf3sMHFclElNzccY5DSK5phwx0jfqxopyVLkgp5LEOKIF
         C3+ac/IT08zl9i0D3aBLW9sdmsgYK7OGd0kFaxQ+8jUMevTBsWlvLsiNWMZaGzSgbV
         V50rVN5VaNl7RrTfmRA42eG0Ff02z0tzyid7G8M48AHXavECbDC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Drew DeVault <sir@cmpwn.com>
Subject: [PATCH 2/3] send-email: accept long lines with suitable transfer encoding
Date:   Fri,  6 Jul 2018 02:23:56 +0000
Message-Id: <20180706022357.739657-3-sandals@crustytoothpaste.net>
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

With --validate (which is the default), we warn about lines exceeding
998 characters due to the limits specified in RFC 5321.  However, if
we're using a suitable transfer encoding (quoted-printable or base64),
we're guaranteed not to have lines exceeding 76 characters, so there's
no need to fail in this case.  The auto transfer encoding handles this
specific case, so accept it as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-send-email.txt |  5 +++--
 git-send-email.perl              |  8 ++++++--
 t/t9001-send-email.sh            | 13 +++++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 385c7de9e2..f44fb4b81e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -401,8 +401,9 @@ have been specified, in which case default to 'compose'.
 +
 --
 		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
-		*	Warn of patches that contain lines longer than 998 characters; this
-			is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
+		*	Warn of patches that contain lines longer than 998 characters unless
+			a suitable transfer encoding is used; this is due to SMTP limits as
+			described by http://www.ietf.org/rfc/rfc2821.txt.
 --
 +
 Default is the value of `sendemail.validate`; if this is not set,
diff --git a/git-send-email.perl b/git-send-email.perl
index a76953c310..4ea30c4070 100755
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
@@ -1899,6 +1899,10 @@ sub validate_patch {
 		return $hook_error if $hook_error;
 	}
 
+	# Any long lines will be automatically fixed if we use a suitable transfer
+	# encoding.
+	return if $xfer_encoding =~ /^(?:auto|quoted-printable|base64)$/;
+
 	open(my $fh, '<', $fn)
 		or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 	while (my $line = <$fh>) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 6cdcbcb19e..6a0ace386b 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -480,6 +480,19 @@ test_expect_success $PREREQ 'long lines with auto encoding are quoted-printable'
 	grep "Content-Transfer-Encoding: quoted-printable" msgtxt1
 '
 
+test_expect_success $PREREQ '--validate passes with certain encodings' '
+	for enc in auto quoted-printable base64
+	do
+		git send-email \
+			--from="Example <nobody@example.com>" \
+			--to=nobody@example.com \
+			--smtp-server="$(pwd)/fake.sendmail" \
+			--transfer-encoding=$enc \
+			--validate \
+			$patches longline.patch
+	done
+'
+
 test_expect_success $PREREQ 'Invalid In-Reply-To' '
 	clean_fake_sendmail &&
 	git send-email \
