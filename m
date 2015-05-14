From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] log: do not shorten decoration names too early
Date: Thu, 14 May 2015 13:49:45 -0400
Message-ID: <20150514174945.GB7966@peff.net>
References: <55534D95.60609@alum.mit.edu>
 <xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
 <xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
 <xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
 <20150514063317.GA22509@peff.net>
 <xmqq8ucr83h8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 19:49:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsxGb-0003iv-0Q
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933810AbbENRts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:49:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:58661 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933414AbbENRts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:49:48 -0400
Received: (qmail 15823 invoked by uid 102); 14 May 2015 17:49:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 12:49:47 -0500
Received: (qmail 25551 invoked by uid 107); 14 May 2015 17:49:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 13:49:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 13:49:45 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8ucr83h8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269057>

On Thu, May 14, 2015 at 10:37:39AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > While we are on the subject of the name_decoration code, I had
> > considered at one point replacing the use of the decorate.[ch] hash
> > table with a commit_slab (you can't do it in the general case, because
> > decorate.[ch] handles arbitrary objects, but the name_decoration code
> > only does commits). It would in theory be faster, though I don't know if
> > the time we spend on the hash table is actually measurable (we make a
> > lot of queries on it, but it doesn't actually get that big in the first
> > place).
> 
> Hmmm, but I do not know if commit_slab is a good fit for the usage
> pattern.  I expect commit objects to be fairly sparsely decorated
> (e.g. a tag or ref pointing at say 1-2% of commits or fewer).
> Wouldn't the hashtable used by decorate.[ch] with the max load
> factor capped to 66% a better economy?

Good point. A slab would be less memory efficient, but cheaper to look
up (it is a direct memory reference, with no probing and no hashcmp()).
But cache effects matter, so it could even be slower.

On the other hand, the slab makes it easy to actually store the real
type (struct name_decoration), whereas the decorate hash stores only
pointers. So we'd save an extra malloc/pointer in each case.

So with your slab_peek() below, I'd guess that the slab would actually
be faster. But I'd also be unsurprised if it makes no appreciable
difference to the overall runtime of "git log --decorate". I think we'd
have to build it and profile (and please feel free to say "eh, not worth
the time to think about further").

> I notice that there is no API into commit_slab to ask "Does this
> commit have data in the slab?"  *slabname##_at() may be the closest
> thing, but that would allocate the space and then says "This is the
> slot for that commit; go check if there is data there already."

Yes. I think it's not a big deal if your slab is reasonably full (you'll
extend it to the full size of your commit space eventually either way).
But for a sparse slab, it does make that query much more expensive than
it needs to be.

> Perhaps we want a new function *slabname##_peek() with the same
> signature as *slabname##_at() that returns NULL when commit->index
> is larger than the last existing element in the slab?  Then the
> above would become more like:
> 
>     const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
>     {
>             struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
>             if (!v)
>                     return NULL;
>             if (sizep)
>                     *sizep = v->size;
>             return v->buffer;
>     }

Yeah, I agree that is a good interface. It is basically a read-only
version of slab_at(). And it should be similarly agnostic as to the type
we are storing, because the pointer is into the slab array.

I'm not sure that the memory overhead is that big a deal (even in the
kernel, we are only talking about a few megabytes). But it is wasteful,
and the interface above should be trivial to write, so it might be worth
doing anyway.

-Peff
