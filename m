From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] not making corruption worse
Date: Wed, 18 Mar 2015 06:21:08 -0400
Message-ID: <20150318102108.GA27249@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317073730.GA25267@peff.net>
 <xmqqh9tjme0l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 11:21:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYB6C-0005fn-Ks
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 11:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215AbbCRKVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 06:21:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:34551 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754074AbbCRKVK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 06:21:10 -0400
Received: (qmail 825 invoked by uid 102); 18 Mar 2015 10:21:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 05:21:10 -0500
Received: (qmail 1892 invoked by uid 107); 18 Mar 2015 10:21:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 06:21:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 06:21:08 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9tjme0l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265714>

On Tue, Mar 17, 2015 at 03:54:02PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But it strikes me as weird that we consider the _tips_ of history to be
> > special for ignoring breakage. If the tip of "bar" is broken, we omit
> > it. But if the tip is fine, and there's breakage three commits down in
> > the history, then doing a clone is going to fail horribly, as
> > pack-objects realizes it can't generate the pack. So in practice, I'm
> > not sure how much you're buying with the "don't mention broken refs"
> > code.
> 
> I think this is a trade-off between strictness and convenience.  Is
> it preferrable that every time you try to clone a repository you get
> reminded that one of its refs point at a bogus object and you
> instead have to do "git fetch $there" with a refspec that excludes
> the broken one, or is it OK to allow clones and fetches silently
> succeed as if nothing is broken?

I think the real issue is that we do not know on the server side what
the client wants. Is it "tell me the refs, so I can grab just the one I
need, and I don't care about the broken ones"? Or is it "I want
everything you have, and tell me if you can't serve it"?  You want
strictness in the latter case, but not in the former. But if we were to
err on the side of strictness, you could not do the former at all
(because upload-pack would barf before the client even has a chance to
say anything).

I'm not sure if anyone will actually find GIT_REF_PARANOIA useful for
something like that or not. As an environment variable, it may impact a
filesystem-local clone, but it would not travel across a TCP connection.
And doing so is tough, because the ref advertisement happens before the
client speaks.

If we ever have a client-speaks-first protocol, one extension could
allow the client to flip the paranoia switch on the server. But my main
goal here was really just making "prune" safer, so I'm happy enough with
what this series does, for now.

> In some parts of the system there is a movement to make this trade
> off tweakable (hint: what happened to the knobs to fsck that allow
> certain kinds of broken objects in the object store?  did the topic
> go anywhere?). This one so far lacked such a knob to tweak, and I
> view your paranoia bit as such a knob.

I think I promised several times to review that topic and never got
around to it. Which makes me a bad person. It is still on my todo list.

-Peff
