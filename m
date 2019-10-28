Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7851F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfJ1A7e (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54282 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729001AbfJ1A7d (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:33 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 611A361CAF;
        Mon, 28 Oct 2019 00:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224371;
        bh=9cHS+BdocZDusjgmfDKsZP7OczLxO50sQOp48s48Hg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OHYyuAQ0nDOPxz6oElH2R+teJ1bfUmHVaJp9x5YDp7Od6WfDEPKGhNv5zNrtNsv6z
         p2+AD1NROVfFjFAFngHvY+di921qpfYmiQsG0czscY9USLacZxXOqdbcKaRsKFMXty
         1EVODkwU1DfImXrqS4JSfYG39RCefvvqfS6S+AzUfCp6RU5gbaNEIQBhJDX1RtcbS7
         d9zOsHGtVTPytKd+0mutNrhC4feLNKgRDrREd+BNvl+yYPXW6SXzYmPHCWbjXiMtZX
         G3713gUwP3BjcqqFe5X4hhvMD8IpHT2Z1/HWgKVmcsfpCuL1xJrQPf+qaM+k6aSrkp
         MDkmlSFAeEeQ+ZCtBa0M7rMtnuvbOWCpuiKjwCE1P7UkN/Ves42xaA4TiSms/L9eCf
         +fC4fd3k6uPVXLsCAezsmf1cpobtS31NoYT8scvC/WhhMN3kjQzJ3CSbJHbvqClsdL
         MEiHb6d+tXj6tiVt6K3ifdwbhjbIZXIBp0kHvn8EiHlq9+l97JW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 08/15] t4015: abstract away SHA-1-specific constants
Date:   Mon, 28 Oct 2019 00:59:00 +0000
Message-Id: <20191028005907.24985-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4015-diff-whitespace.sh | 89 +++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 36 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6b087df3dc..eadaf57262 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -16,6 +16,7 @@ test_expect_success "Ray Lehtiniemi's example" '
 	} while (0);
 	EOF
 	git update-index --add x &&
+	before=$(git rev-parse --short $(git hash-object x)) &&
 
 	cat <<-\EOF >x &&
 	do
@@ -24,10 +25,11 @@ test_expect_success "Ray Lehtiniemi's example" '
 	}
 	while (0);
 	EOF
+	after=$(git rev-parse --short $(git hash-object x)) &&
 
-	cat <<-\EOF >expect &&
+	cat <<-EOF >expect &&
 	diff --git a/x b/x
-	index adf3937..6edc172 100644
+	index $before..$after 100644
 	--- a/x
 	+++ b/x
 	@@ -1,3 +1,5 @@
@@ -61,6 +63,7 @@ test_expect_success 'another test, without options' '
 	EOF
 
 	git update-index x &&
+	before=$(git rev-parse --short $(git hash-object x)) &&
 
 	tr "_" " " <<-\EOF >x &&
 	_	whitespace at beginning
@@ -70,10 +73,11 @@ test_expect_success 'another test, without options' '
 	unchanged line
 	CR at end
 	EOF
+	after=$(git rev-parse --short $(git hash-object x)) &&
 
-	tr "Q_" "\015 " <<-\EOF >expect &&
+	tr "Q_" "\015 " <<-EOF >expect &&
 	diff --git a/x b/x
-	index d99af23..22d9f73 100644
+	index $before..$after 100644
 	--- a/x
 	+++ b/x
 	@@ -1,6 +1,6 @@
@@ -108,9 +112,9 @@ test_expect_success 'another test, without options' '
 	git diff -w --ignore-cr-at-eol >out &&
 	test_must_be_empty out &&
 
-	tr "Q_" "\015 " <<-\EOF >expect &&
+	tr "Q_" "\015 " <<-EOF >expect &&
 	diff --git a/x b/x
-	index d99af23..22d9f73 100644
+	index $before..$after 100644
 	--- a/x
 	+++ b/x
 	@@ -1,6 +1,6 @@
@@ -132,9 +136,9 @@ test_expect_success 'another test, without options' '
 	git diff -b --ignore-cr-at-eol >out &&
 	test_cmp expect out &&
 
-	tr "Q_" "\015 " <<-\EOF >expect &&
+	tr "Q_" "\015 " <<-EOF >expect &&
 	diff --git a/x b/x
-	index d99af23..22d9f73 100644
+	index $before..$after 100644
 	--- a/x
 	+++ b/x
 	@@ -1,6 +1,6 @@
@@ -154,9 +158,9 @@ test_expect_success 'another test, without options' '
 	git diff --ignore-space-at-eol --ignore-cr-at-eol >out &&
 	test_cmp expect out &&
 
