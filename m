Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ECFD1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 17:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbeIRXIn (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 19:08:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:52294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729037AbeIRXIn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 19:08:43 -0400
Received: (qmail 7875 invoked by uid 109); 18 Sep 2018 17:35:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Sep 2018 17:35:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9302 invoked by uid 111); 18 Sep 2018 17:35:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Sep 2018 13:35:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2018 13:35:03 -0400
Date:   Tue, 18 Sep 2018 13:35:03 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged
 content
Message-ID: <20180918173503.GE15470@sigill.intra.peff.net>
References: <20180820154120.19297-1-pclouds@gmail.com>
 <20180916063146.9850-1-pclouds@gmail.com>
 <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
 <20180917181511.GA3894@sigill.intra.peff.net>
 <CACsJy8CFf7mVMbxWO9ASfVKE_PLdiLmxSN3CuMC=_sEsL_5pmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CFf7mVMbxWO9ASfVKE_PLdiLmxSN3CuMC=_sEsL_5pmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 08:41:36PM +0200, Duy Nguyen wrote:

> > I think the reflog approach has been successful: give these intermediate
> > states a name. So in theory I could do something like:
> >
> >   git checkout -p :@{2.minutes.ago}
> >
> > though it would probably be useful to be able to walk the states, too,
> > just like we have "log --reflog-walk".
> >
> > The syntax above is off-the-cuff (and based on the ":<stage>" index
> > syntax). I guess if we had a separate log for "stuff in the worktree
> > that got thrown away by reset" we might need a separate syntax.
> 
> I'm leaning towards reflog too. Not because of the syntax but because
> of reusing the current code base. I don't have to worry about pruning,
> walking, gc-ing... because it's pretty much already there. And the UI
> is not so urgent since reflog file is very readable, early adopters
> can just open the file and get the hash.

Ah, good point on pruning/gc. I had imagined a new "index log" format.
But really if you just turn the result into a tree, then it becomes just
another ref(log). That might be slightly less efficient, but the
flexibility and simplicity are probably worth it. Or maybe with
cache-tree it is not even less efficient.

So that definitely seems like the right direction.

> I'm trying to quickly make something that writes to
> "$GIT_DIR/logs/index" and see how it goes. But yeah I'll probably drop
> this patch. The ":@{2.minutes.ago}" just makes me like this direction
> more, even though I don't know if I could even make that work.

I think "index@{2.minutes.ago}" would almost work, but it would probably
complain about a reflog without a matching ref. That seems like it would
be pretty easy to work around in the reflog code. Or maybe even by
having a stash-like "index log" ref.

-Peff
