Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF92EC636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 19:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjBVTrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 14:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjBVTr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 14:47:29 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B26D3E60B
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 11:47:28 -0800 (PST)
Received: (qmail 14965 invoked by uid 109); 22 Feb 2023 19:47:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Feb 2023 19:47:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10642 invoked by uid 111); 22 Feb 2023 19:47:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Feb 2023 14:47:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Feb 2023 14:47:27 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     John Cai <johncai86@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 2/2] diff: teach diff to read algorithm from diff
 driver
Message-ID: <Y/ZxT2ByET4BxGVt@coredump.intra.peff.net>
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
 <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
 <CABPp-BFCMpA=nHtb5RuQL7ACbkhSEKtvmRxKwMuktcf24uQJtQ@mail.gmail.com>
 <EE7565DF-BE70-4C45-AF0B-95C85050DFA4@gmail.com>
 <CABPp-BGDi1VQXFdGw_Y8i0ZDBOoHJe9039fh4mO44qJ-nJE1ig@mail.gmail.com>
 <47981D9E-9DC7-4C23-911D-13BA52A27040@gmail.com>
 <CABPp-BHQn0sjAMwJ+r6uenO=nGLG1HvfnhS6tG8mu1BWt4bdOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHQn0sjAMwJ+r6uenO=nGLG1HvfnhS6tG8mu1BWt4bdOw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2023 at 09:32:52AM -0800, Elijah Newren wrote:

> > I was thinking we would just use the tree-ish of the first one
> 
> That would certainly simplify, but it'd be pretty important to
> document.  (Incidentally, this kind of decision was my reason for
> asking about all those special cases earlier, i.e. how to handle diff
> between different commits, how to handle renames, how to handle bare
> repositories, etc.)
> 
> This kind of decision probably also means you'd need a variety of
> testcases where .gitattributes is different in every commit & the
> index & the working tree, and then you start testing several of the
> possible pairings to make sure the right .gitattributes file is used
> (e.g. (commit, commit), (commit, index), (index, commit), (worktree,
> index), etc.)

There may be some prior art here in how we handle mailmaps in a bare
repository. In that case, we pull them from HEAD (or really any commit
of your choosing, but the default is HEAD). That may seem a bit weird,
but it matches how non-bare repositories work, which read the mailmap
from the working tree.

So likewise, even looking at an old commit like "git show HEAD~1000", in
a non-bare repository we will read .gitattributes from the working tree,
which means it is (roughly) coming from HEAD. In some ways that is good
(there may be improvements to the attributes) and in some ways it is
weird and confusing (the meaning of the attributes may have been
different back then, or the two histories may even be somewhat
unrelated!). So I think you can make an argument either way on what is
useful, but harmonizing the non-bare and bare cases seems like the best
place to start.

And then that machinery would probably be enough to let people ask for
specific things on top (like "git show --attributes-from=HEAD~1000
HEAD~1000" if they really wanted).

-Peff
