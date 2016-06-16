Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.5 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB74C1FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 07:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbcFPHCd (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 03:02:33 -0400
Received: from avasout06.plus.net ([212.159.14.18]:53233 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbcFPHCc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 03:02:32 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jun 2016 03:02:31 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id 7JtQ1t0032iA9hg01JtR1i; Thu, 16 Jun 2016 07:53:29 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=Rr04V3SK c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=BNFp--SqAAAA:8 a=TSbVqHtbAAAA:8 a=pWMgPhmuWYeNdMPjUCoA:9
 a=CjuIK1q_8ugA:10 a=wCHOS_8tIzIYXQCUOVd6:22 a=NJcUIoPEKLAEIzHnl83t:22
Received: from charles by hashpling.plus.com with local (Exim 4.84_2)
	(envelope-from <charles@hashpling.org>)
	id 1bDRB6-0004D3-JA; Thu, 16 Jun 2016 07:53:24 +0100
Date:	Thu, 16 Jun 2016 07:53:24 +0100
From:	Charles Bailey <charles@hashpling.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] grep: fix grepping for "intent to add" files
Message-ID: <20160616065324.GA14967@hashpling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Charles Bailey <cbailey32@bloomberg.net>

This reverts commit 4d552005323034c1d6311796ac1074e9a4b4b57e.

This commit caused 'git grep' to no longer find matches in new files in
the working tree where the corresponding index entry had the "intent to
add" bit set.

Add tests to cover this case and a few related cases which previously
lacked coverage.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---

Originally discussed:

http://thread.gmane.org/gmane.comp.version-control.git/272363/focus=276358

http://thread.gmane.org/gmane.comp.version-control.git/283001/focus=283002

Unless I've misunderstood the conversation and commit message, the
referenced commit was supposed to be a "code as a comment" commit with
no change in observable behavior however a user was surprised that 'git
grep' couldn't find something that regular grep could, despite the file
being tracked - albeit new and "intended to add".

 builtin/grep.c  |  2 +-
 t/t7810-grep.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 462e607..d5aacba 100644
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
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1e72971..eae731a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1364,4 +1364,33 @@ test_expect_success 'grep --color -e A --and -e B -p with context' '
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
 test_done
-- 
2.8.2.311.gee88674

