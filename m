Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD1AC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325022070E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbgFWPZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:25:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:40208 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732878AbgFWPZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:25:09 -0400
Received: (qmail 11910 invoked by uid 109); 23 Jun 2020 15:25:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 15:25:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17020 invoked by uid 111); 23 Jun 2020 15:25:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 11:25:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 11:25:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 10/10] fast-export: anonymize "master" refname
Message-ID: <20200623152507.GJ1435482@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623152436.GA50925@coredump.intra.peff.net>
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

Now that we can ask fast-export to retain particular tokens, we have a
much better tool for the first one (because it works for any ref, not
just master).

For the second, the notion of "default branch name" is likely to become
configurable soon, at which point the name _does_ leak information.
Let's drop this special case in preparation.

Note that we have to adjust the test a bit, since it relied on using the
name "master" in the anonymized repos. We could just use
--seed-anonymized=master to keep the same output, but then we wouldn't
know if it works because of our hard-coded master or because of the
seeding.

So let's flip the test a bit, and confirm that we anonymize "master",
but keep "other" in the output.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c            |  7 -------
 t/t9351-fast-export-anonymize.sh | 12 +++++++-----
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index ef82497bbf..7e0e1770cf 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -538,13 +538,6 @@ static const char *anonymize_refname(const char *refname)
 	static struct strbuf anon = STRBUF_INIT;
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
index d84eec9bab..6e2041865c 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -22,6 +22,7 @@ test_expect_success 'export anonymized stream' '
 	git fast-export --anonymize --all \
 		--seed-anonymized=retain-me \
 		--seed-anonymized=xyzzy:custom-name \
+		--seed-anonymized=other \
 		>stream
 '
 
@@ -45,12 +46,12 @@ test_expect_success 'stream omits gitlink oids' '
 	! grep a000000000000000000 stream
 '
 
-test_expect_success 'stream allows master as refname' '
-	grep master stream
+test_expect_success 'stream retains other as refname' '
+	grep other stream
 '
 
 test_expect_success 'stream omits other refnames' '
-	! grep other stream &&
+	! grep master stream &&
 	! grep mytag stream
 '
 
@@ -76,15 +77,16 @@ test_expect_success 'import stream to new repository' '
 test_expect_success 'result has two branches' '
 	git for-each-ref --format="%(refname)" refs/heads >branches &&
 	test_line_count = 2 branches &&
-	other_branch=$(grep -v refs/heads/master branches)
+	other_branch=refs/heads/other &&
+	main_branch=$(grep -v $other_branch branches)
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
2.27.0.517.gbc32778fa3
