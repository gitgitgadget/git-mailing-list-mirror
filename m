From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Mon, 12 Mar 2012 14:37:25 -0400
Message-ID: <20120312183725.GA2187@sigill.intra.peff.net>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com>
 <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com>
 <vpqzkblixmb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:37:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7A7i-0005yw-As
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 19:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267Ab2CLSh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 14:37:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47875
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487Ab2CLSh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 14:37:28 -0400
Received: (qmail 20454 invoked by uid 107); 12 Mar 2012 18:37:38 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Mar 2012 14:37:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2012 14:37:25 -0400
Content-Disposition: inline
In-Reply-To: <vpqzkblixmb.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192919>

On Mon, Mar 12, 2012 at 05:37:32PM +0100, Matthieu Moy wrote:

> I do find it reasonable, but I think 'upstream' has several advantages
> over it.
> 
> * 'upstream' makes "git push" and "git pull" symmetrical. While there
>   are workflows where it is usefull to have "push" and "pull" point to
>   different branches, I think it is far more intuitive to have this
>   symmetry by default.

This is one of the things I really hate about 'upstream'. If you share a
central repo with other people, it makes sense. You push and pull from
the same place. But in the classic kernel-style workflow, you'd pull
from an upstream, and then publish your work elsewhere. And I think it's
not just kernel people who use this asymmetric workflow. On something
like GitHub, you get your own fork repo on the site as a publishing
point. But you also want to keep pulling and basing your work on what
the main project is doing. You can't just pull from your fork, since it
never gets updates from the main project; you pull them into your local
repo, and then push them up to your fork.

So in a very reasonable common newbie workflow, "upstream" will not at
all do what you want, because it will go to the wrong repo[1]

That being said, "current" will _also_ go to the wrong repo, because
push fundamentally respects "branch.*.remote".  Which is definitely not
what you want in the asymmetric case. This is not a push.default issue,
but I think it is somewhat related, and maybe worth discussing along
with the topic of asymmetry. Am I the only one who finds this behavior
annoying? I've mostly trained my fingers to type "git push
<my-publish-repo>", but I do occasionally forget. Do other people with
asymmetric workflows find this annoying? Do they not care? Or are many
fewer people doing asymmetric things than I think?

While I'm ranting, there's another weirdness I noticed. If I have
push.default set to upstream, and config like this:

  [branch "foo"]
     remote = origin
     merge = refs/heads/master

then typing "git push" will go to foo's master branch. But if I type
"git push other-remote", then it will go to other-remote's master
branch. Which makes no sense to me. The upstream is foo's master, and
now we are making guesses about how the names on each side are the same.
Is this an intentional behavior?

[1] One saving grace of going to the wrong repo is that you usually
    don't have permissions to push to that repo, so you get a harmless
    error message.

> * For newbies, the sequence "create an empty repository, clone it,
>   commit and push" works like a charm with either 'upstream' or
>   'current'. Today, the first push to an empty repository requires
>   either saying "git push origin master" or "git push --all", both of
>   which sound like black magic to the poor user who did not yet learn
>   what 'origin' is and what a branch is.

Ending that confusion is one of the best reasons to switch the default,
IMHO, but I don't think it argues for "current" versus "upstream", as
they both fix it (but Michael's matching-current hybrid would not, so I
agree it is less appealing).

> * 'upstream' makes it easy to create a local topic branch, and let
>   'push' send it to the master branch (i.e. have local 'topic-branch'
>   pull and push to 'origin/master'). In general, 'upstream' allows
>   workflows where you push to branches with either a different name or
>   with the same name (by setting the upstream appropriately), but the
>   opposite is not true.

Actually, this is the thing that scares me the most about "upstream" as
a default, because in this case, you are implicitly performing the
equivalent of a fast-forward merge. So that's handy if you are a new
user who wants to publish your work back to the master branch. But that
has two problems:

  1. If you are a new user who does like the implicit merge, you may
     find it convenient not to have to learn about "git checkout; git
     merge topic ; git push remote master". But it only helps you
     _sometimes_. If master has had other work built on it, your push
     will fail, and you will have to do the merge yourself. So it is
     only helping you by omitting a step some of the time, and you still
     have to learn why the step is sometimes necessary and sometimes
     not.

     Yes, experienced users do not have this learning problem. But
     remember we are talking about a default targeted at new users, and
     trying to reduce their confusion.  People who know and like what
     "upstream" does can configure it themselves.

  2. If you are a new user who _doesn't_ want to do the merge, but
     instead wants to publish your work-in-progress topic, then the
     implicit merge-back-to-master behavior is wrong and dangerous.
     You are publishing work that probably violates the general rules
     for what goes on master.

     Or perhaps somebody else has built on top of master, and your push
     fails. If you're an astute reader, you will see that the failing
     push tried to go to master. But if you're not, you may retry with
     "-f", which is quite dangerous, as now you are not just
     accidentally publishing a work-in-progress, but you are
     overwriting somebody else's work. Obviously this is a problem
     anytime you use "-f", but the fact that your "foo" branch is going
     to somewhere besides the remote's "foo" branch makes me think it is
     much more likely a clueless user will get confused and overwrite
     something on the more "mainstream" branch.

So far a lot of the discussion has focused on "what is the most sensible
default for the most number of people". But I wonder if a better
question is "what is the default that is the least likely to do
something dangerous and embarrassing". People who use git enough to say
"wow, I don't like this default for my workflow" are probably at the
point that they can configure push.default themselves.

-Peff
