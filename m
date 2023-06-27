Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1422BEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 06:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjF0GvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 02:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjF0GvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 02:51:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174A49F
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 23:51:14 -0700 (PDT)
Received: (qmail 27838 invoked by uid 109); 27 Jun 2023 06:51:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 06:51:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14353 invoked by uid 111); 27 Jun 2023 06:51:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 02:51:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 02:51:03 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Clean up stale .gitignore and .gitattribute patterns
Message-ID: <20230627065103.GA1226768@coredump.intra.peff.net>
References: <CAHGBnuOR+MU50jhNBHw8buWS_Yr9D92mErvgoi=cK16a=4_YUA@mail.gmail.com>
 <20230624011234.GA95358@coredump.intra.peff.net>
 <CAHGBnuPO63Hi8mfA+MkAGES-gs0eNCDPG2FcPZT=YsnVzKd30A@mail.gmail.com>
 <xmqqo7l25ibw.fsf@gitster.g>
 <CAHGBnuMjCsMetCJfhfDXb7aYttgUOc0WY+wJ_Q-tmoV4WES-pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHGBnuMjCsMetCJfhfDXb7aYttgUOc0WY+wJ_Q-tmoV4WES-pQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 26, 2023 at 06:42:17PM +0200, Sebastian Schuberth wrote:

> On Mon, Jun 26, 2023 at 5:55 PM Junio C Hamano <gitster@pobox.com> wrote:
> 
> > > PS: As a future idea, it might be good if "git mv" gives a hint about
> > > updating .gitattributes if files matching .gitattributes pattern are
> > > moved.
> >
> > Interesting.  "git mv hello.jpg hello.jpeg" would suggest updating
> > a "*.jpg <list of attribute definitions>" line in the .gitattributes
> > to begin with "*.jpeg"?
> 
> Yes, right. Or as a simpler variant to start with (as patterns might
> match files in different directories, and not all of the matching
> files might be moved), just say that a specific .gitattributes line
> needs updating (or needs to be duplicated / generalized in case files
> in both the old and new location match).

Yeah, I don't think we could ever do anything automated here; a human
needs to judge the intent and how the patterns should be adapted.

But perhaps something like:

  1. When git-commit makes a new commit that removes paths (whether they
     were totally removed, or renamed), find all gitattribute lines
     whose patterns match those paths.

  2. For each such pattern, see if it still matches anything in the
     resulting tree.

  3. If not, print advise() lines showing the file/line of the pattern
     which is no longer used.

Doing so naively (by checking matches for each file in the tree) would
be a little expensive, but maybe OK in practice. It could perhaps be
done more efficiently with specialized code, but it might be tricky to
right (and you still end up O(size of tree) in the worst case, because
something like "*.jpg" needs to be compared against every entry).

Of course on the way there you should end up with a decent tool for
"which patterns are not currently used?". And you could just
periodically run that manually if you want to clean up (or even from a
post-commit hook).


Re-reading your email, though, I wonder if you meant something a little
simpler, like:

  1. When a path is moved via git-mv, see if the attributes before/after
     are the same.

  2. If not, then mention which ones matched the old path via advise().

That is probably easier to write, though it does not help the "git rm"
case (where attributes may become obsolete).

-Peff
