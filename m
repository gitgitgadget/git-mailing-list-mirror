From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/17] provide a helper to free commit buffer
Date: Thu, 12 Jun 2014 16:08:55 -0400
Message-ID: <20140612200855.GB4468@sigill.intra.peff.net>
References: <20140610213509.GA26979@sigill.intra.peff.net>
 <20140610214005.GH19147@sigill.intra.peff.net>
 <xmqqzjhi56oo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:09:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvBIz-0004GA-QX
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 22:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbaFLUI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 16:08:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:42887 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752111AbaFLUI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 16:08:57 -0400
Received: (qmail 2605 invoked by uid 102); 12 Jun 2014 20:08:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jun 2014 15:08:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jun 2014 16:08:55 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzjhi56oo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251493>

On Thu, Jun 12, 2014 at 11:22:31AM -0700, Junio C Hamano wrote:

> > Note that we also need to provide a "detach" mechanism for
> > the weird case in fsck which passes the buffer back to be
> > freed.
> 
> I find that last sentence a bit of white lie ;-).
> 
> The sole caller of "detach" is in index-pack, and discards the
> return value, which is not wrong per-se because it still has the
> pointer to the piece of memory it fed to parse_object_buffer(),
> knows and/or assumes that the return value must be the same as the
> one it already has, and it handles the freeing of that memory
> without relying on the object layer at all.
> 
> But that is an even more weird special case than the white-lie
> version.  As an API, "detach" that returns the buffer to be freed
> looks much less weird than what is really going on in the current
> caller.
> 
> I however have to wonder if
> 
> 	if (detach_commit_buffer(commit) != data)
>         	die("BUG");
> 
> might want to be there.

Yeah, it is a tricky site. It knows that parse_object_buffer may attach
the buffer we hand it to "commit->buffer", even though we would prefer
to keep the buffer ourselves. So the existing code really just wants to
say "erase that attachment". And of course I started with:

  void detach_commit_buffer(struct commit *commit)
  {
	commit->buffer = NULL;
  }

Both before and after it's a bit of a layering violation; we know how
the internals of buffer attaching work, and that we can detach to get
our original.

I then expanded it to the strbuf-inspired detach you see, even though
there are no callers who actually care about the return value. That
makes more sense to me as a general API. I don't think it actually makes
the layering violation worse (we are still making the exact same
assumption), but I think it _seems_ worse, because the API now seems
more fully formed. And note that we make the exact same assumptions
abotu "struct tree" a few lines above.

The safety check you mention above makes sense to me. There are two
things I'd _rather_ do, but they end up more complicated:

  1. It would be nice to ask parse_object_buffer not to attach the
     buffer in the first place; then we could get rid of the detach
     function entirely. But that attachment is necessary for all of the
     fsck sub-functions we call. Factoring those to take a separate
     buffer would be rather disruptive.

  2. Instead of confirming that detach returns the same buffer, just
     assume our buffer was eaten (as promised by set_commit_buffer),
     and continue on with whatever detach_commit_buffer returns.
     But it is not _our_ buffer in the first place. It is passed in by
     the caller, so this replacement would have to bubble back up to the
     original allocator.

So just putting in the safety check is probably the least-disruptive
thing. It doesn't automatically adapt to a change in the underlying
commit_buffer code, but it would at least notice it.

-Peff
