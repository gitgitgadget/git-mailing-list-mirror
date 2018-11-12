Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277E31F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeKMAsV (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:48:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:35774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726385AbeKMAsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:48:20 -0500
Received: (qmail 29661 invoked by uid 109); 12 Nov 2018 14:54:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:54:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11426 invoked by uid 111); 12 Nov 2018 14:54:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:54:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:54:42 -0500
Date:   Mon, 12 Nov 2018 09:54:42 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH 8/9] sha1-file: use loose object cache for quick existence
 check
Message-ID: <20181112145442.GH7400@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112144627.GA2478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cases where we expect to ask has_sha1_file() about a lot of objects
that we are not likely to have (e.g., during fetch negotiation), we
already use OBJECT_INFO_QUICK to sacrifice accuracy (due to racing with
a simultaneous write or repack) for speed (we avoid re-scanning the pack
directory).

However, even checking for loose objects can be expensive, as we will
stat() each one. On many systems this cost isn't too noticeable, but
stat() can be particularly slow on some operating systems, or due to
network filesystems.

Since the QUICK flag already tells us that we're OK with a slightly
stale answer, we can use that as a cue to look in our in-memory cache of
each object directory. That basically trades an in-memory binary search
for a stat() call.

Note that it is possible for this to actually be _slower_. We'll do a
full readdir() to fill the cache, so if you have a very large number of
loose objects and a very small number of lookups, that readdir() may end
up more expensive.

This shouldn't be a big deal in practice. If you have a large number of
reachable loose objects, you'll already run into performance problems
(which you should remedy by repacking). You may have unreachable objects
which wouldn't otherwise impact performance. Usually these would go away
with the prune step of "git gc", but they may be held for up to 2 weeks
in the default configuration.

So it comes down to how many such objects you might reasonably expect to
have, how much slower is readdir() on N entries versus M stat() calls
(and here we really care about the syscall backing readdir(), like
getdents() on Linux, but I'll just call this readdir() below).

If N is much smaller than M (a typical packed repo), we know this is a
big win (few readdirs() followed by many uses of the resulting cache).
When N and M are similar in size, it's also a win. We care about the
latency of making a syscall, and readdir() should be giving us many
values in a single call. How many?

On Linux, running "strace -e getdents ls" shows a 32k buffer getting 512
entries per call (which is 64 bytes per entry; the name itself is 38
bytes, plus there are some other fields). So we can imagine that this is
always a win as long as the number of loose objects in the repository is
a factor of 500 less than the number of lookups you make. It's hard to
auto-tune this because we don't generally know up front how many lookups
we're going to do. But it's unlikely for this to perform significantly
worse.

Signed-off-by: Jeff King <peff@peff.net>
---
There's some obvious hand-waving in the paragraphs above. I would love
it if somebody with an NFS system could do some before/after timings
with various numbers of loose objects, to get a sense of where the
breakeven point is.

My gut is that we do not need the complexity of a cache-size limit, nor
of a config option to disable this. But it would be nice to have a real
number where "reasonable" ends and "pathological" begins. :)

 object-store.h |  1 +
 sha1-file.c    | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/object-store.h b/object-store.h
index bf1e0cb761..60758efad8 100644
--- a/object-store.h
+++ b/object-store.h
@@ -13,6 +13,7 @@ struct object_directory {
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
 	 * sacrificing accuracy due to races for speed. That includes
+	 * object existence with OBJECT_INFO_QUICK, as well as
 	 * our search for unique abbreviated hashes. Don't use it for tasks
 	 * requiring greater accuracy!
 	 *
diff --git a/sha1-file.c b/sha1-file.c
index 4aae716a37..e53da0b701 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -921,6 +921,24 @@ static int open_sha1_file(struct repository *r,
 	return -1;
 }
 
+static int quick_has_loose(struct repository *r,
+			   const unsigned char *sha1)
+{
+	int subdir_nr = sha1[0];
+	struct object_id oid;
+	struct object_directory *odb;
+
+	hashcpy(oid.hash, sha1);
+
+	prepare_alt_odb(r);
+	for (odb = r->objects->odb; odb; odb = odb->next) {
+		odb_load_loose_cache(odb, subdir_nr);
+		if (oid_array_lookup(&odb->loose_objects_cache, &oid) >= 0)
+			return 1;
+	}
+	return 0;
+}
+
 /*
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
@@ -1171,6 +1189,8 @@ static int sha1_loose_object_info(struct repository *r,
 	if (!oi->typep && !oi->type_name && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
+		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
+			return quick_has_loose(r, sha1) ? 0 : -1;
 		if (stat_sha1_file(r, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
-- 
2.19.1.1577.g2c5b293d4f

