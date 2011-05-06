From: Jeff King <peff@peff.net>
Subject: Re: error with $ git push origin HEAD:newbranch
Date: Fri, 6 May 2011 13:02:04 -0400
Message-ID: <20110506170204.GA16576@sigill.intra.peff.net>
References: <loom.20110505T103708-225@post.gmane.org>
 <20110505093752.GB29595@sigill.intra.peff.net>
 <loom.20110505T114511-660@post.gmane.org>
 <20110505105914.GA464@sigill.intra.peff.net>
 <loom.20110506T034552-210@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 19:02:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIOPv-00086L-KQ
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 19:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704Ab1EFRCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 13:02:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33036
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754263Ab1EFRCI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 13:02:08 -0400
Received: (qmail 11973 invoked by uid 107); 6 May 2011 17:04:02 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 May 2011 13:04:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 May 2011 13:02:04 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110506T034552-210@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172990>

On Fri, May 06, 2011 at 02:16:03AM +0000, chris wrote:

> Jeff King <peff <at> peff.net> writes:
> > 
> > On Thu, May 05, 2011 at 10:06:21AM +0000, chris wrote:
> > 
> > > It is slightly surprising that git-push doesn't default to assuming 
> > > one means refs/heads/newbranch in this case.  I don't see a reason 
> > > not to?
> > 
> > Consider something like:
> > 
> >   $ git checkout v1.5
> >   $ git push origin HEAD:foo
> > 
> > Would you want "foo" to be a branch or a tag? I can see arguments for
> > either.
> 
> If the above command wanted to produce a tag, just provide 'v1.5' as the source 
> ref.  It seems to me that first checking out the tag then pushing from HEAD is 
> extra steps in order to push a branch ref without having to be explicit about 
> it.  $ git push origin v1.5:foo would have been simpler if intending to push a 
> tag ref.

Sure, but that was just a small example. It could just as easily have
been:

  $ git checkout v1.5
  ... look look look ...
  ... hmm, this one doesn't have the bug or feature I'm looking for ...
  $ git checkout v1.5.1
  ... look look look ...
  ... nor this one ...
  $ git checkout v1.5.2
  ... look look look ...
  ... oh, this one has it, let's push it upstream to communicate to
      somebody ...
  $ git push origin HEAD:foo

Sure, I _could_ say "git push origin v1.5.2:foo" in the final step. But
my mental model is "I have found the thing I am looking for, now push
it", which means HEAD is more natural.  This is more obvious to see when
you start leaving refs, like:

  $ git checkout HEAD^
  ... look look look; nope ...
  $ git checkout HEAD^
  ... look look look; nope ...
  $ git checkout HEAD^
  ... yep, found it ...
  $ git push origin HEAD:foo

So in both of those cases, what should be pushed? A tag or a branch? My
argument is that git would have to guess. Rather than guess, we come
back to the user and say "please be more specific".

> Given that git-push has specific syntax for pushing a tag, and git-push makes 
> other assumptions that give the perception it is generally used for branches 
> unless told otherwise also makes me expect that "foo" to be a branch.

That tag syntax is antique and predates most of the nice DWIM behavior
of refspecs. Nowadays you can just say "git push <remote> v1.5" and it
will do the same thing without the "tag" modifier. So I doubt anyone
uses it.

I wonder if we should more clearly mark it as useless in the
documentation.

> The following is provided for specifically calling out a tag:
> 
>   $ git push origin tag <refspec>
> 
> However, that syntax as far as I can tell is pretty worthless anyway, as the 
> following will not work:
> 
>   $ git push origin tag HEAD:newtag
>   error: src refspec refs/tags/HEAD does not match any.
> 
>   $ git push origin tag 183c65e:newtag
>   error: src refspec refs/tags/183c65e does not match any.

Right. It's literally about expanding "tag foo" into
"refs/tags/foo:refs/tags/foo". So it only works for a tag ref.

For both of those, you would need:

  git push origin HEAD:refs/tags/newtag

  git push origin 183c65e:refs/tags/newtag

> But both the following are successful, which makes me ask why the 'tag' option 
> exists if the above doesn't work.
> 
>   $ git push tag existingtag:newtag1
> 
>   $ git push existingtag:newtag2
> 
> So I see little purpose in the $ git push tag <refspec> syntax, as the source 
> must already be a tag anyway.

Right. Once upon a time, that didn't Just Work. These days we see that
the LHS of the refspec is a tag, and infer that the RHS should be, as
well (in the absence of anything more specific).

> Personally, I would prefer that git-push work on branches by default[1], 
> providing shortcuts for pushing tag[2] refs and remote branch[3] refs, while all 
> other ref types must be called out explicitly.  Creating new refs isn't 
> destructive, so it seems these could be supported without concern.
> 
> 1. $ git push origin SHA1:branch1
>   => $ git push origin SHA1:refs/heads/branch1
> 
> 2. $ git push origin tag SHA1:tagname
>   => $ git push origin SHA1:refs/tags/tagname
> 
> 3. $ git push origin SHA1:upstream/branch2
>   => $ git push origin SHA1:refs/remotes/upstream/branch2

In (3), how do you differentiate between the branch
"refs/heads/upstream/branch2" and the remote tracking branch
"refs/remotes/upstream/branches"?

-Peff
