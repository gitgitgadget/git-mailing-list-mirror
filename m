From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 09 Jul 2007 11:47:03 +0200
Message-ID: <20070709094703.GP1528MdfPADPa@greensroom.kotnet.org>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707090011070.4248@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 11:47:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ppr-0007JS-FH
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 11:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbXGIJrI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 05:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbXGIJrH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 05:47:07 -0400
Received: from psmtp03.wxs.nl ([195.121.247.12]:40484 "EHLO psmtp03.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbXGIJrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 05:47:06 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JKW00F30OIFZJ@psmtp03.wxs.nl> for git@vger.kernel.org; Mon,
 09 Jul 2007 11:47:04 +0200 (MEST)
Received: (qmail 10946 invoked by uid 500); Mon, 09 Jul 2007 09:47:03 +0000
In-reply-to: <Pine.LNX.4.64.0707090011070.4248@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51975>

Thanks for the review.

On Mon, Jul 09, 2007 at 12:56:04AM +0100, Johannes Schindelin wrote:
> - you use a lot of what was in cg-admin-rewritehist (including 
>   adjustments I made in the documentation for filter-branch), but you also 
>   make it more confusing for people used to that tool:
> 
> 	- instead of leaving the original branches as they are, you 
> 	  overwrite them. That's okay. But then you put the originals into 
> 	  refs/rewritten. Without cg-admin-rewritehist using that name 
> 	  for the _result_, you could explain your way out of confusion. 
> 	  As it is, you cannot.

I thought you had to specify the name of the new branch on the command
line.  Anyway, I don't really care about the name of this hierarchy.
I just picked a name that is somewhat related to "rewrite-commits".
Suggestions are welcome.  I could also just not create them.
The old values are also available in reflog.

> 	- in spite of doing the same as cg-admin-rewritehist with filters, 
> 	  you call them maps. But they are no maps. They are manipulators, 
> 	  you can call them mutators or filters, too. Given what people 
> 	  know of cg-admin-rewritehist, you really should keep the name 
> 	  "filter".

Nonesense.  They are not filters
(http://en.wikipedia.org/wiki/Filter_%28higher-order_function%29).
They are maps (http://en.wikipedia.org/wiki/Map_%28higher-order_function%29).
(In cg-admin-rewritehist some of them are (partial) filters,
but the ones I have are not filters).
I could extend the commit-map to remove the commit it the output is
empty, but it'd still be closer to a map than to a filter.
(You can map a commit to nothing, but a filter can't alter
the elements of a list, it only determines which elements are kept.)

> 	- the name "map" itself is used in cg-admin-rewritehist, to map 
> 	  commit names from old to new. By using that name differently, 
> 	  again you contribute to confusion, for no good reason.

There is a good reason to call what I call maps maps.  They _are_ maps.
Still, I'm open for suggestions.

> - get_one_line() is a misnomer. It wants to be named get_linelen().

Hmmm... I guess you missed Linus' mistake when he introduced it
in commit.c (e3bc7a3bc7b77f44d686003f5a9346a135529f73).
Do you want me to rename that one as well?

> - instead of spawning read-tree, you could use unpack_trees() to boost 
>   performance even more. But I guess it is probably left for later, to 
>   make it easier to review the patch.

Yeah, it looked a bit tricky for an initial implementation, especially
where I move the HEAD forward.

> - The example you give with "git update-index --remove" can fail, right? 

Yes.  Spectacularly, even.

> - The commit filter again deviates from the usage in cg-admin-rewritehist. 
>   I can see that you wanted to make it more versatile. However, it makes 
>   the tool potentially also a bit more cumbersome to use. Besides, you use 
>   a temporary file where there is no need to.

Are you saying I should use two pipes?
What if the commit message is larger than the pipe buffer?

> - the more fundamental problem with the missing "map", I do not see a 
>   reasonable way to get the same functionality from any of the code 
>   snippets passed to rewrite-commits. Indeed, even the workaround of 
>   cg-admin-rewritehist, to read $TEMP/map/$sha1, does not work, since you 
>   are keeping it all in memory. On IRC, gitster suggested to use a 
>   bidirectional pipe (such as stdin/stdout) to get at the new commit 
>   names, but because of buffering, I guess this is no joy.

I could add an option to write $TEMP/map/$sha1, but it's not clear
to me when such a map would be useful.  Please enlighten me.

> As commented on IRC, the env/tree/parent/msg filters of 
> cg-admin-rewritehist could be all emulated by commit filters. However, 
> that would be really inconvenient. So at a later stage, these would have 
> to be integrated into rewrite-commits (even if it would be possible to 
> drive rewrite-commits by a shell porcelain, but I guess you are opposed to 
> that idea, since you want to do everything else in C, too).

I'm not opposed to running a few commands and connecting stuff in shell.
(See git-submodule add, although I admit that I would have preferred to
do all of it in C.)

> However, the biggest and very real problem is that your filters do not 
> have a "map" function to get the rewritten sha1 for a given sha1. That is 
> what makes the filters so versatile, though, since you can skip revisions 
> by much more complex rules than just greps on the commit message or 
> header.

I thought your were opposed to the idea of skipping commits, since
you still carry along the changes in those commits.
Do you have a use case?

> But hey, maybe it _is_ time to rethink the whole filter business, and 
> introduce some kind of regular expression based action language. Something 
> like
> 
> 	git rewrite-commits -e '/^author Darl McBribe/skip-commit' \

What's wrong with --author='!Darl McBribe' ?

> 		-e 'substitute/^author Joahnnes/author Johannes/header' \
> 		-e 'substitute/poreclain/porcelain/body' \
> 		-e 'rewrite-commit-names'

Hmmm... some of these would basically need a builtin sed.
I was thinking about adding --remove and --rename, though.

skimo
