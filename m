Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA19320756
	for <e@80x24.org>; Tue, 17 Jan 2017 18:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdAQStn (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 13:49:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:40349 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751103AbdAQStl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 13:49:41 -0500
Received: (qmail 17579 invoked by uid 109); 17 Jan 2017 18:43:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 18:43:00 +0000
Received: (qmail 20131 invoked by uid 111); 17 Jan 2017 18:43:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 13:43:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 13:42:58 -0500
Date:   Tue, 17 Jan 2017 13:42:58 -0500
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com
Subject: Re: [RFC] Add support for downloading blobs on demand
Message-ID: <20170117184258.sd7h2hkv27w52gzt@sigill.intra.peff.net>
References: <20170113155253.1644-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170113155253.1644-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an issue I've thought a lot about. So apologies in advance that
this response turned out a bit long. :)

On Fri, Jan 13, 2017 at 10:52:53AM -0500, Ben Peart wrote:

> Design
> ~~~~~~
> 
> Clone and fetch will pass a “--lazy-clone” flag (open to a better name 
> here) similar to “--depth” that instructs the server to only return 
> commits and trees and to ignore blobs.
> 
> Later during git operations like checkout, when a blob cannot be found
> after checking all the regular places (loose, pack, alternates, etc), 
> git will download the missing object and place it into the local object 
> store (currently as a loose object) then resume the operation.

Have you looked at the "external odb" patches I wrote a while ago, and
which Christian has been trying to resurrect?

  http://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/

This is a similar approach, though I pushed the policy for "how do you
get the objects" out into an external script. One advantage there is
that large objects could easily be fetched from another source entirely
(e.g., S3 or equivalent) rather than the repo itself.

The downside is that it makes things more complicated, because a push or
a fetch now involves three parties (server, client, and the alternate
object store). So questions like "do I have all the objects I need" are
hard to reason about.

If you assume that there's going to be _some_ central Git repo which has
all of the objects, you might as well fetch from there (and do it over
normal git protocols). And that simplifies things a bit, at the cost of
being less flexible.

> To prevent git from accidentally downloading all missing blobs, some git
> operations are updated to be aware of the potential for missing blobs.  
> The most obvious being check_connected which will return success as if 
> everything in the requested commits is available locally.

Actually, Git is pretty good about trying not to access blobs when it
doesn't need to. The important thing is that you know enough about the
blobs to fulfill has_sha1_file() and sha1_object_info() requests without
actually fetching the data.

So the client definitely needs to have some list of which objects exist,
and which it _could_ get if it needed to.

The one place you'd probably want to tweak things is in the diff code,
as a single "git log -Sfoo" would fault in all of the blobs.

> To minimize the impact on the server, the existing dumb HTTP protocol 
> endpoint “objects/<sha>” can be used to retrieve the individual missing
> blobs when needed.

This is going to behave badly on well-packed repositories, because there
isn't a good way to fetch a single object. The best case (which is not
implemented at all in Git) is that you grab the pack .idx, then grab
"slices" of the pack corresponding to specific objects, including
hunting down delta bases.

But then next time the server repacks, you have to throw away your .idx
file. And those can be big. The .idx for linux.git is 135MB. You really
wouldn't want to do an incremental fetch of 1MB worth of objects and
have to grab the whole .idx just to figure out which bytes you needed.

You can solve this by replacing the dumb-http server with a smart one
that actually serves up the individual objects as if they were truly
sitting on the filesystem. But then you haven't really minimized impact
on the server, and you might as well teach the smart protocols to do
blob fetches.


One big hurdle to this approach, no matter the protocol, is how you are
going to handle deltas. Right now, a git client tells the server "I have
this commit, but I want this other one". And the server knows which
objects the client has from the first, and which it needs from the
second. Moreover, it knows that it can send objects in delta form
directly from disk if the other side has the delta base.

So what happens in this system? We know we don't need to send any blobs
in a regular fetch, because the whole idea is that we only send blobs on
demand. So we wait for the client to ask us for blob A. But then what do
we send? If we send the whole blob without deltas, we're going to waste
a lot of bandwidth.

