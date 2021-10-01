Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119EAC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 05:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D59619F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 05:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbhJAF33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 01:29:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:58860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhJAF32 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 01:29:28 -0400
Received: (qmail 26116 invoked by uid 109); 1 Oct 2021 05:27:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Oct 2021 05:27:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7873 invoked by uid 111); 1 Oct 2021 05:27:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Oct 2021 01:27:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Oct 2021 01:27:44 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Message-ID: <YVacUCcl6USJSY5T@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
 <xmqqsfxof2hr.fsf@gitster.g>
 <YVVoXJo3DlPQd1A3@coredump.intra.peff.net>
 <CABPp-BF20vpC4m5V4JtS91fuA+PMiEN78J9OpVEPDpnKsTcP8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BF20vpC4m5V4JtS91fuA+PMiEN78J9OpVEPDpnKsTcP8A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 09:26:37PM -0700, Elijah Newren wrote:

> >  - This side-steps all of our usual code for getting object data into
> >    memory. In general, I'd expect this content to not be too enormous,
> >    but it _could_ be if there are many / large blobs in the result. So
> >    we may end up with large maps. Probably not a big deal on modern
> >    64-bit systems. Maybe an issue on 32-bit systems, just because of
> >    virtual address space.
> >
> >    Likewise, we do support systems with NO_MMAP. They'd work here, but
> >    it would probably mean putting all that object data into the heap. I
> >    could live with that, given how rare such systems are these days, and
> >    that it only matters if you're using --remerge-diff with big blobs.
> 
> Um, I'm starting to get uncomfortable with this pretend_object stuff.
> Part of the reason that merge-ort isn't truly "in memory" despite
> attempting to do exactly that, was because for large enough repos with
> enough files modified on both sides, I wasn't comfortable assuming
> that all new files from three-way content merges and all new trees fit
> into memory.  I'm sure we'd be fine with current-day linux kernel
> sized repos.  No big deal.  In fact, most merges probably don't add
> more than a few dozen new files.  But for microsoft-sized repos, and
> with repos tending to grow over time, more so when the tools
> themselves scale nicely (which we've all been working on enabling),
> makes me worry there might be enough new objects within a single merge
> (especially given the recursive inner merges) that we might need to
> worry about this.

I do think we need to consider that the content might be larger than
will comfortably fit in memory. But the point of using mmap is that we
don't have to care. The OS is taking care of it for us (just like it
would in regular object files).

The question is just whether we're comfortable assuming that mmap
exists if you're working on such a large repository. I'd guess that big
repos are pretty painful with out it (and again, I'm not even clear
which systems Git runs on even lack mmap these days). So IMHO this isn't
really a blocker for going in this direction.

> >    The whole pretend-we-have-this-object thing
> >    may want to likewise make sure we don't write out objects that we
> >    already have in the real odb.
> 
> Right, so I'd have to copy the relevant logic from write_object_file()
> -- I think that means instead of write_object_file()'s calls to
> freshen_packed_object() and freshen_loose_object() that I instead call
> find_pack_entry() and make has_loose_object() in object-file.c not be
> static and then call it.  Does that sound right?

Yes. You _could_ call the same freshening functions, but I think since
we know that our objects are throw-away anyway, we do not even need to
perform that freshening operation. I think just has_object_file() would
be sufficient for your needs.

-Peff
