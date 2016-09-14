Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB562070F
	for <e@80x24.org>; Wed, 14 Sep 2016 23:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763789AbcINX7g (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 19:59:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:43466 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757554AbcINX7f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 19:59:35 -0400
Received: (qmail 22911 invoked by uid 109); 14 Sep 2016 23:58:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 23:58:46 +0000
Received: (qmail 5290 invoked by uid 111); 14 Sep 2016 23:58:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 19:58:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 16:58:43 -0700
Date:   Wed, 14 Sep 2016 16:58:43 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] use zstd zlib wrapper
Message-ID: <20160914235843.nacr54ekvl6rjipk@sigill.intra.peff.net>
References: <20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a fancy new compression algorithm called "zstd". The
idea is that it's supposed to get similar compression ratios
to zlib, but with much faster compression and decompression
times. And on top of that, a nice sliding scale to trade off
size versus time on the compression side.

The zstd site at https://facebook.github.io/zstd/ claims
close to 3x speedup for both compression and decompression
versus zlib, with similar compression ratios. There are
other fast algorithms (like lz4), but they usually compress
much worse (follow the link above for a nice table of
results).

Since any git operations that have to access objects need to
do a zlib inflate, in theory we can speed up everything by
using zstd. And then on the packing side, use higher
compression levels when making on-disk packfiles (which will
be accessed many times) and lower ones when making loose
objects, or deflating packed objects on the fly when serving
fetches.

The catch, of course, is that it's a new incompatible
format. This would be a pretty huge change and totally break
backwards compatibility for git, not just on disk but
on-the-wire as well. So my goal here was not a finished
product but just a quick experiment to see if it did indeed
bring the promise speedups.

Disappointingly, the answer seems to be "no".

The patch is relatively straightforward. zstd ships with a
zlib-compatible wrapper that we can just plug in. For
compression, it writes with zlib by default, but you can
flip it to zstd mode with a run-time flag. For
decompression, it auto-detects and runs the correct choice
between zlib and zstd. So this patch _could_ serve as the
basis for a real solution. We'd bundle zstd and its wrapper
with the runtime switch off, and then after several years
people could enable zstd writing to cut off older clients.
In the patch below, that switch is just setting the
pack.compression level to "zstd1", "zstd2", etc.

I ran a series of tests where I would:

  1. Repack with "-F" and a particular pack.compression
     setting, measuring both the time to repack and the size
     of the resulting pack.

  2. Time "git rev-list --objects --all" to see the effect
     on commit/tree traversal.

  3. Run "log -Sfoo --raw" to see the additional effect on
     accessing the blobs.

All the timings below are against linux.git. The rev-list
timings are best-of-five, but I didn't do multiple timings
for the repack or "log -S" tests, because they were so
painfully slow (and because the effect sizes seemed to be
larger than run-to-run noise).

I did these on top of my delta-cache and pack-mru patches,
since that would amplify any effect we see (i.e.,
those speed up other things so decompression time is a
relatively larger share of the pie).

Here's a baseline run using stock zlib, with the default
compression settings:

 [zlib]
 - pack
   1122845190
 - repack
   real    4m43.817s
   user    17m32.396s
   sys     0m5.964s
 - rev-list --objects --all
   real    0m27.378s
   user    0m27.132s
   sys     0m0.240s
 - log -Sfoo --raw
   real    5m3.490s
   user    5m0.040s
   sys     0m3.424s

You can see that we're pretty much CPU bound. You can also
see that there's quite a bit of parallelism going on in the
repack (this is a quad-core with hyperthreading).

Here's the same thing built against the zstd wrapper, but
still using zlib:

 [zstd, disabled]
 - pack
   1123089975
   (+0.02%)
 - repack
   real    4m58.263s
   user    17m50.596s
   sys     0m7.200s
   (+5%)
 - rev-list --objects --all
   real    0m28.143s
   user    0m27.864s
   sys     0m0.272s
   (+3%)
 - log -Sfoo --raw
   real    5m12.742s
   user    5m9.804s
   sys     0m2.912s
   (+3%)

