Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E43B1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 21:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbcFUVdR (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 17:33:17 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:50957 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcFUVcs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 17:32:48 -0400
Received: from hashpling.plus.com ([212.159.69.125]:35829)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1bFSzy-0002SO-I0; Tue, 21 Jun 2016 22:14:18 +0100
From:	Charles Bailey <charles@hashpling.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] grep: fix grepping for "intent to add" files
Date:	Tue, 21 Jun 2016 14:14:12 -0700
Message-Id: <20160621211412.28752-2-charles@hashpling.org>
X-Mailer: git-send-email 2.8.2.311.gee88674
In-Reply-To: <20160621211412.28752-1-charles@hashpling.org>
References: <20160621211412.28752-1-charles@hashpling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Charles Bailey <cbailey32@bloomberg.net>

This reverts commit 4d552005323034c1d6311796ac1074e9a4b4b57e and adds an
alternative fix to maintain the -L --cached behavior.

4d5520053 caused 'git grep' to no longer find matches in new files in
the working tree where the corresponding index entry had the "intent to
add" bit set, despite the fact that these files are tracked.

The content in the index of a file for which the "intent to add" bit is
set is considered indeterminate and not empty. For most grep queries we
want these to behave the same, however for -L --cached (files without a
match) we don't want to respond positively for "intent to add" files as
their contents are indeterminate. This is in contrast to files with
empty contents in the index (no lines implies no matches for any grep
query expression) which should be reported in the output of a grep -L
--cached invocation.

Add tests to cover this case and a few related cases which previously
lacked coverage.

Helped-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---

Is "Helped-by" an appropriate attribution in this case?

Personally, I could have gone either way on the -L --cached
functionality but I know that Duy has put a lot more thought into
"intent-to-add" entries so I trust his judgement.

 builtin/grep.c  |  4 ++--
 t/t7810-grep.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 462e607..ae73831 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -386,7 +386,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 
 	for (nr = 0; nr < active_nr; nr++) {
 		const struct cache_entry *ce = active_cache[nr];
-		if (!S_ISREG(ce->ce_mode) || ce_intent_to_add(ce))
+		if (!S_ISREG(ce->ce_mode))
 			continue;
 		if (!ce_path_match(ce, pathspec, NULL))
 			continue;
@@ -396,7 +396,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 		 * cache version instead
 		 */
 		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
-			if (ce_stage(ce))
+			if (ce_stage(ce) || ce_intent_to_add(ce))
 				continue;
 			hit |= grep_sha1(opt, ce->sha1, ce->name, 0, ce->name);
 		}
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index c4302ed..6c7ccb3 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1364,4 +1364,42 @@ test_expect_success 'grep --color -e A --and -e B -p with context' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep can find things only in the work tree' '
+	touch work-tree-only &&
+	git add work-tree-only &&
+	echo "find in work tree" >work-tree-only &&
+	git grep --quiet "find in work tree" &&
+	test_must_fail git grep --quiet --cached "find in work tree" &&
+	test_must_fail git grep --quiet "find in work tree" HEAD &&
+	git rm -f work-tree-only
+'
+
+test_expect_success 'grep can find things only in the work tree (i-t-a)' '
+	echo "intend to add this" >intend-to-add &&
+	git add -N intend-to-add &&
+	git grep --quiet "intend to add this" &&
+	test_must_fail git grep --quiet --cached "intend to add this" &&
+	test_must_fail git grep --quiet "intend to add this" HEAD &&
+	git rm -f intend-to-add
+'
+
+test_expect_success 'grep can find things only in the index' '
+	echo "only in the index" >cache-this &&
+	git add cache-this &&
+	rm cache-this &&
+	test_must_fail git grep --quiet "only in the index" &&
+	git grep --quiet --cached "only in the index" &&
+	test_must_fail git grep --quiet "only in the index" HEAD &&
+	git rm --cached cache-this
+'
+
+test_expect_success 'grep does not report i-t-a with -L --cached' '
+	echo "intend to add this" >intend-to-add &&
+	git add -N intend-to-add &&
+	git ls-files | grep -v "^intend-to-add\$" >expected &&
+	git grep -L --cached "nonexistent_string" >actual &&
+	test_cmp expected actual &&
+	git rm -f intend-to-add
+'
+
 test_done
-- 
2.8.2.311.gee88674

