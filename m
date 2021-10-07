Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4F9C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 02:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E968C61175
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 02:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhJGCkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 22:40:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:34678 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhJGCkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 22:40:12 -0400
Received: (qmail 27667 invoked by uid 109); 7 Oct 2021 02:38:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Oct 2021 02:38:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6493 invoked by uid 111); 7 Oct 2021 02:38:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Oct 2021 22:38:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Oct 2021 22:38:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Message-ID: <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YV5aaD418SyZqS/1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 06, 2021 at 10:24:40PM -0400, Jeff King wrote:

> On Wed, Oct 06, 2021 at 05:24:14PM -0700, Junio C Hamano wrote:
> 
> > * tb/repack-write-midx (2021-10-01) 9 commits
> >   (merged to 'next' on 2021-10-06 at ccdd5aaf2a)
> >  + builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
> >  + builtin/repack.c: make largest pack preferred
> >  + builtin/repack.c: support writing a MIDX while repacking
> >  + builtin/repack.c: extract showing progress to a variable
> >  + builtin/repack.c: rename variables that deal with non-kept packs
> >  + builtin/repack.c: keep track of existing packs unconditionally
> >  + midx: preliminary support for `--refs-snapshot`
> >  + builtin/multi-pack-index.c: support `--stdin-packs` mode
> >  + midx: expose `write_midx_file_only()` publicly
> > 
> >  "git repack" has been taught to generate multi-pack reachability
> >  bitmaps.
> > 
> >  Will merge to 'master'.
> 
> Sorry not to catch this before it hit 'next', but there's a small leak
> in the test helper. This patch can go on top to fix it.

The reason for that is that I didn't find it by inspection; I've started
running my personal builds through coverity. It wasn't too bad to set up
with a GitHub Action, like so:

---
 .github/workflows/coverity.yml | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 .github/workflows/coverity.yml

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
new file mode 100644
index 0000000000..bfd4dff275
--- /dev/null
+++ b/.github/workflows/coverity.yml
@@ -0,0 +1,35 @@
+name: coverity-scan
+on: push
+
+jobs:
+  latest:
+    runs-on: ubuntu-latest
+    steps:
+      - uses: actions/checkout@v2
+      - run: ci/install-dependencies.sh
+      - name: Download Coverity Build Tool
+        run: |
+          wget -q https://scan.coverity.com/download/linux64 --post-data "token=$TOKEN&project=peff/git" -O cov-analysis-linux64.tar.gz
+          mkdir cov-analysis-linux64
+          tar xzf cov-analysis-linux64.tar.gz --strip 1 -C cov-analysis-linux64
+        env:
+          TOKEN: ${{ secrets.COVERITY_SCAN_TOKEN }}
+
+      - name: Build with cov-build
+        run: |
+          export PATH=$(pwd)/cov-analysis-linux64/bin:$PATH
+          cov-build --dir cov-int make
+
+      - name: Submit the result to Coverity Scan
+        run: |
+          tar czvf git.tgz cov-int
+          curl \
+            --form project=peff/git \
+            --form token=$TOKEN \
+            --form email=peff@peff.net \
+            --form file=@git.tgz \
+            --form version=$(git rev-parse HEAD) \
+            --form description="$(./git version)" \
+            https://scan.coverity.com/builds?project=peff/git
+        env:
+          TOKEN: ${{ secrets.COVERITY_SCAN_TOKEN }}

Is there interest in having something like this in the main repo? We'd
need to tweak some values:

  - we have to send the project name (here peff/git); we can presumably
    get this on the fly from the Actions environment

  - any repo which wants to use this has to set up the secret token
    (COVERITY_SCAN_TOKEN here). That involves creating a coverity
    account, and then setting the token in the GitHub web interface.
    Presumably we'd just bail immediately if that token isn't set, so
    forks aside from git/git would have to enable it independently.

  - likewise it needs the email address for the coverity account. That
    could probably be set in the environment, too.

  - we'd probably want to only run it for integration branches, since
    coverity sets some limits on how often it runs. This could probably
    be set in another environment variable, so people could tweak it for
    their forks if they wanted to (or we could use the ci-config hacks,
    but I put those together mostly because these environment variables
    didn't exist back then; I suspect we could switch off of them now).

There are tons of existing warnings, many of which are false positives.
But it keeps track of which problems are new, and emails out a summary
of only the new ones (which is how I saw the leak here, which just hit
next). I don't care all that much about leaks here (we have other
techniques for finding them), but when Stefan used to do regular
coverity builds in the past, it routinely found useful errors.

If we had it running on git/git, it's possible for people to subscribe
to those notifications (or view them on the site; both require the
people to have coverity accounts, but they're free).

Thoughts?

-Peff
