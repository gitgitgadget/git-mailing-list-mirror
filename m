Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A9FC433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90387227C3
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 15:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbhAJP31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 10:29:27 -0500
Received: from mail.aerusso.net ([104.225.219.13]:56200 "EHLO mail.aerusso.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbhAJP31 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 10:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aerusso.net; s=default;
        t=1610292525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QLxp/GCXVzzT4RbYYjrcij+jI1ZGzaP0PbvWh8VnyY=;
        b=G0tnj6WM5M60B4taEkHO9PAwYQvTrL77Yrj8E5VZlxghTEbGUJBaHeLqX39AG9VVCc2F0O
        Sp2zFTmeQyguky3MNf/rmn4uMQ+AzrIliYHQ88mdGl/ZLTwF5Pt3ZlY19SuqEkqLe5Pqqs
        j6u6clkB1NdckWGfkNFs4FJuhbzgtq7y+IE0bYCwMr2Yza1JHCNsV4bEVMlnPRufqInEbT
        jol/+UCnselX1fplGvjfQbc2NfXv8SazoyHYKRJ4F3aDvoQhqHb43pY35TNba/Kb99sxES
        +rP8wGRf0YoIRw7j20KoFO2gTH382rQiHE54N/6NqwiOozsUJn+yKyrT8MrR7Q==
Subject: [PATCH v2] t6016: move to lib-log-graph.sh framework
From:   Antonio Russo <aerusso@aerusso.net>
To:     git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <6dc37f6b-1afd-544d-126e-2be9422571c6@aerusso.net>
Message-ID: <82785993-0393-4db0-a089-d1633e5d1374@aerusso.net>
Date:   Sun, 10 Jan 2021 08:28:22 -0700
MIME-Version: 1.0
In-Reply-To: <6dc37f6b-1afd-544d-126e-2be9422571c6@aerusso.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t6016 manually reconstructs git log --graph output by using the reported
commit hashes from `git rev-parse`.  Each tag is converted into an
environment variable manually, and then `echo`-ed to an expected output
file, which is in turn compared to the actual output.

The expected output is difficult to read and write, because, e.g.,
each line of output must be prefaced with echo, quoted, and properly
escaped.  Additionally, the test is sensitive to trailing whitespace,
which may potentially be removed from graph log output in the future.

In order to reduce duplication, ease troubleshooting of failed tests by
improving readability, and ease the addition of more tests to this file,
port the operations to `lib-log-graph.sh`, which is already used in
several other tests, e.g., t4215.  Give all merges a simple commit
message, and use a common `check_graph` macro taking a heredoc of the
expected output which does not required extensive escaping.

All commits, including merges, continue to be tagged, even if they are
immediately deleted, in order to exercise the exact same logic, i.e. in
`--all`, `--simplify-by-decoration`, and `git tag -d`.

Signed-off-by: Antonio Russo <aerusso@aerusso.net>
---
 t/t6016-rev-list-graph-simplify-history.sh | 354 ++++++++++-----------
 1 file changed, 167 insertions(+), 187 deletions(-)

I did not try to factor this commit into two since I did not hear any
strong opinions in favor of that.

diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index f5e6e92f5b..f79df8b6d1 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -8,6 +8,12 @@
 test_description='--graph and simplified history'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-log-graph.sh
+
+check_graph () {
+	cat >expect &&
+	lib_test_cmp_graph --format=%s "$@"
+}
 
 test_expect_success 'set up rev-list --graph test' '
 	# 3 commits on branch A
@@ -28,7 +34,7 @@ test_expect_success 'set up rev-list --graph test' '
 
 	# Octopus merge B and C into branch A
 	git checkout A &&
-	git merge B C &&
+	git merge B C -m A4 &&
 	git tag A4 &&
 
 	test_commit A5 bar.txt &&
@@ -38,81 +44,64 @@ test_expect_success 'set up rev-list --graph test' '
 	test_commit C3 foo.txt &&
 	test_commit C4 bar.txt &&
 	git checkout A &&
-	git merge -s ours C &&
+	git merge -s ours C -m A6 &&
 	git tag A6 &&
 
-	test_commit A7 bar.txt &&
-
-	# Store commit names in variables for later use
-	A1=$(git rev-parse --verify A1) &&
-	A2=$(git rev-parse --verify A2) &&
-	A3=$(git rev-parse --verify A3) &&
-	A4=$(git rev-parse --verify A4) &&
-	A5=$(git rev-parse --verify A5) &&
-	A6=$(git rev-parse --verify A6) &&
-	A7=$(git rev-parse --verify A7) &&
-	B1=$(git rev-parse --verify B1) &&
-	B2=$(git rev-parse --verify B2) &&
-	C1=$(git rev-parse --verify C1) &&
-	C2=$(git rev-parse --verify C2) &&
-	C3=$(git rev-parse --verify C3) &&
-	C4=$(git rev-parse --verify C4)
-	'
+	test_commit A7 bar.txt
+'
 
 test_expect_success '--graph --all' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "| |   " >> expected &&
-	echo "|  \\  " >> expected &&
-	echo "*-. | $A4" >> expected &&
-	echo "|\\ \\| " >> expected &&
-	echo "| | * $C2" >> expected &&
-	echo "| | * $C1" >> expected &&
-	echo "| * | $B2" >> expected &&
-	echo "| * | $B1" >> expected &&
-	echo "* | | $A3" >> expected &&
-	echo "| |/  " >> expected &&
-	echo "|/|   " >> expected &&
-	echo "* | $A2" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --all > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	| * C3
+	* | A5
+	| |
+	|  \
+	*-. | A4
+	|\ \|
+	| | * C2
+	| | * C1
+	| * | B2
+	| * | B1
+	* | | A3
+	| |/
+	|/|
+	* | A2
+	|/
+	* A1
+	EOF
+'
 
 # Make sure the graph_is_interesting() code still realizes
 # that undecorated merges are interesting, even with --simplify-by-decoration
 test_expect_success '--graph --simplify-by-decoration' '
-	rm -f expected &&
 	git tag -d A4 &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "| |   " >> expected &&
-	echo "|  \\  " >> expected &&
-	echo "*-. | $A4" >> expected &&
-	echo "|\\ \\| " >> expected &&
-	echo "| | * $C2" >> expected &&
-	echo "| | * $C1" >> expected &&
-	echo "| * | $B2" >> expected &&
-	echo "| * | $B1" >> expected &&
-	echo "* | | $A3" >> expected &&
-	echo "| |/  " >> expected &&
-	echo "|/|   " >> expected &&
-	echo "* | $A2" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --all --simplify-by-decoration > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all --simplify-by-decoration <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	| * C3
+	* | A5
+	| |
+	|  \
+	*-. | A4
+	|\ \|
+	| | * C2
+	| | * C1
+	| * | B2
+	| * | B1
+	* | | A3
+	| |/
+	|/|
+	* | A2
+	|/
+	* A1
+	EOF
+'
 
 test_expect_success 'setup: get rid of decorations on B' '
 	git tag -d B2 &&
@@ -122,142 +111,133 @@ test_expect_success 'setup: get rid of decorations on B' '
 
 # Graph with branch B simplified away
 test_expect_success '--graph --simplify-by-decoration prune branch B' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "* | $A4" >> expected &&
-	echo "|\\| " >> expected &&
-	echo "| * $C2" >> expected &&
-	echo "| * $C1" >> expected &&
-	echo "* | $A3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --simplify-by-decoration --all > actual &&
-	test_cmp expected actual
-	'
+	check_graph --simplify-by-decoration --all <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	| * C3
+	* | A5
+	* | A4
+	|\|
+	| * C2
+	| * C1
+	* | A3
+	|/
+	* A2
+	* A1
+	EOF
+'
 
 test_expect_success '--graph --full-history -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "* | $A4" >> expected &&
-	echo "|\\| " >> expected &&
-	echo "* | $A3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	git rev-list --graph --full-history --all -- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --full-history --all -- bar.txt <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* | A5
+	* | A4
+	|\|
+	* | A3
+	|/
+	* A2
+	EOF
+'
 
 test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "* | $A3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	git rev-list --graph --full-history --simplify-merges --all \
-		-- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --full-history --simplify-merges --all -- bar.txt <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* | A5
+	* | A3
+	|/
+	* A2
+	EOF
+'
 
 test_expect_success '--graph -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "* $A3" >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	git rev-list --graph --all -- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all -- bar.txt <<-\EOF
+	* A7
+	* A5
+	* A3
+	| * C4
+	|/
+	* A2
+	EOF
+'
 
 test_expect_success '--graph --sparse -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "* $A6" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "* $A4" >> expected &&
-	echo "* $A3" >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "| * $C2" >> expected &&
-	echo "| * $C1" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --sparse --all -- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --sparse --all -- bar.txt <<-\EOF
+	* A7
+	* A6
+	* A5
+	* A4
+	* A3
+	| * C4
+	| * C3
+	| * C2
+	| * C1
+	|/
+	* A2
+	* A1
+	EOF
+'
 
 test_expect_success '--graph ^C4' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "* $A6" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "*   $A4" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $B2" >> expected &&
-	echo "| * $B1" >> expected &&
-	echo "* $A3" >> expected &&
-	git rev-list --graph --all ^C4 > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all ^C4 <<-\EOF
+	* A7
+	* A6
+	* A5
+	*   A4
+	|\
+	| * B2
+	| * B1
+	* A3
+	EOF
+'
 
 test_expect_success '--graph ^C3' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "*   $A4" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $B2" >> expected &&
-	echo "| * $B1" >> expected &&
-	echo "* $A3" >> expected &&
-	git rev-list --graph --all ^C3 > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all ^C3 <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* A5
+	*   A4
+	|\
+	| * B2
+	| * B1
+	* A3
+	EOF
+'
 
 # I don't think the ordering of the boundary commits is really
 # that important, but this test depends on it.  If the ordering ever changes
 # in the code, we'll need to update this test.
 test_expect_success '--graph --boundary ^C3' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "| |     " >> expected &&
-	echo "|  \\    " >> expected &&
-	echo "*-. \\   $A4" >> expected &&
-	echo "|\\ \\ \\  " >> expected &&
-	echo "| * | | $B2" >> expected &&
-	echo "| * | | $B1" >> expected &&
-	echo "* | | | $A3" >> expected &&
-	echo "o | | | $A2" >> expected &&
-	echo "|/ / /  " >> expected &&
-	echo "o / / $A1" >> expected &&
-	echo " / /  " >> expected &&
-	echo "| o $C3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "o $C2" >> expected &&
-	git rev-list --graph --boundary --all ^C3 > actual &&
-	test_cmp expected actual
-	'
+	check_graph --boundary --all ^C3 <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* | A5
+	| |
+	|  \
+	*-. \   A4
+	|\ \ \
+	| * | | B2
+	| * | | B1
+	* | | | A3
+	o | | | A2
+	|/ / /
+	o / / A1
+	 / /
+	| o C3
+	|/
+	o C2
+	EOF
+'
 
 test_done
-- 
2.30.0

