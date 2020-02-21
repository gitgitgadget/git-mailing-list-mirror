Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE04EC11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6E6222C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgBUDQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:16:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:50008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729027AbgBUDQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 22:16:52 -0500
Received: (qmail 14833 invoked by uid 109); 21 Feb 2020 03:16:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Feb 2020 03:16:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15536 invoked by uid 111); 21 Feb 2020 03:25:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Feb 2020 22:25:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Feb 2020 22:16:51 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] clone: pass --single-branch during
 --recurse-submodules
Message-ID: <20200221031651.GA1278019@coredump.intra.peff.net>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200128221736.9217-1-emilyshaffer@google.com>
 <20200130102303.GD840531@coredump.intra.peff.net>
 <20200221025306.GK2447@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221025306.GK2447@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 06:53:06PM -0800, Emily Shaffer wrote:

> On Thu, Jan 30, 2020 at 05:23:03AM -0500, Jeff King wrote:
> > On Tue, Jan 28, 2020 at 02:17:36PM -0800, Emily Shaffer wrote:
> 
> Ouch. I forgot about this review for some time. Sorry :)

That's OK. I forgot about, too. :)

> > This makes sense to me, bearing in mind that I'm not at all a good
> > person to point out subtleties with submodules that could bite us.
> 
> I wonder if it makes sense to ship this to our submodule-using masses
> here for a little while and see how it works / whether anybody yells?
> This might be too small for that kind of thing.

Certainly putting it in front of more users gives us more confidence.
But I have a feeling the gotcha here would be that it does what _some_
set of users wants, but not so much for others. And your audience may
not be a representative sample. So certainly it doesn't hurt, but I'll
leave it you whether you think it's worthwhile.

I'm having trouble even coming up with a devil's advocate example for
the "others" in this case, though. Getting general exposure in "next"
and then "master" leading up to the release might also help, but I get
the impression that those audiences aren't necessarily comprehensive,
either.

> > > As discussed in the thread for v1 of this patch, in cases when the
> > > submodule commit referenced by the specified superproject branch isn't
> > > the same as the HEAD of the submodule repo known by the server side,
> > > this still works in kind of a non-obvious way. In these cases, first we
> > > fetch the single branch that is the ancestor of the server's HEAD; then
> > > we fetch the commit needed by the superproject (and its ancestry). So
> > > while this change prevents us from fetching *all* branches on clone, it
> > > doesn't necessarily limit us to a single branch as described.
> > 
> > Is it worth adding a test that we do the right thing here? Not so much
> > to prove that it works now, but to protect us against future changes. It
> > seems like the sort of thing that could get subtly broken.
> 
> What did you have in mind beyond the test I added already?

I think your test just covers the "happy path" that what we want to
fetch is on the tip of that single branch. But do we test a case where
the commit we need for a submodule isn't on the HEAD branch of that
submodule, and we "clone --single-branch --recurse-submodules" the
superproject and it works? I.e., from what you describe above it should
work, but it might be nice to make sure it continues to do so.

> > > -update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
> > > +update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--single-branch] [--] [<path>...]::
> > 
> > This line is horrendously long. Not new in your patch, but I wonder if
> > the time might have come to break it up.
> 
> I dug around in Asciidoc doc and couldn't find a good way to do so. The
> trailing :: means this command listing is done as a "definition list",
> and I just didn't see any way to multiline an entry for such a thing. :(

Hmm, yeah. Personally I think it would be better as:

  update [options] [--] [<path>...]::
     ...
     The supported options are:

       --init::
         ...here's what init does...

but I guess some of them are repeated between commands, which would need
addressing. Anyway, it's clear this is way beyond the scope of your
patch, so let's forget about it for now.

-Peff
