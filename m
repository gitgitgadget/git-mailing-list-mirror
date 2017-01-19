Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D4C20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 16:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbdASQe0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 11:34:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:41544 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753869AbdASQeU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 11:34:20 -0500
Received: (qmail 28814 invoked by uid 109); 19 Jan 2017 16:33:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 16:33:53 +0000
Received: (qmail 6442 invoked by uid 111); 19 Jan 2017 16:34:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 11:34:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 11:33:50 -0500
Date:   Thu, 19 Jan 2017 11:33:50 -0500
From:   Jeff King <peff@peff.net>
To:     Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@freebsd.org>
Cc:     Ed Maste <emaste@freebsd.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] clear_delta_base_cache(): don't modify hashmap while
 iterating
Message-ID: <20170119163350.zsfb33lmigkyljjh@sigill.intra.peff.net>
References: <20170112082138.GJ4426@acme.spoerlein.net>
 <20170118140117.GK4426@acme.spoerlein.net>
 <20170118143814.or34vxxwjwnzg5jz@sigill.intra.peff.net>
 <20170118200646.6larm2qu32xm73on@sigill.intra.peff.net>
 <CAJ9axoSzZJXD4RKvVx+D60dw4sakMJWgNmOP-cREWA53Ae3C3w@mail.gmail.com>
 <20170118202704.w6pjxfvnge7utk34@sigill.intra.peff.net>
 <20170118215120.6hle2uxgkcvvtlox@sigill.intra.peff.net>
 <CAJ9axoT1pUQc_jTKxO+RMw7emhA4ss1NCAU+hpnyG5LMwGD89w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ9axoT1pUQc_jTKxO+RMw7emhA4ss1NCAU+hpnyG5LMwGD89w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 03:03:46PM +0100, Ulrich Spörlein wrote:

> > I suspect the patch below may fix things for you. It works around it by
> > walking over the lru list (either is fine, as they both contain all
> > entries, and since we're clearing everything, we don't care about the
> > order).
> 
> Confirmed. With the patch applied, I can import the whole 55G in one go
> without any crashes or aborts. Thanks much!

Thanks. Here it is rolled up with a commit message.

-- >8 --
Subject: clear_delta_base_cache(): don't modify hashmap while iterating

Removing entries while iterating causes fast-import to
access an already-freed `struct packed_git`, leading to
various confusing errors.

What happens is that clear_delta_base_cache() drops the
whole contents of the cache by iterating over the hashmap,
calling release_delta_base_cache() on each entry. That
function removes the item from the hashmap. The hashmap code
may then shrink the table, but the hashmap_iter struct
retains an offset from the old table.

As a result, the next call to hashmap_iter_next() may claim
that the iteration is done, even though some items haven't
been visited.

The only caller of clear_delta_base_cache() is fast-import,
which wants to clear the cache because it is discarding the
packed_git struct for its temporary pack. So by failing to
remove all of the entries, we still have references to the
freed packed_git.

To make things even more confusing, this doesn't seem to
trigger with the test suite, because it depends on
complexities like the size of the hash table, which entries
got cleared, whether we try to access them before they're
evicted from the cache, etc.

So I've been able to identify the problem with large
imports like freebsd's svn import, or a fast-export of
linux.git. But nothing that would be reasonable to run as
part of the normal test suite.

We can fix this easily by iterating over the lru linked list
instead of the hashmap. They both contain the same entries,
and we can use the "safe" variant of the list iterator,
which exists for exactly this case.

Let's also add a warning to the hashmap API documentation to
reduce the chances of getting bit by this again.

Reported-by: Ulrich Spörlein <uqs@freebsd.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-hashmap.txt | 4 +++-
 sha1_file.c                             | 9 ++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index 28f5a8b71..a3f020cd9 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -188,7 +188,9 @@ Returns the removed entry, or NULL if not found.
 `void *hashmap_iter_next(struct hashmap_iter *iter)`::
 `void *hashmap_iter_first(struct hashmap *map, struct hashmap_iter *iter)`::
 
-	Used to iterate over all entries of a hashmap.
+	Used to iterate over all entries of a hashmap. Note that it is
+	not safe to add or remove entries to the hashmap while
+	iterating.
 +
 `hashmap_iter_init` initializes a `hashmap_iter` structure.
 +
diff --git a/sha1_file.c b/sha1_file.c
index 1eb47f611..d20714d6b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2342,11 +2342,10 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 
 void clear_delta_base_cache(void)
 {
-	struct hashmap_iter iter;
-	struct delta_base_cache_entry *entry;
-	for (entry = hashmap_iter_first(&delta_base_cache, &iter);
-	     entry;
-	     entry = hashmap_iter_next(&iter)) {
+	struct list_head *lru, *tmp;
+	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
+		struct delta_base_cache_entry *entry =
+			list_entry(lru, struct delta_base_cache_entry, lru);
 		release_delta_base_cache(entry);
 	}
 }
-- 
2.11.0.747.g2c5918130

