Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF741FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 17:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754013AbcH2RSz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:18:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:34868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752043AbcH2RSy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:18:54 -0400
Received: (qmail 30953 invoked by uid 109); 29 Aug 2016 17:18:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Aug 2016 17:18:53 +0000
Received: (qmail 21263 invoked by uid 111); 29 Aug 2016 17:18:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Aug 2016 13:18:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2016 13:18:49 -0400
Date:   Mon, 29 Aug 2016 13:18:49 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     "W. David Jarvis" <william.d.jarvis@gmail.com>, git@vger.kernel.org
Subject: Re: Reducing CPU load on git server
Message-ID: <20160829171849.psz5j3xy5kesql5e@sigill.intra.peff.net>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
 <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net>
 <c1778c9b-2dd1-9cef-0330-204fe9d08d39@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1778c9b-2dd1-9cef-0330-204fe9d08d39@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 12:46:27PM +0200, Jakub Narębski wrote:

> > So your load is probably really spiky, as you get thundering herds of
> > fetchers after every push (the spikes may have a long flatline at the
> > top, as it takes time to process the whole herd).
> 
> One solution I have heard about, in the context of web cache, to reduce
> the thundering herd problem (there caused by cache expiring at the same
> time in many clients) was to add some random or quasi-random distribution
> to expiration time.  In your situation adding a random delay with some
> specified deviation could help.

That smooths the spikes, but you still have to serve all of the requests
eventually. So if your problem is that the load spikes and the system
slows to a crawl as a result (or runs out of RAM, etc), then
distributing the load helps. But if you have enough load that your
system is constantly busy, queueing the load in a different order just
shifts it around.

GHE will also introduce delays into starting git when load spikes, but
that's a separate system that coalescing identical requests.

> I wonder if this system for coalescing multiple fetches is something
> generic, or is it something specific to GitHub / GitHub Enterprise
> architecture?  If it is the former, would it be considered for
> upstreaming, and if so, when it would be in Git itself?

I've already sent upstream the patch for a "hook" that sits between
upload-pack and pack-objects (and it will be in v2.10). So that can call
an arbitrary script which can then make scheduling policy for
pack-objects, coalesce similar requests, etc.

GHE has a generic tool for coalescing program invocations that is not
Git-specific at all (it compares its stdin and command line arguments to
decide when two requests are identical, runs the command on its
arguments, and then passes the output to all members of the herd). That
_might_ be open-sourced in the future, but I don't have a specific
timeline.

> One thing to note: if you have repositories which are to have the
> same contents, you can distribute the pack-file to them and update
> references without going through Git.  It can be done on push
> (push to master, distribute to mirrors), or as part of fetch
> (master fetches from central repository, distributes to mirrors).
> I think; I have never managed large set of replicated Git repositories.

Doing it naively has some gotchas, because you want to make sure you
have all of the necessary objects. But if you are going this route,
probably distributed a git-bundle is the simplest way.

> > Generally no, they should not conflict. Writes into the object database
> > can happen simultaneously. Ref updates take a per-ref lock, so you
> > should generally be able to write two unrelated refs at once. The big
> > exception is that ref deletion required taking a repo-wide lock, but
> > that presumably wouldn't be a problem for your case.
> 
> Doesn't Git avoid taking locks, and use lockless synchronization
> mechanisms (though possibly equivalent to locks)?  I think it takes
> lockfile to update reflog together with reference, but if reflogs
> are turned off (and I think they are off for bare repositories by
> default), ref update uses "atomic file write" (write + rename)
> and compare-and-swap primitive.  Updating repository is lock-free:
> first update repository object database, then reference.

There is a lockfile to make the compare-and-swap atomic, but yes, it's
fundamentally based around the compare-and-swap. I don't think that
matters to the end user though. Fundamentally they will see "I hoped to
move from X to Y, but somebody else wrote Z, aborting", which is the
same as "I did not win the lock race, aborting".

The point is that updating two different refs is generally independent,
and updating the same ref is not.

> I guess that trying to replicate DGit approach that GitHub uses, see
> "Introducing DGit" (http://githubengineering.com/introducing-dgit)
> is currently out of question?

Minor nitpick (that you don't even have any way of knowing about, so
maybe more of a public service announcement). GitHub will stop using the
"DGit" name because it's too confusingly similar to "Git" (and "Git" is
trademarked by the project). There's a new blog post coming that
mentions the name change, and that historic one will have a note added
retroactively. The new name is "GitHub Spokes" (get it, Hub, Spokes?).

But in response to your question, I'll caution that replicating it is a
lot of work. :)

Since the original problem report mentions GHE, I'll note that newer
versions of GHE do support clustering and can share the git load across
multiple Spokes servers. So in theory that could make the replica layer
go away entirely, because it all happens behind the scenes.

-Peff

PS Sorry, I generally try to avoid hawking GitHub wares on the list, but
   since the OP mentioned GHE specifically, and because there aren't
   really generic solutions to most of these things, I do think it's a
   viable path for a solution for him.
