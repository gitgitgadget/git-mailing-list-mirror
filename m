Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420ECC19F2D
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 08:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiHKIMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiHKIMI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 04:12:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70095B07D
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 01:12:05 -0700 (PDT)
Received: (qmail 8517 invoked by uid 109); 11 Aug 2022 08:12:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Aug 2022 08:12:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19736 invoked by uid 111); 11 Aug 2022 08:12:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Aug 2022 04:12:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Aug 2022 04:12:01 -0400
From:   Jeff King <peff@peff.net>
To:     Andrew Olsen <andrew.olsen@koordinates.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git rev-list --missing=allow-promisor
Message-ID: <YvS50W6wku5Y/NC7@coredump.intra.peff.net>
References: <CAPJmHpVssKshapGYDF-ifU1fts-jFTC-HqxnjN8meSMP3weB4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPJmHpVssKshapGYDF-ifU1fts-jFTC-HqxnjN8meSMP3weB4g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 11, 2022 at 09:33:54AM +1200, Andrew Olsen wrote:

> Steps to reproduce:
> 1. Create a git repository with missing+promised blobs.
> For example, I did this:
> git clone git@github.com:git/git.git git-no-blobs --filter=blob:none
> --depth=1 --bare
> 
> --filter=blob:none - don't fetch any blobs
> --depth=1 - we don't need git's entire history, just one commit is fine
> --bare - this avoids git fetching any blobs as part of the checkout operation
> 
> 2. In this repository, run:
> git rev-list HEAD --objects --missing=allow-promisor

Thanks for a clear report. I can reproduce this easily.

> Expected outcome:
> git rev-list prints the paths and OIDs of all the objects
> 
> Actual outcome:
> Any of the following:
> a) git rev-list prints the paths and OIDs of all the objects
> b) git rev-list fails with "fatal: malformed mode in tree entry"
> c) git rev-list fails with "fatal: too-short tree object"

Even better is to compile with SANITIZE=address, which reliably shows
that this is indeed a use-after-free.

> Diagnosis:
> With missing=allow-promisor, when git encounters a missing object, it
> calls is_promisor on it, which in turn calls add_promisor_object on
> lots of things.
> In this line in add_promisor_object, the buffer of the tree that we
> are currently traversing is freed:
> https://github.com/git/git/blob/master/packfile.c#L2242

Ugh, yes. This is due to my fcc07e980b (is_promisor_object(): free tree
buffer after parsing, 2021-04-13). In most cases we'll have just
allocated memory for the tree buffer in parse_object(), but occasionally
we'll jump into is_promisor_object() while looking at an existing tree,
and parse_object() will just reuse the buffer cached in the struct.

It would be really nice to have some kind of reference-counting for
these cached buffers, but doing it everywhere may be rather complicated.
An easier hack to fix this area is for it to check ahead of time whether
there's a cached buffer we'll reuse. That only fixes this spot, but this
function is rather unlike most others in that it starts looking at new
random trees in the middle of an existing tree traversal (this would be
possible in a regular tree walk if you could have circular references,
but you can't easily because of sha1).

So something like this makes the bug go away, though it does feel a
little dirty:

---
diff --git a/packfile.c b/packfile.c
index 6b0eb9048e..c3186c1a02 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2217,7 +2217,14 @@ static int add_promisor_object(const struct object_id *oid,
 			       void *set_)
 {
 	struct oidset *set = set_;
-	struct object *obj = parse_object(the_repository, oid);
+	struct object *obj;
+	int save_tree_buffer = 0;
+
+	obj = lookup_object(the_repository, oid);
+	if (obj && obj->type == OBJ_TREE && obj->parsed)
+		save_tree_buffer = 1;
+
+	obj = parse_object(the_repository, oid);
 	if (!obj)
 		return 1;
 
@@ -2239,7 +2246,8 @@ static int add_promisor_object(const struct object_id *oid,
 			return 0;
 		while (tree_entry_gently(&desc, &entry))
 			oidset_insert(set, &entry.oid);
-		free_tree_buffer(tree);
+		if (!save_tree_buffer)
+			free_tree_buffer(tree);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;

-Peff
