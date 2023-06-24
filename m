Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8CDEB64D7
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 01:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjFXBQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 21:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjFXBQy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 21:16:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410161715
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 18:16:53 -0700 (PDT)
Received: (qmail 13135 invoked by uid 109); 24 Jun 2023 01:16:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 24 Jun 2023 01:16:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8596 invoked by uid 111); 24 Jun 2023 01:16:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jun 2023 21:16:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jun 2023 21:16:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Clean up stale .gitignore and .gitattribute patterns
Message-ID: <20230624011651.GB95358@coredump.intra.peff.net>
References: <CAHGBnuOR+MU50jhNBHw8buWS_Yr9D92mErvgoi=cK16a=4_YUA@mail.gmail.com>
 <xmqqcz1may4g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz1may4g.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2023 at 10:26:23AM -0700, Junio C Hamano wrote:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
> > is there a command to easily check patterns in .gitignore and
> > .gitattributes to still match something? I'd like to remove / correct
> > patterns that don't match anything anymore due to (re)moved files.
> 
> I guess "git check-attr --stdin" and "git check-ignore --stdin" will
> be part of the solution to your problem, but I do not know what the
> other parts would be.
> 
> Feeding "ls-files" output to "check-ignore --stdin" feels sort-of
> oxymoron because by definition the output from "ls-files" cannot
> contain any ignored paths.

You can feed "ls-files -o" (since without --exclude-standard it lists
every untracked file in the working tree), but note that this is
inherently incomplete. Any solution like this can only tell you which
ones are unused by what's in your current working tree, not what might
be possible if you ran "make foo" or whatever.

It can be wrong the other way, too. You might have "file.foo" sitting
around from a build last year (or even sightseeing an old commit), even
though support for building ".foo" is long gone from the code base.

So you'd really want to start with a fresh clone, then run any build
commands that might possibly put cruft in the working tree (if that's
even possible on a single platform), and then do your analysis (and see
my other mail in the thread for some hacky scripting there).

-Peff
