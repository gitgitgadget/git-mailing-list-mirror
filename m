Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9025C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 10:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9988764E7A
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 10:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhBIKzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:55:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:54562 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232035AbhBIKxg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 05:53:36 -0500
Received: (qmail 26006 invoked by uid 109); 9 Feb 2021 10:52:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Feb 2021 10:52:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4095 invoked by uid 111); 9 Feb 2021 10:52:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Feb 2021 05:52:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Feb 2021 05:52:45 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/2] t: add --no-tag option to test_commit
Message-ID: <YCJpfYJqevvqBj1D@coredump.intra.peff.net>
References: <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the conveniences that test_commit offers is making a tag for each
commit. This makes it easy to refer to the commits in subsequent
commands. But it can also be a pain if you care about reachability,
because those tags keep the commits reachable even if they are rewound
from the branch they're made on.

The alternative is that scripts have to call test_tick, git-add, and
git-commit themselves. Let's add a --no-tag option to give them the
one-liner convenience of using test_commit.

This is in preparation for the next patch, which will add some more
calls. But I cleaned up an existing site to show off the feature. There
are probably more cleanups possible.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4208-log-magic-pathspec.sh | 9 ++-------
 t/test-lib-functions.sh       | 9 ++++++++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 5e10136e9a..7f0c1dcc0f 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -31,13 +31,8 @@ test_expect_success '"git log :/a -- " should not be ambiguous' '
 test_expect_success '"git log :/detached -- " should find a commit only in HEAD' '
 	test_when_finished "git checkout main" &&
 	git checkout --detach &&
-	# Must manually call `test_tick` instead of using `test_commit`,
-	# because the latter additionally creates a tag, which would make
-	# the commit reachable not only via HEAD.
-	test_tick &&
-	git commit --allow-empty -m detached &&
-	test_tick &&
-	git commit --allow-empty -m something-else &&
+	test_commit --no-tag detached &&
+	test_commit --no-tag something-else &&
 	git log :/detached --
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6bca002316..1587241ba0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -202,6 +202,7 @@ test_commit () {
 	author= &&
 	signoff= &&
 	indir= &&
+	no_tag= &&
 	while test $# != 0
 	do
 		case "$1" in
@@ -222,6 +223,9 @@ test_commit () {
 			indir="$2"
 			shift
 			;;
+		--no-tag)
+			no_tag=yes
+			;;
 		*)
 			break
 			;;
@@ -244,7 +248,10 @@ test_commit () {
 	git ${indir:+ -C "$indir"} commit \
 	    ${author:+ --author "$author"} \
 	    $signoff -m "$1" &&
-	git ${indir:+ -C "$indir"} tag "${4:-$1}"
+	if test -z "$no_tag"
+	then
+		git ${indir:+ -C "$indir"} tag "${4:-$1}"
+	fi
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
2.30.1.887.ge7d57fcab0

