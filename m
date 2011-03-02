From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git blame-tree
Date: Wed, 2 Mar 2011 13:07:23 -0500
Message-ID: <20110302180722.GA20287@sigill.intra.peff.net>
References: <20110302164031.GA18233@sigill.intra.peff.net>
 <20110302171653.GA18957@sigill.intra.peff.net>
 <AANLkTim4fKO=Lb0dY0DzRu1QqC8NHPoF8iveYQ2E6OBH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 19:07:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuqSS-0003D5-5C
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 19:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528Ab1CBSH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 13:07:26 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57874 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756338Ab1CBSHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 13:07:25 -0500
Received: (qmail 19311 invoked by uid 111); 2 Mar 2011 18:07:24 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 18:07:24 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 13:07:23 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim4fKO=Lb0dY0DzRu1QqC8NHPoF8iveYQ2E6OBH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168330>

On Wed, Mar 02, 2011 at 06:51:57PM +0100, Piotr Krukowiecki wrote:

> On Wed, Mar 2, 2011 at 6:16 PM, Jeff King <peff@peff.net> wrote:
> > I considered making it a special mode of "git blame" when blame is fed a
> > directory instead of a file. But the implementations aren't shared at
> > all (nor do I think they need to be; blame-tree is _way_ simpler). And I
> 
> git blame dir/file.c
>   "Show what revision and author last modified each line of a file"
> 
> git blame dir/
>   "Show what revision and author last modified each file"

Right, I think we are agreeing.

> This makes sense to me (the user).  I don't understand the
> implementation thing. I don't see a difference between those two
> commands. Even more, if I'm educated  Unix user I might know
> directories are also files.

I mean the implementations are very different, so there was not much
point in putting the code into builtin/blame.c.

> > didn't want to steal that concept in case somebody can think of a more
> > content-level way of blaming a whole tree that makes sense (obviously
> > just showing the concatenation of the blames of each file is one way,
> > but I don't know how useful that would be). If we want to go that way,
> > we can always catch the special case in blame and just exec blame-tree.
> 
> Still can be in git-blame command, no?

Right. What I meant was that we don't have to make the decision now. If
people like blame-tree, we can later magically turn:

  git blame dir

into "git blame-tree dir". So I think we are just agreeing.

> > The initial set of interesting files we come up with is gotten by
> > looking at the tree of the first pending object after parsing the rev
> > options (defaulting to HEAD). Which sounds a little flaky to me, but
> > does what you want in practice. I'd be curious if somebody can come up
> > with a counterexample where the ability to manually specify the source
> > tree would be more useful.
> 
> Same argument as for normal blame: I want to know who modified files at
> the state of commit X (if I understand the question correctly).

Yeah, that's what it does now. Specifically I was wondering about more
elaborate examples, like:

  git blame-tree dir branch1 branch2

It will traverse using both branch1 and branch2, but get the initial
list of files from branch1. I guess we could also union those trees or
something. But I expect most calls to be:

  git blame-tree dir commit

and that's it.

-Peff
