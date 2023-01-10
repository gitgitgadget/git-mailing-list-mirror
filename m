Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4F4C54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 12:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbjAJMUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 07:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbjAJMUM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 07:20:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6658186CE
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 04:18:40 -0800 (PST)
Received: (qmail 17239 invoked by uid 109); 10 Jan 2023 12:18:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Jan 2023 12:18:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26833 invoked by uid 111); 10 Jan 2023 12:18:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Jan 2023 07:18:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Jan 2023 07:18:39 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Fredrik =?utf-8?B?w5ZiZXJn?= <fredrik@bakskuru.se>,
        git@vger.kernel.org
Subject: Re: Bugreport: Prefix - is ignored when sorting (on committerdate)
Message-ID: <Y71Xnx2vmznV913I@coredump.intra.peff.net>
References: <CALDp=1EVmQE2NZAd7ccAT0z=R=2S8FvyJzsPNrDeXwdJkEW3Lg@mail.gmail.com>
 <CAN0heSprKD35P-D7GTVQ20eRsj0AriYEA7iCDnrA9GuiwX0snw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSprKD35P-D7GTVQ20eRsj0AriYEA7iCDnrA9GuiwX0snw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2023 at 11:54:16AM +0100, Martin Ågren wrote:

> On Tue, 10 Jan 2023 at 10:50, Fredrik Öberg <fredrik@bakskuru.se> wrote:
> > - Create a new repository
> > - Add a new file to the repository and commit
> > - Create a tag
> > $ git tag -a TagOne -m ""
> > - Update the file and commit the change
> > - Create a tag
> > $ git tag -a TagTwo -m ""
> > - List tags by committerdate:
> > $ git tag -l --sort=committerdate
> > (oldest tag is listed first)
> > - List tags by reversed committerdate:
> > $ git tag -l --sort=-committerdate
> > (oldest tag it still listed first)
> [...]
> 
> This bisects to 7c5045fc18 ("ref-filter: apply fallback refname sort
> only after all user sorts", 2020-05-03). I've cc-ed the author. That
> commit does change the behavior for the kind of test repo you describe.
> 
> That said, you're using "committerdate" here. If you use "taggerdate"
> (or "creatordate") I think you'll get the output you expect, even for
> newer Git versions. Does that help?

Yes, I think that's the crux of the issue here; there is no date sorting
happening at all, before or after that patch. Depending on what you want
to do, I think "creatordate" is probably the most common option (it's
better than taggerdate in that it handles lightweight tags, too). But if
you really want committer dates, then "--sort=-=*committerdate" would
work.

> Since you just have two commits in the reproducer, there's a strong
> correlation between tag names and the timestamps involved. You actually
> end up sorting by refname: because there is no committerdate for these
> tags, the refnames are compared as a fallback. While the old code then
> applied the reversal ('-') to *that*, the new code first fails to find
> any difference, so doesn't have anything to reverse, then falls back to
> comparing the refnames, at which point it doesn't consider reversing the
> result.
> 
> All of this is based on my understanding. I could obviously be wrong.

I think that explanation is exactly correct. The only difference before
and after that patch is whether the "-" is applied to the fallback
refname sort.

> I suppose it could be argued that the '-' should be applied to the
> fallback as well, e.g., to uphold some sort of "using '-' should give
> the same result as piping the whole thing through tac" (i.e., respecting
> `s->reverse` in `compare_refs()`, if you're following along in
> 7c5045fc18). With multiple sort keys, some with '-' and some
> without, we'd grab the '-' from the first key. It seems like that could
> make sense, actually.

I dunno. Just because you are reverse-sorting on one field doesn't
necessarily imply that you want the tie-breaker to reverse-sort, too. I
get that it's kind of a "DWIM" when there's a single sorting key, but I
think the multi-key behavior is harder to explain. In:

  git for-each-ref --sort=committername --sort=-committerdate

should a refname tie breaker follow the reverse-chronological sort, or
the in-order name sort? The date sort is the primary key here, so
respecting it would be most like "tac". But the inner tie-breaker is
breaking ties on committername, so should it be most like that?

I could see it depending on exactly what you're trying to do. Which
leads me to think the rule should be as simple as possible. You can
always do:

  git for-each-ref --sort=-refname --sort=-committerdate

to specify exactly what you want.

-Peff
