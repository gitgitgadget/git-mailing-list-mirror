Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE71AC83F01
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 22:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343872AbjH3WiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 18:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbjH3WiL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 18:38:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC3BC2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 15:37:56 -0700 (PDT)
Received: (qmail 19570 invoked by uid 109); 30 Aug 2023 19:51:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Aug 2023 19:51:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29745 invoked by uid 111); 30 Aug 2023 19:51:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Aug 2023 15:51:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Aug 2023 15:51:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] ci: allow branch selection through "vars"
Message-ID: <20230830195113.GA1709824@coredump.intra.peff.net>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830194919.GA1709446@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we added config to skip CI for certain branches in e76eec3554 (ci:
allow per-branch config for GitHub Actions, 2020-05-07), there wasn't
any way to avoid spinning up a VM just to check the config. From the
developer's perspective this isn't too bad, as the "skipped" branches
complete successfully after running the config job (the workflow result
is "success" instead of "skipped", but that is a minor lie).

But we are still wasting time and GitHub's CPU to spin up a VM just to
check the result of a short shell script. At the time there wasn't any
way to avoid this. But they've since introduced repo-level variables
that should let us do the same thing:

  https://github.blog/2023-01-10-introducing-required-workflows-and-configuration-variables-to-github-actions/#configuration-variables

This is more efficient, and as a bonus is probably less confusing to
configure (the existing system requires sticking your config on a magic
ref).

See the included docs for how to configure it.

The code itself is pretty simple: it checks the variable and skips the
config job if appropriate (and everything else depends on the config job
already). There are two slight inaccuracies here:

  - we don't insist on branches, so this likewise applies to tag names
    or other refs. I think in practice this is OK, and keeping the code
    (and docs) short is more important than trying to be more exact. We
    are targeting developers of git.git and their limited workflows.

  - the match is done as a substring (so if you want to run CI for
    "foobar", then branch "foo" will accidentally match). Again, this
    should be OK in practice, as anybody who uses this is likely to only
    specify a handful of well-known names. If we want to be more exact,
    we can have the code check for adjoining spaces. Or even move to a
    more general CI_CONFIG variable formatted as JSON. I went with this
    scheme for the sake of simplicity.

Signed-off-by: Jeff King <peff@peff.net>
---
 .github/workflows/main.yml |  1 +
 ci/config/README           | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 ci/config/README

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 1b41278a7f..c364abb8f8 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -21,6 +21,7 @@ concurrency:
 jobs:
   ci-config:
     name: config
+    if: vars.CI_BRANCHES == '' || contains(vars.CI_BRANCHES, github.ref_name)
     runs-on: ubuntu-latest
     outputs:
       enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
diff --git a/ci/config/README b/ci/config/README
new file mode 100644
index 0000000000..8de3a04e32
--- /dev/null
+++ b/ci/config/README
@@ -0,0 +1,14 @@
+You can configure some aspects of the GitHub Actions-based CI on a
+per-repository basis by setting "variables" and "secrets" from with the
+GitHub web interface. These can be found at:
+
+  https://github.com/<user>/git/settings/secrets/actions
+
+The following variables can be used:
+
+ - CI_BRANCHES
+
+   By default, CI is run when any branch is pushed. If this variable is
+   non-empty, then only the branches it lists will run CI. Branch names
+   should be separated by spaces, and should use their shortened form
+   (e.g., "main", not "refs/heads/main").
-- 
2.42.0.528.g5e092cb179

