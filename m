Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28AB220451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbcLMXn6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:43:58 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:56375 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbcLMXn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:43:56 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 65EE9C3448;
        Wed, 14 Dec 2016 00:31:52 +0100 (CET)
Received: from drbeat.li (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 4A77DC3445;
        Wed, 14 Dec 2016 00:31:52 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id 0910E216CE; Wed, 14 Dec 2016 00:31:52 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 2/6] update_unicode.sh: remove an unnecessary subshell level
Date:   Wed, 14 Dec 2016 00:31:40 +0100
Message-Id: <1481671904-1143-3-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
References: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the move into contrib/update-unicode, we no longer create the
unicode directory to have a clean working folder. Instead, the directory
of the script is used. This means that the subshell can be removed.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 contrib/update-unicode/update_unicode.sh | 53 ++++++++++++++++----------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/contrib/update-unicode/update_unicode.sh b/contrib/update-unicode/update_unicode.sh
index 7b90126..ff664ec 100755
--- a/contrib/update-unicode/update_unicode.sh
+++ b/contrib/update-unicode/update_unicode.sh
@@ -7,32 +7,31 @@
 #
 cd "$(dirname "$0")"
 UNICODEWIDTH_H=$(git rev-parse --show-toplevel)/unicode_width.h
+
+if ! test -f UnicodeData.txt; then
+	wget http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
+fi &&
+if ! test -f EastAsianWidth.txt; then
+	wget http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
+fi &&
+if ! test -d uniset; then
+	git clone https://github.com/depp/uniset.git
+fi &&
 (
-	if ! test -f UnicodeData.txt; then
-		wget http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
+	cd uniset &&
+	if ! test -x uniset; then
+		autoreconf -i &&
+		./configure --enable-warnings=-Werror CFLAGS='-O0 -ggdb'
 	fi &&
-	if ! test -f EastAsianWidth.txt; then
-		wget http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
-	fi &&
-	if ! test -d uniset; then
-		git clone https://github.com/depp/uniset.git
-	fi &&
-	(
-		cd uniset &&
-		if ! test -x uniset; then
-			autoreconf -i &&
-			./configure --enable-warnings=-Werror CFLAGS='-O0 -ggdb'
-		fi &&
-		make
-	) &&
-	UNICODE_DIR=. && export UNICODE_DIR &&
-	cat >$UNICODEWIDTH_H <<-EOF
-	static const struct interval zero_width[] = {
-		$(uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
-		  grep -v plane)
-	};
-	static const struct interval double_width[] = {
-		$(uniset/uniset --32 eaw:F,W)
-	};
-	EOF
-)
+	make
+) &&
+UNICODE_DIR=. && export UNICODE_DIR &&
+cat >$UNICODEWIDTH_H <<-EOF
+static const struct interval zero_width[] = {
+	$(uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
+	  grep -v plane)
+};
+static const struct interval double_width[] = {
+	$(uniset/uniset --32 eaw:F,W)
+};
+EOF
-- 
2.7.2
