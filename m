Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F4F1F935
	for <e@80x24.org>; Thu, 22 Sep 2016 04:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750778AbcIVEF2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 00:05:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:46467 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbcIVEF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 00:05:27 -0400
Received: (qmail 8801 invoked by uid 109); 22 Sep 2016 04:05:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 04:05:26 +0000
Received: (qmail 5401 invoked by uid 111); 22 Sep 2016 04:05:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 00:05:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 00:05:24 -0400
Date:   Thu, 22 Sep 2016 00:05:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH] verify_packfile: check pack validity before accessing
 data
Message-ID: <20160922040523.x3pihbs7f5iudyfz@sigill.intra.peff.net>
References: <20160922034904.dm5okldfmgmin5d7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160922034904.dm5okldfmgmin5d7@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 11:49:05PM -0400, Jeff King wrote:

> The verify_packfile() does not explicitly open the packfile;
> instead, it starts with a sha1 checksum over the whole pack,
> and relies on use_pack() to open the packfile as a side
> effect.
> 
> If the pack cannot be opened for whatever reason (either
> because its header information is corrupted, or perhaps
> because a simultaneous repack deleted it), then use_pack()
> will die(), as it has no way to return an error. This is not
> ideal, as verify_packfile() otherwise tries to gently return
> an error (this lets programs like git-fsck go on to check
> other packs).
> 
> Instead, let's check is_pack_valid() up front, and return an
> error if it fails. This will open the pack as a side effect,
> and then use_pack() will later rely on our cached
> descriptor, and avoid calling die().

I actually had an ulterior motive, but it didn't pan out. I
think this change is an improvement on its own, which is why I posted
it. But here's my ulterior motive, for reference.

The die() in question happens when use_pack() is asked to lazily open a
pack, but it fails. If this happens then the code in question is racy
with respect to somebody else running a repack, because the pack we are
looking for might go away, but we could find the object in another pack.
Since we cannot handle the retry at this level, callers of use_pack()
should generally use is_pack_valid() early to cache the descriptor (and
at that early stage, they can still bail to another pack if necessary).
See the comment in fill_pack_entry(), for example, or the discussion in 
4c08018 (pack-objects: protect against disappearing packs, 2011-10-14).

So I wanted to know whether there were any code paths that failed to do
so, and just blindly rely on the lazy-open. Finding the races is
inherently hard, because you only catch them when somebody else is doing
a repack. But if we just _remove_ the lazy-load, then it becomes easy to
catch anybody relying on it. Like:

diff --git a/sha1_file.c b/sha1_file.c
index b9c1fa3..f3d7615 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1122,8 +1122,8 @@ unsigned char *use_pack(struct packed_git *p,
 	 * hash, and the in_window function above wouldn't match
 	 * don't allow an offset too close to the end of the file.
 	 */
-	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
-		die("packfile %s cannot be accessed", p->pack_name);
+	if (!p->pack_size && p->pack_fd == -1)
+		die("BUG: use_pack() called on unopened '%s'", p->pack_name);
 	if (offset > (p->pack_size - 20))
 		die("offset beyond end of packfile (truncated pack?)");
 	if (offset < 0)
@@ -1140,8 +1140,8 @@ unsigned char *use_pack(struct packed_git *p,
 			size_t window_align = packed_git_window_size / 2;
 			off_t len;
 
-			if (p->pack_fd == -1 && open_packed_git(p))
-				die("packfile %s cannot be accessed", p->pack_name);
+			if (p->pack_fd == -1)
+				die("BUG: use_pack() called on unopened '%s'", p->pack_name);
 
 			win = xcalloc(1, sizeof(*win));
 			win->offset = (offset / window_align) * window_align;


Running the test suite with the patch above revealed the issue in
verify_packfile (and with my patch, the test suite now passes, even with
this).

So I was hoping that we could convert these into assertions as above.
But the test suite passing does not quite tell the whole story. We might
still close a pack in the middle of an operation if we need to open
another one and are running against the system file descriptor limits.
That would only trigger in a repository with a large number of packs (or
a very low descriptor limit).

In such a case, we are relying on the lazy-load (and we _are_ racy!).
But the patch above would punish people on low-descriptor systems. It's
better to have an unlikely race and complete the request than to fail
consistently. :-/

For people who are running high-traffic servers, they just need to make
sure their file descriptor limit is reasonably high to avoid the race.

-Peff
