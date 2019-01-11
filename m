Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A946211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 16:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbfAKQKY (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 11:10:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:33814 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729235AbfAKQKX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 11:10:23 -0500
Received: (qmail 758 invoked by uid 109); 11 Jan 2019 16:10:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 16:10:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10630 invoked by uid 111); 11 Jan 2019 16:10:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 11:10:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 11:10:22 -0500
Date:   Fri, 11 Jan 2019 11:10:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] gc/repack: release packs when needed
Message-ID: <20190111161021.GE16754@sigill.intra.peff.net>
References: <pull.95.git.gitgitgadget@gmail.com>
 <7eee3d107927b30bd3e1ec422e833111627252ce.1544911438.git.gitgitgadget@gmail.com>
 <xmqqmuo81b2n.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmuo81b2n.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 01:01:36PM -0800, Junio C Hamano wrote:

> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 871a56f1c5..df90fd7f51 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -659,8 +659,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
> >  
> >  	report_garbage = report_pack_garbage;
> >  	reprepare_packed_git(the_repository);
> > -	if (pack_garbage.nr > 0)
> > +	if (pack_garbage.nr > 0) {
> > +		close_all_packs(the_repository->objects);
> >  		clean_pack_garbage();
> > +	}
> 
> Closing before removing does make sense, but wouldn't we want to
> move reprepare_packed_git() after clean_pack_garbage() while at it?
> After all, the logical sequence is that we used the current set of
> packs to figure out whihch ones are garbage, then now we are about
> to discard.  We close the packs in the current set (i.e. the fix
> made in this patch), discard the garbage packs.  It would make sense
> to start using the new set (i.e. "reprepare") after all that is
> done, no?  Especially, given that the next step (write-commit-graph)
> still wants to read quite a lot of data from now the latest set of
> packfiles...

I agree that your suggested ordering makes more sense, but I don't think
it matters in practice with the current code. reprepare_packed_git()
never throws away old pack entries (and if they're mmap'd, we might even
continue to use them). So the end result is the same either way.

-Peff
