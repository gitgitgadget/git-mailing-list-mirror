Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABBFC33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 08:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA6F20732
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 08:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgA2INB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 03:13:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:47264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726068AbgA2INB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 03:13:01 -0500
Received: (qmail 15444 invoked by uid 109); 29 Jan 2020 08:13:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 08:13:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14741 invoked by uid 111); 29 Jan 2020 08:20:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2020 03:20:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jan 2020 03:12:59 -0500
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Message-ID: <20200129081259.GB601903@coredump.intra.peff.net>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
 <20200128073100.GA563058@coredump.intra.peff.net>
 <2215899.n3y15ba4yI@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2215899.n3y15ba4yI@mfick-lnx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 08:36:53AM -0700, Martin Fick wrote:

> > There's a slight downside in that tools which _aren't_ careful about
> > repositoryformatversion might try to operate on the repository, writing
> > into refs/ or whatever. But such tools are broken, and I'm not sure we
> > should be catering to them (besides which, the packed-refs ship sailed
> > long ago, so they're already potentially dangerous).
> 
> Could you elaborate on this a bit because it seems on the surface that these 
> tools aren't very dangerous, and therefore likely many of them exist?
> 
> What are the dangers today of tools that understand/operate on loose and 
> packed refs without reading repositoryformatversion?

I was mostly thinking of hacky scripts that tried to touch .git/refs
directly. And there are a few levels of dangerous there:

  - if you're doing "echo $sha1 >.git/refs/heads/master", then you're
    not locking properly. But it would probably work most of the time.

  - if you're properly taking a lock on ".git/refs/heads/master.lock"
    and renaming into place but not looking at packed-refs, then you
    might overwrite somebody else's update which is in the packed file

  - if you're trying to read refs and not reading packed-refs, obviously
    you might miss some values

If you're actually doing the correct locking and packed-refs read (which
"real" implementations like libgit2 do) then no, I don't think that's
dangerous. And I think libgit2 properly complains when it sees a
repositoryformatversion above 0. I don't know offhand about JGit, or any
of the lesser-used ones like dulwich or go-git.

-Peff
