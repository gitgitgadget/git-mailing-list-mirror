Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC760C35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8B92187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgBNGo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:44:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:43204 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725897AbgBNGo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 01:44:29 -0500
Received: (qmail 19266 invoked by uid 109); 14 Feb 2020 06:44:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 06:44:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19341 invoked by uid 111); 14 Feb 2020 06:53:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 01:53:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 01:44:28 -0500
From:   Jeff King <peff@peff.net>
To:     Marius Bakke <marius@devup.no>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Merge hints
Message-ID: <20200214064428.GE605125@coredump.intra.peff.net>
References: <87pnexmcjr.fsf@devup.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pnexmcjr.fsf@devup.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 02, 2020 at 12:52:24PM +0100, Marius Bakke wrote:

> It would be convenient if git had a facility for adding "merge hints",
> both for automatic conflict resolution, as well as giving clues to
> persons inheriting or merging a branch.

To some degree, the git-rerere command does this.

It doesn't let you do the kind of pattern transformations you suggested,
but it does let you resolve a _particular_ conflict once, and then
repeat it again. So it's useful if you're going to find the same
conflict multiple times (e.g., merging to multiple long-running
branches) or if you want to communicate resolutions to somebody (you can
share your merge result, and they can use rerere-train to seed their own
database).

But it sounds like you're more interested in the pattern ones, where you
don't see the _same_ conflict over and over, but rather just similar
ones (your example where one side changes the signature of foo(), but
the other side keeps adding new callers).

In my experience you can't really solve that in an automated way (you
have to decide in each case what should go into the new parameter!). But
assuming you could, it seems like this could all be done outside of Git
itself.

For example:

> It seems to me that git could offer better tools to deal with this.
> Perhaps a ".mergehints", where you could provide a regular expression
> either for automatic merge resolution, or just have git complain loudly
> when a given pattern is merged (say, introduce conflict markers even
> though there were no "real" conflicts).  I.e.:
> 
> [hint1]
> files = *.c
> pattern = FOO_STR
> transform = s/FOO_STR/STR
> 
> [hint2]
> files = *.py
> pattern = 'foo('
> conflict = true

Once Git sees the conflicted state, you should be able to mark up those
conflicts using an external tool. You operate on the file with conflict
markers from your working tree, or you can access the original base,
"theirs" and "ours" content in stages 1, 2, and 3 of the index. So if
you have a smart tool which understands merging and understands the
syntax of your files, it could apply those transforms.

That's more or less how git-mergetool works (feeding those three files
to whatever custom tool you like). I don't have a good knowledge of what
tools are out there that might support something like this, though (I
typically just look at the conflicts manually in an editor).

-Peff
