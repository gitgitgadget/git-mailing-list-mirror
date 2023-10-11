Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918C5CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 21:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjJKVno (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjJKVnn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 17:43:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68AC9E
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 14:43:41 -0700 (PDT)
Received: (qmail 19843 invoked by uid 109); 11 Oct 2023 21:43:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 21:43:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10274 invoked by uid 111); 11 Oct 2023 21:43:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 17:43:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 17:43:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk,
        Izzy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Izzy <winglovet@gmail.com>
Subject: Re: [PATCH v6] merge-tree: add -X strategy option
Message-ID: <20231011214340.GA518221@coredump.intra.peff.net>
References: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
 <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>
 <a482d047-dd40-436d-8daa-0c74780af11f@gmail.com>
 <20231009155315.GA3252778@coredump.intra.peff.net>
 <xmqq4jiz3env.fsf@gitster.g>
 <20231009185234.GB3270793@coredump.intra.peff.net>
 <xmqqlec9kl0k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlec9kl0k.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 12:38:03PM -0700, Junio C Hamano wrote:

> If we have no plan and intention to extend "merge-tree" even more in
> the future, then option 1 would be the approach with least patch
> noise, and as your "something like this" shows, it is a nice and
> clean solution.  I very much like it.
> 
> But as the renovated "merge-tree" is a relatively young thing in our
> toolbox, I suspect that more and more work may want to go into it.
> And the other "official copy_merge_options()" approach would be a
> more healthy solution in the longer run, I would think.  If we were
> to go that route, we should also give an interface to free the
> resources held by the copy.

I am happy with either, as they both resolve the "merge-tree knows
intimate details about merge_options" issue. The patch I showed would
require manually passing more details down to real_merge(), which is I
guess what you are getting at with the "more work may want to go into
it".

> It is not that much code on top of the commit that is already queued
> in 'next', I suspect.  Perhaps something like this?

This looks OK, though...

> +void clear_merge_options(struct merge_options *opt UNUSED)
> +{
> +	; /* no-op as our copy is shallow right now */
> +}

Clearing is generally not just about copies, but any use of the struct.
so this invites the question of whether the original non-copy struct
should have a call to clear_merge_options() in cmd_merge_tree(). And
ditto for every other user.

I do not mind adding such calls, but of course we know that they are
currently noops (and we don't have any particular plan to change that).

-Peff
