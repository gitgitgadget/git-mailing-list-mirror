From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] peel_ref: check object type before loading
Date: Thu, 4 Oct 2012 17:59:33 -0400
Message-ID: <20121004215933.GA17358@sigill.intra.peff.net>
References: <20121004075609.GA1355@sigill.intra.peff.net>
 <20121004080253.GC31325@sigill.intra.peff.net>
 <7vbogiys47.fsf@alter.siamese.dyndns.org>
 <20121004194150.GA13955@sigill.intra.peff.net>
 <7vd30yx94r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:59:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtjz-0005yD-MN
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047Ab2JDV7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 17:59:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41028 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab2JDV7f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 17:59:35 -0400
Received: (qmail 25335 invoked by uid 107); 4 Oct 2012 22:00:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 18:00:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 17:59:33 -0400
Content-Disposition: inline
In-Reply-To: <7vd30yx94r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207040>

On Thu, Oct 04, 2012 at 01:41:40PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > [1] One thing I've been toying is with "external alternates"; dumping
> >     your large objects in some realtively slow data store (e.g., a
> >     RESTful HTTP service). You could cache and cheaply query a list of
> >     "sha1 / size / type" for each object from the store, but getting the
> >     actual objects would be much more expensive. But again, it would
> >     depend on whether you would actually have such a store directly
> >     accessible by a ref.
> 
> Yeah, that actually has been another thing we were discussing
> locally, without coming to something concrete enough to present to
> the list.
> 
> The basic idea is to mark such paths with attributes, and use a
> variant of smudge/clean filter that is _not_ a filter (as we do not
> want to have the interface to this external helper to be "we feed
> the whole big blob to you").  Instead, these smudgex/cleanx things
> work on a pathname.

There are a few ways that smudge/clean filters are not up to the task
currently. One is definitely the efficiency of the interface.

Another is that this distinction is not "canonical in-repo versus
working tree representation".  Yes, part of it is about what you store
in the repo versus what you checkout. But you may also want to diff or
merge these large items. Almost certainly not with the internal text
tools, but you might want to feed the _real_ blobs (not the fake
surrogates) to external tools, and smudge and clean are not a natural
fit for that. If you teach the external tools to dereference the
surrogates, it would work. I think you could also get around it by
giving these smudgex/cleanx filters slightly different semantics.

But the thing I most dislike about a solution like this is that the
representation pollutes git's data model. That is, git stores a blob
representing the surrogate, and that is the official sha1 that goes into
the tree. That means your surrogate decisions are locked into history
forever, which has a few implications:

  1. If I store a surrogate and you store the real blob, we do not get
     the same tree (and in fact get conflicts).

  2. Once I store a blob, I can never revise my decision not to store
     that blob in every subsequent clone without rewriting history. I
     can convert it into a surrogate, but old versions of that blob will
     always be required for object connectivity.

  3. If your surrogate contains more than just the sha1 (e.g., if it
     points to http://cdn.example.com), your history is forever tied to
     that (and you are stuck with configuring run-time redirects if your
     URL changes).

My thinking was to make it all happen below the git object level, at the
same level as packs and loose objects. This is more invasive to git, but
much more flexible.

The basic implementation is pretty straightforward. You configure one or
more helpers which have two operations: provide a list of sha1s, and
fetch a single sha1. Whenever an object lookup fails in the packs and
loose objects, we check the helper lists.  We can cache the lists in
some mmap'able format similar to a pack index, so we can do quick checks
for object existence, type, and size. And if the lookup actually needs
the object, we fetch and cache (where the caching policy would all be
determined by the external script).

The real challenges are:

  1. It is expensive to meet normal reachability guarantees. So you
     would not want a remote to delta against a blob that you _could_
     get, but do not have.

  2. You need to tell remotes that you can access some objects in a
     different way, and not to send them as part of an object transfer.

  3. Many commands need to be taught not to load objects carelessly. For
     the most part, we do well with this because it's already expensive
     to load large objects from disk. I think we've got most of them on
     the diff code path, but I wouldn't be surprised if one or two more
     crop up. Fsck would need to learn to handle these objects
     differently.

Item (3) is really just about trying it and seeing where the problems
come up. For items (1) and (2), we'd need a protocol extension.

Having the receiver send something like "I have these blobs from my external
source, don't send them" is a nice idea, but it doesn't scale well (you
have to advertise the whole list for each transfer, because the receiver
doesn't know which ones are actually referenced).

Having the receiver say "I have access to external database $FOO, go check
the list of objects there and don't send anything it has" unnecessarily
ties the sender to the external database (i.e., they have to implement
$FOO for it to work).

Something simple like "do not send blobs larger than N bytes, nor make
deltas against such blobs" would work. It does mean that your value of N
really needs to match up with what goes into your external database, but
I don't think that will be a huge problem in practice (after the
transfer you can do a consistency check that between the fetched objects
and the external db, you have everything).

> [details on smudgex/cleanx]

All of what you wrote seems very sane; I think the real question is
whether this should be "above" or "below" git's user-visible data model
layer.

-Peff
