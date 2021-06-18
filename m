Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FCDC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 12:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AC8613EB
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 12:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhFRM6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 08:58:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:59912 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhFRM6F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 08:58:05 -0400
Received: (qmail 26624 invoked by uid 109); 18 Jun 2021 12:55:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Jun 2021 12:55:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15112 invoked by uid 111); 18 Jun 2021 12:55:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Jun 2021 08:55:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Jun 2021 08:55:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Tessa L. H. Lovelace" <tessa@assorted.tech>, git@vger.kernel.org
Subject: Re: Using .gitignore symbolic links?
Message-ID: <YMyX2dZ1Ut40hb1L@coredump.intra.peff.net>
References: <1623983680.3494.0@smtp.dreamhost.com>
 <87o8c34dq6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8c34dq6.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 18, 2021 at 01:15:46PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Breaking this was intentional, see https://github.com/git/git/commit/2ef579e261
> 
> That doesn't mean we can't take it back.
> 
> As discussed by Robert's reply and in that commit there's the workaround
> of .git/info/exclude and the core.excludesFile.

I'd prefer not to undo it because of the security implications that led
us there in the first place. And for the most part, there should be a
better way to accomplish the same things:

  - these symlinked files were already subtly broken; Git was not
    following the links when it read them from the index or a tree.

  - repetitive links within a tree can be refactored to use patterns in
    the top-level .gitignore, .gitattributes, etc. It may be that our
    pattern language is not sufficient for some cases, but improving
    that seems like a better path forward.

  - links that span repos can use core.excludesFile or similar (and
    conditional config can help enable them only when you want to). It
    may also be that this could be extended to cover more cases (e.g.,
    you can only have one configured excludesFile, but you may want
    several). Or just a symlink from .git/info/exclude if there's one
    per repo.

I'd be curious to hear if any of those solutions don't help in this
case.

> At the end of the day there's an inherent conflict here between security
> and convenience. We really want a repository to be safe to just "git
> clone", i.e. we don't set up any hooks, execute code etc.; these
> gitattributes and gitignore issues were on edges of that.
> 
> We can make it work as before, but it gets hard to distinguish the
> gitignore you mean, from a gitignore that's pointing to /dev/urandom
> (annoying), or to some crafted out-of-tree thing that'll cause an
> overflow in the parser and an RCE.

I agree with all of this, but I would soften the "RCE" part a bit. An
untrusted repository can already feed whatever it wants into the parser.
The danger of symlinks is that accessing out-of-tree paths may cause
unexpected results (information disclosure in some situations, but also
weirdness when opening files in /dev, /proc, etc).

> Any way out of that that's configurable is going to be be the same
> opt-in problem as core.excludesFile is now.
> 
> So I'd think our options are basically:
> 
>  1) Do nothing, it sucks for some people (like you) but we think it's worth it

I hope the "it sucks" is "the transition sucks", but they're still able
to configure Git differently to achieve the same goals in a roughly
similar way. Again, I'd be curious to hear about cases where this isn't
true.

I'm not completely opposed to having a config switch for "allow
gitignore symlinks" as an escape hatch, as long as the default is still
"off". One of the things I don't like about it is that the config option
needs to come with a warning explaining how the result is still subtly
broken.

>  2) Some DWYM middle ground, e.g. we could discover if the link points
>     to another git repo, and only trust it then, or if it's in the
>     user's $HOME or whatever.

We've talked before about identifying out-of-tree symlinks. It's not
clear to me in this case if the symlinks are to other paths within the
repository, or if they go out-of-tree.

In-tree symlinks are OK. It's just complicated and error-prone to detect
them (because of course interior paths may themselves be symlinks).

I think we'd always want to forbid out-of-tree symlinks, no matter what
they're pointing to (because we don't have any idea what's "safe" in the
user's filesystem). It's easier both us and the user to just have a
switch for "look at these symlinks anyway".

>  3) Bring back the old behavior, it was more of a "while we're at it for
>     gitattributes..." fix than something specifically a problem with
>     gitignore, the RCE threat is a hypothetical, and we can more easily
>     audit/be confident in the gitignore parser, probably...

Hopefully it's obvious at this point that I'd prefer not to go that
route. :)

Tessa mentioned one other thing, which is somewhat orthogonal to the
options you listed. The error message is just:

  warning: unable to access '.gitignore': Too many levels of symbolic links

This comes from a generic open-or-warn function. The kernel is giving us
ELOOP, which we feed to strerror(). And it's _technically_ true, in that
we allow 0 levels of symbolic links. But we could perhaps intercept
ELOOP in the gitignore and gitattributes code to produce a more coherent
warning.

TBH, I didn't give too much thought to user experience in the original
patches because my digging showed that using symlinks for these files
was exceedingly rare (at least on the corpus of GitHub repos I scanned,
but of course all the world is not hosted on GitHub, and there will
always be edge cases anyway).

-Peff
