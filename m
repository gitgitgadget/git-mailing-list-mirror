Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DED41F404
	for <e@80x24.org>; Mon, 17 Sep 2018 18:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeIQXnn (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 19:43:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:51118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727375AbeIQXnn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 19:43:43 -0400
Received: (qmail 14477 invoked by uid 109); 17 Sep 2018 18:15:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Sep 2018 18:15:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14678 invoked by uid 111); 17 Sep 2018 18:15:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 17 Sep 2018 14:15:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2018 14:15:11 -0400
Date:   Mon, 17 Sep 2018 14:15:11 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged
 content
Message-ID: <20180917181511.GA3894@sigill.intra.peff.net>
References: <20180820154120.19297-1-pclouds@gmail.com>
 <20180916063146.9850-1-pclouds@gmail.com>
 <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 07:29:26PM +0200, Duy Nguyen wrote:

> > On the other hand, if I am keeping some change that should never be
> > in a commit in the working tree file, and building the contents in
> > the index using "add -p" to incrementally, it would be the same
> > disaster as you are trying to prevent if I by mistake did a whole
> > path 'add', even if I catch myself doing so before running 'commit'
> > i.e.
> >
> >         edit X
> >         git add -p X
> >         git diff --cached X
> >         git diff X
> >         ... repeat the above number of times ...
> >         git add X ;# OOPS!
> >         git add . ;# OOPS! even worse!
> >
> > Even though this does not involve "git commit -a" or "git commit X",
> > an unrecoverable damage that requires redoing the manual work is
> > already done.
> 
> I don't see a good way to get to recover this situation. I could go
> back to the "index log" idea, where we keep a log of index changes (or
> just "interesting" changes). That way there's no behavior change at
> all. The user who accidentally updates/deletes something can always
> retrieve the old content back (assuming that they realize quickly
> since we can't keep very long log).

FWIW, I like that approach much better, since:

  1. It does not bother or restrict anybody in their workflow; instead,
     they pay the complexity price only when they know they have made a
     mistake.

  2. It covers many more cases (e.g., just doing the wrong thing via
     "add -p").

A naive index log would be pretty cheap in CPU, at least for POSIX-ish
systems. You could just hard link "index" to "index.N" before renaming
"index.lock" over "index". But I guess if you have a gigantic index,
that's less appealing. So maybe storing the equivalent of a "--raw" diff
between the two index states would make more sense (and after all, you
don't really need the stat-cache or cache-tree). It would cost more to
reconstruct the index on the fly, but then the point is that you would
create these logs a lot more than you access them.

> I've been thinking about allowing to undo worktree changes too (e.g.
> accidental "git reset --hard") and this log can cover it as well.

I like that, too. It's a little more costly just because it may involve
object-db writes, but I think in most cases it would be fine. I almost
always "git stash" away discarded changes these days instead of "git
reset --hard", because it effectively provides this kind of log.

> The only downside is we need a new command for the UI (or perhaps I
> can just add "git add --log" or something like that).

I think the reflog approach has been successful: give these intermediate
states a name. So in theory I could do something like:

  git checkout -p :@{2.minutes.ago}

though it would probably be useful to be able to walk the states, too,
just like we have "log --reflog-walk".

The syntax above is off-the-cuff (and based on the ":<stage>" index
syntax). I guess if we had a separate log for "stuff in the worktree
that got thrown away by reset" we might need a separate syntax.

> Should I just drop this patch and go that direction instead? More
> work, but maybe better end result.

I guess my whole response is a long-winded "yes". ;)

-Peff
