Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363B4C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D344D64ECE
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhBZGgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 01:36:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:45568 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhBZGgN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 01:36:13 -0500
Received: (qmail 11979 invoked by uid 109); 26 Feb 2021 06:35:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 06:35:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16566 invoked by uid 111); 26 Feb 2021 06:35:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 01:35:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 01:35:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Blake Burkhart <bburky@bburky.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] open in-tree files with O_NOFOLLOW
Message-ID: <YDiWs6yyv3U9YvC2@coredump.intra.peff.net>
References: <YCsBA002yv8XpppM@coredump.intra.peff.net>
 <YCsBRUQkrAm8l2gz@coredump.intra.peff.net>
 <87y2foaltl.fsf@evledraar.gmail.com>
 <YCsc0OePtrotjeg5@coredump.intra.peff.net>
 <YCu/FoLl8p15mwio@coredump.intra.peff.net>
 <YCvaJg8o882IqNnx@coredump.intra.peff.net>
 <xmqqh7m0uezk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7m0uezk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 11:25:19AM -0800, Junio C Hamano wrote:

> >   [1/6]: add open_nofollow() helper
> >   [2/6]: attr: convert "macro_ok" into a flags field
> >   [3/6]: exclude: add flags parameter to add_patterns()
> >   [4/6]: attr: do not respect symlinks for in-tree .gitattributes
> >   [5/6]: exclude: do not respect symlinks for in-tree .gitignore
> >   [6/6]: mailmap: do not respect symlinks for in-tree .mailmap
> [...]
> 
> So, I've read these changes and they all looked quite reasonable.
>
> Where do we want to go from here?
> 
> Merge it down and forget about the changes in verify_path() and fsck
> in the jk/symlinked-dotgitx-files topic?  Do we want to also cover
> the .gitmodules file with the same mechansim?

Thanks, I'm glad somebody looked at it. :)

Having pondered it, this really seems like a less risky approach than
forbidding symlinks for those paths. It is not impacting what is allowed
in Git, so nobody's repo will break. And we do not even have to worry
that our name-matching code is correct, since we are asking the OS to do
the right thing.

The biggest risk to me is that there is some hiccup with Windows: they
don't have any NOFOLLOW equivalent, and the fallback lstat() is somehow
slower than a real open(). But that seems unlikely (I could well believe
that lstat+open is slower for them, but that only matters if you
actually have a huge number of gitattributes files to open, in which
case you're probably spending your time reading and parsing them
anyway).

So I'd be happy to proceed with this and throw out
jk/symlinked-dotgitx-files. We can salvage the fsck checks from there,
leaving them as warnings, but it's not urgent (they are just
informational as "btw, this symlink won't work like you think it will").
So I'd probably do that as a separate series.

We could also cover .gitmodules, but I'm inclined not to. It's work and
risk to convert it to this form, for little gain. Nobody seems to have
been bothered by the symlink restriction. I guess it would take some
is_ntfs_gitmodules() checks out of the verify_path() code, which could
have some small performance benefit. But we'd definitely still need to
identify .gitmodules files in fsck, because we have to check over their
actual contents.

So I'd likewise be content to leave that to another series (or never if
nobody sees an upside to it).

-Peff
