Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05981F453
	for <e@80x24.org>; Thu, 24 Jan 2019 18:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfAXSch (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 13:32:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:47664 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726003AbfAXSch (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 13:32:37 -0500
Received: (qmail 8271 invoked by uid 109); 24 Jan 2019 18:32:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 18:32:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30833 invoked by uid 111); 24 Jan 2019 18:32:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 13:32:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 13:32:35 -0500
Date:   Thu, 24 Jan 2019 13:32:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
Message-ID: <20190124183235.GA16580@sigill.intra.peff.net>
References: <20190122232301.95971-1-nbelakovski@gmail.com>
 <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190122232301.95971-2-nbelakovski@gmail.com>
 <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
 <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
 <xmqq5zud52ut.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zud52ut.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 10:26:18AM -0800, Junio C Hamano wrote:

> Nickolai Belakovski <nbelakovski@gmail.com> writes:
> 
> > Yes, the parser used the atom argument in an earlier version of this
> > patch, but we since moved the map out of the atom since it only needs
> > to exist once globally. Even though we have a caching mechanism for
> > atoms it still seemed like a logical move to explicitly keep one
> > instance of the map globally.
> 
> I think that is a mistaken move from an earlier version to this
> one.  The worktree-related stuff only becomes necessary and belongs
> to the %(worktreepath) atom, so unless there is a compelling reason
> not to, we should hang it there, instead of introducing a global.
> When you have --format='%(worktreepath) %(worktreepath)', you'd have
> only one shared instance of it in used_atom[] to ensure that we have
> a singleton instance.

What if you have other atoms that need worktrees? E.g., does
%(worktreepath:foo) use the same used_atom slot? What if we have another
worktree-related atom?

If anything, I'd suggest going in the opposite direction, and teaching
the worktree code a function for looking up a working tree by ref. And
then it can handle its own cache to implement that reverse-mapping
efficiently.

> The object_info support in the file, which is relatively new, may be
> what you borrowed the wrong idea of preferring globals from; I think
> it should be taken as an anti-pattern.

And that one is a good example where we _do_ need the global, because we
already have multiple atoms pulling from it. I think the right level is
"global to the ref-filter context", but we do not have that concept yet
(hence why used_atoms, etc, are all file-static globals).

-Peff
