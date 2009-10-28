From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: support remote branches in guess_ref DWIM
Date: Tue, 27 Oct 2009 20:01:04 -0400
Message-ID: <20091028000104.GA9426@sigill.intra.peff.net>
References: <20091026213353.GA27871@sigio.peff.net>
 <7v8wexn34i.fsf@alter.siamese.dyndns.org>
 <20091027014525.GA29583@sigio.peff.net>
 <7vaazc31sj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 01:01:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2vyc-0002ex-V8
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 01:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbZJ1ABD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 20:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756541AbZJ1ABD
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 20:01:03 -0400
Received: from peff.net ([208.65.91.99]:54303 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbZJ1ABC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 20:01:02 -0400
Received: (qmail 4950 invoked by uid 107); 28 Oct 2009 00:04:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 27 Oct 2009 20:04:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2009 20:01:04 -0400
Content-Disposition: inline
In-Reply-To: <7vaazc31sj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131391>

On Tue, Oct 27, 2009 at 03:33:16PM -0700, Junio C Hamano wrote:

> >   $ git fetch ;# presumably gets origin/branch
> >   $ git push origin/branch:renamed-branch
> >
> > which is much nicer than exposing clueless users to
> > ":refs/heads/renamed-branch".
> 
> You would need to expose ":refs/heads/branch" to make this a rename, not a
> copy, wouldn't you?

Yeah, you're right. This was based on an actual user request, and I
didn't think too closely about the other steps. But since the deletion
is of an existing branch, you should be able to do that without
refs/heads. So:

  $ git push origin origin/branch:renamed-branch
  $ git push origin :branch

Which of course you could do in one command if you wanted to live
(more) dangerously.

> > Am I missing some part of your argument?
> 
> I do not see much point (other than your "rename" example) in pushing what
> you got from the other end without changing anything yourself back to the
> same remote.

I don't either; my hope was that we can make that case a little bit
easier without creating undue hardship for anybody else.

> There was a thread in which people argued that the primary thing that is
> dangerous in this sequence
> 
>     $ git checkout origin/next; work-commit; work-commit; ...
> 
> is when you leave the detached HEAD state without saving it to a local
> branch.  I think what is more dangerous is that it will not give the user
> a solid understanding that these commits do _not_ change origin/next in
> any way.  After doing the above, it is understandable that a novice would
> mistakenly think: "I started from origin/next and built some, let's push
> the result".

I suppose it's possible. I don't have any evidence that users actually
think that way.

> With such a misconception, you will see the likely mistake here, too:
> 
>     $ git push origin origin/next:refs/heads/next
> 
> If "rename" is the _only_ valid reason you might want to push what you got
> from there back to the same remote, _and_ if "rename" is something very
> often needed, I think we would prefer to have a way to support that
> operation directly, instead of more general DWIM that would risk passing
> mistakes like the above unwarned.

OK, I can buy that. It would be much nicer even to support explicit
renaming (in fact, the user request started with that, and I just didn't
want to give them an answer that involved refs/heads/, which I think is
unnecessarily scary to users).

> IOW, it's between "prevent push with dubious $src from happening in the
> first place" vs "give them rope".  Historically I always sided with the
> latter camp, but I am trying to play a devil's advocate for a change ;-).

Heh. Thanks for explaining your thinking.

Let's scrap this for now, then. Remote rename doesn't actually come up
very often, and I agree that it would be nice to have an actual atomic
movement, which is what people really want.

-Peff
