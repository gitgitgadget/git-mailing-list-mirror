Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB051F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 21:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034298AbcIYVIa (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 17:08:30 -0400
Received: from ikke.info ([178.21.113.177]:39934 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034182AbcIYVI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 17:08:29 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 8CE514400BF; Sun, 25 Sep 2016 23:08:27 +0200 (CEST)
Received: from io.ikke (unknown [10.8.0.30])
        by vps892.directvps.nl (Postfix) with ESMTP id 6AEF84400A5;
        Sun, 25 Sep 2016 23:08:25 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Swift Geek <swiftgeek@gmail.com>, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>
Subject: [PATCH v3 1/2] t5100-mailinfo: replace common path prefix with variable
Date:   Sun, 25 Sep 2016 23:08:07 +0200
Message-Id: <20160925210808.26424-1-me@ikke.info>
X-Mailer: git-send-email 2.10.0.89.ge802c3a.dirty
In-Reply-To: <20160919185440.18234-1-me@ikke.info>
References: <20160919185440.18234-1-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many tests need to store data in a file, and repeat the same pattern to
refer to that path:

    "$TEST_DIRECTORY"/t5100/

Create a variable that contains this path, and use that instead.

Signed-off-by: Kevin Daudt <me@ikke.info>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Changes since v2:
 - changed $DATA to $data to indicate it's a script-local variable

 t/t5100-mailinfo.sh | 56 +++++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 1a5a546..c4ed0f4 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -7,8 +7,10 @@ test_description='git mailinfo and git mailsplit test'
 
 . ./test-lib.sh
 
+data="$TEST_DIRECTORY/t5100"
+
 test_expect_success 'split sample box' \
-	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
+	'git mailsplit -o. "$data"/sample.mbox >last &&
 	last=$(cat last) &&
 	echo total is $last &&
 	test $(cat last) = 17'
@@ -17,9 +19,9 @@ check_mailinfo () {
 	mail=$1 opt=$2
 	mo="$mail$opt"
 	git mailinfo -u $opt msg$mo patch$mo <$mail >info$mo &&
-	test_cmp "$TEST_DIRECTORY"/t5100/msg$mo msg$mo &&
-	test_cmp "$TEST_DIRECTORY"/t5100/patch$mo patch$mo &&
-	test_cmp "$TEST_DIRECTORY"/t5100/info$mo info$mo
+	test_cmp "$data"/msg$mo msg$mo &&
+	test_cmp "$data"/patch$mo patch$mo &&
+	test_cmp "$data"/info$mo info$mo
 }
 
 
@@ -27,15 +29,15 @@ for mail in 00*
 do
 	test_expect_success "mailinfo $mail" '
 		check_mailinfo $mail "" &&
-		if test -f "$TEST_DIRECTORY"/t5100/msg$mail--scissors
+		if test -f "$data"/msg$mail--scissors
 		then
 			check_mailinfo $mail --scissors
 		fi &&
-		if test -f "$TEST_DIRECTORY"/t5100/msg$mail--no-inbody-headers
+		if test -f "$data"/msg$mail--no-inbody-headers
 		then
 			check_mailinfo $mail --no-inbody-headers
 		fi &&
-		if test -f "$TEST_DIRECTORY"/t5100/msg$mail--message-id
+		if test -f "$data"/msg$mail--message-id
 		then
 			check_mailinfo $mail --message-id
 		fi
@@ -45,7 +47,7 @@ done
 
 test_expect_success 'split box with rfc2047 samples' \
 	'mkdir rfc2047 &&
-	git mailsplit -orfc2047 "$TEST_DIRECTORY"/t5100/rfc2047-samples.mbox \
+	git mailsplit -orfc2047 "$data"/rfc2047-samples.mbox \
 	  >rfc2047/last &&
 	last=$(cat rfc2047/last) &&
 	echo total is $last &&
@@ -56,18 +58,18 @@ do
 	test_expect_success "mailinfo $mail" '
 		git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
 		echo msg &&
-		test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+		test_cmp "$data"/empty $mail-msg &&
 		echo patch &&
-		test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+		test_cmp "$data"/empty $mail-patch &&
 		echo info &&
-		test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $mail-info
+		test_cmp "$data"/rfc2047-info-$(basename $mail) $mail-info
 	'
 done
 
 test_expect_success 'respect NULs' '
 
-	git mailsplit -d3 -o. "$TEST_DIRECTORY"/t5100/nul-plain &&
-	test_cmp "$TEST_DIRECTORY"/t5100/nul-plain 001 &&
+	git mailsplit -d3 -o. "$data"/nul-plain &&
+	test_cmp "$data"/nul-plain 001 &&
 	(cat 001 | git mailinfo msg patch) &&
 	test_line_count = 4 patch
 
@@ -75,52 +77,52 @@ test_expect_success 'respect NULs' '
 
 test_expect_success 'Preserve NULs out of MIME encoded message' '
 
-	git mailsplit -d5 -o. "$TEST_DIRECTORY"/t5100/nul-b64.in &&
-	test_cmp "$TEST_DIRECTORY"/t5100/nul-b64.in 00001 &&
+	git mailsplit -d5 -o. "$data"/nul-b64.in &&
+	test_cmp "$data"/nul-b64.in 00001 &&
 	git mailinfo msg patch <00001 &&
-	test_cmp "$TEST_DIRECTORY"/t5100/nul-b64.expect patch
+	test_cmp "$data"/nul-b64.expect patch
 
 '
 
 test_expect_success 'mailinfo on from header without name works' '
 
 	mkdir info-from &&
-	git mailsplit -oinfo-from "$TEST_DIRECTORY"/t5100/info-from.in &&
-	test_cmp "$TEST_DIRECTORY"/t5100/info-from.in info-from/0001 &&
+	git mailsplit -oinfo-from "$data"/info-from.in &&
+	test_cmp "$data"/info-from.in info-from/0001 &&
 	git mailinfo info-from/msg info-from/patch \
 	  <info-from/0001 >info-from/out &&
-	test_cmp "$TEST_DIRECTORY"/t5100/info-from.expect info-from/out
+	test_cmp "$data"/info-from.expect info-from/out
 
 '
 
 test_expect_success 'mailinfo finds headers after embedded From line' '
 	mkdir embed-from &&
-	git mailsplit -oembed-from "$TEST_DIRECTORY"/t5100/embed-from.in &&
-	test_cmp "$TEST_DIRECTORY"/t5100/embed-from.in embed-from/0001 &&
+	git mailsplit -oembed-from "$data"/embed-from.in &&
+	test_cmp "$data"/embed-from.in embed-from/0001 &&
 	git mailinfo embed-from/msg embed-from/patch \
 	  <embed-from/0001 >embed-from/out &&
-	test_cmp "$TEST_DIRECTORY"/t5100/embed-from.expect embed-from/out
+	test_cmp "$data"/embed-from.expect embed-from/out
 '
 
 test_expect_success 'mailinfo on message with quoted >From' '
 	mkdir quoted-from &&
-	git mailsplit -oquoted-from "$TEST_DIRECTORY"/t5100/quoted-from.in &&
-	test_cmp "$TEST_DIRECTORY"/t5100/quoted-from.in quoted-from/0001 &&
+	git mailsplit -oquoted-from "$data"/quoted-from.in &&
+	test_cmp "$data"/quoted-from.in quoted-from/0001 &&
 	git mailinfo quoted-from/msg quoted-from/patch \
 	  <quoted-from/0001 >quoted-from/out &&
-	test_cmp "$TEST_DIRECTORY"/t5100/quoted-from.expect quoted-from/msg
+	test_cmp "$data"/quoted-from.expect quoted-from/msg
 '
 
 test_expect_success 'mailinfo unescapes with --mboxrd' '
 	mkdir mboxrd &&
 	git mailsplit -omboxrd --mboxrd \
-		"$TEST_DIRECTORY"/t5100/sample.mboxrd >last &&
+		"$data"/sample.mboxrd >last &&
 	test x"$(cat last)" = x2 &&
 	for i in 0001 0002
 	do
 		git mailinfo mboxrd/msg mboxrd/patch \
 		  <mboxrd/$i >mboxrd/out &&
-		test_cmp "$TEST_DIRECTORY"/t5100/${i}mboxrd mboxrd/msg
+		test_cmp "$data"/${i}mboxrd mboxrd/msg
 	done &&
 	sp=" " &&
 	echo "From " >expect &&
-- 
2.10.0.89.ge802c3a.dirty

