Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1E1C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 07:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA82061527
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 07:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348766AbhI3Hfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 03:35:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:58112 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348760AbhI3Hfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 03:35:32 -0400
Received: (qmail 22280 invoked by uid 109); 30 Sep 2021 07:33:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Sep 2021 07:33:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24238 invoked by uid 111); 30 Sep 2021 07:33:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Sep 2021 03:33:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Sep 2021 03:33:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Message-ID: <YVVoXJo3DlPQd1A3@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
 <xmqqsfxof2hr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfxof2hr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 09:08:00PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   Side note: The pretend_object_file() approach is actually even better,
> >   because we know the object is fake. So it does not confuse
> >   write_object_file()'s "do we already have this object" freshening
> >   check.
> >
> >   I suspect it could even be made faster than the tmp_objdir approach.
> >   From our perspective, these objects really are tempfiles. So we could
> >   write them as such, not worrying about things like fsyncing them,
> >   naming them into place, etc. We could just write them out, then mmap
> >   the results, and put the pointers into cached_objects (currently it
> >   insists on malloc-ing a copy of the input buffer, but that seems like
> >   an easy extension to add).
> >
> >   In fact, I think you could get away with just _one_ tempfile per
> >   merge. Open up one tempfile. Write out all of the objects you want to
> >   "store" into it in sequence, and record the lseek() offsets before and
> >   after for each object. Then mmap the whole result, and stuff the
> >   appropriate pointers (based on arithmetic with the offsets) into the
> >   cached_objects list.
> 
> Cute.  The remerge diff code path creates a full tree that records
> the mechanical merge result.  By hooking into the lowest layer of
> write_object() interface, we'd serialize all objects in such a tree
> in the order they are computed (bottom up from the leaf level, I'd
> presume) into a single flat file ;-)

I do still like this approach, but just two possible gotchas I was
thinking of:

 - This side-steps all of our usual code for getting object data into
   memory. In general, I'd expect this content to not be too enormous,
   but it _could_ be if there are many / large blobs in the result. So
   we may end up with large maps. Probably not a big deal on modern
   64-bit systems. Maybe an issue on 32-bit systems, just because of
   virtual address space.

   Likewise, we do support systems with NO_MMAP. They'd work here, but
   it would probably mean putting all that object data into the heap. I
   could live with that, given how rare such systems are these days, and
   that it only matters if you're using --remerge-diff with big blobs.

 - I wonder to what degree --remerge-diff benefits from omitting writes
   for objects we already have. I.e., if you are writing out a whole
   tree representing the conflicted state, then you don't want to write
   all of the trees that aren't interesting. Hopefully the code is
   already figuring out which paths the merge even touched, and ignoring
   the rest. It probably benefits performance-wise from
   write_object_file() deciding to skip some object writes, as well
   (e.g., for resolutions which the final tree already took, as they'd
   be in the merge commit). The whole pretend-we-have-this-object thing
   may want to likewise make sure we don't write out objects that we
   already have in the real odb.

-Peff
