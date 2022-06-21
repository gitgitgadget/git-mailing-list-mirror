Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10BBC433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 06:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346241AbiFUG4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 02:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiFUG4v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 02:56:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1E21CFCF
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 23:56:50 -0700 (PDT)
Received: (qmail 30499 invoked by uid 109); 21 Jun 2022 06:56:49 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Jun 2022 06:56:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Tue, 21 Jun 2022 02:56:49 -0400
From:   Jeff King <peff@peff.net>
To:     Brad Forschinger <bnjf@bnjf.id.au>
Cc:     Brad Forschinger via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-prompt: use builtin test
Message-ID: <YrFrsZj8w0i6PPiz@coredump.intra.peff.net>
References: <pull.1260.git.1655197751403.gitgitgadget@gmail.com>
 <YquwpxEoAVWen8tZ@coredump.intra.peff.net>
 <Yq57MP47M5fAzkFC@bnjf.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yq57MP47M5fAzkFC@bnjf.id.au>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 19, 2022 at 01:26:08AM +0000, Brad Forschinger wrote:

> > But at some point we may say "you have made the environment too hostile
> > for us to function". Is redefining "test" to something that doesn't
> > behave the same way such a case? Part of me wants to say yes. :)
> 
> I'd be inclined to agree!  But disregarding a user with malicious
> intent, these environment changes can also be unintentional: I came
> across it when I stubbed out a quick test() function while prototyping
> something unrelated.

I kind of wonder what else would have trouble with your accidental
breakage. I poked at the bash-completion package as the only other
prominent "source this into your bash script" package I could think of.
They do indeed seem to mostly avoid "test", though there are a few cases
in program-specific completions.

In the general case, though, I think it's an infinite rabbit hole. I can
similarly redefine "declare" or "local" and cause all sorts of trouble.
And there's no real defense for scripts there.

> >   - my biggest concern on cost is that this is an unusual style for our
> >     project (which usually writes in POSIX shell, though of course this
> >     file is meant to be bash/zsh specific). Will it be a maintenance
> >     burden going forward?
> 
> That's possible, but I suspect the burden is minimal.  As you said, this
> is bash and zsh specific, and for those shell coders who only write
> Bourne dialect it's to be read as a "strong" left square bracket.  For
> example, to minimize any shock to the eyeballs I've intentionally not
> re-written string operations `[ a = b ] && [ c = d ]` to `[[ a == b && c
> == d ]]`.  I promise it wasn't mere laziness!

I guess my concern was less about doing it once, and more about: is this
something we want to continue enforcing as time goes on? That is, would
we want to catch it in review and complain about people using "test"?
That's a subtle thing to remember to look for, though I guess we could
automate it via the tests. Or would we rely on people who cared to
notice new instances and submit patches? That's how we deal with some
other portability issues (if nobody is screaming, how broken could it
be?). But it sounds from your description like this was a one-off even
for you.

So I dunno. I'm not really opposed, but I'm not convinced it's really
accomplishing much here.

-Peff
