Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F07C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 21:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6785B2088E
	for <git@archiver.kernel.org>; Thu, 28 May 2020 21:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436694AbgE1VvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 17:51:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:59324 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436611AbgE1VvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 17:51:09 -0400
Received: (qmail 32183 invoked by uid 109); 28 May 2020 21:51:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 May 2020 21:51:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18738 invoked by uid 111); 28 May 2020 21:51:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 May 2020 17:51:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 May 2020 17:51:07 -0400
From:   Jeff King <peff@peff.net>
To:     Steven Willis via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Steven Willis <onlynone@gmail.com>
Subject: Re: [PATCH] doc: ls-tree paths do not support wildcards
Message-ID: <20200528215107.GA1265681@coredump.intra.peff.net>
References: <pull.796.git.git.1590700996483.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.796.git.git.1590700996483.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 09:23:16PM +0000, Steven Willis via GitGitGadget wrote:

> From: Steven Willis <onlynone@gmail.com>
> 
> Signed-off-by: Steven Willis <onlynone@gmail.com>
> ---
>     doc: ls-tree paths do not support wildcards
>     
>     The documentation for ls-tree says that paths can be wildcards, but this
>     appears to be incorrect, only raw paths seem to work.

This part probably should be in the commit message. :)

>  [<path>...]::
> -	When paths are given, show them (note that this isn't really raw
> -	pathnames, but rather a list of patterns to match).  Otherwise
> +	When paths are given, show them (note that this is really raw
> +	pathnames, not a list of patterns to match).  Otherwise
>  	implicitly uses the root level of the tree as the sole path argument.

You're right that we don't match globs, but I don't think it's accurate
to say that these aren't patterns, or that they are raw pathnames. We
_do_ parse them as pathspecs, include magic prefixes. E.g.:

  $ git -C Documentation ls-tree HEAD -- :/Makefile
  100644 blob 90aa329eb7836824a7a45383e4b5b157124d815c	../Makefile

And we complain about pathspec magic that isn't supported in the
matching code:

  $ git ls-tree HEAD -- :^Makefile
  fatal: :^Makefile: pathspec magic not supported by this command: 'exclude' (mnemonic: '!')

But we don't complain about an attempt to use glob characters (which
_could_ really be an attempt to specify a funny-named file, though I
guess you could argue the same for ":" magic).

So I think for now we ought to explain the situation a bit more clearly:
leave this language as-is, but add a new section describing what
patterns we do support.

In the long run it would be nice to actually match regular pathspecs.
That would be a backwards-incompatibility, which I think is why nobody
has pursued it further (and ls-tree is meant to be plumbing that should
stay consistent, so we need to be extra careful). So we'd need a
transition plan. Perhaps:

  1. Deprecate the current behavior in the documentation and release
     notes, encouraging people who want literal matching to use
     --literal-pathspecs or the ":(literal)" magic. AFAICT we've
     supported these since at least 2013 for this command, so it should
     be safe to use unconditionally.

  2. Add a new option, "--use-pathspecs" or similar, that switches the
     matching code to use match_pathspec(). That lets people use the new
     feature immediately if they want to.

  3. When --use-pathspecs is not in use, warn to stderr about any
     wildcard characters in the input. That reinforces the deprecation
     notice in (1) and is likely to get more people's attention.

  4. After several releases, flip the default to --use-pathspecs,
     leaving --no-use-pathspecs as an escape hatch for people who still
     haven't switched their scripts.

  5. After several more releases, eventually remove the old-style
     matching (perhaps leaving --use-pathspecs as a noop).

To be honest, that may be more careful than we absolutely need to be.
We'd only do the wrong thing if you really do have files with glob
metacharacters in their names. And if you're expecting to match names
literally and not using ":(literal)" or similar, your script is
_already_ wrong, since it would be barfing on names starting with a
colon. I have a feeling we made that backwards-incompatible change when
this was converted to pathspecs years ago, and nobody noticed either
way.

-Peff
