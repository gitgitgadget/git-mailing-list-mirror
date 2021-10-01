Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5035C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 05:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FF361452
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 05:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351928AbhJAFXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 01:23:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:58844 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhJAFXc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 01:23:32 -0400
Received: (qmail 26091 invoked by uid 109); 1 Oct 2021 05:21:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Oct 2021 05:21:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7828 invoked by uid 111); 1 Oct 2021 05:21:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Oct 2021 01:21:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Oct 2021 01:21:47 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Message-ID: <YVaa650FehPmk0QD@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
 <CABPp-BFuj3W20J-aKU4BL9cqgA-GPZ2prEbAebY_kR0adaGzHw@mail.gmail.com>
 <YVVmssXlaFM6yD5W@coredump.intra.peff.net>
 <YVVrY0/kXfWHCWJ1@coredump.intra.peff.net>
 <CABPp-BEqcq0wYqNP1xUJj8+E5HUTnip7+asadRoeFLAZ34rTdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEqcq0wYqNP1xUJj8+E5HUTnip7+asadRoeFLAZ34rTdQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 07:31:44PM -0700, Elijah Newren wrote:

> > Some ways it could go wrong:
> >
> >   - is it possible for the merge code to ever write an object? I kind of
> >     wonder if we'd ever do any cache-able transformations as part of a
> >     content-level merge. I don't think we do now, though.
> 
> Yes, of course -- otherwise there would have been no need for the
> tmp_objdir in the first place.  In particular, it needs to write
> three-way-content merges of individual files, and it needs to write
> new tree objects.  (And it needs to do this both for creating the
> virtual merge bases if the merge is recursive, as well as doing it for
> the outer merge.)

Right, sorry, I should have added: ...in addition to the merge-results
we're writing. What I'm getting at is whether there might be _other_
parts of the code that the merge code would invoke. Say, if a
.gitattribute caused us to convert a file's encoding in order to perform
a more semantic merge, and we wanted to store that result somehow (e.g.,
in a similar cache).

I don't think anything like that exists now, but I don't find it outside
the realm of possibility in the future. It's sort of the merge
equivalent of "textconv"; we have external diff and external merge
drivers, but being able to convert contents and feed them to the regular
text diff/merge code simplifies things.

> >   - in step 5, write_object_file() may still be confused by the presence
> >     of the to-be-thrown-away objects in the alternate. This is pretty
> >     unlikely, as it implies that the remerge-diff wrote a blob or tree
> >     that is byte-identical to something that the diff wants to write.
> 
> That's one reason it could be confused.  The textconv filtering in
> particular was creating a new object based on an existing one, and a
> tree, and a ref.  What if there was some other form of caching or
> statistic gathering that didn't write a new object based on an
> existing one, but did add trees and especially refs that referenced
> the existing object?  It's not that the diff wanted to write something
> byte-identical to what the merge wrote, it's just that the diff wants
> to reference the object somehow.

Yes, good point. It can help a little if the alternate-odb added by
tmp_objdir was marked with a flag to say "hey, this is temporary". That
would help write_object_file() decide not to depend on it. But the
problem is so much wider than that that I think it will always be a bit
dangerous; any code could say "can I access this object" and we don't
know if its intent is simply to read it, or to create a new object that
references it.

-Peff
