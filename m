Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF32C33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 10:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ED2215A4
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 10:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgAaKUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:20:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:49400 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728289AbgAaKUu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 05:20:50 -0500
Received: (qmail 13497 invoked by uid 109); 31 Jan 2020 10:20:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Jan 2020 10:20:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30699 invoked by uid 111); 31 Jan 2020 10:28:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2020 05:28:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jan 2020 05:20:49 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] commit-graph.h: store object directory in 'struct
 commit_graph'
Message-ID: <20200131102049.GC2916051@coredump.intra.peff.net>
References: <cover.1580424766.git.me@ttaylorr.com>
 <890e0e7136204f5ca47f0703f32b4adb99ad8d7e.1580424766.git.me@ttaylorr.com>
 <CAN0heSrrrWjBKnzjMfzEkTMVTge2AfVdwsp6D5Mx==5S8-ZLJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrrrWjBKnzjMfzEkTMVTge2AfVdwsp6D5Mx==5S8-ZLJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 07:52:02AM +0100, Martin Ågren wrote:

> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> 
> > +struct object_directory *find_odb(struct repository *r, const char *obj_dir)
> 
> This doesn't look commit-graph related -- could/should it go somewhere
> else?

I think the right place is actually as a static inside
builtin/commit-graph.c, as this is really about handling its weird
--object-dir options.

But it can't go there in this patch, because there's a caller in
commit-graph.c. In patch 4, we convert write_commit_graph() to take an
odb, too, and that call goes away. At that point, we could move it into
the builtin as a static.

Ideally we could flip the order of this patch and patch 4, but that
doesn't work either: by switching to an odb we lose our path
normalization, but if the other side hasn't switched either, then we
can't just compare odb pointers. It would be a temporary regression.

So there's a circular dependency between the two patches. I think we
ought to do done of:

  - move find_odb() to a static as a cleanup on top

  - squash those two patches together into a single

  - swap the patch order, but have write_commit_graph_ctx store both the
    "odb" _and_ the normalized copy of the path we do now. That leaves
    it correct, and then it can be cleaned up in favor of an odb pointer
    comparison in patch 5, along with the rest of the normalized bits.

I'm OK with any of those. The second two have the added bonus that we
could introduce the die() behavior into find_odb() immediately, and
explain it (there's another temporary weirdness in this patch where
specifying an --object-dir outside of the repository becomes a silent
noop, and then the next patch turns it into an error, but that could all
be done in a single step when we introduce find_odb()).

> I think you could drop `cmp` and that final check, and write the loop
> body as "if (!strcmp(...)) break". You could also have an empty loop
> body, but I wouldn't go there -- I'd find that less readable. (Maybe
> that's just me.)

Yeah, I believe you are correct (and this is a nice simplification worth
doing).

-Peff
