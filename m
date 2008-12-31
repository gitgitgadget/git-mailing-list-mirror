From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-) [Scanned]
Date: Wed, 31 Dec 2008 00:21:42 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812302356040.19665@iabervon.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D36@ALTMORE-SVR.altmore.local> <200812302141.02248.bss@iguanasuicide.net> <7v7i5hymp7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Conor Rafferty <conor.rafferty@altmore.co.uk>,
	Jeff Whiteside <jeff.m.whiteside@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 06:25:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHta8-0003il-UN
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 06:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbYLaFVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 00:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbYLaFVo
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 00:21:44 -0500
Received: from iabervon.org ([66.92.72.58]:47274 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbYLaFVo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 00:21:44 -0500
Received: (qmail 28538 invoked by uid 1000); 31 Dec 2008 05:21:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Dec 2008 05:21:42 -0000
In-Reply-To: <7v7i5hymp7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104250>

On Tue, 30 Dec 2008, Junio C Hamano wrote:

> "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
> 
> > On Tuesday 2008 December 30 20:30:46 Conor Rafferty wrote:
> >> MERCURIAL:
> >>
> >> Update
> >> hg update [-C] [-d DATE] [[-r] REV]
> >
> > Which is the role of "git checkout <branch>"
> >
> > "git checkout <branch> <paths>" is similar to "hg revert -r <branch> <paths>", 
> 
> No it is not.
> 
> The form of the command is makes this request:
> 
>     Please look into that named <tree-ish>, and check out the named
>     <paths> out of it to my work tree.  Because the reason I want them in
>     my work tree is so that I can include them as part of the next commit
>     I am preparing to create in the index, please update these paths in my
>     index while at it.

With that description, there's a bug: in addition to the above, it checks 
out from the index any path which does match the <paths> but isn't in 
<tree-ish>. I think the way to fix that would be to update the work tree 
from read_tree_some() instead of using the "if pathspec_match() ... 
checkout_entry()" loop over the index.

With the current code, you can have git check out a file that you've 
changed/deleted from a tree that doesn't contain it at all (and you get 
the index version). E.g.:

$ rm wt-status.c
$ git checkout e83c5163316f89bfbde7d9ab23ca2e25604af290 wt-status.c
$ ls wt-status.c
wt-status.c

(instead, you should get an error if a <path> doesn't match anything in 
the <tree-ish> and only get those things that it matches in the 
<tree-ish>.)

I think I was too zealous sharing code back in February. I should have a 
patch by the weekend if nobody beats me to it. (And I still think that, if 
you hit this case, you must be confused, but git isn't helping by doing 
what it does.)

	-Daniel
*This .sig left intentionally blank*
