Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DEFC1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 13:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753939AbeBGNWA (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 08:22:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:43566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753675AbeBGNV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 08:21:59 -0500
Received: (qmail 8036 invoked by uid 109); 7 Feb 2018 13:22:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Feb 2018 13:22:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30085 invoked by uid 111); 7 Feb 2018 13:22:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Feb 2018 08:22:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Feb 2018 08:21:57 -0500
Date:   Wed, 7 Feb 2018 08:21:57 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: BUG: fetch in certain repo always gives "did not send all
 necessary objects"
Message-ID: <20180207132157.GB16018@sigill.intra.peff.net>
References: <CABPp-BHVD19ZoAmWhQd9aN-v+qB7Ryq9Z-wobLYtJf_b6RWgzQ@mail.gmail.com>
 <CAGZ79kYstN9ATPGKZjnk-hJ6jRsx9Oz0b2hQ5cTiqVqMNDCsyA@mail.gmail.com>
 <CABPp-BHkLLrJDTQwHTYpqC0Cg7Wv_wDr14Fq_LXneg+OzzRngg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHkLLrJDTQwHTYpqC0Cg7Wv_wDr14Fq_LXneg+OzzRngg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 06, 2018 at 04:00:32PM -0800, Elijah Newren wrote:

> > According to Peff this got fixed
> > https://public-inbox.org/git/20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net/
> > and but you've had a corrupted repo from back when you were using an older
> > version of Git.
> >
> > Did that repo exist before d0c39a49cc was rolled out? Then we can keep that
> > hypothesis of "left-over corruption" as Peff put it.
> 
> I'm somewhat confused by this explanation.  That precise commit is the
> one I bisected to that _caused_ the fetch to fail.  Also, there might
> be one important difference here -- in the link you provide, it
> suggests that you had a corrupted working directory that made use of a
> now gc'ed commit.  In the case I was able to dig into, we did not.
> (There was a left-over .git/worktree/<something> that had a now gc'ed
> commit, but no working directory that used it.)

If you had a corrupted .git/worktree/<something>/HEAD, then that does
sound like the same problem. It's true that the commit you bisected to
caused "fetch" to fail, but only because it started looking at more of
your corrupted repository. The corruption happened long before (and I
don't know exactly when it was fixed, but I couldn't replicate it
anymore; it might even still exist).

In your case it sounds like you have the extra twist that the matching
working directory for "<something>" had gone away, but I don't think
that materially changes anything. Until you run "git worktree prune",
that HEAD file is still there and still supposed to be valid.

> I suspect you mean that there was another previous bug that induced
> corruption, that this commit fixed that other bug, while also
> introducing this new bug that makes folks' clones unusable because the
> error doesn't provide enough information for users to know how to fix.

If you want to call that last thing a bug, then I guess so. It's perhaps
a matter for the philosophers whether it is the fault of the new code to
start complaining about an existing on-disk corruption.

> It took me hours to figure it out, after users ran out of ideas and
> came and asked me for help.  (Maybe if I was familiar with worktree,
> and knew they had been using it, then I might have guessed that "HEAD"
> meant "not your actual HEAD but the HEAD of the vestige of some other
> worktree").

Yeah, this is the obvious thing that seems like it ought to be improved.

> Does anyone have pointers about what might be doable in terms of
> providing a more useful error message to allow users to recover?
> And/or ideas of what steps could cause corruption so I can send out a
> PSA to help users avoid it?

Here's a minimal manual reproduction:

  # new repo...
  git init
  git commit --allow-empty -m one

  # with a worktree...
  git worktree add foo
  git -C foo commit --allow-empty -m two
  obj=.git/objects/$(git rev-parse foo | sed 's#..#&/#')

  # now we stop using that worktree
  git -C foo checkout --detach
  git branch -f -D foo
  rm -rf foo

  # and this is the corruption; this might have happened ye olden days
  # because of a bug in the worktree code, but we'll assume that somehow
  # the object went away
  rm -f $obj

And now lots of commands may fail with confusing errors:

  $ git prune
  fatal: unable to parse object: HEAD

Unfortunately fixing that is a little tricky. In this case the stack
looks like:

  parse_object_or_die (oid=0x7fffffffd690, name=0x555555792880 "HEAD") at object.c:239
  add_one_ref (path=0x555555792880 "HEAD", oid=0x7fffffffd690, flag=0, cb_data=0x7fffffffd8e0) at reachable.c:38
  refs_head_ref (refs=0x555555a65430, fn=0x5555556b6ef5 <add_one_ref>, cb_data=0x7fffffffd8e0) at refs.c:1316
  other_head_refs (fn=0x5555556b6ef5 <add_one_ref>, cb_data=0x7fffffffd8e0) at worktree.c:404

So other_head_refs knows that it's looking at the worktrees. And it
passes the alternate ref-store to refs_head_ref(), with "add_one_ref" as
the callback. But the knowledge that we're not talking about the real
"HEAD" is lost as we cross that callback boundary. We'd need to either
add another parameter to the callback, or have some way of talking about
"HEAD in this worktree" as a refname (which AFAIK we don't have).

As for PSAs, my normal go-to in confusing matters like this is git-fsck.
But it seems that it does not check worktree HEADs. :(

  $ git fsck
  Checking object directories: 100% (256/256), done.

So that seems like another bug.

The best PSA for this particular bug may be "try pruning the worktrees":

  $ git worktree prune -v
  Removing worktrees/foo: gitdir file points to non-existent location

  $ git prune; echo $?
  0

-Peff
