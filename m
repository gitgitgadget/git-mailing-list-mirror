Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFFFE95A9E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377098AbjJIPyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 11:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376789AbjJIPxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 11:53:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A20116
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 08:53:18 -0700 (PDT)
Received: (qmail 21314 invoked by uid 109); 9 Oct 2023 15:53:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 15:53:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15484 invoked by uid 111); 9 Oct 2023 15:53:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 11:53:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 11:53:15 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Izzy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Izzy <winglovet@gmail.com>
Subject: Re: [PATCH v6] merge-tree: add -X strategy option
Message-ID: <20231009155315.GA3252778@coredump.intra.peff.net>
References: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
 <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>
 <a482d047-dd40-436d-8daa-0c74780af11f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a482d047-dd40-436d-8daa-0c74780af11f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 10:58:07AM +0100, Phillip Wood wrote:

> > @@ -423,7 +425,7 @@ static int real_merge(struct merge_tree_options *o,
> >   {
> >   	struct commit *parent1, *parent2;
> >   	struct commit_list *merge_bases = NULL;
> > -	struct merge_options opt;
> > +	struct merge_options opt = o->merge_options;
> 
> Copying struct merge_options by value here is unusual in our code base. I
> don't think it introduces a bug (there is no function to free the resources
> allocated in struct merge_options so we do not end up freeing them twice for
> example) but it would be clearer that it was safe if you did
> 
> 	struct merge_options *opt = &o->merge_options;
> 
> and updated the code to reflect that opt is now a pointer or just replaced
> all uses of "opt" with "o->merge_options"

I agree that struct-copying is an unusual pattern, and we'd potentially
run into problems with duplication. But I think it is even trickier than
that here. We also go on to actually _modify_ opt in this function,
assigning to various members (both directly, and I think the merge code
itself will write to opt->priv).

So if we use a pointer (rather than struct assignment), those changes
will persist in the merge_options struct that was passed in. Which is
also weird.

Between the two, I think using a pointer is probably the least-weird.
This real_merge() function is only called once, and is a static-local
helper for cmd_merge_tree(). So the two functions work as a single unit,
and munging "opt" is not a big deal.

-Peff
