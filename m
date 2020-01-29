Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A331EC33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D42B2070E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgA2Kdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:33:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:47376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726069AbgA2Kdx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 05:33:53 -0500
Received: (qmail 16289 invoked by uid 109); 29 Jan 2020 10:33:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 10:33:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15523 invoked by uid 111); 29 Jan 2020 10:41:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2020 05:41:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jan 2020 05:33:52 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 10/12] sparse-checkout: write escaped patterns in cone
 mode
Message-ID: <20200129103352.GD4218@coredump.intra.peff.net>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
 <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <e2f9afc70c92c606a9d93660bce0599b7b7ddf6e.1580236003.git.gitgitgadget@gmail.com>
 <20200129101713.GB4218@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200129101713.GB4218@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 05:17:13AM -0500, Jeff King wrote:

> > From: Derrick Stolee <dstolee@microsoft.com>
> > 
> > If a user somehow creates a directory with an asterisk (*) or backslash
> > (\), then the "git sparse-checkout set" command will struggle to provide
> > the correct pattern in the sparse-checkout file. When not in cone mode,
> > the provided pattern is written directly into the sparse-checkout file.
> > However, in cone mode we expect a list of paths to directories and then
> > we convert those into patterns.
> 
> Is this really about cone mode? It seems more like it is about --stdin.
> I.e., what are the rules for when the input is a filename and when it is
> a pattern? In our earlier discussion, I had assumed that command-line
> arguments to "sparse-checkout set" were actual filenames, and "--stdin"
> just read them from stdin.
> 
> But looking at the documentation, they are always called "patterns" on
> the command-line. Should the "--stdin" documentation make it clear that
> we are no longer taking patterns, but instead actual filenames?
> 
> Or am I confused, and in non-cone-mode the "ls-tree | sparse-checkout"
> pipeline is not supposed to work at all? (I.e., they really are always
> patterns)?

Hmph, sorry, I _was_ just confused. I was reading a copy of the manpage
without your final patch, which made things much clearer.

So OK, I think the resulting documentation does make things clear. And
this is just about cone mode, not --stdin. Please ignore my ramblings in
the rest of the replied-to message. But...

> > Even more specifically, the goal is to always allow the following from
> > the root of a repo:
> > 
> >   git ls-tree --name-only -d HEAD | git sparse-checkout set --stdin
> > 
> > The ls-tree command provides directory names with an unescaped asterisk.
> > It also quotes the directories that contain an escaped backslash. We
> > must remove these quotes, then keep the escaped backslashes.
> > 
> > However, there is some care needed for the timing of these escapes. The
> > in-memory pattern list is used to update the working directory before
> > writing the patterns to disk. Thus, we need the command to have the
> > unescaped names in the hashsets for the cone comparisons, then escape
> > the patterns later.
> 
> OK, this part make sense.

You could also demonstrate this even without --stdin with something
like:

  git config core.sparsecheckoutcone true
  git sparse-checkout set 'foo*bar'

which should take that as a literal filename and put the pattern
'foo\*bar' in the sparse-checkout file. And your tests do cover that.

So really there are two separate bugs here, and it might be a little
easier to explain the "timing of these escapes" thing by doing them
separately. I.e., the case above needs escaping and we could demonstrate
the bug with a command-line "set".  And then follow up by fixing the
problem with correctly de-quoting --stdin.

> > +static char *escaped_pattern(char *pattern)
> [...]
> Do we need to catch other metacharacters here (using is_glob_special()
> perhaps)?

After de-confusing myself, I think the individual code comments I wrote
still apply though (especially this one).

-Peff
