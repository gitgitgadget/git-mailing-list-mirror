Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39841F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeB0LEn (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:04:43 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:47491 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeB0LEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:04:25 -0500
Received: from lindisfarne.localdomain ([89.242.176.20])
        by smtp.talktalk.net with SMTP
        id qd3QeQ4WdoNnDqd3WeXd0P; Tue, 27 Feb 2018 11:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519729463;
        bh=18Of/AHI+lka3dVQpM8jS33zg8IBCqHOd/wHHZd6Njc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=WRFYagKC0NnSZyjjcxTVmguE7p4ivUJb/N/P4Z2rHmK7Pd7E1stn5MxfPFyHEY8nY
         cojHDazHC95/E+0C2g+PIi8HO+reedk4h1B3cxPJRU2MILrcK1/R0DTHyhegLI49NB
         8BNHNUmgpSaY2tDykPRFp/kdAmcayj9js9bUP+k0=
X-Originating-IP: [89.242.176.20]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=BZXIa/HMvEOrkAULb1ciZg==:117
 a=BZXIa/HMvEOrkAULb1ciZg==:17 a=evINK-nbAAAA:8 a=Ww-nyVToyCJjuUgMjvEA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 0/9] Correct offsets of hunks when one is skipped
Date:   Tue, 27 Feb 2018 11:03:55 +0000
Message-Id: <20180227110404.16816-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180213104408.9887-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLEqCjr4RXM2AlqzOzBVFEPlUFdQ2OCsSShqn1NbAdpglbUZ/cDkvEpNf3ak92Ate0ucdA5UTwPlGqnpk4eZGGePtuGZ/sz8n99tX39s9nOyXs6ljS9/
 IBe0VXxr7IyOqES4eyr0vkaLayGfUvMR9pS0Z9SjPhHdLaV/hn4AHS5M+1VNUFH3QbKIvzN9jzmp+NbHbsW+w6B5NnqvbX8dQI+w603FLvjnzLMVQ2k3WZuD
 o8kys+rkDo4gBz63XoQRxniFNd5Ds24meN18SJMIIyugRAJ9/jKRgyMFrGaMxY+LRZGSCjwbFCVwdrrEeqoMqKXiu4lrBCNIifhCFl+gSfU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've fixed the use of test_set_editor most of which was already in pu
and reworked the sha1 comparisons to rewrite the hashes in the index
lines rather than deleting the index lines.

Cover letter to v1:

While working on a patch series to stage selected lines from a hunk
without having to edit it I got worried that subsequent patches would
be applied in the wrong place which lead to this series to correct the
offsets of hunks following those that are skipped or edited.

Interdiff:

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 0fb9c0e0f1..05540ee9ef 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -10,6 +10,16 @@ then
 	test_done
 fi
 
+diff_cmp () {
+	for x
+	do
+		sed  -e '/^index/s/[0-9a-f]*[1-9a-f][0-9a-f]*\.\./1234567../' \
+		     -e '/^index/s/\.\.[0-9a-f]*[1-9a-f][0-9a-f]*/..9abcdef/' \
+		     "$x" >"$x.filtered"
+	done
+	test_cmp "$1.filtered" "$2.filtered"
+}
+
 test_expect_success 'setup (initial)' '
 	echo content >file &&
 	git add file &&
@@ -24,6 +34,7 @@ test_expect_success 'status works (initial)' '
 test_expect_success 'setup expected' '
 	cat >expected <<-EOF
 	new file mode 100644
+	index 0000000..d95f3ad
 	--- /dev/null
 	+++ b/file
 	@@ -0,0 +1 @@
@@ -33,8 +44,8 @@ test_expect_success 'setup expected' '
 
 test_expect_success 'diff works (initial)' '
 	(echo d; echo 1) | git add -i >output &&
-	sed -ne /^index/d -e "/new file/,/content/p" <output >diff &&
-	test_cmp expected diff
+	sed -ne "/new file/,/content/p" <output >diff &&
+	diff_cmp expected diff
 '
 test_expect_success 'revert works (initial)' '
 	git add file &&
