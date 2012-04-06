From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Fri, 6 Apr 2012 04:00:04 -0400
Message-ID: <20120406080004.GA27940@sigill.intra.peff.net>
References: <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <vpqty12h995.fsf@bauges.imag.fr>
 <20120405131301.GB10293@sigill.intra.peff.net>
 <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 06 10:00:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG46F-00030c-Sp
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 10:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439Ab2DFIAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 04:00:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49796
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737Ab2DFIAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 04:00:09 -0400
Received: (qmail 785 invoked by uid 107); 6 Apr 2012 08:00:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 04:00:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 04:00:04 -0400
Content-Disposition: inline
In-Reply-To: <vpqr4w12tjj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194858>

On Fri, Apr 06, 2012 at 09:44:48AM +0200, Matthieu Moy wrote:

> I think exactly the opposite. Once you learnt about remote-tracking
> branches, about "git fetch" Vs "git pull", you understand why "git pull"
> and "git push" are not strictly speaking symmetrical operations.
> 
> But just from the wording, it should be obvious that the commands are
> doing something somehow symmetrical.

My mind may be warped from too much git and I may be misremembering my
early days, but I feel like I never considered "push" and "pull" to be
symmetric opposites. I dunno. We are both talking about some
hypothetical population of new users, and I'm not sure either of us has
hard data.

> > So shouldn't the advice for a non-fast-forward push be:
> >
> >    if $source_ref is currently checked out
> >            advise "git checkout $source_ref, and then..."
> >    fi
> >    if $dest_remote == branch.$source_ref.remote &&
> >       $dest_ref == branch.$source_ref.merge
> >            advise "git pull"
> >    else
> >            advise "git pull $dest_remote $dest_ref"
> >    fi
> >
> > That handles only one ref, of course. If you get multiple non-ff
> > failures, I'm not sure what we should advise.
> 
> The topic ct/advise-push-default does essentially that indeed.

I think it does the first half (recommend checkout if it was a non-HEAD). But
the "pull before push" message just says:

  Updates were rejected because the tip of your current branch is behind
  its remote counterpart. Merge the remote changes (e.g. 'git pull')
  before pushing again.

which is not exactly right. Saying "e.g." lets clueful people know that
the details of merging might be different, but I doubt that subtlety is
helpful for new users.

> > You wrote above that we'll have a hard time explaining how "git pull"
> > works. But I don't think so; if it hasn't been a problem with
> > "matching", then why would it with "current"?
> 
> I mis-spoke. I think I meant something like "if the assumption that
> explaining push -c push.current=upstream is hard, then we'll have a hard
> time explaining git pull".

That makes more sense to me.

> About safety, I don't think we can tell in general which bad push is the
> most serious. push.default=current may create branches unexpectedly,
> while push.default=upstream would ask you to "push --set-upstream" when
> creating the remote branch. push.default=upstream may push to the master
> when you wanted to create a remote topic branch. My feeling is that both
> are equally bad, but maybe I'm wrong here.

I would say without hesitation that fast-forwarding the upstream is more
likely to be disastrous than creating a new branch. However,
push.default=current can also fast-forward an existing branch (although
if you have a local "foo" and its upstream is _not_ the remote "foo", I
find it extremely unlikely that a remote "foo" also exists).

On the other hand, one thing we have not talked about is how one gets
into the "topic push fast-forwards master" situation. Which is running:

  $ git checkout -b topic origin/master

I'm not sure if that is something totally clueless people will run. And
maybe by the time people are intermediate enough git users to run that,
they will have figured out how upstream works. So maybe my concern is
overblown.  I consider the much more likely scenarios for a new user to
be:

  $ git clone ... && cd project
  $ hack hack hack
  $ git push

which will work with either "current" or "upstream", or:

  $ git clone ... && cd project
  $ git checkout foo ;# equivalent of "git checkout -b foo origin/foo"
  $ hack hack hack
  $ git push

which also works with both, or:

  $ git clone ... && cd project
  $ git checkout -b topic
  $ hack hack hack
  $ git push

which will error out for "upstream", and create a new branch "topic" on
the remote with "current".

-Peff
