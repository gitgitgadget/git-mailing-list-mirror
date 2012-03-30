From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Fri, 30 Mar 2012 17:01:12 -0400
Message-ID: <20120330210112.GA20734@sigill.intra.peff.net>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 23:01:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDiwh-0002rl-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 23:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761078Ab2C3VBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 17:01:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41406
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760597Ab2C3VBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 17:01:14 -0400
Received: (qmail 20492 invoked by uid 107); 30 Mar 2012 21:01:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 17:01:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 17:01:12 -0400
Content-Disposition: inline
In-Reply-To: <7vty15ltuo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194409>

On Fri, Mar 30, 2012 at 01:25:03PM -0700, Junio C Hamano wrote:

> And this "only the doneness of the current branch matter" is fundamentally
> different from "push everything in one go", and I am already happy to see
> that future Git is moving in this direction, which also matches the way
> vast majority of people seem to work.  So in that sense, I do not care
> which one we picked between "current" and "upstream".  Obviously the
> former is much simpler to explain and understand, as people do not have to
> learn upstream tracking before doing their first "push".

Right. I also think either is a huge improvement for new users over
"matching". But since we are going through the pain of changing the
default, I think it's worth nit-picking between the options to come up
with the best default.

> > I think we can deal with my first issue (some workflows will cause "git
> > push" to error out without doing anything) with targeted advice for each
> > situation.
> 
> Yes.  I think that is up to the people who favored "upstream" over
> "current" to share their anecdotes to polish such advice messages.

I guess part of me is just cynical. We are announcing "the default will
change to upstream" under the assumption that upstream will get polished
to everyone's liking. But until that polishing is actually done, I am
pessimistic. :)

> > my two concerns is that this:
> >
> >   $ git clone ...
> >   $ git checkout -b topic origin/master
> >   $ hack hack hack
> >   $ git push
> >
> > will try to implicitly fast-forward merge your commits onto master.
> 
> And the reason why it is surprising to the beginners is?  Because "topic"
> and "master" (of "origin/master") are not the same name?

Sort of. It is more because "upstream" is an overloaded concept. Perhaps
you created the branch from origin/master because you wanted to say
"this is where my topic is based, and when I 'rebase -i' later, I want
it to be considered the baseline". Or perhaps you meant to say "I am
going to work on origin's master branch, but I would prefer to call it
'topic' here".

In the latter case, pushing back to origin/master makes sense. They are
forks of the same branch to you, and pushing back is how
you will share your changes to master. But in the former case, you may
or may not consider them the same branch, and you may be pushing simply
to share your work-in-progress of the topic. Putting that work onto
"master" would be confusing in that case.

Note that "current" has the same assumption in reverse. If you create a
local "master" branch (whether or not it is based on a remote
"origin/master"), you may or may not mean them to be the same branch.

So we have to decide when two things are forks of "the same branch", and
when it is merely "X is based on Y", or "X happens to have the same name
as Y". And I think the "name is the same" semantics are way more
obvious.

Do you recall discussions a few years back about git's branching model
versus that of mercurial and other systems? One of the confusing things
for people new to git was the idea that git fundamentally doesn't care
about "what is a branch". They got confused that "master" in the local
repository really had no connection to "master" on the remote repository
(whereas in hg, I think there is some magic in the DAG that connects
them). But that leads me to think that people really do consider "same
name is the same branch", which means "current" is going to be a lot
less likely to confuse people (for that matter, look at the current
matching semantics, which use name mapping; people get confused that we
are pushing all matching branches, but I don't remember anyone ever
complaining that they expect "foo" to go to "bar").

> I tend to think that this is on the "understandable" side of the line
> (after all, I said "Let's start a topic to be merged to origin/master"
> when I started the topic, and I've been rebasing the topic up to date from
> time to time), but obviously you don't think so.

Is that what you said? Or did you say "I am starting a new topic that
will be based on origin/master?" I feel like the concept of "upstream"
is very loosely specified, and can mean many things. And even if you do
eventually expect it to be merged into master, it does not mean you
expect it to do so by default during "git push". You might also simply
want to push the current state of your topic.

> And I think your aversion to the "implicit fast-forward" will lead you to
> teach beginners to do this instead:
> 
>    $ git clone ...
>    $ git checkout -b topic origin/master
>    $ hack hack hack
>    $ git checkout master
>    $ git merge topic
>    $ eyeball, test, think
>    $ git push
> 
> which arguably is a more disciplined way, but I do not know if we can
> expect that people can be trained to be _that_ well disciplined.

Sure, I think that is a better workflow. But I don't expect everyone to
follow it, and I don't think "upstream" is wrong to behave the other
way. You could also teach them what "upstream" means, and have them set
push.default to it.

Ultimately, it is not about whether one workflow is better than the
other. It is about having a default that stops the user and says "hey, I
don't know what workflow you're using. So you need to tell me before I
can continue."

-Peff
