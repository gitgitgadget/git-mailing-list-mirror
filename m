Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FDDC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 22:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D6A20730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 22:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDHWbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 18:31:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:37622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726483AbgDHWbM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 18:31:12 -0400
Received: (qmail 14067 invoked by uid 109); 8 Apr 2020 22:31:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Apr 2020 22:31:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13370 invoked by uid 111); 8 Apr 2020 22:41:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2020 18:41:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Apr 2020 18:31:11 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] bloom: ignore renames when computing changed paths
Message-ID: <20200408223111.GC3468797@coredump.intra.peff.net>
References: <pull.601.git.1586363907252.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.601.git.1586363907252.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 08, 2020 at 04:38:27PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The changed-path Bloom filters record an entry in the filter for
> every path that was changed. This includes every add and delete,
> regardless of whther a rename was detected. Detecting renames
> causes significant performance issues, but also will trigger
> downloading missing blobs in partial clone.
> 
> The simple fix is to disable rename detection when computing a
> changed-path Bloom filter.

Yes, we should be doing as simple a tree-diff as possible.

I wonder if this might actually be fixing a potential bug, too. The loop
below this code only looks at the "two" half of each queued diff pair.
With renames enabled, we might see the source path only in the "one"
half of the rename pair.

However, this seems to work already. If I do:

  echo content >file
  git add file
  git commit -m added
  echo change >file
  git commit -am changed
  git mv file other
  git commit -am 'rename away'
  git mv other file
  git commit -am 'rename back'
  git rm file
  git commit -am removed

  git commit-graph write --reachable --changed-paths
  git log --oneline -- file | cat

then I see all of the commits. Instrumenting Git like:

diff --git a/bloom.c b/bloom.c
index c5b461d1cf..fb2a758e1d 100644
--- a/bloom.c
+++ b/bloom.c
@@ -207,6 +207,10 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 		for (i = 0; i < diff_queued_diff.nr; i++) {
 			const char *path = diff_queued_diff.queue[i]->two->path;
 
+			warning("queuing touched %c path %s for %s",
+				diff_queued_diff.queue[i]->status,
+				path, oid_to_hex(&c->object.oid));
+
 			/*
 			* Add each leading directory of the changed file, i.e. for
 			* 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so

results in:

  warning: queuing touched A path file for 2346d88b0cb4bca11c38ee545d007a7a14ca472a
  warning: queuing touched M path file for 991cd7f0696ae29fea738ca1b8340c90dae4b201
  warning: queuing touched D path file for d3642c9fb27459ea09f6c967a1e6ad119e265d6f
  warning: queuing touched A path other for d3642c9fb27459ea09f6c967a1e6ad119e265d6f
  warning: queuing touched A path file for bc908eb29e562d97ebb8cf718e41b69d3aa1d834
  warning: queuing touched D path other for bc908eb29e562d97ebb8cf718e41b69d3aa1d834
  warning: queuing touched D path file for 7433b46bd6aa170ab17a651c10658a5b0c10ba4f

So we really aren't detecting renames in the first place! And indeed,
checking diffopt.detect_rename shows that it is unset. So I'm curious if
there is a case where that would not be true. I _think_ it would only be
true in a program which ran init_diff_ui_defaults(), but never in
git-commit-graph.

Even if it does nothing in practice, I'm not at all opposed to having it
in there as an explicit documentation of our expectations/requirements
for the loop below. But it's probably worth saying so in the commit
message.

-Peff
