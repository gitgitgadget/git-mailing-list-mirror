Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77308C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525C824673
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgANWsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:48:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:36716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727331AbgANWsT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 17:48:19 -0500
Received: (qmail 10842 invoked by uid 109); 14 Jan 2020 22:48:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Jan 2020 22:48:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26019 invoked by uid 111); 14 Jan 2020 22:54:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2020 17:54:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Jan 2020 17:48:18 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 8/8] sparse-checkout: write escaped patterns in cone mode
Message-ID: <20200114224818.GD3957260@coredump.intra.peff.net>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <79b6e9a565fde766954d7cda84a835b9015af6cb.1579029963.git.gitgitgadget@gmail.com>
 <20200114212548.GD3949560@coredump.intra.peff.net>
 <e325daa4-5a26-3652-5f46-06203403e51d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e325daa4-5a26-3652-5f46-06203403e51d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 05:11:03PM -0500, Derrick Stolee wrote:

> > Do we need to document these rules somewhere? Naively I'd expect
> > "--stdin" to take in literal pathnames. But of course it can't represent
> > a path with a newline. So perhaps it makes sense to take quoted names by
> > default, and allow literal NUL-separated input with "-z" if anybody
> > wants it.
> 
> This is worth thinking about the right way to describe the rules:
> 
> 1. You don't _need_ quotes. They happen to come along for the ride in
>   'git ls-tree' so it doesn't mess up shell scripts that iterate on
>   those entries. At least, that's why I think they are quoted.

It's not just shell scripts. Without quoting, the syntax becomes
ambiguous (e.g., imagine a file with a newline in it). So most Git
output that shows a filename will quote it if necessary, unless
NUL separators are being used.

> 2. If you use quotes, the first layer of quotes will be removed.

I take this to mean that anything starting with a double-quote will have
the outer layer removed, and backslash escapes inside expanded. And
anything without a starting double quote (even if it has internal
backslash escapes!) will be taken literally.

That would match how things like "update-index --index-info" work.

As far as implementation, I know you're trying to keep some of the
escaping, but I think it might make more sense to do use
unquote_c_style() to parse the input (see update-index's use for some
prior art), and then re-quote as necessary to put things into the
sparse-checkout file (I guess quoting more than just quote_c_style()
would do, since you need to quote glob metacharacters like '*' and
probably "!"). But as much as possible, I think you'd want literal
strings inside the program, and just quoting/unquoting at the edges.

> How much of this needs to be documented explicitly, or how much should
> we say "The input format matches what we would expect from 'git ls-tree
> --name-only'"?

I think it's fine to say that, and maybe call attention to the quoting.
Like:

  The input format matches the output of `git ls-tree --name-only`. This
  includes interpreting pathnames that begin with a double quote (") as
  C-style quoted strings.

Disappointingly, update-index does not seem to explain the rules
anywhere. fast-import does cover it. Maybe it's something that ought to
be hoisted out into gitcli(7) or similar (or maybe it has been and I
just can't find it).

-Peff
