Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E3C20229
	for <e@80x24.org>; Sun, 23 Oct 2016 08:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbcJWIGA (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 04:06:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:33091 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbcJWIFz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 04:05:55 -0400
Received: (qmail 6306 invoked by uid 109); 23 Oct 2016 08:05:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Oct 2016 08:05:54 +0000
Received: (qmail 16678 invoked by uid 111); 23 Oct 2016 08:06:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Oct 2016 04:06:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Oct 2016 04:05:52 -0400
Date:   Sun, 23 Oct 2016 04:05:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: revisiting zstd timings
Message-ID: <20161023080552.lma2v6zxmyaiiqz5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You may recall some "what if" timings I did recently, where I replaced
zlib with zstd:

  http://public-inbox.org/git/20160914235843.nacr54ekvl6rjipk@sigill.intra.peff.net/

The aim was that it would give us about the same compression level, but
much faster inflating and deflating. My numbers there showed that yes,
inflate is faster (which speeds up normal operations like traversals and
diffs), but that compression seemed to be much slower.

Since then, zstd has released a new version of their zlib wrapper which
performs much better for our case. Basically, the prior version's
transparent zstd setup was not optimized well for our case of doing tons
of small deflates. I'm cc-ing Przemyslaw Skibinski, who wrote the
wrapper code, and who pointed me in the right direction (thanks!).

I'll include the new patch at the end, but it's basically the same as
the old with one minor symbol change:

	diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
	index 7da2fd44b0..07f45aa171 100644
	--- a/builtin/pack-objects.c
	+++ b/builtin/pack-objects.c
	@@ -2287,7 +2287,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
	 			return config_error_nonbool(k);
	 #ifdef USE_ZSTD
	 		if (skip_prefix(v, "zstd", &v)) {
	-			useZSTD(1);
	+			ZWRAP_useZSTDcompression(1);
	 			/* XXX doesn't seem to be a constant? */
	 			pack_compression_max = 22;
	 		}

Here are the numbers I get with the newer version (see the prior email
for descriptions of each test, but I did run them all from scratch
again).

    zlib
     - pack
     1127899484
     - repack
     real    4m55.099s
     user    17m46.796s
     sys     0m6.164s
     - rev-list
     real    0m27.402s
     user    0m27.080s
     sys     0m0.320s
     - log -Sfoo
     real    5m16.326s
     user    5m13.860s
     sys     0m2.448s

That gives us a baseline for the time of each operation, and the size of
the compressed pack. The rest of the values will be expressed as
percentages from this baseline.

    zstd=disabled
     - pack
     1127884778
     (+0%)
     - repack
     real    4m49.443s
     user    17m39.468s
     sys     0m5.996s
     (-1.9%)
     - rev-list
     real    0m27.527s
     user    0m27.316s
     sys     0m0.208s
     (+0.4%)
     - log -Sfoo
     real    5m21.029s
     user    5m17.704s
     sys     0m3.308s
     (+1.4%)

Timing the wrapper making use of zlib, it produces the same output and
takes a slightly larger amount of time (the repack is quicker, but
there's quite a bit of run-to-run noise in that measurement). Nothing
surprising.

    zstd=1
     - pack
     1191357029
     (+5.6%)
     - repack
     real    4m8.323s
     user    16m24.664s
     sys     0m6.816s
     (-15.8%)
     - rev-list
     real    0m25.780s
     user    0m25.488s
     sys     0m0.288s
     (-5.9%)
     - log -Sfoo
     real    4m19.301s
     user    4m16.488s
     sys     0m2.796s
     (-18%)

Here's where we get interesting; zstd turned down to its lowest setting.
As before, the inflate step shows a nice speedup for some common
read-only operations. The repack is much faster, and the resulting pack
is slightly larger. We'd probably want to tune the cpu/size tradeoff for
deflate a bit higher.

    zstd=3
     - pack
     1163632679
     (+3.1%)
     - repack
     real    4m11.800s
     user    16m34.260s
     sys     0m6.788s
     (-14.6%)
     - rev-list
     real    0m25.678s
     user    0m25.376s
     sys     0m0.296s
     (-6.2%)
     - log -Sfoo
     real    4m19.902s
     user    4m16.604s
     sys     0m3.280s
     (-17.8%)

And here that is. Without spending much more CPU on deflate, we shaved
off a few percent. The reading side remains fast (I wondered if it might
get faster as we shrink the pack just because there are fewer bytes to
deal with on the input side, but it doesn't seem to really matter. And
anyway, we're only talking a few percent of the input size).

    zstd=5
     - pack
     1137697830
     (+0.8%)
     - repack
     real    4m20.930s
     user    16m45.844s
     sys     0m7.100s
     (-11.5%)

Turning it up higher, we're starting to reach parity with zlib for the
pack size. And the deflate process is still faster. I stopped measuring
the read side, since it seemed to be remaining constant.

    zstd=7
     - pack
     1130545314
     (+0.2%)
     - repack
     real    4m28.960s
     user    16m50.028s
     sys     0m6.884s
     (-8.8%)

    zstd=9
     - pack
     1128847500
     (+0%)
     - repack
     real    4m52.234s
     user    17m22.644s
     sys     0m7.080s
     (-0.9%)

    zstd=11
     - pack
     1128415787
     (+0%)
     - repack
     real    5m33.187s
     user    18m12.792s
     sys     0m7.436s
     (+12.9%)

And these numbers show we can pretty much dial in the cpu/size tradeoff
wherever we want.  Going past 9 doesn't seem to really help. I'd
probably leave it at 5, as 0.8% is close enough.

Note that this repack scenario _isn't_ especially realistic. It's
finding new deltas for the whole pack from scratch, which is something
that isn't generally done. Instead, we'd generally deflate a small
number of new objects during a repack, or perhaps when packing objects
to serve a fetch or push. And in that case, compression would be a much
smaller part of the whole task (because we'd spend a lot of our time
writing out the already-compressed objects verbatim).

So saving 10% here really _isn't_ that interesting. I mostly wanted to
confirm that we could use zstd without increasing the CPU time used for
deflating, so that we could reap the benefits on the inflate side. Which
is definitely the case. With these numbers, there's basically no
downside at all to using zstd. It's just faster to read the objects
later.

If we were designing git today, it seems like a no-brainer to use zstd
over zlib. But given backwards-compatibility issues, I'm not sure.
10-20% speedup on reading is awfully nice, but I don't think there's a
good way to gracefully transition, because zlib is part of the
on-the-wire format for serving objects. We could re-compress on the fly,
but that gets expensive (in existing cases, we can quite often serve the
zlib content straight from disk, but this would require an extra
inflate/deflate. At least we wouldn't have to reconstitute objects from
deltas, though).

A transition would probably look something like:

  0. The patch below, or something like it, to teach git to read both
     zlib and zstd, and optionally write zstd. We'd probably want to
     make this an unconditional requirement like zlib, because the point
     is for it to be available everywhere (I assume the zstd code is
     pretty portable, but I haven't put it to the test).

  1. Another patch to add a "zstd" capability to the protocol. This
     would require teaching pack-objects an option to convert zstd back
     to zlib on the fly.

     Servers which handle a limited number of updated clients can switch
     to zstd immediately to get the benefit, and their clients can
     handle it directly. Likewise, clients of older servers may wish to
     repack locally using zstd to get the benefit. They'll have to
     recompress on the fly during push, but pushes are rare than other
     operations (and often limited by bandwidth anyway).

  2. After a while, eventually flip the default to zstd=5.

  3. If "a while" is long enough, perhaps add a patch to let servers
     tell clients "go upgrade" rather than recompressing on the fly.

I don't have immediate plans for any of that, but maybe something to
think about.

Here's the patch which produce the numbers above. Build it with:

  make ZSTD_PATH=/path/to/zstd

where /path/to/zstd is a built clone of
https://github.com/facebook/zstd.

---
diff --git a/Makefile b/Makefile
index 1aad150b34..7e7c8c73e1 100644
--- a/Makefile
+++ b/Makefile
@@ -1140,6 +1140,15 @@ else
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
index 166e52c700..07f45aa171 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -62,6 +62,7 @@ static int num_preferred_base;
 static struct progress *progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
+static int pack_compression_max = Z_BEST_COMPRESSION;
 
 static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
@@ -2281,11 +2282,17 @@ static int git_pack_config(const char *k, const char *v, void *cb)
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
+			ZWRAP_useZSTDcompression(1);
+			/* XXX doesn't seem to be a constant? */
+			pack_compression_max = 22;
+		}
+#endif
+		level = git_config_int(k, v);
 		pack_compression_level = level;
 		pack_compression_seen = 1;
 		return 0;
@@ -2826,7 +2833,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		reuse_delta = 0;
 	if (pack_compression_level == -1)
 		pack_compression_level = Z_DEFAULT_COMPRESSION;
-	else if (pack_compression_level < 0 || pack_compression_level > Z_BEST_COMPRESSION)
+	else if (pack_compression_level < 0 || pack_compression_level > pack_compression_max)
 		die("bad pack compression level %d", pack_compression_level);
 
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
diff --git a/cache.h b/cache.h
index ed3d5dfce1..acc05720a0 100644
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
