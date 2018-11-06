Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3830C1F454
	for <e@80x24.org>; Tue,  6 Nov 2018 07:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeKFRQL (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 12:16:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:41842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729160AbeKFRQL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 12:16:11 -0500
Received: (qmail 17831 invoked by uid 109); 6 Nov 2018 07:52:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 07:52:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29124 invoked by uid 111); 6 Nov 2018 07:51:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 02:51:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 02:52:13 -0500
Date:   Tue, 6 Nov 2018 02:52:13 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Felix Eckhofer <felix@eckhofer.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] pull: handle --verify-signatures for unborn branch
Message-ID: <20181106075212.GC22021@sigill.intra.peff.net>
References: <20181106074910.GA31978@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181106074910.GA31978@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We usually just forward the --verify-signatures option along to
git-merge, and trust it to do the right thing. However, when we are on
an unborn branch (i.e., there is no HEAD yet), we handle this case
ourselves without even calling git-merge. And in this code path, we do
not respect the verification option at all.

It may be more maintainable in the long run to call git-merge for the
unborn case. That would fix this bug, as well as prevent similar ones in
the future. But unfortunately it's not easy to do. As t5520.3
demonstrates, there are some special cases that git-merge does not
handle, like "git pull .. master:master" (by the time git-merge is
invoked, we've overwritten the unborn HEAD).

So for now let's just teach git-pull to handle this feature.

Reported-by: Felix Eckhofer <felix@eckhofer.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pull.c                    | 11 +++++++++++
 t/t5573-pull-verify-signatures.sh |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 798ecf7faf..91616cf7d6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -557,6 +557,17 @@ static int run_fetch(const char *repo, const char **refspecs)
 static int pull_into_void(const struct object_id *merge_head,
 		const struct object_id *curr_head)
 {
+	if (opt_verify_signatures) {
+		struct commit *commit;
+
+		commit = lookup_commit(the_repository, merge_head);
+		if (!commit)
+			die(_("unable to access commit %s"),
+			    oid_to_hex(merge_head));
+
+		verify_merge_signature(commit, opt_verbosity);
+	}
+
 	/*
 	 * Two-way merge: we treat the index as based on an empty tree,
 	 * and try to fast-forward to HEAD. This ensures we will not lose
diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
index 747775c147..3e9876e197 100755
--- a/t/t5573-pull-verify-signatures.sh
+++ b/t/t5573-pull-verify-signatures.sh
@@ -78,4 +78,11 @@ test_expect_success GPG 'pull commit with bad signature with --no-verify-signatu
 	git pull --ff-only --no-verify-signatures bad 2>pullerror
 '
 
+test_expect_success GPG 'pull unsigned commit into unborn branch' '
+	git init empty-repo &&
+	test_must_fail \
+		git -C empty-repo pull --verify-signatures ..  2>pullerror &&
+	test_i18ngrep "does not have a GPG signature" pullerror
+'
+
 test_done
-- 
2.19.1.1533.g982fead9fb
