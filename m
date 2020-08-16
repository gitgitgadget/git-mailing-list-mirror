Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D97C433DF
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 08:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4562065C
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 08:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgHPIyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 04:54:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:60416 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgHPIyH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 04:54:07 -0400
Received: (qmail 24237 invoked by uid 109); 16 Aug 2020 08:54:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 16 Aug 2020 08:54:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6771 invoked by uid 111); 16 Aug 2020 08:54:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 16 Aug 2020 04:54:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 16 Aug 2020 04:54:06 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] dir: make clear_directory() free all relevant memory
Message-ID: <20200816085406.GB1221900@coredump.intra.peff.net>
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
 <068e097e22fa42b79e70b0346cc7460f1a3cbcff.1597561152.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <068e097e22fa42b79e70b0346cc7460f1a3cbcff.1597561152.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 16, 2020 at 06:59:10AM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> The calling convention for the dir API is supposed to end with a call to
> clear_directory() to free up no longer needed memory.  However,
> clear_directory() didn't free dir->entries or dir->ignored.  I believe
> this was oversight, but a number of callers noticed memory leaks and
> started free'ing these, but often somewhat haphazardly (sometimes
> freeing the entries in the arrays, and sometimes only free'ing the
> arrays themselves).  This suggests the callers weren't trying to make
> sure any possible memory used might be free'd, but just the memory they
> noticed their usecase definitely had allocated.  This also caused the
> extra memory deallocations to be duplicated in many places.
> 
> Fix this mess by moving all the duplicated free'ing logic into
> clear_directory().

Makes sense. I don't know the dir.c code very well, so my worry would be
that some caller really wanted the other fields left untouched. But
looking over the callers, it seems they're all clearing it before the
struct goes out of scope. It's possible that they could have created
other pointer references, but it seems unlikely (and I'd argue they
should stop doing that and make their own copies of the data). E.g.,
wt_status_collect_untracked() sticks names into a string_list, but it
sets strdup_strings to make its own copy, so it's good.

> @@ -3034,6 +3031,13 @@ void clear_directory(struct dir_struct *dir)
>  		free(group->pl);
>  	}
>  
> +	for (i = 0; i < dir->ignored_nr; i++)
> +		free(dir->ignored[i]);
> +	for (i = 0; i < dir->nr; i++)
> +		free(dir->entries[i]);
> +	free(dir->ignored);
> +	free(dir->entries);
> +
>  	stk = dir->exclude_stack;
>  	while (stk) {
>  		struct exclude_stack *prev = stk->prev;

In most of our "clear" functions, the struct is ready for use again
(i.e., fields are set back to the initialized state). I don't think any
caller cares at this point, but it may be worth doing while we are here
as a least-surprise thing. That would mean setting these pointers to
NULL, and probably a few others that you aren't touching here.

Perhaps even easier would be to add a dir_init() call at the end after
your next patch adds that function.

-Peff
