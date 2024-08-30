Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF71BE259
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051224; cv=none; b=pyN3rmoY4iT4Wz1qB5ll1Meqjq7Glapn1Z2gCErAwQ80awC2IQuTY6EU+zoxNJy1nyWYjIymJOKm0mvVg34V+ReKdiBpn8LZ5rbQ/6bGLG6t455KI661+yL+Rl10tt/nRyjRjSVFrFWxcuQwz9P/lGpqWyEuy69zDJVClfJ8b24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051224; c=relaxed/simple;
	bh=/S0zCJEY7jH93IxN+GZE7iNpwtS7rm2a5RCB4xzyN4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+iuxN0T7Sge7B29ACqgtAiZvJx0Ru2+8zpSRABAVauLLlNOjYuAtTpCxWjyivcLTeGinDsrEu4f/xloxSQeW8ehgJHwznVei47eFVtXiD2o/T/OWpQpy9aFAAWxi7jXyc9OPucUi1R7ar/H9P3sGJzgxMM/MoMNDPS6MIAohZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14263 invoked by uid 109); 30 Aug 2024 20:53:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Aug 2024 20:53:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27400 invoked by uid 111); 30 Aug 2024 20:53:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Aug 2024 16:53:34 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 Aug 2024 16:53:31 -0400
From: Jeff King <peff@peff.net>
To: Yuri Karnilaev <karnilaev@gmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH] revision: free commit buffers for skipped commits
Message-ID: <20240830205331.GA1038751@coredump.intra.peff.net>
References: <60B730E6-F3C6-4B57-94D6-E5A71754DAF3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60B730E6-F3C6-4B57-94D6-E5A71754DAF3@gmail.com>

On Fri, Aug 30, 2024 at 03:20:15PM +0300, Yuri Karnilaev wrote:

> As you can see from the results, the peak memory usage when processing
> commits in batches is 10 times higher than when processing all commits
> in one go.
> Can you please explain why this happens? Is there a way to work around
> this? Or maybe can you fix this in future Git versions?

Try this:

-- >8 --
Subject: [PATCH] revision: free commit buffers for skipped commits

In git-log we leave the save_commit_buffer flag set to "1", which tells
the commit parsing code to store the object content after it has parsed
it to find parents, tree, etc. That lets us reuse the contents for
pretty-printing the commit in the output. And then after printing each
commit, we call free_commit_buffer(), since we don't need it anymore.

But some options may cause us to traverse commits which are not part of
the output. And so git-log does not see them at all, and doesn't free
them. One such case is something like:

  git log -n 1000 --skip=1000000

which will churn through a million commits, before showing only a
thousand. We loop through these inside get_revision(), without freeing
the contents. As a result, we end up storing the object data for those
million commits simultaneously.

We should free the stored buffers (if any) for those commits as we skip
over them, which is what this patch does. Running the above command in
linux.git drops the peak heap usage from ~1.1GB to ~200MB, according to
valgrind/massif. (I thought we might get an even bigger improvement, but
the remaining memory is going to commit/tree structs, which we do hold
on to forever).

Note that this problem doesn't occur if:

  - you're running a git-rev-list without a --format parameter; it turns
    off save_commit_buffer by default, since it only output the object
    id

  - you've built a commit-graph file, since in that case we'd use the
    optimized graph data instead of the initial parse, and then do a
    lazy parse for commits we're actually going to output

There are probably some other option combinations that can likewise
end up with useless stored commit buffers. For example, if you ask for
"foo..bar", then we'll have to walk down to the merge base, and
everything on the "foo" side won't be shown. Tuning the "save" behavior
to handle that might be tricky (I guess maybe drop buffers for anything
we mark as UNINTERESTING?). And in the long run, the right solution here
is probably to make sure the commit-graph is built (since it fixes the
memory problem _and_ drastically reduces CPU usage).

But since this "--skip" case is an easy one-liner, it's worth fixing in
the meantime. It should be OK to make this call even if there is no
saved buffer (e.g., because save_commit_buffer=0, or because a
commit-graph was used), since it's O(1) to look up the buffer and is a
noop if it isn't present. I verified by running the above command after
"git commit-graph write --reachable", and it takes the same time with
and without this patch.

Reported-by: Yuri Karnilaev <karnilaev@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index ac94f8d429..2d7ad2bddf 100644
--- a/revision.c
+++ b/revision.c
@@ -4407,6 +4407,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 				c = get_revision_1(revs);
 				if (!c)
 					break;
+				free_commit_buffer(revs->repo->parsed_objects, c);
 			}
 		}
 
-- 
2.46.0.769.g1b22d789e3

