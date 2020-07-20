Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19F5C433E6
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA0B2070A
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbgGTRcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:32:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:33512 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgGTRcV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 13:32:21 -0400
Received: (qmail 23490 invoked by uid 109); 20 Jul 2020 17:32:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Jul 2020 17:32:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14574 invoked by uid 111); 20 Jul 2020 17:32:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Jul 2020 13:32:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Jul 2020 13:32:20 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Compressing packed-refs
Message-ID: <20200720173220.GB2045458@coredump.intra.peff.net>
References: <20200716221026.dgduvxful32gkhwy@chatter.i7.local>
 <xmqqsgdrf64c.fsf@gitster.c.googlers.com>
 <20200716225429.i7pb6xorkwdsf5fn@chatter.i7.local>
 <20200717062723.GA1179001@coredump.intra.peff.net>
 <20200718182618.yqo5dcljf3h6q57q@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200718182618.yqo5dcljf3h6q57q@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 18, 2020 at 02:26:18PM -0400, Konstantin Ryabitsev wrote:

> >   - getting new objects into the object store. It sounds like you might
> >     do this with "git fetch", which does need up-to-date refs. We used
> >     to do that, too, but it can be quite slow. These days we migrate the
> >     objects directly via hardlinks, and then use "update-ref --stdin" to
> >     sync the refs into the shared storage repo.
> [...]
> Can you elaborate on the details of that operation, if it's not secret 
> sauce? Say, I have two repos:

No secret sauce, but it's pretty much what you wrote out. A few
comments:

> 1. locate all pack/* and XX/* files in repoA/objects (what about the 
>    info/packs file, or do you loosen all packs first?)

We only copy the pack and loose object files. We don't generate
info/packs at all, since we don't allow dumb-http access. Nor do we copy
any commit-graph files over (those are generated only in the shared
storage repo, and then every fork gets to use them).

Definitely don't loosen packs. It's very expensive. :)

> 2. hardlink them into the same location in repoS/objects

Yep. And now they're available atomically in both places.

> 3. use git-show-ref from repoA to generate stdin for git-update-ref in 
>    repoS

Use for-each-ref for this. It's received more optimizations over the
years (especially around looking at the minimum of packed-refs when it
can). Don't forget to delete refs that have gone away. We do something
like (typed in email, so watch out for errors):

  id=123
  git --git-dir=repoA for-each-ref \
    --format="%(objectname) refs/remotes/$id/%(refname)' >want
  git --git-dir=repoS for-each-ref \
    --format="%(objectname) %(refname)" refs/remotes/$id/ >have

and then compare the results (our code is in ruby using hashes, but you
could do it with comm or similar). And then you should end up with a set
of updates and deletions, which you can feed to "git update-ref --stdin"
(which is smart enough to do deletions before additions to save you from
directory/file conflicts in the namespace).

(There's no particular reason you need to use refs/remotes/ in the
shared repo; for us it's just historical since we really did define
configure remotes for each fork many many years ago).

> 4. Consequent runs of repack in repoA should unreference the hardlinked 
>    files in repoA/objects and leave only their copy in repoS

Yeah, I think it would do so, but we just unlink them immediately.

> I'm not sure I'm quite comfortable doing this kind of spinal surgery on 
> git repos yet, but I'm willing to wet my feet in some safe environments.  
> :)

We resisted it for a long time, too, because I didn't want to violate
any of Git's assumptions. But the cost of fetches was just getting too
high (especially because we queue a sync job after every push, and some
users like to push a _lot_).

> Yes, I did ponder using this, especially when dealing with objstore 
> repos with hundreds of thousands of refs -- thanks for another nudge in 
> this direction. I am planning to add a concept of indicating "baseline" 
> repos to grokmirror, which allows us to:
> 
> 1. set them as islandCore in objstore repositories
> 2. return only their refs via alternateRefsCommand
> 
> This one seems fairly straightforward and I will probably add that in 
> next week.

Yeah, it is. Our alternateRefsCommand is a script that basically does:

  # receive parent id info out-of-band in environment; if it's not
  # there, then show no alternate tips
  test -z "$parent_repo_id" && exit 0

  git --git-dir="$1" for-each-ref \
    --format='%(objectname)' refs/remotes/$i/heads/

Note that we only advertise "heads/" from the fork, and ignore the tags.
I don't know that we did a very rigorous study, but our general finding
was that tags don't often help much, and do clutter up the response for
some repos (again, some users think that 50,000 tags is reasonable).

-Peff