The percentages show the difference against the baseline run
above (wall-clock times for the timing results). The pack
size is similar, which we'd expect (it's not identical
because the threaded delta search is slightly
non-deterministic).

Sadly we lose 3-5% just to the wrapper sitting in front of
zlib. So that's not a great start. But it also means we
might be able to recover that through code optimizations of
the wrapper, the way we call it, etc.

Now here it is with zstd turned onto its lowest setting:

 [zstd, 1]
 - pack
   1199180502
   (+7%)
 - repack
   real    4m11.740s
   user    16m36.510s
   sys     0m7.700s
   (-11%)
 - rev-list --objects --all
   real    0m25.870s
   user    0m25.632s
   sys     0m0.232s
   (-5.5%)
 - log -Sfoo --raw
   real    4m10.899s
   user    4m7.788s
   sys     0m3.056s
   (-17%)

We've definitely traded off some space here. But the
compression is faster, _and_ so is the decompression.

So let's bump up the compression level a bit:

 [zstd, 3]
 - pack
   1162416903
   (+3.5%)
 - repack
   real    5m1.477s
   user    19m34.476s
   sys     0m17.720s
   (+6.2%)
 - rev-list --objects --all
   real    0m25.716s
   user    0m25.468s
   sys     0m0.244s
   (-6%)
 - log -Sfoo --raw
   real    4m10.547s
   user    4m6.500s
   sys     0m3.884s
   (-17%)

OK, the size is improving. But now our compression is
noticeably slower. The decompression remains better, which
is nice. Let's go further:

 [zstd, 5]
 - pack
   1144433165
   (+2%)
 - repack
   real    5m46.050s
   user    22m7.580s
   sys     1m2.212s
   (+22%)
 - rev-list --objects --all
   real    0m25.717s
   user    0m25.404s
   sys     0m0.304s
   (-6%)
 - log -Sfoo --raw
   real    4m14.651s
   user    4m11.176s
   sys     0m3.448s
   (-16%)

Getting close to parity on the size. But the compression
time keeps creeping up.

 [zstd, 10]
 - pack
   1132922195
   (+0.8%)
 - repack
   real    41m35.835s
   user    166m36.956s
   sys     50m11.436s
   (+780%)
 - rev-list --objects --all
   real    0m25.946s
   user    0m25.656s
   sys     0m0.284s
   (-5%)
 - log -Sfoo --raw
   real    4m8.490s
   user    4m5.864s
   sys     0m2.604s
   (-18%)

Oof. We still haven't reached size parity, and now we're
using a _lot_ more CPU on the repack.

I wanted to take it all the way to "22", zstd's maximum,
just for fun. But after 2 hours (real time, so pegging all
my cores while doing so), we were only at 12% of the delta
phase. Yikes.

So...it doesn't seem like a great tradeoff (especially
considering the costs in migrating to a new algorithm). The
decompression _is_ delightfully faster, and it's true that
we decompress more than we compress. But the speed/size
tradeoff for compression doesn't seem great.

