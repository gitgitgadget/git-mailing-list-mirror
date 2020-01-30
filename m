Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB98C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4E520661
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgA3H0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 02:26:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:48174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726415AbgA3H0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 02:26:14 -0500
Received: (qmail 21719 invoked by uid 109); 30 Jan 2020 07:26:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 07:26:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21458 invoked by uid 111); 30 Jan 2020 07:33:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 02:33:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 02:26:12 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Message-ID: <20200130072612.GD2189233@coredump.intra.peff.net>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
 <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
 <20200128073100.GA563058@coredump.intra.peff.net>
 <CAFQ2z_MXDODBmsCVPdvNQzhFSYchq77mJCxw9P0kPSmSnsTZqQ@mail.gmail.com>
 <20200129104754.GE4218@coredump.intra.peff.net>
 <xmqqh80e5cjk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh80e5cjk.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 10:43:11AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Making "refs" a file instead of a directory does work nicely, as any
> > attempts to read or write would get ENOTDIR. And we can fool
> > is_git_directory() as long as it's marked executable. That's OK on POSIX
> > systems, but I'm not sure how it would work on Windows (or maybe it
> > would work just fine, since we presumably just say "yep, everything is
> > executable").
> >
> > So perhaps that's enough, and what we put in HEAD won't matter (since
> > nobody will be able to write into refs/ anyway).
> 
> I wonder if it would help to take the "looser repository detection"
> code alone and have it in a release, way before the rest of the
> reftable topic is ready.  Then by the time a repository created by a
> reftable-enabled Git appears on people's disks, all the older
> versions of Git that are still in people's hands would at least know
> that it is a repository supported by future Git that they themselves
> do not know how to handle, stop repository discovery correctly and
> refrain from damaging the repository with an extension unknown to
> them?

That helps, but it just slightly expands the window where we do the
right thing. I.e., in a rollout like this:

  1. Status quo: we only consider it a repo if "refs/" is executable

  2. We introduce a version of Git that can read and write reftables.

  3. We flip reftables support on by default.

Then any version of git after step 2 is fine. It's the ones from step 1
and older we care about. And there's probably some time between steps 2
and 3 to let the new versions percolate, shake out bugs, etc.

Adding a new step 1.5, "looser repository detection" expands the window
of "good" versions by however long it takes to go from step 1.5 to step
2. But I expect that to be much smaller than the window between 2 and 3,
so I'm not sure it makes a meaningful impact.

(Of course people who voluntarily turn on the feature as soon as they
get hold of a step 2 version have no window at all, but presumably early
adopters are OK with the risk).

-Peff
