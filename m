From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] fetch --prune: Repair branchname DF conflicts
Date: Thu, 19 Dec 2013 06:44:14 -0500
Message-ID: <20131219114413.GA23298@sigill.intra.peff.net>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
 <1387401776-30994-3-git-send-email-jackerran@gmail.com>
 <xmqq4n65hlko.fsf@gitster.dls.corp.google.com>
 <20131219014859.GA32240@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tom Miller <jackerran@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 12:44:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtc1f-0007zq-Rh
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 12:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab3LSLoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 06:44:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:47273 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752488Ab3LSLoT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 06:44:19 -0500
Received: (qmail 16288 invoked by uid 102); 19 Dec 2013 11:44:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Dec 2013 05:44:19 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Dec 2013 06:44:14 -0500
Content-Disposition: inline
In-Reply-To: <20131219014859.GA32240@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239519>

On Wed, Dec 18, 2013 at 07:48:59PM -0600, Tom Miller wrote:

> I did not intend to introduce new lingo. I did some searching through
> history to see if something like this had been worked on before and
> I found a commit by Jeff King that introduced me the the idea of
> "DF conflicts"

I take all the blame. :)

As for the patch itself:

> >> diff --git a/builtin/fetch.c b/builtin/fetch.c
> >> index e50b697..845c687 100644
> >> --- a/builtin/fetch.c
> >> +++ b/builtin/fetch.c
> >> @@ -868,11 +868,6 @@ static int do_fetch(struct transport *transport,
> >>
> >>       if (tags == TAGS_DEFAULT && autotags)
> >>               transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
> >> -     if (fetch_refs(transport, ref_map)) {
> >> -             free_refs(ref_map);
> >> -             retcode = 1;
> >> -             goto cleanup;
> >> -     }
> >>       if (prune) {
> >>               /*
> >>                * We only prune based on refspecs specified
> >> @@ -888,6 +883,11 @@ static int do_fetch(struct transport *transport,
> >>                                  transport->url);
> >>               }
> >>       }
> >> +     if (fetch_refs(transport, ref_map)) {
> >> +             free_refs(ref_map);
> >> +             retcode = 1;
> >> +             goto cleanup;
> >> +     }

I think this is _probably_ a good thing to do, but it does have an
interesting side effect for concurrent operations, and I haven't seen
that mentioned so far in the discussion.

Readers of the ref namespace don't have any sort of transactionally
consistent view of all of the refs. So if a remote has moved a branch
"foo" to "bar" and we "fetch --prune", there will be a moment where a
simultaneous reader will see one of two states that never existed on the
remote (depending on the order the fetch chooses): either both refs
exist, or neither exists.

Right now fetch creates first and deletes after, so a simultaneous
reader may see both refs. After your change, it may see no refs at all.
Even though both are technically wrong, the current behavior is safer.
If the reader is calculating reachability (e.g., for a repack or "git
prune), it is better to have too many references than too few.

I'm not sure to what degree we want to care. This is a race, but it's a
reasonably unlikely one, and the D/F thing bites people in the real
world.

And further confounding this is the fact that even if the writer does
everything correctly, the way we read refs can still cause an odd view
of the whole namespace. For example, consider moving "refs/heads/z/foo"
to "refs/heads/a/foo", while somebody else reads simultaneously. Even
with create-before-delete, we can get the sequence:

  1. Reader reads "refs/heads/a/" and sees it does not contain "foo".

  2. Writer writes "refs/heads/a/foo".

  3. Writer deletes "refs/heads/z/foo".

  4. Reader reads "refs/heads/z", which does not contain "foo".

That race can be closed with a double-read of the ref namespaces, but
that has poor performance. A more reasonable fix, IMHO, would be to have
an alternate ref store that represents transactions atomically (keeping
in mind that this really only matters for busy repos with simultaneous
readers and writers, so it would not even need to be the default ref
store). And once you have such a store, that solves the other problem,
too: you can just treat the delete-create as a transaction anyway. It
also solves a similar problem with refs that rewind.

So even leaving it as-is does not make the problem go away, though the
proposed change does exacerbate it somewhat. I wonder how hard it would
be to do the safer thing in the common case that there is no D/F
conflict. That is, do multiple passes at updating the refs:

  1. Create/update any refs we can. Those with D/F conflicts are put
     aside for the moment.

  2. Delete any refs according to the --prune rules.

  3. Come back to any D/F conflicts and try them again.

I dunno. As far as I know, this is not a race that people see often in
real life (I do not have any confirmed cases of it yet). So it may
simply not be worth worrying about.

-Peff
