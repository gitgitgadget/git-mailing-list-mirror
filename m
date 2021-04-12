Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C86C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D35561287
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbhDLXsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 19:48:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:50530 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237250AbhDLXsB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 19:48:01 -0400
Received: (qmail 26263 invoked by uid 109); 12 Apr 2021 23:47:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Apr 2021 23:47:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19781 invoked by uid 111); 12 Apr 2021 23:47:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Apr 2021 19:47:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Apr 2021 19:47:41 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
Message-ID: <YHTcHY+P7RuZJGab@coredump.intra.peff.net>
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
 <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
 <20210412213653.GH2947267@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412213653.GH2947267@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 11:36:53PM +0200, SZEDER Gábor wrote:

> All what you wrote above makes sense to me, but I've never looked at
> how partial clones work, so it doesn't mean anything...  In any case
> your patch brings great speedups, but, unfortunately, the memory usage
> remains as high as it was:
> 
>   $ /usr/bin/time --format=elapsed: %E  max RSS: %Mk /home/szeder/src/git/bin-wrappers/git -C git-partial.git/ gc
>   Enumerating objects: 188450, done.
>   Counting objects: 100% (188450/188450), done.
>   Delta compression using up to 4 threads
>   Compressing objects: 100% (66623/66623), done.
>   Writing objects: 100% (188450/188450), done.
>   Total 188450 (delta 120109), reused 188450 (delta 120109), pack-reused 0
>   elapsed: 0:15.18  max RSS: 1888332k
> 
> And git.git is not all that large, I wonder how much memory would be
> necessary to 'gc' a 'blob:none' clone of e.g. chromium?! :)
> 
> BTW, this high memory usage in a partial clone is not specific to
> 'repack', 'fsck' suffers just as much:

I think the issue is in the exclude-promisor-object code paths of the
traversal. Try this:

  [two clones of git.git, one full and one partial]
  $ git clone --no-local --bare /path/to/git full.git
  $ git clone --no-local --bare --filter=blob:none /path/to/git partial.git

  [full clone is quick to traverse all objects]
  $ time git -C full.git rev-list --count --all
  63215
  real	0m0.369s
  user	0m0.365s
  sys	0m0.004s

  [partial is, too; it's the same amount of work because we're just
   looking at the commits here]
  $ time git -C partial.git rev-list --count --all
  63215
  real	0m0.373s
  user	0m0.364s
  sys	0m0.009s

  [but now ask it to exclude promisor objects, and it's much slower;
  this is because is_promisor_object() opens up each tree in the pack in
  order to see which "promised" objects it mentions]
  $ time git -C partial.git rev-list --exclude-promisor-objects --count --all
  0
  real	0m11.723s
  user	0m11.354s
  sys	0m0.369s

And I think that is the source for the memory use, too. Without that
option, we peak at 11MB heap. With it, 1.6GB. Oops. Looks like there
might be some "leaks" when we parse tree objects and then leave the
buffers connected to the structs (technically not a leak because we
still have the pointers, but obviously having every tree in memory at
once is not good).

The patch below drops the peak heap to 165MB. Still quite a bit more,
but I think it's a combination of delta-base cache (96MB) plus extra
structs for all the non-commit objects whose flags we marked.

It does seem like there's probably a good space/time tradeoff to be made
here (e.g., caching the list of "promisor" object ids for the pack
instead of inflating and reading all of the trees on the fly).

diff --git a/packfile.c b/packfile.c
index 8668345d93..b79cbc8cd4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2247,6 +2247,7 @@ static int add_promisor_object(const struct object_id *oid,
 			return 0;
 		while (tree_entry_gently(&desc, &entry))
 			oidset_insert(set, &entry.oid);
+		free_tree_buffer(tree);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
diff --git a/revision.c b/revision.c
index 553c0faa9b..fac2577748 100644
--- a/revision.c
+++ b/revision.c
@@ -3271,8 +3271,15 @@ static int mark_uninteresting(const struct object_id *oid,
 			      void *cb)
 {
 	struct rev_info *revs = cb;
+	/*
+	 * yikes, do we really need to parse here? maybe
+	 * lookup_unknown_object() would be sufficient, or
+	 * even oid_object_info() followed by the correct type
+	 */
 	struct object *o = parse_object(revs->repo, oid);
 	o->flags |= UNINTERESTING | SEEN;
+	if (o->type == OBJ_TREE)
+		free_tree_buffer((struct tree *)o);
 	return 0;
 }
 

-Peff