-	tr "Q_" "\015 " <<-\EOF >expect &&
+	tr "Q_" "\015 " <<-EOF >expect &&
 	diff --git a/x b/x
-	index_d99af23..22d9f73 100644
+	index_$before..$after 100644
 	--- a/x
 	+++ b/x
 	@@ -1,6 +1,6 @@
@@ -786,23 +790,25 @@ test_expect_success 'whitespace-only changes not reported' '
 	test_must_be_empty actual
 '
 
-cat <<EOF >expect
-diff --git a/x b/z
-similarity index NUM%
-rename from x
-rename to z
-index 380c32a..a97b785 100644
-EOF
 test_expect_success 'whitespace-only changes reported across renames' '
 	git reset --hard &&
 	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
 	git add x &&
+	before=$(git rev-parse --short $(git hash-object x)) &&
 	git commit -m "base" &&
 	sed -e "5s/^/ /" x >z &&
 	git rm x &&
 	git add z &&
+	after=$(git rev-parse --short $(git hash-object z)) &&
 	git diff -w -M --cached |
 	sed -e "/^similarity index /s/[0-9][0-9]*/NUM/" >actual &&
+	cat <<-EOF >expect &&
+	diff --git a/x b/z
+	similarity index NUM%
+	rename from x
+	rename to z
+	index $before..$after 100644
+	EOF
 	test_cmp expect actual
 '
 
@@ -858,13 +864,15 @@ test_expect_success 'diff that introduces a line with only tabs' '
 	git config core.whitespace blank-at-eol &&
 	git reset --hard &&
 	echo "test" >x &&
+	before=$(git rev-parse --short $(git hash-object x)) &&
 	git commit -m "initial" x &&
 	echo "{NTN}" | tr "NT" "\n\t" >>x &&
+	after=$(git rev-parse --short $(git hash-object x)) &&
 	git diff --color | test_decode_color >current &&
 
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
-	<BOLD>index 9daeafb..2874b91 100644<RESET>
+	<BOLD>index $before..$after 100644<RESET>
 	<BOLD>--- a/x<RESET>
 	<BOLD>+++ b/x<RESET>
 	<CYAN>@@ -1 +1,4 @@<RESET>
@@ -883,19 +891,21 @@ test_expect_success 'diff that introduces and removes ws breakages' '
 		echo "0. blank-at-eol " &&
 		echo "1. blank-at-eol "
 	} >x &&
+	before=$(git rev-parse --short $(git hash-object x)) &&
 	git commit -a --allow-empty -m preimage &&
 	{
 		echo "0. blank-at-eol " &&
 		echo "1. still-blank-at-eol " &&
 		echo "2. and a new line "
 	} >x &&
+	after=$(git rev-parse --short $(git hash-object x)) &&
 
 	git diff --color |
 	test_decode_color >current &&
 
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
-	<BOLD>index d0233a2..700886e 100644<RESET>
+	<BOLD>index $before..$after 100644<RESET>
 	<BOLD>--- a/x<RESET>
 	<BOLD>+++ b/x<RESET>
 	<CYAN>@@ -1,2 +1,3 @@<RESET>
@@ -915,16 +925,18 @@ test_expect_success 'ws-error-highlight test setup' '
 		echo "0. blank-at-eol " &&
 		echo "1. blank-at-eol "
 	} >x &&
+	before=$(git rev-parse --short $(git hash-object x)) &&
 	git commit -a --allow-empty -m preimage &&
 	{
 		echo "0. blank-at-eol " &&
 		echo "1. still-blank-at-eol " &&
 		echo "2. and a new line "
 	} >x &&
+	after=$(git rev-parse --short $(git hash-object x)) &&
 
-	cat >expect.default-old <<-\EOF &&
+	cat >expect.default-old <<-EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
-	<BOLD>index d0233a2..700886e 100644<RESET>
+	<BOLD>index $before..$after 100644<RESET>
 	<BOLD>--- a/x<RESET>
 	<BOLD>+++ b/x<RESET>
 	<CYAN>@@ -1,2 +1,3 @@<RESET>
@@ -934,9 +946,9 @@ test_expect_success 'ws-error-highlight test setup' '
 	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
 	EOF
 
-	cat >expect.all <<-\EOF &&
+	cat >expect.all <<-EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
-	<BOLD>index d0233a2..700886e 100644<RESET>
+	<BOLD>index $before..$after 100644<RESET>
 	<BOLD>--- a/x<RESET>
 	<BOLD>+++ b/x<RESET>
 	<CYAN>@@ -1,2 +1,3 @@<RESET>
@@ -946,9 +958,9 @@ test_expect_success 'ws-error-highlight test setup' '
 	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
 	EOF
 
