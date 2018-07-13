Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3851F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 20:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbeGMUry (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 16:47:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:58960 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731616AbeGMUry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 16:47:54 -0400
Received: (qmail 2621 invoked by uid 109); 13 Jul 2018 20:31:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Jul 2018 20:31:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7164 invoked by uid 111); 13 Jul 2018 20:31:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 13 Jul 2018 16:31:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2018 16:31:40 -0400
Date:   Fri, 13 Jul 2018 16:31:40 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
Message-ID: <20180713203140.GB17670@sigill.intra.peff.net>
References: <pull.9.git.gitgitgadget@gmail.com>
 <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 12:23:28AM +0200, Johannes Schindelin via GitGitGadget wrote:

> This is particularly important to keep in mind when looking at the
> `.git/shallow` file: if any commits listed in that file become
> unreachable, it is not a problem, but if they go missing, it *is* a
> problem. One symptom of this problem is that a deepening fetch may now
> fail with
> 
> 	fatal: error in object: unshallow <commit-hash>
> 
> To avoid this problem, let's prune the shallow list in `git repack` when
> the `-d` option is passed, unless `-A` is passed, too (which would force
> the now-unreachable objects to be turned into loose objects instead of
> being deleted).

I'm not sure if this covers all cases:

 - even with "-A", we may still drop objects subject to
   --unpack-unreachable. So if your pack has an old mtime (e.g., because
   you haven't packed in a while) I think you'd see the same problem.

 - if you use "-adk", we'd keep all objects, and this pruning would not
   be necessary

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 6c636e159..45f321b23 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -444,6 +444,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		if (!quiet && isatty(2))
>  			opts |= PRUNE_PACKED_VERBOSE;
>  		prune_packed_objects(opts);
> +
> +		if (!(pack_everything & LOOSEN_UNREACHABLE) &&
> +		    is_repository_shallow())
> +			prune_shallow(0);
>  	}

I understand how this solves your immediate problem, but it feels like a
weird layering violation (which I think is a result of existing layering
violations ;) ).

I.e., it seems unexpected that "git repack" is going to tweak your
shallow lists. If we were designing from scratch, the sane behavior
seems to me to be:

  1. Shallow pruning should be its own separate command (distinct from
     either repacking or loose object pruning), and should be triggered
     as part of a normal git-gc.

  AND ONE OF:

  2a. Objects mentions in the shallow file are important, and therefore
      _are_ considered reachable on their own. Neither repack nor prune
      needs to know or care.

  OR

  2b. It's OK for shallow objects to be missing, and the shallow code
      should be more resilient to missing objects. Neither repack nor
      prune needs to know or care.

I don't know how hard it would be to get there from the current code
state, though.

-Peff
