Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD0AC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 17:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiHARgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiHARgV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 13:36:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013D638B7
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 10:36:18 -0700 (PDT)
Received: (qmail 607 invoked by uid 109); 1 Aug 2022 17:36:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Aug 2022 17:36:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23331 invoked by uid 111); 1 Aug 2022 17:36:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Aug 2022 13:36:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Aug 2022 13:36:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
Message-ID: <YugPER9UsH1z6MZo@coredump.intra.peff.net>
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
 <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
 <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
 <xmqqzggpyu7q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzggpyu7q.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 31, 2022 at 12:10:01PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm tempted to say that the symref-reading code should
> > actually complain about following something outside of "refs/", but that
> > carries an even higher possibility of breaking somebody. But it seems
> > like we should be consistent between what we allow to be read, and what
> > we allow to be written.
> >
> > At any rate, with the code as you have it above, I think the "make sure
> > HEAD starts with refs/" code is now redundant.
> 
> Isn't the rule these days "HEAD must be either detached or point
> into refs/heads/"?  I thought "checkout" ensures that, and I am
> tempted to think that "symbolic-ref" that works on HEAD should be
> consistent with "checkout".  So "make sure HEAD is within refs/"
> would certainly be "not wrong per-se" but not sufficiently tight,
> I suspect.

No, sadly, that isn't the rule. See afe5d3d516 (symbolic ref: refuse
non-ref targets in HEAD, 2009-01-29) which tightened it to "refs/heads"
and then e9cc02f0e4 (symbolic-ref: allow refs/<whatever> in HEAD,
2009-02-13) which had to loosen it.

Likewise we seemed to touch the reading side at the same time, via
b229d18a80 (validate_headref: tighten ref-matching to just branches,
2009-01-29), and then 222b167386 (Revert "validate_headref: tighten
ref-matching to just branches", 2009-02-12).

In both cases it was refs/top-bases that triggered the revert. The
relevant thread is:

  https://lore.kernel.org/git/cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com/

There's some discussion there about how topgit could do things
differently, but I don't see any plan for moving away. However, the
latest changelog for it I could find has:

  [from https://mackyle.github.io/topgit/changelog.html]
  TopGit 0.19.4 (2017-02-14) introduced support for a new top-bases
  location under heads. This new location will become the default as of
  the TopGit 0.20.0 release. The current location under refs will
  continue to be supported in the future. See tg help migrate-bases for
  more details.

So it looks like there is some will there to switch. But the default
hasn't flipped yet, and we'd be breaking any non-migrated installs. Not
to mention that we don't know if any _other_ tools care. The topgit
folks reported the original problem in 2009 within a few weeks, and it
never made it to a release.

So yeah. We could certainly work out a deprecation/migration plan, but
I'm not sure it's worth the effort. I do suspect there are other parts
of Git that assume HEAD points at refs/heads/, especially the
clone/fetch HEAD-selection code. But that code is getting the symref
target from an untrusted remote, and is already careful about discarding
nonsense and continuing.

Regarding "checkout" versus "symbolic-ref", I do think "checkout"
probably does limit us to refs/heads/. But it is OK for porcelain to be
opinionated and restrictive, but plumbing probably needs to support
existing possibly-silly use cases.

-Peff
