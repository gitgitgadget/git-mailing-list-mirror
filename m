From: Jeff King <peff@peff.net>
Subject: Re: Tag peeling peculiarities
Date: Thu, 14 Mar 2013 01:24:48 -0400
Message-ID: <20130314052448.GA2300@sigill.intra.peff.net>
References: <51409439.5090001@alum.mit.edu>
 <7vwqtb2ood.fsf@alter.siamese.dyndns.org>
 <20130313215800.GA23838@sigill.intra.peff.net>
 <51415516.2070702@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 14 06:25:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG0fQ-0006NS-2N
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 06:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab3CNFYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 01:24:52 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51374 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054Ab3CNFYv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 01:24:51 -0400
Received: (qmail 11577 invoked by uid 107); 14 Mar 2013 05:26:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Mar 2013 01:26:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2013 01:24:48 -0400
Content-Disposition: inline
In-Reply-To: <51415516.2070702@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218113>

On Thu, Mar 14, 2013 at 05:41:58AM +0100, Michael Haggerty wrote:

> Here is analysis of our options as I see them:
> 
> 1. Accept that tags outside of refs/tags are not reliably advertised in
>    their peeled form.  Document this deficiency and either:
> 
>    a. Don't even bother trying to peel refs outside of refs/tags (the
>       status quo).

When you say "not reliably advertised" you mean from upload-pack, right?
What about other callers? From my reading of peel_ref, anybody who calls
it to get a packed ref may actually get a wrong answer. So this is not
just about tag auto-following over fetch, but about other places, too
(however, a quick grep does not make it look like this other places are
all that commonly used).

Another fun fact: upload-pack did not use peel_ref until recently
(435c833, in v1.8.1). So while it is tempting to say "well, this was
always broken, and nobody cared", it was not really; it is a fairly
recent regression in 435c833.

>    b. Change the pack-refs writer to write all peeled refs, but leave
>       the reader unchanged.  This is a low-risk option that would cause
>       old and new clients to do the right thing when reading a full
>       packed-refs file, but an old or new client reading a non-full
>       packed-refs file would not realize that it is non-full and would
>       fail to advertise all peeled refs.  Minor disadvantage: pack-refs
>       becomes slower.

This seems sane. The missing thing is a flag to tell the reader that it
was written by a newer version; I see you dealt with that case below.

I don't think pack-refs being a little bit slower matters. Checking the
types to peel is not even that much work; it's just that it adds up when
you do it for every no-op fetch's ref advertisement. But we can assume
that writing happens a lot less than reading; that is the point of
storing the peeled information in the first place. If that assumption is
not correct in some scenario, then those people should probably not be
packing their refs at all, so I think we can discount them from this
discussion.

> 2. Insist that tags outside of refs/tags are reliably advertised.  I
>    see three ways to do it:
> 
>    a. Without changing the packed-refs contents.  This would require
>       upload-pack to read *all* references outside of refs/tags.  (This
>       is what Peff's patch does.)

FWIW, this is what upload-pack used to do before I switched it to use
peel_ref. The savings are measurable, though they are not
ground-breaking. Still, I think your "fully-packed" proposal above lets
us keep the improvement without too much effort.

>    b. Write all peeled refs to packed-refs without changing the
>       packed-refs header.  This would hardly help, as upload-pack
>       would still have to read all non-tag references outside of
>       refs/tags to be sure that none are tags.

Right, this seems silly; the new reader does extra work for
compatibility with an older writer, but the normal case is to use the
same version. The obvious optimization is to add a flag that says "hey,
I was written by a new writer". And that is your "fully-packed"
proposal, covered below.

>    c. Add a new keyword to the top of the packed-refs file as
>       described above.  Then
> 
>       * Old writer, new reader: the reader would know that some
>         peeled refs might be missing.  upload-pack would have to
>         resolve refs outside of refs/tags, but could optionally write
>         a new-format packed-refs file to avoid repeating the work.

I think that is OK. For the most part, this is a temporary situation
that happens when you are moving from an older to a newer version of
git. If you are switching back and forth between versions, then we are
correct, but you don't get the benefit of the micro-optimization, which
seems fair.

>       * New writer, new reader: the reader would know that all refs
>         are peeled properly and would not have to read any objects.

This is the common case I think we should be optimizing for. And
obviously the outcome here is good. It's also fine without adding the
"fully-packed" flag, though.

>       * Old writer, old reader: status quo; peeled refs are advertised
>         incompletely.

Right. We can't fix those without a time machine, though.

>       * New writer, old reader: This is the interesting case.  The
>         current code in Git would read the header and see "peeled" but
>         ignore "fully-peeled".  But the line-reading code would
>         nevertheless happily read and record peeled references no
>         matter what namespace they live in.  It would also advertise
>         them correctly.  One would have to check historical versions
>         and other clients to see whether they would also behave well.

Right. So we have pretty sane backwards-compatible behavior. I think if
other implementations are not happy seeing a new tag, they are wrong.
The whole point of the "#"-tags is for future expansion. Looking over
libgit2, it seems to ignore the "#"-line completely, so I think it would
behave OK (and it should be taught about fully-peeled, too, but that is
not our immediate problem).

>    d. Add some new notation, like a "^" on a line by itself, to mean
>       "I tried to peel this reference but it was not an annotated tag".
>       Old readers ignore such lines but new readers could take it
>       as an indication to set the REF_KNOWS_PEELED bit for that entry.
>       (It is not clear to me whether it would be permissible to make a
>       change like this without changing the header line.)

I don't see the point. The writer wants to provide REF_KNOWS_PEELED for
every entry in its list so that the reader (which is run more often)
does not have to put forth any effort. So this accomplishes the same
thing as a "anything without a peeled ref did not need peeling" flag,
but takes more space.

> I think the best option would be 1b.  Even though there would never be a
> guarantee that all peeled references are recorded and advertised
> correctly, the behavior would asymptotically approach correctness as old
> Git versions are retired, and the situations where it fails are probably
> rare and no worse than the status quo.

Thanks for laying out the options. I think 1b or 2c are the only sane
paths forward. With either option, a newer writer produces something
that all implementations, old and new, should get right, and that is
primarily what we care about.

So the only question is how much work we want to put into making sure
the new reader handles the old writer correctly. Doing 2c is obviously
more rigorous, and it is not that much work to add the fully-packed
flag, but I kind of wonder if anybody even cares. We can just say "it's
a bug fix; run `git pack-refs` again if you care" and call it a day
(i.e., 1b).

I could go either way.

-Peff
