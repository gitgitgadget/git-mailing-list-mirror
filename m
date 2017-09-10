Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588BF202A4
	for <e@80x24.org>; Sun, 10 Sep 2017 17:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdIJRie (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 13:38:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:33930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750890AbdIJRie (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 13:38:34 -0400
Received: (qmail 13870 invoked by uid 109); 10 Sep 2017 17:38:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Sep 2017 17:38:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21552 invoked by uid 111); 10 Sep 2017 17:39:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Sep 2017 13:39:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Sep 2017 13:38:27 -0400
Date:   Sun, 10 Sep 2017 13:38:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 06/34] clone: release strbuf after use in remove_junk()
Message-ID: <20170910173826.jopzzt5cpc2i3c6m@sigill.intra.peff.net>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175005.20756-7-l.s.r@web.de>
 <xmqq1snj61wr.fsf@gitster.mtv.corp.google.com>
 <0884b528-d455-09c6-0eaf-d2af50077a98@web.de>
 <20170910073002.hg6tqgm2z7owqr2u@sigill.intra.peff.net>
 <7a30c171-22c8-4ae3-3e15-3f4eea893127@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a30c171-22c8-4ae3-3e15-3f4eea893127@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2017 at 12:37:06PM +0200, René Scharfe wrote:

> > And in fact, being called from a signal handler means we should
> > generally avoid touching malloc or free (which could be holding locks).
> > That would mean preferring a leak to strbuf_release(). Of course that is
> > the tip of the iceberg. We call strbuf_addstr() here, and
> > remove_dir_recursively() will grow our buffer.
> 
> And we call opendir(3), readdir(3), and closedir(3), which are also not
> listed as async-safe functions by POSIX [1].

Good point. I don't know how dangerous those are in the real-world
(i.e., is POSIX leaving an out for some implementations, or are they
really unsafe on common platforms like Linux).

> > So I actually wonder if junk_git_dir and junk_work_tree should be
> > pre-sized strbufs themselves. And that makes the leak "go away" in the
> > eyes of leak-checkers because we hold onto the static strbufs until
> > program exit.
> 
> We could start with a small buffer and expand it to match the path
> length of written files as we go.

Yes, but I didn't want to touch each code site that creates a file,
which is a lot more invasive. I expect expanding to 4096 (or PATH_MAX)
would be sufficient in practice.

I'd also note that the current code isn't _remotely_ async safe and
nobody's complained. So I'm perfectly happy doing nothing, too. I care
a bit more about the tempfile.c interface because it's invoked a lot
more frequently.

> Deletion without readdir(3) requires us to keep a list of all written
> files and directories, though.  Perhaps in the form of an append-only
> log; the signal handler could then go through them in reverse order
> and remove them.  Or is there a better way?

No, I think that's how you'd have to do it. The implementation isn't all
that bad, but hitting every file-creation would be invasive. I'd
almost rather bail to exec-ing "rm -rf $dir", but we probably can't do
_that_ in a signal-handler either. :)

-Peff
