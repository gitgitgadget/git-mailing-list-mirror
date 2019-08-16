Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C1A1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 18:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfHPSkw (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 14:40:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:46154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727067AbfHPSkw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 14:40:52 -0400
Received: (qmail 21361 invoked by uid 109); 16 Aug 2019 18:40:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Aug 2019 18:40:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9183 invoked by uid 111); 16 Aug 2019 18:42:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Aug 2019 14:42:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Aug 2019 14:40:51 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG?: xdl_merge surprisingly does not recognize content conflict
Message-ID: <20190816184051.GB13894@sigill.intra.peff.net>
References: <20190815220303.17209-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190815220303.17209-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 03:03:03PM -0700, Elijah Newren wrote:

> The problematic merge was commit 4a3ed2bec603 ("Merge branch
> 'nd/checkout-m'", 2019-04-25), but redoing that merge produces no merge
> conflicts.  This can be seen at the individual file level with the
> following:
> [...]
> I'm not that familiar with the xdl_merge stuff, but this seemed buggy
> to me.  Or is there something about the content merge that I'm just not
> understanding and this merge is actually correct?

Interesting case. If you look at the combined diff, you can see that the
two hunks are actually separated by a single blank line from the
original:

  $ git show 4a3ed2bec603
  [...]
  diff --cc builtin/checkout.c
  index 2e72a5e5a9,7cd01f62be..ffa776c6e1
  --- a/builtin/checkout.c
  +++ b/builtin/checkout.c
  @@@ -737,14 -738,13 +738,20 @@@ static int merge_working_tree(const str
                           */
                          if (!old_branch_info->commit)
                                  return 1;
  +                       old_tree = get_commit_tree(old_branch_info->commit);
  + 
  +                       if (repo_index_has_changes(the_repository, old_tree, &sb))
  +                               die(_("cannot continue with staged changes in "
  +                                     "the following files:\n%s"), sb.buf);
  +                       strbuf_release(&sb);
    
   +                      if (repo_index_has_changes(the_repository,
   +                                                 get_commit_tree(old_branch_info->commit),
   +                                                 &sb))
   +                              warning(_("staged changes in the following files may be lost: %s"),
   +                                      sb.buf);
   +                      strbuf_release(&sb);
   +
                          /* Do more real merge */
    
                          /*

which is itself an interesting diff artifact. The original had a line at
the end, splitting the "if (!old_branch...)" conditional from the "Do
more real merge" comment.  The upper half of the hunk _didn't_ add a new
line between that old conditional and the new code. But the lower half
did, but diff reports it as adding the line at the end (which is equally
valid to adding the line at the top; who knows what the author actually
did!).

That tidbit aside, in general I'd think a single line would not be
enough to separate two hunks and consider them independent. At first I
thought that XDL_MERGE_ZEALOUS was to blame. If I do this:

diff --git a/ll-merge.c b/ll-merge.c
index 5b8d46aede..ea445dfb55 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -107,7 +107,6 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	}
 
 	memset(&xmp, 0, sizeof(xmp));
-	xmp.level = XDL_MERGE_ZEALOUS;
 	xmp.favor = opts->variant;
 	xmp.xpp.flags = opts->xdl_opts;
 	if (git_xmerge_style >= 0)

and re-run the merge, I get a conflict. But it's not in those lines! The
diff of the conflicted state is:

diff --cc builtin/checkout.c
index 2e72a5e5a9,7cd01f62be..0000000000
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@@ -725,9 -725,10 +725,15 @@@ static int merge_working_tree(const str
  			 */
  			struct tree *result;
  			struct tree *work;
+ 			struct tree *old_tree;
  			struct merge_options o;
++<<<<<<< HEAD
  			struct strbuf sb = STRBUF_INIT;
  
++=======
++			struct strbuf sb = STRBUF_INIT;
++
++>>>>>>> 4a3ed2bec603^2
  			if (!opts->merge)
  				return 1;
  
@@@ -737,14 -738,13 +743,20 @@@
  			 */
  			if (!old_branch_info->commit)
  				return 1;
+ 			old_tree = get_commit_tree(old_branch_info->commit);
+ 
+ 			if (repo_index_has_changes(the_repository, old_tree, &sb))
+ 				die(_("cannot continue with staged changes in "
+ 				      "the following files:\n%s"), sb.buf);
+ 			strbuf_release(&sb);
  
 +			if (repo_index_has_changes(the_repository,
 +						   get_commit_tree(old_branch_info->commit),
 +						   &sb))
 +				warning(_("staged changes in the following files may be lost: %s"),
 +					sb.buf);
 +			strbuf_release(&sb);
 +
  			/* Do more real merge */
  
  			/*

So it found another conflict (where the zealous resolution did the
_right_ thing!) but didn't do anything for the hunk in question.

I do wonder if the fact that the separating line a blank one is relevant
or not (i.e., is it tickling some heuristics in xdiff).

-Peff
