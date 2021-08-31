Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B977C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 05:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323826101B
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 05:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhHaFim (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 01:38:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:34678 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231704AbhHaFim (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 01:38:42 -0400
Received: (qmail 3719 invoked by uid 109); 31 Aug 2021 05:37:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Aug 2021 05:37:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17292 invoked by uid 111); 31 Aug 2021 05:37:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 01:37:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 01:37:46 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YS3AKhQJjMrFm1JO@coredump.intra.peff.net>
References: <xmqqr1eimtrp.fsf@gitster.g>
 <YSVjnSDaBXgXvT9W@nand.local>
 <xmqq35qymrcn.fsf@gitster.g>
 <xmqqy28qlcow.fsf@gitster.g>
 <YSVuUYFh7lmhNlEy@nand.local>
 <xmqqo89jbf49.fsf@gitster.g>
 <YSko4OwwPb7MwEMa@nand.local>
 <xmqq4kb797xc.fsf@gitster.g>
 <YSwhNxqAS8JajA7p@nand.local>
 <22366f81-65a6-55d1-706c-59f877127be0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22366f81-65a6-55d1-706c-59f877127be0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 09:21:31PM -0400, Derrick Stolee wrote:

> Yes, supporting non-alternates is a historical accident. Supporting
> alternates that are not actually the core object database of a full
> repository is on purpose.
> 
> So, hopefully the remaining discussion that I am seeing can be
> solved by a decision such as:
> 
>   "If we add the restriction that the builtin always runs with a
>    repository and --object-dir always points to its objects dir
>    or one of its registered alternates, then we have access to a
>    local config file to learn how to interpret that object directory."

I left a similar comment in the other part of the thread. :)

> >> I wonder if it is safe to assume that in practice a directory given
> >> to the "--object-dir" option is always the "objects" subdirectory in
> >> a repository, and it is an error if there is no "config" file next
> >> to the directory.  Then, we could check ../config relative to the
> >> given directory and error out if they use different hash.
> 
> I would say that is not always the case, and we should not error out.
> 
> I think taking a look to see if ../config exists to use the data
> might be helpful for some cases, but should not be a blocker for
> completing the requested operation. The config from the non-alternate
> repo should be sufficient for this (somewhat strange) case.

Yes, agreed. We have long supported these kind of "bare" alternates, and
I wouldn't be surprised if they are in wide use (though I do wonder how
folks actually modify them, since most commands that touch objects
really do want to be in a repository).

In other cases where we may benefit from their being a containing repo
(e.g., accessing the ref tips of the alternate), we speculatively look
at ".." and see if there are any refs. See refs_from_alternate_cb()[0].

The natural extension for the hash-format problem would probably be to
call check_repository_format_gently() on the parent directory of the
alternate-objects dir. If it succeeds, then we can pull out the
hash_algo parameter from its repository_format struct. And if not, then
we just assume it matches the main repo.

But I suspect all of this is moot for now, beyond being able to return a
nicer error message. The rest of the code is not at all ready to handle
packs with two different hashes in the same process. And I suspect it
would take a reasonable amount of refactoring to make it so. If somebody
wants to work on that, I won't stop them, but I kind of doubt it is
worth anybody's time.

[0] Looking at refs_from_alternate_cb(), I did wonder if it would work
    at all with a reftable alternate, but I suspect it would. I think we
    ended up still having a "refs/" directory in that case, so we'd
    recognize it as a repo (though really, it ought to be using
    is_git_directory() instead of its hacky check). And then we farm out
    the actual ref iteration to a separate for-each-ref process, passing
    along --git-dir, which will read that alternate repo's config. So it
    should Just Work, even with a different ref backend. It's almost
    certainly broken if the hash algorithms don't match, though, because
    we'd get oddly sized results from for-each-ref's output.

    That's all just interesting tangent, though. :)

-Peff
