Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09463C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 18:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjFASKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjFASJu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 14:09:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309BD193
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 11:09:49 -0700 (PDT)
Received: (qmail 6328 invoked by uid 109); 1 Jun 2023 18:09:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 18:09:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25556 invoked by uid 111); 1 Jun 2023 18:09:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 14:09:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 14:09:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] ci: run ASan/UBSan in a single job
Message-ID: <20230601180947.GB4167886@coredump.intra.peff.net>
References: <20230601180220.GA4167745@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601180220.GA4167745@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we started running sanitizers in CI via 1c0962c0c4 (ci: add address
and undefined sanitizer tasks, 2022-10-20), we ran them as two separate
CI jobs, since as that commit notes, the combination "seems to take
forever".

And indeed, it does with gcc. However, since the previous commit
switched to using clang, the situation is different, and we can save
some CPU by using a single job for both. Comparing before/after CI runs,
this saved about 14 minutes (the single combined job took 54m, versus
44m plus 24m for ASan and UBSan jobs, respectively). That's wall-clock
and not CPU, but since our jobs are mostly CPU-bound, the two should be
closely proportional.

This does increase the end-to-end time of a CI run, though, since before
this patch the two jobs could run in parallel, and the sanitizer job is
our longest single job. It also means that we won't get a separate
result for "this passed with UBSan but not with ASan" or vice versa).
But as 1c0962c0c4 noted, that is not a very useful signal in practice.

Below are some more detailed timings of gcc vs clang that I measured by
running the test suite on my local workstation. Each measurement counts
only the time to run the test suite with each compiler (not the compile
time itself). We'll focus on the wall-clock times for simplicity, though
the CPU times follow roughly similar trends.

Here's a run with CC=gcc as a baseline:

  real	1m12.931s
  user	9m30.566s
  sys	8m9.538s

Running with SANITIZE=address increases the time by a factor of ~4.7x:

  real	5m40.352s
  user	49m37.044s
  sys	36m42.950s

Running with SANITIZE=undefined increases the time by a factor of ~1.7x:

  real	2m5.956s
  user	12m42.847s
  sys	19m27.067s

So let's call that 6.4 time units to run them separately (where a unit
is the time it takes to run the test suite with no sanitizers). As a
simplistic model, we might imagine that running them together would take
5.4 units (we save 1 unit because we are no longer running the test
suite twice, but just paying the sanitizer overhead on top of a single
run).

But that's not what happens. Running with SANITIZE=address,undefined
results in a factor of 9.3x:

  real	11m9.817s
  user	77m31.284s
  sys	96m40.454s

So not only did we not get faster when doing them together, we actually
spent 1.5x as much CPU as doing them separately! And while those
wall-clock numbers might not look too terrible, keep in mind that this
is on an unloaded 8-core machine. In the CI environment, wall-clock
times will be much closer to CPU times. So not only are we wasting CPU,
but we risk hitting timeouts.

Now let's try the same thing with clang. Here's our no-sanitizer
baseline run, which is almost identical to the gcc one (which is quite
convenient, because we can keep using the same "time units" to get an
apples-to-apples comparison):

  real	1m11.844s
  user	9m28.313s
  sys	8m8.240s

And now again with SANITIZE=address, we get a 5x factor (so slightly
worse than gcc's 4.7x, though I wouldn't read too much into it; there is
a fair bit of run-to-run noise):

  real	6m7.662s
  user	49m24.330s
  sys	44m13.846s

And with SANITIZE=undefined, we are at 1.5x, slightly outperforming gcc
(though again, that's probably mostly noise):

  real	1m50.028s
  user	11m0.973s
  sys	16m42.731s

So running them separately, our total cost is 6.5x. But if we combine
them in a single run (SANITIZE=address,undefined), we get:

  real	6m51.804s
  user	52m32.049s
  sys	51m46.711s

which is a factor of 5.7x. That's along the lines we'd hoped for!
Running them together saves us almost a whole time unit. And that's not
counting any time spent outside the test suite itself (starting the job,
setting up the environment, compiling) that we're no longer duplicating
by having two jobs.

So clang behaves like we'd hope: the overhead to run the sanitizers is
additive as you add more sanitizers. Whereas gcc's numbers seem very
close to multiplicative, almost as if the sanitizers were enforcing
their overheads on each other (though that is purely a guess on what is
going on; ultimately what matters to us is the amount of time it takes).

And that roughly matches the CI improvement I saw. A "time unit" there
is more like 12 minutes, and the observed time savings was 14 minutes
(with the extra presumably coming from avoiding duplicated setup, etc).

Signed-off-by: Jeff King <peff@peff.net>
---
I'm not excited about increasing the total run-time. However, if we want
to deal with that, I suspect a better solution is to split the tests up
into several parallel jobs the way the Windows ones do. That's a lot
more work to set up, but it would let us bring the runtime down to match
other tests (which seem to take 15-20 minutes, versus 44 minutes even
before this patch).

 .github/workflows/main.yml | 5 +----
 ci/lib.sh                  | 7 ++-----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 487ad31e66..2114303b7d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -273,10 +273,7 @@ jobs:
           - jobname: linux-leaks
             cc: gcc
             pool: ubuntu-latest
-          - jobname: linux-asan
-            cc: clang
-            pool: ubuntu-latest
-          - jobname: linux-ubsan
+          - jobname: linux-asan-ubsan
             cc: clang
             pool: ubuntu-latest
     env:
diff --git a/ci/lib.sh b/ci/lib.sh
index db7105e8a8..369d462f13 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -278,11 +278,8 @@ linux-leaks)
 	export GIT_TEST_PASSING_SANITIZE_LEAK=true
 	export GIT_TEST_SANITIZE_LEAK_LOG=true
 	;;
-linux-asan)
-	export SANITIZE=address
-	;;
-linux-ubsan)
-	export SANITIZE=undefined
+linux-asan-ubsan)
+	export SANITIZE=address,undefined
 	;;
 esac
 
-- 
2.41.0.346.g8d12207a4f

