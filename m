Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA5FC83F14
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 22:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbjH3Wi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 18:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjH3Wi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 18:38:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE39CFE
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 15:38:14 -0700 (PDT)
Received: (qmail 19583 invoked by uid 109); 30 Aug 2023 19:51:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Aug 2023 19:51:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29761 invoked by uid 111); 30 Aug 2023 19:51:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Aug 2023 15:51:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Aug 2023 15:51:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] ci: deprecate ci/config/allow-ref script
Message-ID: <20230830195132.GB1709824@coredump.intra.peff.net>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830194919.GA1709446@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have the CI_BRANCHES mechanism, there is no need for anybody
to use the ci/config/allow-ref mechanism. In the long run, we can
hopefully remove it and the whole "config" job, as it consumes CPU and
adds to the end-to-end latency of the whole workflow. But we don't want
to do that immediately, as people need time to migrate until the
CI_BRANCHES change has made it into the workflow file of every branch.

So let's issue a warning, which will appear in the "annotations" section
below the workflow result in GitHub's web interface. And let's remove
the sample allow-refs script, as we don't want to encourage anybody to
use it.

Signed-off-by: Jeff King <peff@peff.net>
---
 .github/workflows/main.yml |  9 ++++++---
 ci/config/allow-ref.sample | 27 ---------------------------
 2 files changed, 6 insertions(+), 30 deletions(-)
 delete mode 100755 ci/config/allow-ref.sample

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c364abb8f8..dcf7d78f1d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -44,10 +44,13 @@ jobs:
         name: check whether CI is enabled for ref
         run: |
           enabled=yes
-          if test -x config-repo/ci/config/allow-ref &&
-             ! config-repo/ci/config/allow-ref '${{ github.ref }}'
+          if test -x config-repo/ci/config/allow-ref
           then
-            enabled=no
+            echo "::warning::ci/config/allow-ref is deprecated; use CI_BRANCHES instead"
+            if ! config-repo/ci/config/allow-ref '${{ github.ref }}'
+            then
+              enabled=no
+            fi
           fi
 
           skip_concurrent=yes
diff --git a/ci/config/allow-ref.sample b/ci/config/allow-ref.sample
deleted file mode 100755
index af0e076f8a..0000000000
--- a/ci/config/allow-ref.sample
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/sh
-#
-# Sample script for enabling/disabling GitHub Actions CI runs on
-# particular refs. By default, CI is run for all branches pushed to
-# GitHub. You can override this by dropping the ".sample" from the script,
-# editing it, committing, and pushing the result to the "ci-config" branch of
-# your repository:
-#
-#   git checkout -b ci-config
-#   cp allow-ref.sample allow-ref
-#   $EDITOR allow-ref
-#   git add allow-ref
-#   git commit -am "implement my ci preferences"
-#   git push
-#
-# This script will then be run when any refs are pushed to that repository. It
-# gets the fully qualified refname as the first argument, and should exit with
-# success only for refs for which you want to run CI.
-
-case "$1" in
-# allow one-off tests by pushing to "for-ci" or "for-ci/mybranch"
-refs/heads/for-ci*) true ;;
-# always build your integration branch
-refs/heads/my-integration-branch) true ;;
-# don't build any other branches or tags
-*) false ;;
-esac
-- 
2.42.0.528.g5e092cb179
