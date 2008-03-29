From: Sam Vilain <sam@vilain.net>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Sun, 30 Mar 2008 12:22:07 +1300
Message-ID: <47EECF1F.60908@vilain.net>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 30 00:20:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfkLQ-0001AQ-Rq
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 00:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbYC2XT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 19:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbYC2XT1
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 19:19:27 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:35277 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbYC2XTV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 19:19:21 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id D6B6121C96F; Sun, 30 Mar 2008 12:19:11 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 0AAC021C967;
	Sun, 30 Mar 2008 12:19:06 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78490>

Avery Pennarun wrote:
> It would probably be possible to fix each of these problems
> individually, but it would be a whole series of different fixes.  I'd
> like to propose a rather different way of doing things that I think
> would solve most of these problems, and get some feedback:
> 
> What if *all* the objects for A, B, and C were always in the *same*
> repository?  Almost all the problems would go away.  Imagine if it
> worked like this:

Well, that would create a lot of unnecessary work when cloning.
Partitioning by project is a natural way to divide the projects up.
It's worth noting that the early implementations of submodules were
based on this design, of keeping everything together.

However, what you are suggesting should IMHO be allowed to work.  In
particular, if the submodule path is ".", then I think there's a good
case that they should come from within the same project.  If it's a
relative URL, it should initialize based on the remote URL that was used
for the original fetch (or, rather, the remote URL for the current branch).

And, if it happens that after a checkout, that the commit of a submodule
is already in the object directory (ie, there's another branch), then
maybe that should automatically check out.

> 1. git-clone had a way to *not* clone every single object from every
> branch in the parent repository; only the ones you were interested in.

It could easily, if someone would allow clone to have a --track option
like git remote does:

  git init
  git remote add -t branch -f URL

> 2. You still check into C, then B, then A, but it doesn't actually
> matter if you put B and C on a branch first or not, because 'git push'
> will work properly, because it auto-pushes B and C revisions based on
> the fact that A refers to them (ie. implicit branches via the
> submodule mechanism).

This push failure thing is regrettable; however it's not clear which
branch name the submodules should get.  A given commit might exist on
several branches, which one do you choose to name it?

> 4. You can 'git clone' a local copy of A, and B/C will be cloned
> automatically along with it.
> 6. git-pull should be modified to auto-download objects referred to by
> 'submodule' references in trees.

I think this could be a switch to git clone/pull, configurable to be the
default action.

> 5. B and C, when git-submodule checks them out, should have their own
> .git directories, but use A as an 'alternatives' entry.

There is also a Google Summer of Code project for this - see
http://git.or.cz/gitwiki/SoC2008Ideas#head-9215572f23513542a23d3555aa72775bc4b91038

> This would really help my workflow a lot.  Am I missing something?

Well, no, it's true that the current workflow has interface niggles;
however it's important to understand why the current implementation is
the way it is, and make sure that new designs build on top of the parts
which are already designed well, where they can.

Sam
