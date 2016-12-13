Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91FD209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 23:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbcLMXoQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:44:16 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:56376 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751704AbcLMXn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:43:56 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 4966DC3447;
        Wed, 14 Dec 2016 00:31:53 +0100 (CET)
Received: from drbeat.li (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 49ACAC3444;
        Wed, 14 Dec 2016 00:31:52 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id 053D2216A8; Wed, 14 Dec 2016 00:31:52 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 1/6] update_unicode.sh: move it into contrib/update-unicode
Date:   Wed, 14 Dec 2016 00:31:39 +0100
Message-Id: <1481671904-1143-2-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
References: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As it's used only by a tiny minority of the Git developer population,
this script does not belong into the main Git source directory.

Move it into contrib/ and adjust the paths to account for the new
location.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 .gitignore                               |  1 -
 contrib/update-unicode/.gitignore        |  3 +++
 contrib/update-unicode/README            | 20 ++++++++++++++++
 contrib/update-unicode/update_unicode.sh | 38 ++++++++++++++++++++++++++++++
 update_unicode.sh                        | 40 --------------------------------
 5 files changed, 61 insertions(+), 41 deletions(-)
 create mode 100644 contrib/update-unicode/.gitignore
 create mode 100644 contrib/update-unicode/README
 create mode 100755 contrib/update-unicode/update_unicode.sh
 delete mode 100755 update_unicode.sh

diff --git a/.gitignore b/.gitignore
index f96e50e..5555ae0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -204,7 +204,6 @@
 /config.mak.autogen
 /config.mak.append
 /configure
-/unicode
 /tags
 /TAGS
 /cscope*
diff --git a/contrib/update-unicode/.gitignore b/contrib/update-unicode/.gitignore
new file mode 100644
index 0000000..b0ebc6a
--- /dev/null
+++ b/contrib/update-unicode/.gitignore
@@ -0,0 +1,3 @@
+uniset/
+UnicodeData.txt
+EastAsianWidth.txt
diff --git a/contrib/update-unicode/README b/contrib/update-unicode/README
new file mode 100644
index 0000000..b9e2fc8
--- /dev/null
+++ b/contrib/update-unicode/README
@@ -0,0 +1,20 @@
+TL;DR: Run update_unicode.sh after the publication of a new Unicode
+standard and commit the resulting unicode_widths.h file.
+
+The long version
+================
+
+The Git source code ships the file unicode_widths.h which contains
+tables of zero and double width Unicode code points, respectively.
+These tables are generated using update_unicode.sh in this directory.
+update_unicode.sh itself uses a third-party tool, uniset, to query two
+Unicode data files for the interesting code points.
+
+On first run, update_unicode.sh clones uniset from Github and builds it.
+This requires a current-ish version of autoconf (2.69 works per December
+2016).
+
+On each run, update_unicode.sh checks whether more recent Unicode data
+files are available from the Unicode consortium, and rebuilds the header
+unicode_widths.h with the new data. The new header can then be
+committed.
diff --git a/contrib/update-unicode/update_unicode.sh b/contrib/update-unicode/update_unicode.sh
new file mode 100755
index 0000000..7b90126
--- /dev/null
+++ b/contrib/update-unicode/update_unicode.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+#See http://www.unicode.org/reports/tr44/
+#
+#Me Enclosing_Mark  an enclosing combining mark
+#Mn Nonspacing_Mark a nonspacing combining mark (zero advance width)
+#Cf Format          a format control character
+#
+cd "$(dirname "$0")"
+UNICODEWIDTH_H=$(git rev-parse --show-toplevel)/unicode_width.h
+(
+	if ! test -f UnicodeData.txt; then
+		wget http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
+	fi &&
+	if ! test -f EastAsianWidth.txt; then
+		wget http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
+	fi &&
+	if ! test -d uniset; then
+		git clone https://github.com/depp/uniset.git
+	fi &&
+	(
+		cd uniset &&
+		if ! test -x uniset; then
+			autoreconf -i &&
+			./configure --enable-warnings=-Werror CFLAGS='-O0 -ggdb'
+		fi &&
+		make
+	) &&
+	UNICODE_DIR=. && export UNICODE_DIR &&
+	cat >$UNICODEWIDTH_H <<-EOF
+	static const struct interval zero_width[] = {
+		$(uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
+		  grep -v plane)
+	};
+	static const struct interval double_width[] = {
+		$(uniset/uniset --32 eaw:F,W)
+	};
+	EOF
+)
diff --git a/update_unicode.sh b/update_unicode.sh
deleted file mode 100755
index 27af77c..0000000
--- a/update_unicode.sh
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/sh
-#See http://www.unicode.org/reports/tr44/
-#
-#Me Enclosing_Mark  an enclosing combining mark
-#Mn Nonspacing_Mark a nonspacing combining mark (zero advance width)
-#Cf Format          a format control character
-#
-UNICODEWIDTH_H=../unicode_width.h
-if ! test -d unicode; then
-	mkdir unicode
-fi &&
-( cd unicode &&
-	if ! test -f UnicodeData.txt; then
-		wget http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
-	fi &&
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
-- 
2.7.2