@@ -59,6 +70,7 @@ test_expect_success 'status works (commit)' '
 
 test_expect_success 'setup expected' '
 	cat >expected <<-EOF
+	index 180b47c..b6f2c08 100644
 	--- a/file
 	+++ b/file
 	@@ -1 +1,2 @@
@@ -69,8 +81,8 @@ test_expect_success 'setup expected' '
 
 test_expect_success 'diff works (commit)' '
 	(echo d; echo 1) | git add -i >output &&
-	sed -ne "/^---/,/content/p" <output >diff &&
-	test_cmp expected diff
+	sed -ne "/^index/,/content/p" <output >diff &&
+	diff_cmp expected diff
 '
 test_expect_success 'revert works (commit)' '
 	git add file &&
@@ -88,8 +100,8 @@ test_expect_success 'setup expected' '
 test_expect_success 'dummy edit works' '
 	test_set_editor : &&
 	(echo e; echo a) | git add -p &&
-	git diff | sed /^index/d >diff &&
-	test_cmp expected diff
+	git diff > diff &&
+	diff_cmp expected diff
 '
 
 test_expect_success 'setup patch' '
@@ -103,12 +115,11 @@ test_expect_success 'setup patch' '
 '
 
 test_expect_success 'setup fake editor' '
-	FAKE_EDITOR="$(pwd)/fake-editor.sh" &&
-	write_script "$FAKE_EDITOR" <<-\EOF &&
+	write_script "fake_editor.sh" <<-\EOF &&
 	mv -f "$1" oldpatch &&
 	mv -f patch "$1"
 	EOF
-	test_set_editor "$FAKE_EDITOR"
+	test_set_editor "$(pwd)/fake_editor.sh"
 '
 
 test_expect_success 'bad edit rejected' '
@@ -143,6 +154,7 @@ test_expect_success 'setup patch' '
 test_expect_success 'setup expected' '
 	cat >expected <<-EOF
 	diff --git a/file b/file
+	index b5dd6c9..f910ae9 100644
 	--- a/file
 	+++ b/file
 	@@ -1,4 +1,4 @@
@@ -156,8 +168,8 @@ test_expect_success 'setup expected' '
 
 test_expect_success 'real edit works' '
 	(echo e; echo n; echo d) | git add -p &&
-	git diff | sed /^index/d >output &&
-	test_cmp expected output
+	git diff >output &&
+	diff_cmp expected output
 '
 
 test_expect_success 'skip files similarly as commit -a' '
@@ -165,11 +177,11 @@ test_expect_success 'skip files similarly as commit -a' '
 	echo file >.gitignore &&
 	echo changed >file &&
 	echo y | git add -p file &&
-	git diff | sed /^index/d >output &&
+	git diff >output &&
 	git reset &&
 	git commit -am commit &&
-	git diff | sed /^index/d >expected &&
-	test_cmp expected output &&
+	git diff >expected &&
+	diff_cmp expected output &&
 	git reset --hard HEAD^
 '
 rm -f .gitignore
@@ -214,6 +226,7 @@ test_expect_success 'setup again' '
 # Write the patch file with a new line at the top and bottom
 test_expect_success 'setup patch' '
 	cat >patch <<-EOF
+	index 180b47c..b6f2c08 100644
 	--- a/file
 	+++ b/file
 	@@ -1,2 +1,4 @@
@@ -228,7 +241,7 @@ test_expect_success 'setup patch' '
 # Expected output, diff is similar to the patch but w/ diff at the top
 test_expect_success 'setup expected' '
 	echo diff --git a/file b/file >expected &&
-	cat patch >>expected &&
+	cat patch |sed "/^index/s/ 100644/ 100755/" >>expected &&
 	cat >expected-output <<-EOF
 	--- a/file
 	+++ b/file
@@ -258,8 +271,8 @@ test_expect_success C_LOCALE_OUTPUT 'add first line works' '
 		sed -n -e "s/^Stage this hunk[^@]*\(@@ .*\)/\1/" \
 		       -e "/^[-+@ \\\\]"/p  >output &&
 	test_must_be_empty error &&
