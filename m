Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D864C25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 07:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbiHNHDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 03:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHNHDh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 03:03:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21431EEE2
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 00:03:36 -0700 (PDT)
Received: (qmail 18650 invoked by uid 109); 14 Aug 2022 07:03:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 14 Aug 2022 07:03:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31757 invoked by uid 111); 14 Aug 2022 07:03:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Aug 2022 03:03:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 14 Aug 2022 03:03:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Xavier Morel <xavier.morel@masklinn.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] actually detect bad file modes in fsck
Message-ID: <YvieR3Jy9d0JB9IB@coredump.intra.peff.net>
References: <B3488A12-BCE3-48C8-915C-E2AC4E71ECD2@masklinn.net>
 <YvLkU3X9lBsG8wXp@coredump.intra.peff.net>
 <YvLttyyaZWm4pitu@coredump.intra.peff.net>
 <6688857F-B899-4253-933B-0DFE25155D13@masklinn.net>
 <YvQPQUuC+IxO0uo4@coredump.intra.peff.net>
 <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
 <220811.86r11nqfi2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220811.86r11nqfi2.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 11, 2022 at 11:39:42AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > OK, so here are cleaned-up patches to do that.
> >
> >   [1/3]: tree-walk: add a mechanism for getting non-canonicalized modes
> >   [2/3]: fsck: actually detect bad file modes in trees
> >   [3/3]: fsck: downgrade tree badFilemode to "info"
> 
> This LGTM.
> 
> I noticed/reported this issue more than a year ago, but the series I had
> for fixing it ended up being dropped, here's the report/analysis at the
> time:
> https://lore.kernel.org/git/20210308150650.18626-31-avarab@gmail.com/
> 
> Basically I was taking a much longer way around to avoid...

I took a look at that patch, but I'd really prefer _not_ to lose the
auto-canonicalizing for most code paths. It's an easy thing to forget
about, and the current state protects most code from getting confused by
malicious or buggy modes.

> >  	/* counts the number of bytes left in the `buffer`. */
> >  	unsigned int size;
> > +
> > +	/* option flags passed via init_tree_desc_gently() */
> > +	enum tree_desc_flags {
> > +		TREE_DESC_RAW_MODES = (1 << 0),
> > +	} flags;
> >  };
> 
> ...this from 1/3 here, i.e. now we're paying the cost of an extra entry
> in every "struct tree_desc" user (which includes some hot codepaths),
> and just for this one fsck caller.

Yes, but I don't think tree_desc itself is very hot. We allocate one per
iteration on the stack, not one per tree. So you'd have at most N at
once for a tree with depth N. And the rest of tree_desc is...already not
very lightweight.

In fact, I think this flag ends up in what is currently padding (I get
72 bytes for the struct before and after). Though in the long run that
"unsigned int" should almost certainly become a "size_t", which would
fill out that padding. I still doubt it's measurable.

> I wonder if we couldn't introduce a init_tree_desc_gently_flags() for
> this instead. You note in 1/3 that you're (rightly) avoiding the churn
> of existing callers, but they could just use a "static inline" wrapper
> function that would set those flags to 0, we'd pass the flags down, and
> not put them into the "tree_desc" struct.

You'd need not just that function, but wrappers for the iterator
functions. I agree it could work. It just seemed less clean to me.

> Arguably it doesn't belong there at all, since this new thing is really
> an "opts" struct, but "tree_desc" is for "the state of the walk".

I think that's a philosophical difference, and not one I really agree
with. I'd argue that options are part of the state (and we mingle them
already in other structs like rev_info).

> It might/would make sense as a "raw_mode" in "struct name_entry"
> perhaps, but then we're gettin closer to the larger scope of my initial
> larger series, oh well ... :)

Yes, I'd be OK with that approach, too. But aren't we now similarly
bloating things for a value that most callers won't care about? ;)

-Peff
