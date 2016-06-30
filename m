Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4801F744
	for <e@80x24.org>; Thu, 30 Jun 2016 10:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbcF3Ktr (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 06:49:47 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:35507 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbcF3Ktp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 06:49:45 -0400
Received: from hashpling.plus.com ([212.159.69.125]:46418)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1bIYyo-0007aJ-D6; Thu, 30 Jun 2016 11:13:54 +0100
From:	Charles Bailey <charles@hashpling.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/3] grep: fix grepping for "intent to add" files
Date:	Thu, 30 Jun 2016 11:13:48 +0100
Message-Id: <20160630101348.15665-4-charles@hashpling.org>
X-Mailer: git-send-email 2.8.2.311.gee88674
In-Reply-To: <20160630101348.15665-1-charles@hashpling.org>
References: <20160630101348.15665-1-charles@hashpling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Charles Bailey <cbailey32@bloomberg.net>

This reverts commit 4d5520053 (grep: make it clear i-t-a entries are
ignored, 2015-12-27) and adds an alternative fix to maintain the -L
--cached behavior.

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
 builtin/grep.c  |  4 ++--
 t/t7810-grep.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 2 deletions(-)

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
index 6e6eaa4..c18e954 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1364,4 +1364,62 @@ test_expect_success 'grep --color -e A --and -e B -p with context' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep can find things only in the work tree' '
+	: >work-tree-only &&
+	git add work-tree-only &&
+	test_when_finished "git rm -f work-tree-only" &&
+	echo "find in work tree" >work-tree-only &&
+	git grep --quiet "find in work tree" &&
+	test_must_fail git grep --quiet --cached "find in work tree" &&
+	test_must_fail git grep --quiet "find in work tree" HEAD
+'
+
+test_expect_success 'grep can find things only in the work tree (i-t-a)' '
+	echo "intend to add this" >intend-to-add &&
+	git add -N intend-to-add &&
+	test_when_finished "git rm -f intend-to-add" &&
+	git grep --quiet "intend to add this" &&
+	test_must_fail git grep --quiet --cached "intend to add this" &&
+	test_must_fail git grep --quiet "intend to add this" HEAD
+'
+
+test_expect_success 'grep does not search work tree with assume unchanged' '
+	echo "intend to add this" >intend-to-add &&
+	git add -N intend-to-add &&
+	git update-index --assume-unchanged intend-to-add &&
+	test_when_finished "git rm -f intend-to-add" &&
+	test_must_fail git grep --quiet "intend to add this" &&
+	test_must_fail git grep --quiet --cached "intend to add this" &&
+	test_must_fail git grep --quiet "intend to add this" HEAD
+'
+
+test_expect_success 'grep can find things only in the index' '
+	echo "only in the index" >cache-this &&
+	git add cache-this &&
+	rm cache-this &&
+	test_when_finished "git rm --cached cache-this" &&
+	test_must_fail git grep --quiet "only in the index" &&
+	git grep --quiet --cached "only in the index" &&
+	test_must_fail git grep --quiet "only in the index" HEAD
+'
+
+test_expect_success 'grep does not report i-t-a with -L --cached' '
+	echo "intend to add this" >intend-to-add &&
+	git add -N intend-to-add &&
+	test_when_finished "git rm -f intend-to-add" &&
+	git ls-files | grep -v "^intend-to-add\$" >expected &&
+	git grep -L --cached "nonexistent_string" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
+	echo "intend to add this" >intend-to-add-assume-unchanged &&
+	git add -N intend-to-add-assume-unchanged &&
+	test_when_finished "git rm -f intend-to-add-assume-unchanged" &&
+	git update-index --assume-unchanged intend-to-add-assume-unchanged &&
+	git ls-files | grep -v "^intend-to-add-assume-unchanged\$" >expected &&
+	git grep -L "nonexistent_string" >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.8.2.311.gee88674

