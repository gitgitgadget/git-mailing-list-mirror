From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Fri, 11 Nov 2011 13:13:52 -0500
Message-ID: <20111111181352.GA16055@sigill.intra.peff.net>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
 <20111107172218.GB3621@sigill.intra.peff.net>
 <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
 <20111107183938.GA5155@sigill.intra.peff.net>
 <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
 <20111107210134.GA7380@sigill.intra.peff.net>
 <CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
 <20111108181442.GA17317@sigill.intra.peff.net>
 <CAMP44s2RjcFtdO2jft0Hg9RtqK-DRK47gX8By-dBFSBcSA+yFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 19:14:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROvc1-0003RQ-8R
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 19:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab1KKSNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 13:13:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39668
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273Ab1KKSNz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 13:13:55 -0500
Received: (qmail 3442 invoked by uid 107); 11 Nov 2011 18:13:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Nov 2011 13:13:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2011 13:13:52 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s2RjcFtdO2jft0Hg9RtqK-DRK47gX8By-dBFSBcSA+yFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185277>

On Fri, Nov 11, 2011 at 02:30:48PM +0200, Felipe Contreras wrote:

> > Doesn't --all mean all refs, including tags and branches?
> 
> Nope, only branches, try it. I also found it strange. And what is
> more, you can't use --all and --tags at the same time. Totally
> strange.

Yeah, you're right. Sorry for my confusion.

So in that sense, it is poorly named, and "--branches" (or "--heads")
would be more accurate. At the same time, it is probably more likely
what the user wants to do (you almost never want to push "refs/remotes",
for example). So I am a little hesitant to suggest changing it, even
with a warning and deprecation period.

> And yes, in this particular use-case that's what I am trying to avoid,
> but in other use-cases (like creating a new repo and pushing
> *everything*), a *true* --all would be nice.

Right. It looks like that is just spelled "--mirror" (which gives you
pruning also), or "refs/*:refs/*" (without pruning). The latter is even
more flexible, as you could do "refs/*:refs/foo/*" to keep several
related backups in one upstream repo.

Just to get back to the original patch for a second: are we in agreement
that what you want to do with "sync" is almost possible now (modulo a
separate --prune option), and that there is a separate issue of making
friendlier syntax for a few common refspecs?

> > We could add syntactic sugar to make
> > --branches mean "refs/heads/*". But I do worry that pseudo-options like
> > that just end up creating more confusion (I seem to recall there being a
> > lot of confusion about "--tags", which is more or less the same thing).
> 
> But it's not, that could explain part of the confusion. I think these
> would be totally intuitive.
> 
>  --branches
>  --tags
>  --other
>  --all
>  --update
>  --prune

My problem with them syntactically is that you have option-looking
things that are really not flags, but rather syntactic placeholders for
refspecs. So you have:

  git push --prune remote --branches

which looks wrong from the perspective of usual option-parsing rules.
And does:

  git push remote --prune --branches

work? Or:

  git push --prune --branches remote

?

I think we could make them all work if we want. But somehow the syntaxes
just look wrong to me. Using a non-dashed placeholder for special
refspecs makes more sense to me like:

  git push --prune remote BRANCHES

and then it really is just a special way of spelling "refs/heads/*". But
then, I also think it's good for users to understand that the options
are refspecs, and what that means. It's not a hard concept, and then
when they inevitably say "how can I do BRANCHES, except put the result
somewhere else in the remote namespace", it's a very natural extension
to learn about the right-hand side o the refspec.

Of course I also think BRANCHES looks ugly, and people should just learn
"refs/heads/*".

I dunno. Maybe my brain is fried from knowing too much about how git
works. I don't have much of an "ordinary user" perspective anymore.

> But what about 'git fetch'? You didn't comment anything. I think we
> should try to be consistent in these imaginary future options, maybe
> to devise a transition, or at least to identify good names for the new
> options.

Yeah, fetch makes it harder because the options may have subtly
different meanings. Using non-option placeholders would work around
that. You would still have options for pruning, which to me is not
really a refspec, but an option that acts on the refspecs.

>From the list in your previous email, you wrote:

> --prune -> rename to --prune-tracking?
> --prune-local (new; prune local branches that don't exist on the remote)

I think --prune wouldn't need renaming. If you fetch into tracking
branches, then pruning would prune tracking branches. If you fetch as a
mirror (refs/*:refs/*), then you would prune everything.

And "--prune-local" doesn't seem like a fetch operation to me. Either
you are mirroring, and --prune already handles it as above. Or you are
interested in getting rid of branches whose upstream has gone away. But
that's not a fetch operation; that's a branch operation.

-Peff
