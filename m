Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FF320989
	for <e@80x24.org>; Thu, 13 Oct 2016 20:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753832AbcJMUNl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 16:13:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:57132 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753535AbcJMUNd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 16:13:33 -0400
Received: (qmail 6455 invoked by uid 109); 13 Oct 2016 20:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 20:06:46 +0000
Received: (qmail 31992 invoked by uid 111); 13 Oct 2016 20:07:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 16:07:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2016 16:06:44 -0400
Date:   Thu, 13 Oct 2016 16:06:44 -0400
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: use "quick" has_sha1_file for tag following
Message-ID: <20161013200644.lnustevmpvufbg5y@sigill.intra.peff.net>
References: <fb66dc02-fb75-5aad-74e5-01b969cf9f9a@oracle.com>
 <af801f22-0e24-525d-a862-f2114941719a@oracle.com>
 <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
 <20161013165344.jv7hyj74q33yb4ip@sigill.intra.peff.net>
 <20161013170443.43slna3zvcvrse5r@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161013170443.43slna3zvcvrse5r@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2016 at 01:04:43PM -0400, Jeff King wrote:

> > This patch teaches fetch to use HAS_SHA1_QUICK to sacrifice
> > accuracy for speed, in cases where we might be racy with a
> > simultaneous repack. This is similar to the fix in 0eeb077
> > (index-pack: avoid excessive re-reading of pack directory,
> > 2015-06-09). As with that case, it's OK for has_sha1_file()
> > occasionally say "no I don't have it" when we do, because
> > the worst case is not a corruption, but simply that we may
> > fail to auto-follow a tag that points to it.
> 
> Failing in this direction doesn't make me feel great. I had hoped it
> would fail the _other_ way, and request an object that we might already
> have.
> 
> There are two alternatives that might be worth pursuing:
> 
>   1. The thing that makes this really painful is the quadratic
>      duplicate-search in prepare_packed_git_one(). We could speed that
>      up pretty easily by keeping a hash of the packs indexed by their
>      names, and looking up in that.
> 
>      That drops the quadratic factor, but it's still going to be
>      O(nr_tags * nr_packs), as we have to at the very least readdir()
>      all of objects/pack to see that nothing new showed up.

That hash patch would look something like what is below.

Here are numbers for the perf script ("quick" is the one that skips
reprepare entirely, "hash" is this hash table patch, and "quick+hash" is
the combination of the two):

origin              quick                    hash                     quick+hash            
--------------------------------------------------------------------------------------------
11.09(10.38+0.70)   0.08(0.06+0.01) -99.3%   1.41(0.65+0.75) -87.3%   0.07(0.05+0.01) -99.4%

So yes, it does improve this case, but not nearly as much as the "quick"
approach. Putting it on top of the "quick" approach is barely noticeable
(it is speeding up the initial prepare_packed_git() call, but it's just
not expensive enough in the first place to be worth it).

The "hash" patch does fix a potentially quadratic behavior, though, so I
guess in theory it is worth it. But I had to go up to quite a large
number of packs to make it worthwhile. Here it is at 7500 packs, running
"git cat-file -e $some_object_that_exists":

  [origin]
  real    0m0.417s
  user    0m0.376s
  sys     0m0.040s

  [hash]
  real    0m0.054s
  user    0m0.008s
  sys     0m0.044s

So it's certainly better. But 7500 packs is just silly, and squeezing
out ~400ms there is hardly worth it. If you repack this same case into a
single pack, the command drops to 5ms. So yes, there's close to an order
of magnitude speedup here, but you get that _and_ another order of
magnitude just by repacking.

So I think it's only worth pursuing if we wanted to scrap my original
patch, and continue to aggressively reprepare_packed_git(). I'd worry
that it's still expensive on some systems, even with the hash, because
the opendir/readdir might cost a lot (OTOH, we'll by definition have
just done a stat() on the loose version of the object, so there's a
limit to how fast we can make it).

I dunno.

---
 cache.h     |  2 ++
 sha1_file.c | 44 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index ec791a6..0d8b4e8 100644
--- a/cache.h
+++ b/cache.h
@@ -1411,6 +1411,7 @@ struct pack_window {
 };
 
 extern struct packed_git {
+	struct hashmap_entry name_entry;
 	struct packed_git *next;
 	struct pack_window *windows;
 	off_t pack_size;
@@ -1428,6 +1429,7 @@ extern struct packed_git {
 		 do_not_close:1;
 	unsigned char sha1[20];
 	struct revindex_entry *revindex;
+	size_t basename_len;
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
 } *packed_git;
diff --git a/sha1_file.c b/sha1_file.c
index c652cb6..eb6a5f3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -602,6 +602,8 @@ struct packed_git *packed_git;
 static struct mru packed_git_mru_storage;
 struct mru *packed_git_mru = &packed_git_mru_storage;
 
+static struct hashmap pack_name_index;
+
 void pack_report(void)
 {
 	fprintf(stderr,
@@ -1260,6 +1262,30 @@ struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 	return p;
 }
 
+static int pack_name_hashcmp(const void *va, const void *vb, const void *name)
+{
+	const struct packed_git *a = va, *b = vb;
+
+	if (a->basename_len != b->basename_len)
+		return -1;
+	else if (name)
+		return memcmp(a->pack_name, name, a->basename_len);
+	else
+		return memcmp(a->pack_name, b->pack_name, a->basename_len);
+}
+
+static int pack_loaded(const char *name, size_t len)
+{
+	struct packed_git key;
+
+	if (!pack_name_index.tablesize)
+		return 0;
+
+	hashmap_entry_init(&key, memhash(name, len));
+	key.basename_len = len;
+	return !!hashmap_get(&pack_name_index, &key, name);
+}
+
 void install_packed_git(struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
@@ -1267,6 +1293,12 @@ void install_packed_git(struct packed_git *pack)
 
 	pack->next = packed_git;
 	packed_git = pack;
+
+	if (!pack_name_index.tablesize)
+		hashmap_init(&pack_name_index, pack_name_hashcmp, 0);
+	strip_suffix(pack->pack_name, ".pack", &pack->basename_len);
+	hashmap_entry_init(pack, memhash(pack->pack_name, pack->basename_len));
+	hashmap_add(&pack_name_index, pack);
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
@@ -1347,15 +1379,9 @@ static void prepare_packed_git_one(char *objdir, int local)
 
 		base_len = path.len;
 		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
-			/* Don't reopen a pack we already have. */
-			for (p = packed_git; p; p = p->next) {
-				size_t len;
-				if (strip_suffix(p->pack_name, ".pack", &len) &&
-				    len == base_len &&
-				    !memcmp(p->pack_name, path.buf, len))
-					break;
-			}
-			if (p == NULL &&
+			if (
+			    /* Don't reopen a pack we already have. */
+			    !pack_loaded(path.buf, base_len) &&
 			    /*
 			     * See if it really is a valid .idx file with
 			     * corresponding .pack file that we can map.
-- 
2.10.1.589.gca16299

