Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2A6C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BF8207FD
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgA2Krz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:47:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:47394 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726091AbgA2Krz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 05:47:55 -0500
Received: (qmail 16403 invoked by uid 109); 29 Jan 2020 10:47:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 10:47:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15591 invoked by uid 111); 29 Jan 2020 10:55:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2020 05:55:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jan 2020 05:47:54 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Message-ID: <20200129104754.GE4218@coredump.intra.peff.net>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
 <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
 <20200128073100.GA563058@coredump.intra.peff.net>
 <CAFQ2z_MXDODBmsCVPdvNQzhFSYchq77mJCxw9P0kPSmSnsTZqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_MXDODBmsCVPdvNQzhFSYchq77mJCxw9P0kPSmSnsTZqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 04:56:26PM +0100, Han-Wen Nienhuys wrote:

> JGit currently implements what we have here, as this is what's spelled
> out in the spec that Shawn posted  back in the day. It's probably
> acceptable to this, though, as the reftable support has only landed in
> JGit very recently and will probably appear very experimental to
> folks.
> 
> How would the layout be then? We'll have
> 
>   HEAD - dummy file
>   reftable/ - the tables
>   refs/ - dummy dir
> 
> where shall we store the reftable list? maybe in a file called
> 
>   reftable-list
> 
> If we have both HEAD/refs + (refable/reftable-list), what should we
> put there to ensure that no git version actually manages to use the
> repository? (what happens if someone deletes the version setting from
> the .git/config file)

Yeah, it would be nice to have something that an older version of Git
would totally choke on, but I'm not sure we have a lot of leeway. What
we put in HEAD has to be syntactically legitimate enough to appease
validate_headref(), so our options are either "ref:
refs/something/bogus" or an object hash that we don't have (e.g.,
0{40}). The former would be preferable because it would (in theory)
prevent us from writing to HEAD, as well.

I wondered what would happen if you put in a syntactically invalid ref,
like "ref: refs/.not/.valid" (leading dots are not allowed in path
components of refnames). It does cause _some_ parts of Git to choke, but
sadly "git update-ref HEAD $sha1" actually writes to .git/refs/.not/.valid.

Even "refs/../../dangerous" doesn't give it pause. Yikes. It seems we're
pretty willing to accept symref destinations without further checking.

Making "refs" a file instead of a directory does work nicely, as any
attempts to read or write would get ENOTDIR. And we can fool
is_git_directory() as long as it's marked executable. That's OK on POSIX
systems, but I'm not sure how it would work on Windows (or maybe it
would work just fine, since we presumably just say "yep, everything is
executable").

So perhaps that's enough, and what we put in HEAD won't matter (since
nobody will be able to write into refs/ anyway).

> > But that raises a question: how ready are reftables to handle non-sha1
> > object ids? I see a lot of GIT_SHA1_RAWSZ, and I think the on-disk
> > format actually has binary sha1s, right? In theory if those all become
> > the_hash_algo->rawsz, then it might "Just Work" to read and write
> > slightly larger entries.
> 
> The format fixes the reftable at 20 bytes, and there is not enough
> framing information to just write more data. We'll have to encode the
> hash size in the version number somehow, eg. we could use the  higher
> order bit of the version byte to encode it, for example.
> 
> But it needs a new version of the spec. I think it's premature to do
> this while v1 of reftable isn't in git-core yet.

I don't know that we technically need the reftables file to say how long
the hashes are. The git config will tell us which hash we're using, and
everything else is supposed to follow. So I think it would work OK as
long as you're able to be told by the rest of Git that hashes are N
bytes, and just use that to compute the fixed-size records.

That said, it might make for easier debugging if the reftables file
declares the size it assumes.

-Peff
