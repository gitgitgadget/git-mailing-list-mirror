From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Fri, 24 Jan 2014 16:35:21 -0500
Message-ID: <20140124213521.GA26602@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
 <20140108093716.GE15720@sigill.intra.peff.net>
 <xmqqob32s08p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 22:35:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6oPR-0002bU-5s
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 22:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbaAXVfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 16:35:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:38402 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753203AbaAXVfX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 16:35:23 -0500
Received: (qmail 11031 invoked by uid 102); 24 Jan 2014 21:35:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Jan 2014 15:35:23 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jan 2014 16:35:21 -0500
Content-Disposition: inline
In-Reply-To: <xmqqob32s08p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241044>

On Thu, Jan 23, 2014 at 04:16:06PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In a triangular workflow, you may have a distinct
> > @{upstream} that you pull changes from, but publish by
> > default (if you typed "git push") to a different remote (or
> > a different branch on the remote). It may sometimes be
> > useful to be able to quickly refer to that publishing point
> > (e.g., to see which changes you have that have not yet been
> > published).
> >
> > This patch introduces the <branch>@{publish} shorthand (or
> > "@{pu}" to be even shorter). It refers to the tracking
> > branch of the remote branch to which you would push if you
> > were to push the named branch. That's a mouthful to explain,
> > so here's an example:
> >
> >   $ git checkout -b foo origin/master
> >   $ git config remote.pushdefault github
> >   $ git push
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> 
> As there is no @{pu} in publish_mark() as far as I can see, and also
> I found it is a bit unclear what the example in the last paragraph
> wants to illustrate, I'll reword the above as the following before
> merging it to 'next'.

Yeah, I think the @{pu} was just a silly omission from the code, though
I agree after our discussion that we should just stick with "@{publish}"
for now.

I am not sure why I said "git push" at the end. I would have thought
that:

  $ git rev-parse --symbolic-full-name @{publish}
  refs/remotes/github/foo

would have been the right command to demonstrate. The text you suggested
is fine, though I think you can simply drop the "git push", as it does
not add anything.

As far as merging it to 'next', I had not really intended it to go that
far. :) It was more for Ram to use as a base. I find some of the
refactoring questionable, including:

  1. The meaning of branch->pushremote is subtly different from that of
     branch->remote. Ram's followup refactoring did a better job of
     that (but he is missing the patches on top to finish out the
     feature).

  2. We are duplicating the "where to push" logic here. That should
     probably be factored out so that "git push" and "@{publish}" use
     the same logic.

And of course there are no tests or documentation. It might work,
though.

I don't mind if you want to merge it and do more work in-tree, but I do
not think it should graduate as-is. And you may want check from Ram that
he is not in the middle of his own version based on the patches he sent
earlier, as reworking them on top of mine would probably just be
needless extra work.

Are you planning on having request-pull use @{publish} as a default? I
saw you cc'd me on that thread, but I didn't have any opinion besides
"sounds like you could use it here".

-Peff
