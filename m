Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846F22023D
	for <e@80x24.org>; Fri,  3 Mar 2017 07:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbdCCHOW (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 02:14:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:37738 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbdCCHOT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 02:14:19 -0500
Received: (qmail 12437 invoked by uid 109); 3 Mar 2017 07:14:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 07:14:04 +0000
Received: (qmail 25446 invoked by uid 111); 3 Mar 2017 07:14:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 02:14:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 02:14:03 -0500
Date:   Fri, 3 Mar 2017 02:14:03 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH] t/perf: use $MODERN_GIT for all repo-copying steps
Message-ID: <20170303071403.2k3vbcdstllq2j3y@sigill.intra.peff.net>
References: <20170228221236.selqkf5wme3fvued@sigill.intra.peff.net>
 <20170302195041.1699-1-jonathantanmy@google.com>
 <20170303064512.khs2seru5onl54mh@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170303064512.khs2seru5onl54mh@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 01:45:12AM -0500, Jeff King wrote:

> I repeated the tests over fbd4a703 given in the commit message of
> ee9a7002fc and confirmed that it behaves the same with your fixed
> version of the test. I did have to tweak a few other things to get the
> test to run against such an old version of git, though. I'll follow-up
> with a patch.

Here's that patch.

-- >8 --
Subject: [PATCH] t/perf: use $MODERN_GIT for all repo-copying steps

Since 1a0962dee (t/perf: fix regression in testing older
versions of git, 2016-06-22), we point "$MODERN_GIT" to a
copy of git that matches the t/perf script itself, and which
can be used for tasks outside of the actual timings. This is
needed because the setup done by perf scripts keeps moving
forward in time, and may use features that the older
versions of git we are testing do not have.

That commit used $MODERN_GIT to fix a case where we relied
on the relatively recent --git-path option. But if you go
back further still, there are more problems.

Since 7501b5921 (perf: make the tests work in worktrees,
2016-05-13), we use "git -C", but versions of git older than
44e1e4d67 (git: run in a directory given with -C option,
2013-09-09) don't know about "-C". So testing an old version
of git with a new version of t/perf will fail the setup
step.

We can fix this by using $MODERN_GIT during the setup;
there's no need to use the antique version, since it doesn't
affect the timings. Likewise, we'll adjust the "init"
invocation; antique versions of git called this "init-db".

Signed-off-by: Jeff King <peff@peff.net>
---
With this patch I was able to run p0001 against v1.7.0. I don't think we
can go further back than that because the perf library depends on the
presence of bin-wrappers. That's probably enough. Unlike the t/interop
library I proposed recently it's not that interesting to go really far
back in time (and I did hack around the bin-wrappers thing in t/interop;
you really can test against v1.0.0 there).

 t/perf/perf-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 46f08ee08..ab4b8b06a 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -83,7 +83,7 @@ test_perf_create_repo_from () {
 	error "bug in the test script: not 2 parameters to test-create-repo"
 	repo="$1"
 	source="$2"
-	source_git="$(git -C "$source" rev-parse --git-dir)"
+	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
 	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
 	mkdir -p "$repo/.git"
 	(
@@ -102,7 +102,7 @@ test_perf_create_repo_from () {
 	) &&
 	(
 		cd "$repo" &&
-		git init -q && {
+		"$MODERN_GIT" init -q && {
 			test_have_prereq SYMLINKS ||
 			git config core.symlinks false
 		} &&
-- 
2.12.0.385.gdf4947bc7

