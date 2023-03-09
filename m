Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D194C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 07:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCIHYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 02:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCIHYl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 02:24:41 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE775193E5
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 23:24:39 -0800 (PST)
Received: (qmail 6569 invoked by uid 109); 9 Mar 2023 07:24:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 07:24:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28728 invoked by uid 111); 9 Mar 2023 07:24:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 02:24:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 02:24:38 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] object-file: reprepare alternates when necessary
Message-ID: <ZAmJtnLgwimRBGTb@coredump.intra.peff.net>
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
 <pull.1490.v2.git.1678301252360.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1490.v2.git.1678301252360.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2023 at 06:47:32PM +0000, Derrick Stolee via GitGitGadget wrote:

> Extend reprepare_packed_git() to also reprepate the alternate odb list

s/reprepate/reprepare/

Unless you were inventing a new word. :)

> This change is specifically for concurrent changes to the repository, so
> it is difficult to create a test that guarantees this behavior is
> correct. I manually verified by introducing a reprepare_packed_git() call
> into get_revision() and stepped into that call in a debugger with a
> parent 'git log' process. Multiple runs of prepare_alt_odb() kept
> the_repository->objects->odb as a single-item chain until I added a
> .git/objects/info/alternates file in a different process. The next run
> added the new odb to the chain and subsequent runs did not add to the
> chain.

One thing that test wouldn't cover is loading alternates from
$GIT_ALTERNATE_OBJECT_DIRECTORIES. Once upon a time, I think we were
pretty inconsistent in finding duplicates. But these days it looks like
it's all done centrally in link_alt_odb_entry(), via alt_odb_usable().
So it should be good.

>     object-file: reprepare alternates when necessary
>     
>     This subtlety was notice by Michael Haggerty due to how alternates are
>     used server-side at $DAYJOB. Moving pack-files from a repository to the
>     alternate occasionally causes failures because processes that start
>     before the alternate exists don't know how to find that alternate at
>     run-time.

Yeah, I don't think there's any real reason not to do this. It simply
doesn't come up in the same way that packfile-repreparing does, because
there it is routine for a concurrent gc to remove an existing packfile
and add the objects elsewhere.

Whereas modifying alternates was never seen as something that would
happen often or automatically. I guess in GitHub's case it is from
converting a repository from stand-alone into a fork, migrating its
objects to a shared one, and adding an alternate.

The only downside might be performance. For sane cases, I think scanning
the new alternates is OK. I know Eric (cc'd) has some crazy
100k-alternate setup (from 407532f82d, etc), but I'd expect a reprepare
there is already expensive (we already have to re-scan every one of
those directories for packfiles, and throw out any loose object caches).

The patch itself looks good to me (and I agree with the sentiment to
just inline the lines rather than adding a function).

-Peff
