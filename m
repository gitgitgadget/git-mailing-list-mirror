Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30F701F404
	for <e@80x24.org>; Mon, 26 Feb 2018 01:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeBZBav (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 20:30:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:36708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751913AbeBZBav (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 20:30:51 -0500
Received: (qmail 12084 invoked by uid 109); 26 Feb 2018 01:30:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Feb 2018 01:30:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8603 invoked by uid 111); 26 Feb 2018 01:31:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 25 Feb 2018 20:31:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Feb 2018 20:30:48 -0500
Date:   Sun, 25 Feb 2018 20:30:48 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] revision.c: reduce object database queries
Message-ID: <20180226013048.GA8677@sigill.intra.peff.net>
References: <1519522496-73090-1-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519522496-73090-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 08:34:56PM -0500, Derrick Stolee wrote:

> In mark_parents_uninteresting(), we check for the existence of an
> object file to see if we should treat a commit as parsed. The result
> is to set the "parsed" bit on the commit.
> 
> Modify the condition to only check has_object_file() if the result
> would change the parsed bit.
> 
> When a local branch is different from its upstream ref, "git status"
> will compute ahead/behind counts. This uses paint_down_to_common()
> and hits mark_parents_uninteresting(). On a copy of the Linux repo
> with a local instance of "master" behind the remote branch
> "origin/master" by ~60,000 commits, we find the performance of
> "git status" went from 1.42 seconds to 1.32 seconds, for a relative
> difference of -7.0%.

This looks like an obvious and easy optimization, and I'm OK with this
patch.

But looking at the existing code, it makes me wonder a few things:

> diff --git a/revision.c b/revision.c
> index 5ce9b93..bc7def5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -113,7 +113,8 @@ void mark_parents_uninteresting(struct commit *commit)
>  			 * it is popped next time around, we won't be trying
>  			 * to parse it and get an error.
>  			 */
> -			if (!has_object_file(&commit->object.oid))
> +			if (!commit->object.parsed &&
> +			    !has_object_file(&commit->object.oid))
>  				commit->object.parsed = 1;

We don't actually need the object contents at all right here. This is
just faking the "parsed" flag for later so that calls to parse_object()
don't barf.

This code comes originally form 454fbbcde3 (git-rev-list: allow missing
objects when the parent is marked UNINTERESTING, 2005-07-10). But later,
in aeeae1b771 (revision traversal: allow UNINTERESTING objects to be
missing, 2009-01-27), we marked dealt with calling parse_object() on the
parents more directly.

So what I wonder is whether this code is simply redundant and can go
away entirely. That would save the has_object_file() call in all cases.
We'd stop setting the fake commit->object.parsed flag, which in theory
means we'd make repeated failed calls to parse_commit_gently() if we
visited the same commit over and over. I wonder if add_parents_to_list()
should skip already-UNINTERESTING parents, which would mean we only try
to access each missing candidate once (OTOH missing ones are probably
rare enough that it doesn't make much difference either way).

Probably the fake commit->object.parsed flag isn't hurting anything in
practice, but it seems pretty nasty to lie about having loaded the
commit in the global store. E.g., imagine a follow-up traversal in the
same process in which that commit _isn't_ UNINTERESTING, and we'd
erroneously treat it as an available commit with no parents.

-Peff
