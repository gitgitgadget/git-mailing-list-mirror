Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A31B207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754576AbcIMDXn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:23:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:42283 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754318AbcIMDXj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:23:39 -0400
Received: (qmail 20261 invoked by uid 109); 13 Sep 2016 03:23:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:23:39 +0000
Received: (qmail 18449 invoked by uid 111); 13 Sep 2016 03:23:49 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:23:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:23:36 -0700
Date:   Mon, 12 Sep 2016 20:23:36 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 06/16] diff: always try to set up the repository
Message-ID: <20160913032336.cur3rrzpgepulqi6@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we see an explicit "--no-index", we do not bother calling
setup_git_directory_gently() at all. This means that we may
miss out on reading repo-specific config.

It's arguable whether this is correct or not. If we were
designing from scratch, making "git diff --no-index"
completely ignore the repository makes some sense. But we
are nowhere near scratch, so let's look at the existing
behavior:

  1. If you're in the top-level of a repository and run an
     explicit "diff --no-index", the config subsystem falls
     back to reading ".git/config", and we will respect repo
     config.

  2. If you're in a subdirectory of a repository, then we
     still try to read ".git/config", but it generally
     doesn't exist. So "diff --no-index" there does not
     respect repo config.

  3. If you have $GIT_DIR set in the environment, we read
     and respect $GIT_DIR/config,

  4. If you run "git diff /tmp/foo /tmp/bar" to get an
     implicit no-index, we _do_ run the repository setup,
     and set $GIT_DIR (or respect an existing $GIT_DIR
     variable). We find the repo config no matter where we
     started, and respect it.

So we already respect the repository config in a number of
common cases, and case (2) is the only one that does not.
And at least one of our tests, t4034, depends on case (1)
behaving as it does now (though it is just incidental, not
an explicit test for this behavior).

So let's bring case (2) in line with the others by always
running the repository setup, even with an explicit
"--no-index". We shouldn't need to change anything else, as the
implicit case already handles the prefix.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff.c           |  4 ++--
 t/t4053-diff-no-index.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index a31643c..7f91f6d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -301,9 +301,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	if (!no_index) {
-		prefix = setup_git_directory_gently(&nongit);
+	prefix = setup_git_directory_gently(&nongit);
 
+	if (!no_index) {
 		/*
 		 * Treat git diff with at least one path outside of the
 		 * repo the same as if the command would have been executed
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index e60c951..453e6c3 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -107,4 +107,24 @@ test_expect_success 'diff from repo subdir shows real paths (implicit)' '
 	test_cmp expect actual.head
 '
 
+test_expect_success 'diff --no-index from repo subdir respects config (explicit)' '
+	echo "diff --git ../../non/git/a ../../non/git/b" >expect &&
+	test_config -C repo diff.noprefix true &&
+	test_expect_code 1 \
+		git -C repo/sub \
+		diff --no-index ../../non/git/a ../../non/git/b >actual &&
+	head -n 1 <actual >actual.head &&
+	test_cmp expect actual.head
+'
+
+test_expect_success 'diff --no-index from repo subdir respects config (implicit)' '
+	echo "diff --git ../../non/git/a ../../non/git/b" >expect &&
+	test_config -C repo diff.noprefix true &&
+	test_expect_code 1 \
+		git -C repo/sub \
+		diff ../../non/git/a ../../non/git/b >actual &&
+	head -n 1 <actual >actual.head &&
+	test_cmp expect actual.head
+'
+
 test_done
-- 
2.10.0.230.g6f8d04b

