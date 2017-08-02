Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CDF61F991
	for <e@80x24.org>; Wed,  2 Aug 2017 09:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbdHBJ2u (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 05:28:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:55358 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751142AbdHBJ2s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 05:28:48 -0400
Received: (qmail 4641 invoked by uid 109); 2 Aug 2017 09:28:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 09:28:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7460 invoked by uid 111); 2 Aug 2017 09:29:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 05:29:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 05:28:46 -0400
Date:   Wed, 2 Aug 2017 05:28:46 -0400
From:   Jeff King <peff@peff.net>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Subject: Re: reftable [v4]: new ref storage format
Message-ID: <20170802092846.u4lyiogvvl7ezdfq@sigill.intra.peff.net>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
 <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
 <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
 <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 01, 2017 at 07:38:37PM -0700, Shawn Pearce wrote:

> > OBJS blocks can also be
> > unbounded in size if very many references point at the same object,
> > thought that is perhaps only a theoretical problem.
> 
> Gah, I missed that in reftable. The block id pointer list could cause
> a single object id to exceed what fits in a block, and that will cause
> the writer to fail unless its caller sets the block size larger. I
> basically assumed this overflow condition is very unlikely, as its not
> common to have a huge number of refs pointing to the same object.

It's actually quite common for us, as we have big shared-object repos
that contain a copy of the refs of all of their child repos (for
reachability during packing, etc). So tags, where the value is the same
in each fork, you have one ref per fork pointing to it.

Just peeking at torvalds/linux, we have some objects with ~35K refs
pointing to them (e.g., the v2.6.11 tag).

> > Peff and I discussed off-list whether the lookup-by-SHA-1 feature is
> > so important in the first place. Currently, all references must be
> > scanned for the advertisement anyway,
> 
> Not really. You can hide refs and allow-tip-sha1 so clients can fetch
> a ref even if it wasn't in the advertisement. We really want to use
> that wire protocol capability with Gerrit Code Review to hide the
> refs/changes/ namespace from the advertisement, but allow clients to
> fetch any of those refs if they send its current SHA-1 in a want line
> anyway.
> 
> So a server could scan only the refs/{heads,tags}/ prefixes for the
> advertisement, and then leverage the lookup-by-SHA1 to verify other
> SHA-1s sent by the client.

Yeah, that makes sense (though I hope in the end that strategy will go
away in favor of a better protocol, as getting the sha1 out-of-band has
obvious UX complexities).

> > OTOH a mythical protocol v2 might reduce the need to scan the
> > references for advertisement, so maybe this optimization will be more
> > helpful in the future?
> 
> Yes, I'm hopeful we can get a v2 protocol built on the work Jonathan
> Tan is doing, and switch the advertisement around to "client speaks
> first", so that we can be smarter on the server about which refs are
> read and sent. That is a long way off, lets say 3-5 years before its
> really common in clients.

I was actually planning to spend some time on this in the next month or
two. I don't think it needs to be that complicated. We don't need a
whole protocol revamp. We just need a way to get a few bits from the
client before the advertisement, and from there we can bootstrap any
more radical protocol changes we want.

I know it will take a while before it's something we can expect in
clients, but it's definitely worth planning around. And sometimes a
feature like this can drive upgrades, if it's something that produces an
immediate and obvious benefit to the client.

> Servers today don't update HEAD reflog when a branch is pushed. I
> think trying to record that is overkill, you have the reflog data in
> the ref itself that the client sent the command to modify.

I think they do, at least for C git:

  $ git init --bare dst.git
  $ git -C dst.git config core.logallrefupdates
  $ git push dst.git
  ...
  To dst.git
   * [new branch]      master -> master
  $ find dst.git/logs -type f | xargs wc -l
    1 dst.git/logs/refs/heads/master
    1 dst.git/logs/HEAD

The special logic for "see if we're updating the ref that HEAD points
to" is deep in the ref machinery, so it gets triggered for all updates,
including pushes.

I agree it's not actually that interesting for a bare repo, where HEAD
isn't that meaningful (and doesn't tend to change a lot anyway).

> > That's what I was thinking. But I've yet to hear anybody complain
> > about missing reflogs for symrefs if the underlying reference is
> > updated directly, so maybe we should just leave that "problem"
> > unsolved. It is certainly simpler and less brittle not to have to keep
> > backreferences like these in sync with the forward references.
> 
> Yup, that is my take on it, and why I didn't try to put this into
> reftable drafts, even though it was discussed between us on the list
> in earlier messages.

Yeah, I'd agree. It might be worth doing a better job of showing the
before/after destinations in the reflog when updating a symbolic ref,
which would let you reconstruct the state from the pointed-to reflogs if
you cared to. But that's orthogonal to the storage format (you can do it
already if you bother to pass a good message to "symbolic-ref -m").

-Peff