The on-disk size of all of the blobs in linux.git is ~500MB. The actual
data size is ~48GB. Some of that is from zlib, which you get even for
non-deltas. But the rest of it is from the delta compression. I don't
think it's feasible to give that up, at least not for "normal" source
repos like linux.git (more on that in a minute).

So ideally you do want to send deltas. But how do you know which objects
the other side already has, which you can use as a delta base? Sending
the list of "here are the blobs I have" doesn't scale. Just the sha1s
start to add up, especially when you are doing incremental fetches.

I think this sort of things performs a lot better when you just focus on
large objects. Because they don't tend to delta well anyway, and the
savings are much bigger by avoiding ones you don't want. So a directive
like "don't bother sending blobs larger than 1MB" avoids a lot of these
issues. In other words, you have some quick shorthand to communicate
between the client and server: this what I have, and what I don't.
Normal git relies on commit reachability for that, but there are
obviously other dimensions. The key thing is that both sides be able to
express the filters succinctly, and apply them efficiently.

> After cloning, the developer can use sparse-checkout to limit the set of 
> files to the subset they need (typically only 1-10% in these large 
> repos).  This allows the initial checkout to only download the set of 
> files actually needed to complete their task.  At any point, the 
> sparse-checkout file can be updated to include additional files which 
> will be fetched transparently on demand.

If most of your benefits are not from avoiding blobs in general, but
rather just from sparsely populating the tree, then it sounds like
sparse clone might be an easier path forward. The general idea is to
restrict not just the checkout, but the actual object transfer and
reachability (in the tree dimension, the way shallow clone limits it in
the time dimension, which will require cooperation between the client
and server).

So that's another dimension of filtering, which should be expressed
pretty succinctly: "I'm interested in these paths, and not these other
ones." It's pretty easy to compute on the server side during graph
traversal (though it interacts badly with reachability bitmaps, so there
would need to be some hacks there).

It's an idea that's been talked about many times, but I don't recall
that there were ever working patches. You might dig around in the list
archive under the name "sparse clone" or possibly "narrow clone".

> Now some numbers
> ~~~~~~~~~~~~~~~~
> 
> One repo has 3+ million files at tip across 500K folders with 5-6K 
> active developers.  They have done a lot of work to remove large files 
> from the repo so it is down to < 100GB.
> 
> Before changes: clone took hours to transfer the 87GB .pack + 119MB .idx
> 
> After changes: clone took 4 minutes to transfer 305MB .pack + 37MB .idx
> 
> After hydrating 35K files (the typical number any individual developer 
> needs to do their work), there was an additional 460 MB of loose files 
> downloaded.

It sounds like you have a case where the repository has a lot of large
files that are either historical, or uninteresting the sparse-tree
dimension.

How big is that 460MB if it were actually packed with deltas?

> Future Work
> ~~~~~~~~~~~
> 
> The current prototype calls a new hook proc in sha1_object_info_extended 
> and read_object, to download each missing blob.  A better solution would 
> be to implement this via a long running process that is spawned on the 
> first download and listens for requests to download additional objects 
> until it terminates when the parent git operation exits (similar to the 
> recent long running smudge and clean filter work).

Yeah, see the external-odb discussion. Those prototypes use a process
per object, but I think we all agree after seeing how the git-lfs
interface has scaled that this is a non-starter. Recent versions of
git-lfs do the single-process thing, and I think any sort of
external-odb hook should be modeled on that protocol.

> Need to investigate an alternate batching scheme where we can make a 
> single request for a set of "related" blobs and receive single a 
> packfile (especially during checkout).

I think this sort of batching is going to be the really hard part to
retrofit onto git. Because you're throwing out the procedural notion
that you can loop over a set of objects and ask for each individually.
You have to start deferring computation until answers are ready. Some
operations can do that reasonably well (e.g., checkout), but something
like "git log -p" is constantly digging down into history. I suppose you
could just perform the skeleton of the operation _twice_, once to find
the list of objects to fault in, and the second time to actually do it.

That will make git feel a lot slower, because a lot of the illusion of
speed is the way it streams out results. OTOH, if you have to wait to
fault in objects from the network, it's going to feel pretty slow
anyway. :)

-Peff
