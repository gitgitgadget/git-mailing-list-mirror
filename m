Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835F6C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 08:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF566137C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 08:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhJDIPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 04:15:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:60230 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231189AbhJDIPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 04:15:23 -0400
Received: (qmail 8676 invoked by uid 109); 4 Oct 2021 08:13:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Oct 2021 08:13:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12136 invoked by uid 111); 4 Oct 2021 08:13:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Oct 2021 04:13:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Oct 2021 04:13:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Andrzej Hunt <andrzej@ahunt.org>,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hash: reduce size of algo member of object ID
Message-ID: <YVq3rqwz82RgpUfl@coredump.intra.peff.net>
References: <8da7bad2-b5a8-5aef-284b-dfa4e78556a9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8da7bad2-b5a8-5aef-284b-dfa4e78556a9@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 03, 2021 at 07:51:40AM +0200, René Scharfe wrote:

> cf0983213c (hash: add an algo member to struct object_id, 2021-04-26)
> introduced the algo member as an int.  This increased the size of struct
> object_id by 4 bytes (12.5%) and imposed a 4-byte alignment.  Currently
> we only need to stored the values 0, 1 and 2 in it.  Let's use an
> unsigned char instead to reduce the size overhead and lift the alignment
> requirement.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Not sure how to measure the performance impact of this change.  The perf
> tests mentioned by cf0983213c don't show much of a difference with
> GIT_PERF_REPEAT_COUNT=10 for me:

Not surprising. If going from nothing to an int didn't have an impact on
those tests, then going from an int to char isn't likely to, either.

> 0001.1: rev-list --all                           0.11(0.08+0.02)     0.11(0.08+0.02) +0.0%
> 0001.2: rev-list --all --objects                 3.04(2.98+0.05)     3.04(2.98+0.05) +0.0%
> 0001.3: rev-list --parents                       0.05(0.04+0.01)     0.05(0.03+0.01) +0.0%
> 0001.5: rev-list -- dummy                        0.21(0.20+0.01)     0.21(0.19+0.01) +0.0%
> 0001.6: rev-list --parents -- dummy              0.22(0.20+0.01)     0.22(0.20+0.01) +0.0%
> 0001.8: rev-list $commit --not --all             0.06(0.05+0.00)     0.06(0.05+0.00) +0.0%
> 0001.9: rev-list --objects $commit --not --all   0.06(0.05+0.00)     0.06(0.05+0.00) +0.0%

I do think these probably aren't very good tests. They're going to
mostly be dealing with actual object structs. Your patch changes the
size of "struct object_id", but the object structs themselves still need
4-byte alignment. And they have a bunch of padding in the first place.

If we instrument "git version --build-options" like this:

diff --git a/help.c b/help.c
index 3c3bdec213..718e32cadf 100644
--- a/help.c
+++ b/help.c
@@ -11,6 +11,8 @@
 #include "version.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "blob.h"
+#include "tag.h"
 
 struct category_description {
 	uint32_t category;
@@ -663,6 +665,11 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
 		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
+		strbuf_addf(buf, "sizeof-object_id: %d\n", (int)sizeof(struct object_id));
+		strbuf_addf(buf, "sizeof-commit: %d\n", (int)sizeof(struct commit));
+		strbuf_addf(buf, "sizeof-blob: %d\n", (int)sizeof(struct blob));
+		strbuf_addf(buf, "sizeof-tree: %d\n", (int)sizeof(struct tree));
+		strbuf_addf(buf, "sizeof-tag: %d\n", (int)sizeof(struct tag));
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
 }

then we can see that your patch doesn't the change the size of any of
the structs at all! Even the original cf0983213c going from nothing to
an int changed only "struct blob" (it went from 32 to 36 bytes).

A more interesting test is something that stores a bunch of oids. A good
candidate is "cat-file --batch-all-objects". In the default mode, it
uses an oid_array to sort the set of objects. In unordered mode, it uses
an oidset to mark seen ones.

Here are hyperfine results. The three versions are:

  - none: cf0983213c^
  - int: cf0983213c
  - char: cf0983213c with the equivalent of your patch on top

