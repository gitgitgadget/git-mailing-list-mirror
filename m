From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Mon, 21 Nov 2011 16:44:50 -0500
Message-ID: <20111121214450.GA20338@sigill.intra.peff.net>
References: <20111107183938.GA5155@sigill.intra.peff.net>
 <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
 <20111107210134.GA7380@sigill.intra.peff.net>
 <CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
 <20111108181442.GA17317@sigill.intra.peff.net>
 <CAMP44s2RjcFtdO2jft0Hg9RtqK-DRK47gX8By-dBFSBcSA+yFA@mail.gmail.com>
 <20111111181352.GA16055@sigill.intra.peff.net>
 <CAMP44s06p+KyJAu4ddiCa8CFRq5eogbqxxJU16Z-SUb3GSp67Q@mail.gmail.com>
 <20111114122556.GB19746@sigill.intra.peff.net>
 <CAMP44s1G9jJyiis7z7XbPvW925E-u=0_-h9jJKkj2wyPS9o5ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 22:45:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSbfg-00014R-3Z
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 22:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab1KUVox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 16:44:53 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48824
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405Ab1KUVox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 16:44:53 -0500
Received: (qmail 23562 invoked by uid 107); 21 Nov 2011 21:45:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Nov 2011 16:45:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Nov 2011 16:44:50 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s1G9jJyiis7z7XbPvW925E-u=0_-h9jJKkj2wyPS9o5ig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185762>

On Mon, Nov 14, 2011 at 03:57:07PM +0200, Felipe Contreras wrote:

> >> I'm not going to investigate the subtleties of these different setups,
> >> I'm going to put my common user hat and ask; how do I fetch as a
> >> mirror?
> >
> > The problem with that question is that you haven't defined mirror. Does
> > that mean you just want pruning, or does it mean that you want your
> > local ref namespace to match that of the remote?
> 
> Exactly, no mirror has been defined, because I don't want a mirror. A
> mirror is supposed to have all the refs in sync all the time; that's
> not what I want.

I didn't mean "you didn't define a mirror in your config". I meant "your
question is not well-defined, because you haven't defined the term
'mirror'". IOW, I can't answer your question without knowing exactly
what you meant.

> > BTW, right now there is "git remote add --mirror ...", which sets up the
> > fetch refspec for you (in this case, mirror is "make your refs look like
> > the remote's"). Perhaps rather than adding syntactic sugar to fetch, it
> > would be best to channel users into configuring a remote that selects
> > from one of a few common setups (including different types of mirrors).
> 
> But that assumes that they would want the same refspec operation *all
> the time* which is not the case (at least for me). Sometimes I want to
> update only existing branches, sometimes I want to fetch new branches
> too, sometimes I want to prune local branches, sometimes not.

OK, then that means it must be a fetch command-line thing, not a
configured thing. Though note that even leaving prune out, I don't think
git does what you want (e.g., how are you fetching only to update
existing branches?).

> > No, you would just do "--prune", because your refspecs are _already_
> > indicating that you are writing into the local namespace, and anything
> > you have locally would be deleted by the prune operation. I.e., there is
> > no need for --prune-local in this scenario; --prune already does what we
> > want.
> 
> That's very risky. The user might forget that this is a mirror repo,
> and delete the local branches unintentionally. Plus, it would be then
> impossible to prune remote tracking branches.

Sorry, but I don't see how "--prune" is supposed to know what to prune
except through the refspecs that have been provided to it (either in
configuration or on the command line). So what is:

  git fetch --prune <remote> refs/*:refs/*

_supposed_ to do, if not prune your local namespace?

I don't buy the "it's too risky" argument. You have configured a remote
that will fetch and overwrite your local branches already, if you ever
run "git fetch foo". But somehow running "git fetch --prune foo" is too
risky, because you might forget that it will delete all of your
branches?

> > As a user, how do I resolve the situation? I might say topic-Y is
> > obsolete and get rid of it. I might rebase it onto another branch. Or I
> > might declare it to have no upstream. But all of those are branch
> > operations, not fetch operations.
> 
> Yes, but that has nothing to do with the operation I want to achieve:
> git remote sync. By which I mean synchronize the local branches with
> the branches of a certain remote.

Right. I was only trying to explain a case where you would want to prune
in the local namespace, when fetch is not configured to touch the local
namespace. Which is the only use case I could think of for something
named --prune-local. But let's forget it. My point was that it is not
related to fetch, and I was just guessing at what you might want from
--prune-local.

> > So what I was trying to say was that either your fetch refspecs tell
> > fetch to write into your local branch namespace, or not. If they do,
> > then --prune is sufficient (with no -local variant required). If not,
> > then touching your local branch namespace is outside the scope of fetch.
> 
> I don't want this to be a *permanent* configuration. I see this
> similar to --force. You can achieve the same by adding a + at the
> beginning of the refspec, but this is something that should be
> activated on a per-command basis, thus the option. I think this should
> be the same.

Then you can tweak what is pruned on a per-command basis by providing
alternate refspecs. Right now that would probably mean:

  git fetch --prune <remote> refs/*:refs/*

or

  git fetch --prune <remote> refs/heads/*:refs/remotes/<remote>/*

but as we discussed earlier in the thread, those can be made less scary
with syntactic sugar.

-Peff
