From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH]: reverse bisect v 2.0
Date: Mon, 3 Oct 2011 06:41:12 -0400
Message-ID: <20111003104112.GE16078@sigill.intra.peff.net>
References: <20110929142027.GA4936@zelva.suse.cz>
 <20110930114220.GA742@zelva.suse.cz>
 <7v62k9q4oq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Vyskocil <mvyskocil@suse.cz>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 12:41:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAfxY-0005DQ-FX
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 12:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab1JCKlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 06:41:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51548
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab1JCKlO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 06:41:14 -0400
Received: (qmail 27363 invoked by uid 107); 3 Oct 2011 10:46:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 06:46:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 06:41:12 -0400
Content-Disposition: inline
In-Reply-To: <7v62k9q4oq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182650>

On Fri, Sep 30, 2011 at 11:13:25AM -0700, Junio C Hamano wrote:

> I wonder if something along the following line would make the usage more
> pleasant and self-explanatory:
> 
>     $ git bisect start --used-to='git frotz says xyzzy' v0.99 master
>     Bisecting: 171 revisions left to test after this (roughly 8 steps)
>     $ ... build and then test ...
>     $ git bisect tested
>     You are trying to check: git frotz says xyzzy
>     Does the result satisify what you are trying to find [y/n]? yes

I like this idea a lot. My "yes/no" thing was a "if I were designing
bisect from scratch today..." suggestion, but having something like
--used-to makes it a natural addition to the regular good/bad interface.
And I really like the prompt to help people remember what it is they're
declaring each time.

However, --used-to feels a bit backwards to me. I think of it as
"--has-property" or something similar. That is, you are looking for when
something appeared (be it a bug, a feature, or whatever). But I guess it
depends on what you are bisecting. In my case, "yes" would be the
current "bad", and "no" would be the current "good".

So maybe provide both --used-to and --has-property (which I really
dislike as a name, but I can't think of anything better at the moment).
And then we can interpret "yes" and "no" accordingly, depending which
one the user used (and while that _sounds_ confusing, it won't be to the
user; we'll be prompting them with "you're looking for ...", so their
answer will be very natural).

But with both of them, the user is free to phrase it in whatever way
feels natural.

> When trying to find regression, you would say:
> 
>     $ git bisect start --used-to='it works' v0.99 master

Just for completeness, under my proposal this could also be:

  $ git bisect start --has-property='git frotz is broken' v0.99 master

Which is probably slightly less natural. But:

> When trying to find a fix, you would say:
> 
>     $ git bisect start --used-to='checkout $tree $path clobbers $path' v0.99 master

This one would be a bit nicer:

  $ git bisect start --has-property='checkout works' v0.99 master

-Peff

PS Side note: do we really need it to be interactive? I would think
   you could do:

      $ git bisect start --used-to='git frotz says xyzzy'
      Bisecting: 171 revisions left to test after this (roughly 8 steps)
      Checking whether 'git frotz says xyzzy'.
      $ ... build and test ...
      $ git bisect yes
      Bisecting: 89 revisions left to test after this (roughly 7 steps)
      Checking whether 'git frotz says xyzzy'.

   It means the user is reminded, then tests, then responds. But I think
   it would be enough of a reminder. The important thing is that we keep
   mentioning it at each bisection step. Maybe it depends on how long
   your build/test step is (I tend to work on things like git, where
   that is a 30-second procedure, not a kernel with a long build and a
   reboot in between :) ).