All compiled with "gcc -O2", and run in a fully packed clone of
linux.git.

It looks like adding the "algo" field did make a big difference for the
oid_array case, but changing it to a char doesn't seem to help at all:

  $ hyperfine -L v none,int,char './git.{v} cat-file --batch-all-objects --batch-check="%(objectname)"'
  Benchmark #1: ./git.none cat-file --batch-all-objects --batch-check="%(objectname)"
    Time (mean ± σ):      1.653 s ±  0.009 s    [User: 1.607 s, System: 0.046 s]
    Range (min … max):    1.640 s …  1.670 s    10 runs
   
  Benchmark #2: ./git.int cat-file --batch-all-objects --batch-check="%(objectname)"
    Time (mean ± σ):      1.067 s ±  0.012 s    [User: 1.017 s, System: 0.050 s]
    Range (min … max):    1.053 s …  1.089 s    10 runs
   
  Benchmark #3: ./git.char cat-file --batch-all-objects --batch-check="%(objectname)"
    Time (mean ± σ):      1.092 s ±  0.013 s    [User: 1.046 s, System: 0.046 s]
    Range (min … max):    1.080 s …  1.116 s    10 runs
   
  Summary
    './git.int cat-file --batch-all-objects --batch-check="%(objectname)"' ran
      1.02 ± 0.02 times faster than './git.char cat-file --batch-all-objects --batch-check="%(objectname)"'
      1.55 ± 0.02 times faster than './git.none cat-file --batch-all-objects --batch-check="%(objectname)"'

I'm actually surprised it had this much of an impact. But I guess this
benchmark really is mostly just memcpy-ing oids into a big array,
sorting it, and printing the result. If that array is 12% bigger, we'd
expect at least a 12% speedup. But adding in non-linear elements like
growing the array (though I guess that is amortized linear) and sorting
(which picks up an extra log(n) term) make the difference.

It's _kind of_ silly in a sense, since usually you'd ask for other parts
of the object, which will make the speed difference relatively smaller.
But just dumping a bunch of oids is actually not an unreasonable thing
to do. I suspect it got a lot slower with 32-byte GIT_MAX_RAWSZ, too
(even when you're using 20-byte sha1), but I don't think there's an easy
way to get out of that.

Using --unordered switches us to using a khash-backed oidset. This
doesn't seem to show any meaningful difference in the three cases (the
averages follow the pattern I'd expect, but we're within the noise).

  $ hyperfine -L v none,int,char './git.{v} cat-file --batch-all-objects --unordered --batch-check="%(objectname)"'
  Benchmark #1: ./git.none cat-file --batch-all-objects --unordered --batch-check="%(objectname)"
    Time (mean ± σ):      2.125 s ±  0.024 s    [User: 2.071 s, System: 0.054 s]
    Range (min … max):    2.092 s …  2.182 s    10 runs
   
  Benchmark #2: ./git.int cat-file --batch-all-objects --unordered --batch-check="%(objectname)"
    Time (mean ± σ):      2.152 s ±  0.016 s    [User: 2.083 s, System: 0.068 s]
    Range (min … max):    2.123 s …  2.175 s    10 runs
   
  Benchmark #3: ./git.char cat-file --batch-all-objects --unordered --batch-check="%(objectname)"
    Time (mean ± σ):      2.137 s ±  0.013 s    [User: 2.079 s, System: 0.058 s]
    Range (min … max):    2.127 s …  2.167 s    10 runs
   
  Summary
    './git.none cat-file --batch-all-objects --unordered --batch-check="%(objectname)"' ran
      1.01 ± 0.01 times faster than './git.char cat-file --batch-all-objects --unordered --batch-check="%(objectname)"'
      1.01 ± 0.01 times faster than './git.int cat-file --batch-all-objects --unordered --batch-check="%(objectname)"'

What surprises me most here is that --unordered is so much slower than
its sorted cousin. It's purpose is to make things faster (though it
likely still does so for queries that actually look at the object
properties, since hitting them in pack order is beneficial there).

-Peff