-	git diff --cached | sed /^index/d >diff &&
-	test_cmp expected diff &&
+	git diff --cached >diff &&
+	diff_cmp expected diff &&
 	test_cmp expected-output output
 '
 
@@ -267,6 +280,7 @@ test_expect_success 'setup expected' '
 	cat >expected <<-EOF
 	diff --git a/non-empty b/non-empty
 	deleted file mode 100644
+	index d95f3ad..0000000
 	--- a/non-empty
 	+++ /dev/null
 	@@ -1 +0,0 @@
@@ -281,14 +295,15 @@ test_expect_success 'deleting a non-empty file' '
 	git commit -m non-empty &&
 	rm non-empty &&
 	echo y | git add -p non-empty &&
-	git diff --cached | sed /^index/d >diff &&
-	test_cmp expected diff
+	git diff --cached >diff &&
+	diff_cmp expected diff
 '
 
 test_expect_success 'setup expected' '
 	cat >expected <<-EOF
 	diff --git a/empty b/empty
 	deleted file mode 100644
+	index e69de29..0000000
 	EOF
 '
 
@@ -299,8 +314,8 @@ test_expect_success 'deleting an empty file' '
 	git commit -m empty &&
 	rm empty &&
 	echo y | git add -p empty &&
-	git diff --cached | sed /^index/d >diff &&
-	test_cmp expected diff
+	git diff --cached >diff &&
+	diff_cmp expected diff
 '
 
 test_expect_success 'split hunk setup' '
@@ -326,7 +341,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	#    exits.
 	printf "%s\n" s e     q n q q |
 	EDITOR=: git add -p &&
-	git diff | sed /^index/d >actual &&
+	git diff >actual &&
 	! grep "^+15" actual
 '
 
@@ -338,7 +353,7 @@ test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
 	printf "%s\n" s n y e   q n q q |
 	EDITOR=: git add -p 2>error &&
 	test_must_be_empty error &&
-	git diff | sed /^index/d >actual &&
+	git diff >actual &&
 	! grep "^+31" actual
 '
 
@@ -357,14 +372,15 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	cat >expected <<-\EOF &&
 	* Unmerged path conflict.t
 	diff --git a/non-conflict.t b/non-conflict.t
+	index f766221..5ea2ed4 100644
 	--- a/non-conflict.t
 	+++ b/non-conflict.t
 	@@ -1 +1 @@
 	-non-conflict
 	+changed
 	EOF
-	git diff --cached | sed /^index/d >diff &&
-	test_cmp expected diff
+	git diff --cached >diff &&
+	diff_cmp expected diff
 '
 
 test_expect_success TTY 'diffs can be colorized' '
@@ -393,7 +409,7 @@ test_expect_success 'patch-mode via -i prompts for files' '
 
 	echo test >expect &&
 	git diff --cached --name-only >actual &&
-	test_cmp expect actual
+	diff_cmp expect actual
 '
 
 test_expect_success 'add -p handles globs' '
@@ -550,7 +566,6 @@ test_expect_success 'add -p works with pathological context lines' '
 
 test_expect_success 'add -p patch editing works with pathological context lines' '
 	git reset &&
-	test_set_editor "$FAKE_EDITOR" &&
 	# n q q below is in case edit fails
 	printf "%s\n" e y    n q q |
 	git add -p &&

Phillip Wood (9):
  add -i: add function to format hunk header
  t3701: indent here documents
  t3701: use test_write_lines and write_script
  t3701: don't hard code sha1 hash values
  t3701: add failing test for pathological context lines
  add -p: Adjust offsets of subsequent hunks when one is skipped
  add -p: calculate offset delta for edited patches
  add -p: fix counting when splitting and coalescing
  add -p: don't rely on apply's '--recount' option

 git-add--interactive.perl  | 106 +++++++++++++----
 t/t3701-add-interactive.sh | 288 +++++++++++++++++++++++++--------------------
 2 files changed, 240 insertions(+), 154 deletions(-)

-- 
2.16.1

