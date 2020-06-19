Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D80C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD7220DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbgFSN0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:26:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:37146 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgFSN0m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 09:26:42 -0400
Received: (qmail 2713 invoked by uid 109); 19 Jun 2020 13:26:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Jun 2020 13:26:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14631 invoked by uid 111); 19 Jun 2020 13:26:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jun 2020 09:26:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Jun 2020 09:26:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] fast-export: anonymize "master" refname
Message-ID: <20200619132640.GB2540774@coredump.intra.peff.net>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619132304.GA2540657@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running "fast-export --anonymize" will leave "refs/heads/master"
untouched in the output, for two reasons:

  - it helped to have some known reference point between the original
    and anonymized repository

  - since it's historically the default branch name, it doesn't leak any
    information

Now that we can ask fast-export to dump the anonymized ref mapping, we
have a much better tool for the first one (because it works for _any_
ref, not just master).

For the second, the notion of "default branch name" is likely to become
configurable soon, at which point the name _does_ leak information.
Let's drop this special case in preparation.

Note that we have to adjust the test a bit, since it relied on using the
name "master" in the anonymized repos. But this gives us a good
opportunity to further test the new dumping feature.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c            |  7 -------
 t/t9351-fast-export-anonymize.sh | 16 ++++++----------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 6caea6f290..cd0174d514 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -547,13 +547,6 @@ static const char *anonymize_refname(const char *refname)
 	const char *full_refname = refname;
 	int i;
 
-	/*
-	 * We also leave "master" as a special case, since it does not reveal
-	 * anything interesting.
-	 */
-	if (!strcmp(refname, "refs/heads/master"))
-		return refname;
-
 	strbuf_reset(&anon);
 	for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
 		if (skip_prefix(refname, prefixes[i], &refname)) {
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 0c5dd2a4fb..88847b0f60 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -26,11 +26,8 @@ test_expect_success 'stream omits path names' '
 	! grep xyzzy stream
 '
 
-test_expect_success 'stream allows master as refname' '
-	grep master stream
-'
-
-test_expect_success 'stream omits other refnames' '
+test_expect_success 'stream omits refnames' '
+	! grep master stream &&
 	! grep other stream &&
 	! grep mytag stream
 '
@@ -52,9 +49,7 @@ test_expect_success 'refname mapping can be dumped' '
 	# we make no guarantees of the exact anonymized names,
 	# so just check that we have the right number and
 	# that a sample line looks sane.
-	# Note that master is not anonymized, and so not included
-	# in the mapping.
-	test_line_count = 6 refs.out &&
+	test_line_count = 7 refs.out &&
 	grep "^refs/heads/other refs/heads/" refs.out
 '
 
@@ -69,15 +64,16 @@ test_expect_success 'import stream to new repository' '
 test_expect_success 'result has two branches' '
 	git for-each-ref --format="%(refname)" refs/heads >branches &&
 	test_line_count = 2 branches &&
-	other_branch=$(grep -v refs/heads/master branches)
+	main_branch=$(sed -ne "s,refs/heads/master ,,p" ../refs.out) &&
+	other_branch=$(sed -ne "s,refs/heads/other ,,p" ../refs.out)
 '
 
 test_expect_success 'repo has original shape and timestamps' '
 	shape () {
 		git log --format="%m %ct" --left-right --boundary "$@"
 	} &&
 	(cd .. && shape master...other) >expect &&
-	shape master...$other_branch >actual &&
+	shape $main_branch...$other_branch >actual &&
 	test_cmp expect actual
 '
 
-- 
2.27.0.480.g4f98dbcb10

