Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0AA203C1
	for <e@80x24.org>; Mon, 14 Nov 2016 21:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938722AbcKNVV0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 16:21:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:43044 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938503AbcKNVVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 16:21:25 -0500
Received: (qmail 23033 invoked by uid 109); 14 Nov 2016 21:21:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 21:21:25 +0000
Received: (qmail 4835 invoked by uid 111); 14 Nov 2016 21:21:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 16:21:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2016 16:21:23 -0500
Date:   Mon, 14 Nov 2016 16:21:23 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFH] limiting ref advertisements
Message-ID: <20161114212122.rkgeoh4rj5cxdadf@sigill.intra.peff.net>
References: <20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net>
 <CACsJy8DwKxz14Dow9dEKeXnBriMzN_OptnGM7nPigPcS_pHX9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DwKxz14Dow9dEKeXnBriMzN_OptnGM7nPigPcS_pHX9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 06:46:21PM +0700, Duy Nguyen wrote:

> > So it seems like left-anchoring the refspecs can never be fully correct.
> > We can communicate "master" to the server, who can then look at every
> > ref it would advertise and ask "could this be called master"? But it
> > will be setting in stone the set of "could this be" patterns. Granted,
> > those haven't changed much over the history of git, but it seems awfully
> > fragile.
> 
> The first thought that comes to mind is, if left anchoring does not
> work, let's support both left and right anchoring. I guess you
> considered and discarded this.
> 
> If prefix matching does not work, and assuming "some-prefix" sent by
> client to be in fact "**/some-prefix" pattern at server side will set
> the "could this be" in stone, how about use wildmatch? It's flexible
> enough and we have full control over the pattern matching engine so C
> Git <-> C Git should be good regardless of platforms. I understand
> that wildmatch is still complicated enough that a re-implementation
> can easily divert in behavior. But a pattern with only '*', '/**',
> '/**/' and '**/' wildcards (in other words, no [] or ?) could make the
> engine a lot simpler and still fit our needs (and give some room for
> client-optimization).

Thanks for responding to this. I've been meaning to get back to it with
some code experiments, but they keep getting bumped down in priority. So
let me at least outline some of my thoughts, without code. :)

I was hoping to avoid right-anchoring because it's expensive to find all
of the right-anchored cases (assuming that ref storage is generally
hierarchical, which it is now and probably will be for future backends).

I also don't think it covers all cases. As bizarre as it is, I believe
you can currently do:

  git fetch $remote origin

and find refs/remotes/origin/HEAD.

So I think the best we can ever do is have the server look at a specific
set of patterns. Those patterns could be expressed by wildmatch. I was
just a little nervous to turn to wildmatch, because it's complicated and
we may want to update it in the future in a slightly-incompatible way.

We also want to give some preference-order to the patterns. If I give
you "refs/heads/master", and that ref exists, you do not need to tell me
whether you also have "refs/heads/refs/heads/master". So you have to
provide multiple patterns for each possible ref. And you need to group
them as "show the first one that matches from this group".

The pattern the client is using really is the ref_rev_parse_rules. So I
think the solution is more like one of:

  1. Specify the pattern set ahead of time, and then the server applies
     it to each refname. We need some pattern language that can express
     "fill in the thing in the middle". IOW, something like:

       advertise-pattern=%s
       advertise-pattern=refs/tags/%s
       advertise-pattern=refs/heads/%s
       advertise-lookup=master
       advertise-lookup=v1.0

     except that the thought of using snprintf() to handle formats
     provided by the user is vaguely terrifying. We could make sure they
     contain only a single "%s", but given the history there, it still
     makes me nervous. I guess we could write our own pseudo-%s parser
     that is much more careful and complains on bugs instead of
     executing arbitrary code. ;)

     I don't think wildmatch quite works for that, because it wants to
     have the full pattern.

  2. Declare the current set of ref_rev_parse_rules as "version 1", and
     send:

       advertise-lookup-v1=master
       advertise-lookup-v1=v1.0

     and the server would do the right thing. We could do a v2, but it
     gets hairy. Let's imagine we add "refs/notes/%s" to the lookup
     rules, and we'll call that v2.

     But remember that these are "early capabilities", before the server
     has spoken at all. So the client doesn't know if we can handle v2.
     So we have to send _both_ (and v2-aware servers can ignore the v1).

       advertise-lookup-v1=master
       advertise-lookup-v2=master

     But that's not quite enough. A v1 server won't look in refs/notes
     at all. So we have to say that, too:

       advertise-lookup-v1=refs/notes/master

     And of course the v1 server has no idea that this isn't necessary
     if we already found refs/heads/master.

     So I think you really do need the client to be able to say "also
     look at this pattern".

Of course we do still want left-anchoring, too. Wildcards like
"refs/heads/*" are always left-anchored. So I think we'd have two types,
and a full request for

  git fetch origin +refs/heads/*:refs/remotes/origin/* master:foo

would look like:

  (1) advertise-pattern-v1
  (2) advertise-pattern=refs/notes/%s
  (3) advertise-prefix=refs/heads
  (4) advertise-lookup=master

where the lines mean:

  1. Use the standard v1 patterns (we could spell them out, but this
     just saves bandwidth. In fact, it could just be implicit that v1
     patterns are included, and we could skip this line).

  2. This is for our fictional future version where the client knows
     added refs/notes/* to its DWIM but the server hasn't yet.

  3. Give me all of refs/heads/*

  4. Look up "master" using the advertise patterns and give me the first
     one you find.

So given that we can omit (1), and that (2) is just an example for the
future, it could look like:

  advertise-prefix=refs/heads
  advertise-lookup=master

which is pretty reasonable. It's not _completely_ bulletproof in terms
of backwards compatibility. The "v1" thing means the client can't insert
a new pattern in the middle (remember they're ordered by priority). So
maybe it is better to spell them all out (one thing that makes me
hesitate is that these will probably end up as URL parameters for the
HTTP version, which means our URL can start to get a little long).

Anyway. That's the direction I'm thinking. I haven't written the code
yet. The trickiest thing will probably be that the server would want to
avoid advertising the same ref twice via two mechanisms (or perhaps the
client just be tolerant of duplicates; that relieves the server of any
duplicate-storage requirements).

-Peff
