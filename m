Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E7552023D
	for <e@80x24.org>; Fri,  3 Mar 2017 11:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbdCCLlY (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 06:41:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:37950 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbdCCLlU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 06:41:20 -0500
Received: (qmail 32480 invoked by uid 109); 3 Mar 2017 11:13:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 11:13:50 +0000
Received: (qmail 27162 invoked by uid 111); 3 Mar 2017 11:13:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 06:13:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 06:13:48 -0500
Date:   Fri, 3 Mar 2017 06:13:48 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jason Cooper <git@lakedaemon.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170303111347.6uzuhvmpdwr27qjw@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <xmqqinnyztqe.fsf@gitster.mtv.corp.google.com>
 <20170226011359.GI11350@io.lakedaemon.net>
 <20170226051834.i37mlqv5wxwz3254@sigill.intra.peff.net>
 <20170302214610.GA86054@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302214610.GA86054@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 02, 2017 at 01:46:10PM -0800, Brandon Williams wrote:

> There were a few of us discussing this sort of approach internally.  We
> also figured that, given some performance hit, you could maintain your
> repo in sha256 and do some translation to sha1 if you need to push or
> fetch to a server which has the the repo in a sha1 format.  This way you
> can convert your repo independently of the rest of the world.

Yeah, you definitely _can_ convert between the two. It's just expensive
to do so on the fly. We'd potentially want to be able to during the
transition period just to help people get all the work converted over.
But I had assumed that the conversion would be a mix of:

  1. Unpublished work (or work which is otherwise OK to be rewritten)
     could be converted to the new hash.

  2. Old history could be grafted with a parent pointer that mentions
     the tip of the old history by its new hash, but the pointed-to
     parent contains sha1s.

> As for storing the translation table, you should really only need to
> maintain the table until old clients are phased out and all of the repos
> of a project have experienced flag day and have been converted to
> sha256.

I think you've read more into my "conversion" than I intended. The old
history won't get rewritten. It will just be grafted onto the bottom of
the commit history you've got, and the new trees will all be written
with the new hash.

So you still have those old objects hanging around that refer to things
by their sha1 (not to mention bug trackers, commit messages, etc, which
all use commit ids). And you want to be able to quickly resolve those
references.

What _does_ get rewritten is what's in your ref files, your pack .idx,
etc. Those are all sha256 (or whatever), and work as sha1's do now.
Looking up a sha1 reference from an old object just goes through the
extra level of indirection.

-Peff
