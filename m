Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A3BC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B12C2083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 16:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgEGQUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 12:20:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:40458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726701AbgEGQUO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 12:20:14 -0400
Received: (qmail 643 invoked by uid 109); 7 May 2020 16:20:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 16:20:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19076 invoked by uid 111); 7 May 2020 16:20:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 12:20:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 12:20:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] ci: allow per-branch config for GitHub Actions
Message-ID: <20200507162011.GA3638906@coredump.intra.peff.net>
References: <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505210451.GA645290@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 05:04:51PM -0400, Jeff King wrote:

> Subject: [PATCH] ci: allow per-branch config for GitHub Actions

Here's a "v2" of that patch based on the discussion.

I think it smooths some of the rough edges of the orphan-branch
approach, while still having a cost on par with other suggestions (or at
least ones that truly allow any config; we can check for "for-ci/**" or
something very cheaply, but that implies hard-coding it for everybody).
I think the cost here is acceptable, and it gives us room to add more
features in the future.

If Actions eventually adds per-repo variable storage that can be used in
"if:" conditionals, then we could eventually switch to that. :)

The documentation here should be enough to let people work with it. But
we'd probably want to take Danh's patch to mention Actions in
SubmittingPatches on top (and it possibly could be modified to point to
the ci/config directory).

-- >8 --
Subject: [PATCH] ci: allow per-branch config for GitHub Actions

Depending on the workflows of individual developers, it can either be
convenient or annoying that our GitHub Actions CI jobs are run on every
branch. As an example of annoying: if you carry many half-finished
work-in-progress branches and rebase them frequently against master,
you'd get tons of failure reports that aren't interesting (not to
mention the wasted CPU).

This commit adds a new job which checks a special branch within the
repository for CI config, and then runs a shell script it finds there to
decide whether to skip the rest of the tests. The default will continue
to run tests for all refs if that branch or script is missing.

There have been a few alternatives discussed:

One option is to carry information in the commit itself about whether it
should be tested, either in the tree itself (changing the workflow YAML
file) or in the commit message (a "[skip ci]" flag or similar). But
these are frustrating and error-prone to use:

  - you have to manually apply them to each branch that you want to mark

  - it's easy for them to leak into other workflows, like emailing patches

We could likewise try to get some information from the branch name. But
that leads to debates about whether the default should be "off" or "on",
and overriding still ends up somewhat awkward. If we default to "on",
you have to remember to name your branches appropriately to skip CI. And
if "off", you end up having to contort your branch names or duplicate
your pushes with an extra refspec.

By comparison, this commit's solution lets you specify your config once
and forget about it, and all of the data is off in its own ref, where it
can be changed by individual forks without touching the main tree.

There were a few design decisions that came out of on-list discussion.
I'll summarize here:

 - we could use GitHub's API to retrieve the config ref, rather than a
   real checkout (and then just operate on it via some javascript). We
   still have to spin up a VM and contact GitHub over the network from
   it either way, so it ends up not being much faster. I opted to go
   with shell to keep things similar to our other tools (and really
   could implement allow-refs in any language you want). This also makes
   it easy to test your script locally, and to modify it within the
   context of a normal git.git tree.

 - we could keep the well-known refname out of refs/heads/ to avoid
   cluttering the branch namespace. But that makes it awkward to
   manipulate. By contrast, you can just "git checkout ci-config" to
   make changes.

 - we could assume the ci-config ref has nothing in it except config
   (i.e., a branch unrelated to the rest of git.git). But dealing with
   orphan branches is awkward. Instead, we'll do our best to efficiently
   check out only the ci/config directory using a shallow partial clone,
   which allows your ci-config branch to be just a normal branch, with
   your config changes on top.

 - we could provide a simpler interface, like a static list of ref
   patterns. But we can't get out of spinning up a whole VM anyway, so
   we might as well use that feature to make the config as flexible as
   possible. If we add more config, we should be able to reuse our
   partial-clone to set more outputs.

Signed-off-by: Jeff King <peff@peff.net>
---
 .github/workflows/main.yml  | 42 +++++++++++++++++++++++++++++++++++++
 ci/config/allow-refs.sample | 26 +++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100755 ci/config/allow-refs.sample

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fd4df939b5..802a4bf7cd 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -6,7 +6,39 @@ env:
   DEVELOPER: 1
 
 jobs:
+  ci-config:
+      runs-on: ubuntu-latest
+      outputs:
+        enabled: ${{ steps.check-ref.outputs.enabled }}
+      steps:
+        - name: try to clone ci-config branch
+          continue-on-error: true
+          run: |
+            git -c protocol.version=2 clone \
+              --no-tags \
+              --single-branch \
+              -b ci-config \
+              --depth 1 \
+              --no-checkout \
+              --filter=blob:none \
+              https://github.com/${{ github.repository }} \
+              config-repo &&
+              cd config-repo &&
+              git checkout HEAD -- ci/config
+        - id: check-ref
+          name: check whether CI is enabled for ref
+          run: |
+            enabled=yes
+            if test -x config-repo/ci/config/allow-ref &&
+               ! config-repo/ci/config/allow-ref '${{ github.ref }}'
+            then
+              enabled=no
+            fi
+            echo "::set-output name=enabled::$enabled"
+
   windows-build:
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
     steps:
     - uses: actions/checkout@v1
@@ -70,6 +102,8 @@ jobs:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   vs-build:
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
     env:
       MSYSTEM: MINGW64
       NO_PERL: 1
@@ -154,6 +188,8 @@ jobs:
                           ${{matrix.nr}} 10 t[0-9]*.sh)
         "@
   regular:
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
     strategy:
       matrix:
         vector:
@@ -189,6 +225,8 @@ jobs:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   dockerized:
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
     strategy:
       matrix:
         vector:
@@ -213,6 +251,8 @@ jobs:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   static-analysis:
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
     env:
       jobname: StaticAnalysis
     runs-on: ubuntu-latest
@@ -221,6 +261,8 @@ jobs:
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
   documentation:
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
     env:
       jobname: Documentation
     runs-on: ubuntu-latest
diff --git a/ci/config/allow-refs.sample b/ci/config/allow-refs.sample
new file mode 100755
index 0000000000..f157f1945a
--- /dev/null
+++ b/ci/config/allow-refs.sample
@@ -0,0 +1,26 @@
+#!/bin/sh
+#
+# Sample script for enabling/disabling GitHub Actions CI runs on
+# particular refs. By default, CI is run for all branches pushed to
+# GitHub. You can override this by dropping the ".sample" from the script,
+# editing it, committing, and pushing the result to the "ci-config" branch of
+# your repository:
+#
+#   git checkout -b ci-config
+#   cp allow-refs.sample allow-refs
+#   $EDITOR allow-refs
+#   git commit -am "implement my ci preferences"
+#   git push
+#
+# This script will then be run when any refs are pushed to that repository. It
+# gets the fully qualified refname as the first argument, and should exit with
+# success only for refs for which you want to run CI.
+
+case "$1" in
+# allow one-off tests by pushing to "for-ci" or "for-ci/mybranch"
+refs/heads/for-ci*) true ;;
+# always build your integration branch
+refs/heads/my-integration-branch) true ;;
+# don't build any other branches or tags
+*) false ;;
+esac
-- 
2.26.2.1005.ge383644752