-	cat >expect.none <<-\EOF
+	cat >expect.none <<-EOF
 	<BOLD>diff --git a/x b/x<RESET>
-	<BOLD>index d0233a2..700886e 100644<RESET>
+	<BOLD>index $before..$after 100644<RESET>
 	<BOLD>--- a/x<RESET>
 	<BOLD>+++ b/x<RESET>
 	<CYAN>@@ -1,2 +1,3 @@<RESET>
@@ -1022,14 +1034,15 @@ test_expect_success 'detect moved code, complete file' '
 	EOF
 	git add test.c &&
 	git commit -m "add main function" &&
+	file=$(git rev-parse --short HEAD:test.c) &&
 	git mv test.c main.c &&
 	test_config color.diff.oldMoved "normal red" &&
 	test_config color.diff.newMoved "normal green" &&
 	git diff HEAD --color-moved=zebra --color --no-renames | test_decode_color >actual &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>new file mode 100644<RESET>
-	<BOLD>index 0000000..a986c57<RESET>
+	<BOLD>index 0000000..$file<RESET>
 	<BOLD>--- /dev/null<RESET>
 	<BOLD>+++ b/main.c<RESET>
 	<CYAN>@@ -0,0 +1,5 @@<RESET>
@@ -1040,7 +1053,7 @@ test_expect_success 'detect moved code, complete file' '
 	<BGREEN>+<RESET><BGREEN>}<RESET>
 	<BOLD>diff --git a/test.c b/test.c<RESET>
 	<BOLD>deleted file mode 100644<RESET>
-	<BOLD>index a986c57..0000000<RESET>
+	<BOLD>index $file..0000000<RESET>
 	<BOLD>--- a/test.c<RESET>
 	<BOLD>+++ /dev/null<RESET>
 	<CYAN>@@ -1,5 +0,0 @@<RESET>
@@ -1094,6 +1107,8 @@ test_expect_success 'detect malicious moved code, inside file' '
 	EOF
 	git add main.c test.c &&
 	git commit -m "add main and test file" &&
+	before_main=$(git rev-parse --short HEAD:main.c) &&
+	before_test=$(git rev-parse --short HEAD:test.c) &&
 	cat <<-\EOF >main.c &&
 		#include<stdio.h>
 		int stuff()
@@ -1126,10 +1141,12 @@ test_expect_success 'detect malicious moved code, inside file' '
 			bar();
 		}
 	EOF
+	after_main=$(git rev-parse --short $(git hash-object main.c)) &&
+	after_test=$(git rev-parse --short $(git hash-object test.c)) &&
 	git diff HEAD --no-renames --color-moved=zebra --color | test_decode_color >actual &&
-	cat <<-\EOF >expected &&
+	cat <<-EOF >expected &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
-	<BOLD>index 27a619c..7cf9336 100644<RESET>
+	<BOLD>index $before_main..$after_main 100644<RESET>
 	<BOLD>--- a/main.c<RESET>
 	<BOLD>+++ b/main.c<RESET>
 	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
@@ -1147,7 +1164,7 @@ test_expect_success 'detect malicious moved code, inside file' '
 	 {<RESET>
 	 foo();<RESET>
 	<BOLD>diff --git a/test.c b/test.c<RESET>
-	<BOLD>index 1dc1d85..2bedec9 100644<RESET>
+	<BOLD>index $before_test..$after_test 100644<RESET>
 	<BOLD>--- a/test.c<RESET>
 	<BOLD>+++ b/test.c<RESET>
 	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
@@ -1176,9 +1193,9 @@ test_expect_success 'plain moved code, inside file' '
 	test_config color.diff.newMovedAlternative "yellow" &&
 	# needs previous test as setup
 	git diff HEAD --no-renames --color-moved=plain --color | test_decode_color >actual &&
-	cat <<-\EOF >expected &&
+	cat <<-EOF >expected &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
-	<BOLD>index 27a619c..7cf9336 100644<RESET>
+	<BOLD>index $before_main..$after_main 100644<RESET>
 	<BOLD>--- a/main.c<RESET>
 	<BOLD>+++ b/main.c<RESET>
 	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
@@ -1196,7 +1213,7 @@ test_expect_success 'plain moved code, inside file' '
 	 {<RESET>
 	 foo();<RESET>
 	<BOLD>diff --git a/test.c b/test.c<RESET>
-	<BOLD>index 1dc1d85..2bedec9 100644<RESET>
+	<BOLD>index $before_test..$after_test 100644<RESET>
 	<BOLD>--- a/test.c<RESET>
 	<BOLD>+++ b/test.c<RESET>
 	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
