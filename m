Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD1A20966
	for <e@80x24.org>; Sat,  1 Apr 2017 08:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbdDAIVF (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 04:21:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:55329 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750904AbdDAIVD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 04:21:03 -0400
Received: (qmail 30212 invoked by uid 109); 1 Apr 2017 08:21:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 08:21:01 +0000
Received: (qmail 16295 invoked by uid 111); 1 Apr 2017 08:21:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 04:21:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 04:21:00 -0400
Date:   Sat, 1 Apr 2017 04:20:59 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] read-cache: avoid git_path() race in
 freshen_shared_index()
Message-ID: <20170401082059.wdgvcv2qv56b75b4@sigill.intra.peff.net>
References: <20170329080820.8084-1-chriscool@tuxfamily.org>
 <xmqqfuhwau6r.fsf@gitster.mtv.corp.google.com>
 <20170329175614.uecvtvmzoj2wfle3@sigill.intra.peff.net>
 <CACsJy8BR9=Ju_7tSmZEH+UDqWG3Ud1KXY-m6r_jHb-aQUoUMAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BR9=Ju_7tSmZEH+UDqWG3Ud1KXY-m6r_jHb-aQUoUMAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 04:24:40PM +0700, Duy Nguyen wrote:

> On Thu, Mar 30, 2017 at 12:56 AM, Jeff King <peff@peff.net> wrote:
> > But in the end it doesn't really matter. I think code like:
> >
> >   const char *filename = git_path(...);
> >
> > or
> >
> >   nontrivial_function(git_path(...));
> >
> > is an anti-pattern. It _might_ be safe, but it's really hard to tell
> > without following the complete lifetime of the return value. I've been
> > tempted to suggest we should abolish git_path() entirely. But it's so
> > darn useful for things like unlink(git_path(...)), or other direct
> > system calls.
> 
> Yeah. I thought we killed most of those (was it your patches?).

Yes, after fixing a bug where static buffer reuse caused git to randomly
delete a ref, I rage-converted most of the dangerous looking cases.

> I had a quick look at "git grep -w git_path" again. The ones in
> builtin/am.c, builtin/grep.c and submodule.c look very much like that
> anti-pattern. The one in read_index_from() probably should be replaced
> with git_pathdup() as well. Sorry no patches (I'm very slow these
> days).

Yeah, I think a number of them are actually OK if you dig (e.g., passing
it to am_state_init() immediately duplicates the result), but it's a bad
pattern if you have to dig to see if it's right. It's hard to tell when
a sub-function may reuse the buffer. For instance, git-init passes the
result to adjust_shared_perm(), which might lazily load the config from
disk. I don't know if that calls git_path() or not, but it's an awful
lot of code to run.

A lot of the cases look like they could be fixed by using git_path_foo()
instead of git_path("FOO"). (And in many cases we even have
git_path_foo() defined already!).

My favorite is the one in add_worktree(), which calls strbuf_addstr() on
the result of git_path(0. That one's _not_ dangerous, but surely it
would be simpler to just write directly into the strbuf. :)

-Peff
