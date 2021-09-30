Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8005DC433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 21:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6062F61881
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 21:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbhI3VCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 17:02:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:58676 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhI3VCG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 17:02:06 -0400
Received: (qmail 25382 invoked by uid 109); 30 Sep 2021 21:00:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Sep 2021 21:00:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 755 invoked by uid 111); 30 Sep 2021 21:00:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Sep 2021 17:00:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Sep 2021 17:00:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Message-ID: <YVYlZhl6uACu+UGG@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
 <xmqqsfxof2hr.fsf@gitster.g>
 <YVVoXJo3DlPQd1A3@coredump.intra.peff.net>
 <87tui2tckn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tui2tckn.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 03:16:19PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I also wonder how much if anything writing out the one file v.s. lots of
> loose objects is worthwhile on systems where we could write out those
> loose objects on a ramdisk, which is commonly available on e.g. Linux
> distros these days out of the box. If you care about performance but not
> about your transitory data using a ramdisk is generally much better than
> any other potential I/O optimization.

I'd think in general we won't be using a ramdisk, because tmp_objdir is
putting its directory inside $GIT_DIR/objects. It doesn't _have_ to, but
using a ramdisk works against its original purpose (which was to store
potentially quite a lot of data from an incoming push, and to be able to
rename it cheaply into its final resting place).

It would probably not be too hard to provide a flag that indicates the
intended use, though (and then we decide where to create the temporary
directory based on that).

> Finally, and I don't mean to throw a monkey wrench into this whole
> discussion, so take this as a random musing: I wonder how much faster
> this thing could be on its second run if instead of avoiding writing to
> the store & cleaning up, it just wrote to the store, and then wrote
> another object keyed on the git version and any revision paramaters
> etc., and then pretty much just had to do a "git cat-file -p <that-obj>"
> to present the result to the user :)
> 
> I suppose that would be throwing a lot more work at an eventual "git gc"
> than we ever do now, so maybe it's a bit crazy, but I think it might be
> an interesting direction in general to (ab)use either the primary or
> some secondary store in the .git dir as a semi-permanent cache of
> resolved queries from the likes of "git log".

I don't think it's crazy to just write the objects to the main object
store. We already generate cruft objects for some other operations
(Junio asked elsewhere in the thread about virtual trees for recursive
merges; I don't know the answer offhand, but I'd guess we do there).
They do get cleaned up eventually.

I'm not sure it helps performance much by itself. In a merge (or even
just writing a tree out from the index), by the time you realize you
already have the object, you've done most of the work to generate it.

I think what you're describing is to make some kind of cache structure
on top. That might be sensible (and indeed, the index already does this
with the cachetree extension). But it can also easily come later if the
objects are just in the regular odb.

-Peff
