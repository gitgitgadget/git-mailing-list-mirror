Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDCF620357
	for <e@80x24.org>; Sun, 16 Jul 2017 10:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdGPKBo (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 06:01:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:41900 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751048AbdGPKBn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 06:01:43 -0400
Received: (qmail 22488 invoked by uid 109); 16 Jul 2017 10:01:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 10:01:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24331 invoked by uid 111); 16 Jul 2017 10:01:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 06:01:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 06:01:41 -0400
Date:   Sun, 16 Jul 2017 06:01:41 -0400
From:   Jeff King <peff@peff.net>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>
Subject: Re: reftable: new ref storage format
Message-ID: <20170716100141.h4skqqod6lq5s5cc@sigill.intra.peff.net>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
 <CAJo=hJts=wY4vBaLsOtoH8+LBFK_drBhHMxPvKoQcqtpOfJOog@mail.gmail.com>
 <20170714200830.iks5drqu72cypkny@sigill.intra.peff.net>
 <CAJo=hJtMo4OSxcYbq4oecTQYnwTR0zK8HgyqVEhOYZ-4eu4S9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJo=hJtMo4OSxcYbq4oecTQYnwTR0zK8HgyqVEhOYZ-4eu4S9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 15, 2017 at 11:01:47PM -0700, Shawn Pearce wrote:

> > How deep would you anticipate stacks getting? Would it be feasible for
> > the tip to contain the names of the tables in the entire chain? If we're
> > talking about 20 (or even 32) bytes per name, you could still fit over a
> > hundred names in a 4K inode.
> 
> I think we'd want to keep the stacks under 32, which is a reasonable
> amount of space used in the header of each reftable. I don't have this
> yet in my updated document + implementation, but I'll look at trying
> to add it over the next couple of days. Your idea to hold the explicit
> list of the stack in each reftable makes for a very safe atomic reader
> view.

Great.  I was thinking about this a bit and have one more possible
tweak.

If you store the names of the dependent reftables in each table, then
you end up using storage quadratic in the size of the stack. Because
the bottom-most table has 0 pointers, then the next one has 1, and then
next one has 2, and so on, until the nth one has n.

Now we're talking about n=32 here, so that's probably OK.

But one variant is that the reftables _don't_ know about their
ancestors. Instead, the list of reftables is kept in a top-level pointer
file, and it's that pointer file which is rewritten on update. I.e., a
write is something like:
 
   1. Take reftable.lock

   2. Write reftables/1234abcd to represent your update.

   3. Copy the old reftable to reftable.lock, then append "1234abcd".

   4. Atomic rename into place.

And the reader is just:

  1. Open reftable, read the list of tables.

  2. In parallel, open/fetch each of the tables and find your starting
     pointer for iteration/lookup.

  3. Do a list-merge on the open tables.

The one thing you lose is that "unreachable" reftables no longer form a
meaningful hierarchy. With the pointers inside the reftables themselves,
if your "reftable" file got corrupted, you could find the dangling table
at the apex of the graph and have a good guess at the ref state.
Without, you just have a jumble of states and you don't know which takes
precedence (though you could probably make a good guess from mtimes).

> I added log support to the reftable format. I updated [1] to reflect
> log blocks at the end of the file. I ran a year's worth of log
> records, 149,932 log entries on 43,061 refs to test:

Cool. I'll be on vacation for the next week, so apologies if I don't
keep the discussion going. But I'm very excited about the overall
direction. :)

-Peff
