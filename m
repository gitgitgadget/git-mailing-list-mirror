From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Fri, 6 Apr 2012 03:15:20 -0400
Message-ID: <20120406071520.GD25301@sigill.intra.peff.net>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <vpqty12h995.fsf@bauges.imag.fr>
 <20120405131301.GB10293@sigill.intra.peff.net>
 <vpqwr5uceis.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 06 09:18:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG3R4-0001TS-Nq
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 09:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab2DFHSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 03:18:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49744
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754742Ab2DFHPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 03:15:25 -0400
Received: (qmail 32691 invoked by uid 107); 6 Apr 2012 07:15:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 03:15:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 03:15:20 -0400
Content-Disposition: inline
In-Reply-To: <vpqwr5uceis.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194853>

On Thu, Apr 05, 2012 at 06:46:51PM +0200, Matthieu Moy wrote:

> It seems rather natural to me to have "asymetric workflow, asymetric
> commands" by default. So, if one wants to push to a place other than
> upstream, say "git push public-repo branch", or set your upstream to
> where you want to push (simple with "git push -u"), and say explicitely
> "git pull repo branch".

That makes sense _if_ the user is thinking about pull and push as
symmetric commands. That may be immediately obvious for some people's
mental models. But I suspect it is not for others (it is not for mine,
though I obviously do not count as a beginner).

> I can hardly imagine someone knowing what "git pull" does, and
> _surprised_ to see that "git push" sends commits to the same place. I
> agree that sending commits to upstream may be a mistake, but I don't
> think it can happen "by surprise".

You are asking the new user to make a logical inference about the
relationship between push and pull. That inference may seem obvious to
you, and it may even be obvious to a large portion of new users. But
keep in mind that we are not debating whether "upstream" is a reasonable
thing for git to have, but rather whether it is a good default.  My
concern is that upstream as a default would have negligible benefit for
people who do make the inference, but be dangerous for the group who do
not. We don't know the size of the latter, but my feeling is that it is
non-trivial.

> There are also ways to shoot yourself in the foot with when setting
> upstream to something other that where you usually push. For example,
> run "git rebase -i" without argument, and it will offer you to rewrite
> some published history.

Yes, although that is often what you want in such a setup (e.g., you are
rebasing on top of the upstream branch, but publishing your work in
progress).  However, I do agree that it can potentially be dangerous.
Two helpful saving graces are:

  1. The first thing you see upon "git rebase -i" is a giant list of the
     commits from your upstream branch. It is usually quite obvious that
     you are rebasing more than you want in this case, and you can abort
     before doing anything.

  2. Even if you do rebase, you have made a _local_ error. You are not
     hurting anyone until you push, at which point you will get a
     non-fast-forward error, and you have a chance to fix things before
     disrupting other people.

> And I still have my concern with real beginners: what advice would you
> give to a user whose "git push" is denied because of non-fast forward. I
> raised this concern already:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=193196
> 
> and I essentially had the answer "telling the user to pull is wrong"
> (with which I disagree), but no one managed to give another advice.

It _is_ wrong unless the destination branch is also the configured
upstream. Which yes, it probably is if push.default is "upstream".
Unless you actually specified a push destination, in which case it may
not be. Or if you were pushing something besides HEAD.

If the push destination was $remote:$branch, it seems the only correct
thing is to suggest "git pull $remote $branch" in the general case, and
possibly simplify that to "git pull" if $remote:$branch is the
configured upstream. And if the source was HEAD, of course; otherwise
you would need to checkout.

So shouldn't the advice for a non-fast-forward push be:

   if $source_ref is currently checked out
           advise "git checkout $source_ref, and then..."
   fi
   if $dest_remote == branch.$source_ref.remote &&
      $dest_ref == branch.$source_ref.merge
           advise "git pull"
   else
           advise "git pull $dest_remote $dest_ref"
   fi

That handles only one ref, of course. If you get multiple non-ff
failures, I'm not sure what we should advise.

> >> The discussion seems to focuse on 'let's make "git push" easy to
> >> explain', but I think the right thing to do is to make _Git_ easy to
> >> explain. With "push.default = current", we'll have a hard time
> >> explaining how "git pull" works.
> >
> > Do we have a hard time explaining how "git pull" works now?
> 
> I don't think so, but Junio's argument is that explaining what push
> would do with 'upstream' would be too complex, and that 'current' is
> easier to explain. If 'git pull' is simple, then 'git -c
> push.current=upstream push' is equally simple.

You wrote above that we'll have a hard time explaining how "git pull"
works. But I don't think so; if it hasn't been a problem with
"matching", then why would it with "current"?

I agree that your symmetry explanation is reasonably simple for
explaining what "git push" will do for new users (though I also think
"current" is quite easy to explain). I'm less concerned with explaining
and more concerned about safe defaults.

-Peff
