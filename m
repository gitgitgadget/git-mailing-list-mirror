Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A68C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527BC2071E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391776AbgAXTBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:01:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:43894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390226AbgAXTBU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 14:01:20 -0500
Received: (qmail 7628 invoked by uid 109); 24 Jan 2020 19:01:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Jan 2020 19:01:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10330 invoked by uid 111); 24 Jan 2020 19:08:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jan 2020 14:08:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jan 2020 14:01:19 -0500
From:   Jeff King <peff@peff.net>
To:     David =?utf-8?B?QnVyc3Ryw7Zt?= <davidburstrom@spotify.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug or unexpected behaviour in git show <rev>:a\b
Message-ID: <20200124190119.GB1672342@coredump.intra.peff.net>
References: <CAA-mk2_jB2X1J-NCXQ92spa-fmEct9G9f1iQo7t8=rvD5coFDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA-mk2_jB2X1J-NCXQ92spa-fmEct9G9f1iQo7t8=rvD5coFDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 01:45:28PM +0100, David Burström wrote:

> As part of some experiments on running git on Windows, I found
> something unexpected. If I use e.g. bash to run the following in a
> repository:
> 
> git show HEAD:a\\b
> 
> the command stalls for a short while and then exits with 0 and prints
> nothing on stdout. I've verified this on git 2.25.0 and 2.21.0. I
> would have expected either "fatal: Path 'a\b' does not exist in
> 'HEAD'" or something of that nature. Nothing in "man git revisions"
> hint that backslash is treated specially. Is this a bug or is it an
> undocumented feature?

Maybe both. :) This is an interesting case.

The arguments to git-show (like anything that invokes the revision
machinery, like git-log) can be _either_ an object identifier or a
pathspec. Since you didn't provide a "--" separator to disambiguate,
we'll try both.

For your case "HEAD:a\b", as well as the more mundane "HEAD:a-b",
get_oid() realizes they are not valid object identifiers (because the
files don't exist in HEAD^{tree}). So then we consider it as a pathspec.

In the case of "HEAD:a-b", no such file exists in the working tree
either, so we complain:

 $ git show HEAD:a-b
 fatal: Path 'a-b' does not exist in 'HEAD'

and here verify_filename(), which produces the error, is smart enough to
diagnose that the bogus argument looks a lot like a request for a
path-in-tree.

But since 28fcc0b71a (pathspec: avoid the need of "--" when wildcard is
used, 2015-05-02), we allow non-files as pathspecs if they use magic
glob meta-characters (to make it more convenient to use "*.c" or
similar). And "\" is such a meta-character. So we actually diff HEAD
using the pathspec "HEAD:a\b", which of course matches nothing.

You can defeat this by using "--". I.e.:

  [mundane name, dwim logic complains because file doesn't exist]
  $ git show HEAD:a-b
  fatal: Path 'a-b' does not exist in 'HEAD'

  [mundane name, explicit pathspec does diff with no matches]
  $ git show -- HEAD:a-b

  [mundane name, explicit revision complains that it can't be resolved]
  $ git show HEAD:a-b --
  fatal: bad revision 'HEAD:a-b'

  [exotic name, dwim considers it a pathspec due to metacharacter]
  $ git show HEAD:a\\b

  [exotic name, explicit pathspec does the same thing]
  $ git show -- HEAD:a\\b

  [exotic name, explicit revision is just like the mundane case]
  $ git show HEAD:a\\b --
  fatal: bad revision 'HEAD:a\b'

So everything is working as designed, or at least explainable. But I
think there is some room for improvement. A backslash that isn't
followed by a glob meta-character _is_ still a meta character (your
"a\b" would be globbing for "ab"). But it's useless enough that I think
it shouldn't be enough to trigger the "oh, you probably meant this as a
pathspec" DWIM rule.

We _could_ also say "even though this could technically be a pathspec
because of its metacharacter, it looks vaguely enough like a
path-in-tree revision that we shouldn't guess". That I'm less
comfortable with, just because it makes the heuristics even more
magical.

Also, unrelated to your problem, but I find it interesting in the output
above that "git show HEAD:foo --" produces a less useful error message
than "git show HEAD:foo" without the separator, even though the user has
given us even more information about their intent. I think the DWIM
verify_filename() has grown a lot more diagnosis code over the years
that could also be used in the other code path.

-Peff