I'm not sure why we don't get numbers as nice as the ones on
the zstd website. Obviously possibility 0 is that I simply
screwed something up. But here are some other thoughts /
wild guesses:

  1. There's clearly some overhead to using the zlib
     wrapper. Even just calling into zlib with it to
     compress seems to cost about 5%.

     For zstd, it's less clear. The regular (non-wrapper)
     zstd API seems to involve allocating a zstd compressor,
     and then feeding multiple compressions to it. So that
     would amortize the setup cost. I'd guess that the zlib
     wrapper has to allocate a new zstd compressor for each
     wrapped compression (obviously they could share one,
     but then you run into threading issues).

     The fact that the time increases as we bump the
     compression level implies to me that the main cost is
     in the actual compression, though, not in the setup.
     It's possible that the setup cost is higher when the
     compression level is higher, but I wouldn't really
     expect it to scale as rapidly as my numbers show.

     So this is probably making things worse than they
     otherwise could be, but I doubt it's the real cause of
     the problems.

  2. Git tends to do a lot of relatively small compressions,
     as we zlib-compress deltas. So I wonder (and this is a
     wild guess) if zstd performs more favorably on "normal"
     sized inputs.

     That would be possible to test. Or could probably be
     found out by digging more into the zstd benchmarks;
     they used some standard corpuses, but the results are
     summarized. More broken-down results may show patterns.

     I didn't do those things, hence "wild guess".

And obviously even this patch series _does_ show an
improvement on the decompression side (which happens a lot
more often than compression!). So this isn't a total dead
end. But given the ratio/time tradeoff I saw on the
compression side, there are other options. E.g., lz4 is even
faster than zstd, but comes with a size penalty (though I
think it's more like 30%, not 7%).

I would have liked to test with lz4, too, but they don't
ship a totally trivial zlib wrapper. :)

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile               |  9 +++++++++
 builtin/pack-objects.c | 19 +++++++++++++------
 cache.h                |  4 ++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 99e0eb2..e29edbe 100644
--- a/Makefile
+++ b/Makefile
@@ -1138,6 +1138,15 @@ else
 endif
 IMAP_SEND_LDFLAGS += $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
+# for linking straight out of zstd build directory
+ifdef ZSTD_PATH
+	LIB_OBJS += $(ZSTD_PATH)/zlibWrapper/zstd_zlibwrapper.o
+	BASIC_CFLAGS += -I$(ZSTD_PATH)/zlibWrapper
+	BASIC_CFLAGS += -I$(ZSTD_PATH)/lib -I$(ZSTD_PATH)/lib/common
+	BASIC_CFLAGS += -DUSE_ZSTD
+	EXTLIBS += $(ZSTD_PATH)/lib/libzstd.a
+endif
+
 ifdef ZLIB_PATH
 	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
 	EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4a63398..b424465 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -62,6 +62,7 @@ static int num_preferred_base;
 static struct progress *progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
+static int pack_compression_max = Z_BEST_COMPRESSION;
 
 static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
@@ -2220,11 +2221,17 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "pack.compression")) {
-		int level = git_config_int(k, v);
-		if (level == -1)
-			level = Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die("bad pack compression level %d", level);
+		int level;
+		if (!v)
+			return config_error_nonbool(k);
+#ifdef USE_ZSTD
+		if (skip_prefix(v, "zstd", &v)) {
+			useZSTD(1);
+			/* XXX doesn't seem to be a constant? */
+			pack_compression_max = 22;
+		}
+#endif
+		level = git_config_int(k, v);
 		pack_compression_level = level;
 		pack_compression_seen = 1;
 		return 0;
@@ -2765,7 +2772,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		reuse_delta = 0;
 	if (pack_compression_level == -1)
 		pack_compression_level = Z_DEFAULT_COMPRESSION;
-	else if (pack_compression_level < 0 || pack_compression_level > Z_BEST_COMPRESSION)
+	else if (pack_compression_level < 0 || pack_compression_level > pack_compression_max)
 		die("bad pack compression level %d", pack_compression_level);
 
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
diff --git a/cache.h b/cache.h
index 3556326..9b2f8f5 100644
--- a/cache.h
+++ b/cache.h
@@ -37,7 +37,11 @@
 #define git_SHA1_Update		git_SHA1_Update_Chunked
 #endif
 
+#ifdef USE_ZSTD
+#include "zstd_zlibwrapper.h"
+#else
 #include <zlib.h>
+#endif
 typedef struct git_zstream {
 	z_stream z;
 	unsigned long avail_in;
-- 
2.10.0.271.ge3ee153
