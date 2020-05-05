Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C466C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 21:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7665D20721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgEEVEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 17:04:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:38390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729070AbgEEVEx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 17:04:53 -0400
Received: (qmail 15114 invoked by uid 109); 5 May 2020 21:04:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 May 2020 21:04:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2567 invoked by uid 111); 5 May 2020 21:04:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 May 2020 17:04:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 May 2020 17:04:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200505210451.GA645290@coredump.intra.peff.net>
References: <20200504150105.GB11373@coredump.intra.peff.net>
 <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505182418.GA66702@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 02:24:18PM -0400, Jeff King wrote:

> But _if_ we can read from other refs in the repository, I would be very
> happy if we parsed config out of refs/ci/branches or something. It feels
> like that's something that ought to be possible, but I haven't quite
> figured out a way to do it.

OK, I finally figured this out. The result is the patch below, which I
think should make everybody happy. Or at least has the ability to do so
if they're willing to push a config ref. ;)

-- >8 --
Subject: [PATCH] ci: allow per-branch config for GitHub Actions

Depending on the workflows of individual developers, it can either be
convenient or annoying that our GitHub Actions CI jobs are run on every
branch. As an example of annoying: if you carry many half-finished
work-in-progress branches and rebase them frequently against master,
you'd get tons of failure reports that aren't interesting (not to
mention the wasted CPU).

This commit adds a new job which checks a special ref within the
repository for CI config, and (optionally) causes all of the other jobs
to be skipped.

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

I used refs/ci/config as the config ref, which should be a commit whose
tree contains various config files (right now the only one is
"ref-whitelist"). It was intentional to avoid refs/heads/ here so we
don't conflict with any branch workflows. But it does make it a little
awkward to edit, since you can't check it out directly.

Right now the logic is to run CI for all branches by default, unless a
whitelist exists, in which case the branch must be mentioned there
(using its fully qualified ref name). We could easily add in a
blacklist, as well. Or since we're running a shell in a VM, we really
could just run "./allow-ref $refname" and let individual forks specify
whatever shell code they like.

Signed-off-by: Jeff King <peff@peff.net>
---
After writing that, I think we probably ought to just do the allow-ref
thing from the start, and skip this whitelist logic. Then we should
never need to change this workflow file again. People can implement
whatever weird custom logic they want to.

 .github/workflows/main.yml | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fd4df939b5..51f4ff6e89 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -6,7 +6,29 @@ env:
   DEVELOPER: 1
 
 jobs:
+  check-ci:
+      runs-on: ubuntu-latest
+      outputs:
+        enabled: ${{ steps.check-ref.outputs.enabled }}
+      steps:
+        - uses: actions/checkout@v2
+          continue-on-error: true
+          with:
+            ref: refs/ci/config
+        - id: check-ref
+          name: check whether CI is enabled for ref
+          run: |
+            enabled=yes
+            if test -e ref-whitelist &&
+               ! grep '^${{ github.ref }}$' ref-whitelist
+            then
+              enabled=no
+            fi
+            echo "::set-output name=enabled::$enabled"
+
   windows-build:
+    needs: check-ci
+    if: needs.check-ci.outputs.enabled == 'yes'
     runs-on: windows-latest
     steps:
     - uses: actions/checkout@v1
@@ -70,6 +92,8 @@ jobs:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   vs-build:
+    needs: check-ci
+    if: needs.check-ci.outputs.enabled == 'yes'
     env:
       MSYSTEM: MINGW64
       NO_PERL: 1
@@ -154,6 +178,8 @@ jobs:
                           ${{matrix.nr}} 10 t[0-9]*.sh)
         "@
   regular:
+    needs: check-ci
+    if: needs.check-ci.outputs.enabled == 'yes'
     strategy:
       matrix:
         vector:
@@ -189,6 +215,8 @@ jobs:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   dockerized:
+    needs: check-ci
+    if: needs.check-ci.outputs.enabled == 'yes'
     strategy:
       matrix:
         vector:
@@ -213,6 +241,8 @@ jobs:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   static-analysis:
+    needs: check-ci
+    if: needs.check-ci.outputs.enabled == 'yes'
     env:
       jobname: StaticAnalysis
     runs-on: ubuntu-latest
@@ -221,6 +251,8 @@ jobs:
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
   documentation:
+    needs: check-ci
+    if: needs.check-ci.outputs.enabled == 'yes'
     env:
       jobname: Documentation
     runs-on: ubuntu-latest
-- 
2.26.2.962.g87ee755179

