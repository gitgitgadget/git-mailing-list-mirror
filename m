Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C76C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 04:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDREM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 00:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDREM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 00:12:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3946B4
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 21:12:54 -0700 (PDT)
Received: (qmail 32712 invoked by uid 109); 18 Apr 2023 04:12:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 04:12:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30469 invoked by uid 111); 18 Apr 2023 04:12:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 00:12:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 00:12:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>, git@vger.kernel.org
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order':
 Commits from 2011 are treated to be before 1980
Message-ID: <20230418041253.GD60552@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <xmqqa5z6q1jl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5z6q1jl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 02:51:42AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There may be also cases where the two diverge. Obviously having two
> > parsers isn't ideal. I think sharing the code may involve a lot of work,
> > though. The pretty-print parser is interested in pulling out more
> > information, and is less focused on performance. Parsing commits is
> > traditionally a hot path, as we historically had to parse every commit,
> > even if we weren't showing it (including non-log operations like
> > computing merge bases, reachability, and so forth).
> >
> > But that may not matter so much. One, we already inflate the whole
> > commit object, not just the header. So even if we spend a few extra
> > instructions on parsing, it may not be noticeable. And two, these days
> > we often cache commit metadata in the commit-graph files, which avoids
> > loading the commit message entirely (and thus this parsing) for most
> > operations.
> 
> Makes readers wonder which parser is used to parse commit objects in
> order to populate the commit-graph files.  If that step screws up,
> we'd record a broken timestamp there X-<.

It should be be the parse_commit() one, since the commit-graph writing
code works off of parsed "struct commit" objects to find its data. Which
is good, since we may silently optimize out a parse in favor of the
commit-graph; we'd want the two to always match. So recording a broken
timestamp there is OK (but see below).

Where it gets trickier is if we then fix the parser to handle this case.
Now the commit-graph stores a broken value, and further writes are
clever enough to say "ah, I already have that commit in the graph; no
need to recompute its values". So once you start using a version of Git
with the more lenient parser, you'd have to manually blow away any graph
files and rebuild to see the benefit.

One thing the commit graph perhaps _could_ do is omit the commit, or
mark it as "this one is broken in some way". And then fall back to
parsing those few instead (which is slower, but if it's a small minority
of commits, that's OK). But I don't think there's any code for that. And
it's kind of tricky anyway, because the parser just sets the date to "0"
with no indication that there was any potential error. So it's probably
solvable, but perhaps not worth the effort. The current rule is just
"whatever we got from parsing is what the commit-graph will return",
which works well in practice unless the parser changes.

-Peff
