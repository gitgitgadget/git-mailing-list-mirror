Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDC421FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 11:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1169132AbdDXLPc (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 07:15:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:38967 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168752AbdDXLNf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 07:13:35 -0400
Received: (qmail 23448 invoked by uid 109); 24 Apr 2017 11:13:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 11:13:33 +0000
Received: (qmail 5567 invoked by uid 111); 24 Apr 2017 11:13:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 07:13:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 07:13:31 -0400
Date:   Mon, 24 Apr 2017 07:13:31 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: reject entries with null sha1
Message-ID: <20170424111330.rfkoafb74wxzszl2@sigill.intra.peff.net>
References: <20170421184617.lc5bioa5px6ninrj@sigill.intra.peff.net>
 <CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 05:39:33PM +0700, Duy Nguyen wrote:

> > When merged to pu, this fixes the existing test breakage in t7009 when
> > GIT_TEST_SPLIT_INDEX is used (because the split index didn't rewrite the
> > whole index, "git rm --cached" didn't always barf).
> 
> Latest 'pu' has your patch, but t7009 still fails on me (with "invalid
> object" error), more on this later..

Right, it fails for me, too. But only on the new test "noop
filter-branch complaisn". The old one "filter commands are still
checked" should pass after my patch.

> Just checking, since cache-tree helps speed up many operations,
> dropping cache-tree can have some performance implication. But this
> must be an error case (null sha1) and we will not run into it often to
> worry about unnecessary dropping, correct?

Correct. We usually die when we see a null sha1. So this only kicks in
when GIT_ALLOW_NULL_SHA1 is set, which basically means when
filter-branch is running. And of course there it only kicks in when you
actually have a null sha1, which is a rare error case (and you must be
removing it with your filter, or write-tree will barf anyway).

> > The one thing I haven't figured out it is why the new test in t7009
> > fails with the split-index. And even more curiously, the new tests in
> > t1601 _don't_ fail with it, even if I instrument the fake index to have
> > more entries (making it more likely to split).
> 
> back to t7009 failure. I'll see if I can look more into this this
> weekend. If split-index somehow produces these null sha1, then I
> probably have a problem.

I don't think it's producing them. It's just that the check in
write-tree isn't triggering for some reasons. If I run t7009 with
GIT_TRACE=1, the failing test shows:

  trace: built-in: git 'read-tree' '-i' '-m' 'e3ed0c3a94f05540151bd8cb9ac647b8777964a6'
  error: invalid object 160000 0000000000000000000000000000000000000000 for 'broken'
  warning: cache entry has null sha1: broken
  trace: built-in: git 'cat-file' 'commit' 'e3ed0c3a94f05540151bd8cb9ac647b8777964a6'
  trace: built-in: git 'write-tree'

That last write-tree _should_ barf, but it doesn't. I suspect the reason
is that in the read-tree step, we do not properly strip the cache-tree
when we see the null sha1, so it just gets reused later. But I couldn't
reproduce it when running t1601, which does roughly the same steps.

If I instrument it like this:

diff --git a/read-cache.c b/read-cache.c
index 15a4779f2..4d9482092 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2268,9 +2268,10 @@ static int do_write_index(struct index_state *istate, int newfd,
 		if (err)
 			return -1;
 	}
+	warning("drop_cache_tree = %d", drop_cache_tree);
 	if (!strip_extensions && !drop_cache_tree && istate->cache_tree) {
 		struct strbuf sb = STRBUF_INIT;
-
+		warning("reusing cache tree");
 		cache_tree_write(&sb, istate->cache_tree);
 		err = write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;

then I see:

  trace: built-in: git 'read-tree' '-i' '-m' 'e3ed0c3a94f05540151bd8cb9ac647b8777964a6'
  error: invalid object 160000 0000000000000000000000000000000000000000 for 'broken'
  warning: cache entry has null sha1: broken
  warning: drop_cache_tree = 1
  warning: drop_cache_tree = 0
  warning: reusing cache tree
  trace: built-in: git 'cat-file' 'commit' 'e3ed0c3a94f05540151bd8cb9ac647b8777964a6'
  trace: built-in: git 'write-tree'

So we end up in do_write_index twice, and one time we copy the cache
tree. I don't know how cache-tree works with the split index. Is it
possible that we write the cache-tree covering the entry for "broken"
into a separate index than the "broken" entry itself? That would explain
what I'm seeing.

> BTW, I ran t7009 with valgrind and it reported this. Is it something
> we should be worried about? I vaguely recall you're doing something
> with prio-queue...
> 
> ==4246== Source and destination overlap in memcpy(0x5952990, 0x5952990, 16)
> ==4246==    at 0x4C2EACD: memcpy@@GLIBC_2.14 (in
> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==4246==    by 0x545D05: swap (prio-queue.c:15)
> ==4246==    by 0x545D72: prio_queue_reverse (prio-queue.c:25)
> ==4246==    by 0x4CBC0C: sort_in_topological_order (commit.c:723)
> ==4246==    by 0x574C97: prepare_revision_walk (revision.c:2858)
> ==4246==    by 0x48A2BA: cmd_rev_list (rev-list.c:385)
> ==4246==    by 0x405A6F: run_builtin (git.c:371)
> ==4246==    by 0x405CDC: handle_builtin (git.c:572)
> ==4246==    by 0x405E51: run_argv (git.c:624)
> ==4246==    by 0x405FF3: cmd_main (git.c:701)
> ==4246==    by 0x4A48CE: main (common-main.c:43)

I couldn't reproduce here, but it looks like it comes from René's new
SWAP macro. It doesn't detect a noop swap, and we may call memcpy with
identical src and dst parameters. That's _probably_ fine in practice,
but we may want to exit the function early.

I'll ping separately in that thread.

-Peff
