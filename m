From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] revision traversal: retire BOUNDARY_SHOW
Date: Tue, 6 Mar 2007 03:29:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703060322270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk5xvw6mg.fsf@assigned-by-dhcp.cox.net> <7vzm6rurst.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703060253140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pozuncr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 03:29:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOPQu-0000ye-2b
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 03:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965768AbXCFC3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 21:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965773AbXCFC3k
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 21:29:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:54604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965768AbXCFC3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 21:29:39 -0500
Received: (qmail invoked by alias); 06 Mar 2007 02:29:38 -0000
X-Provags-ID: V01U2FsdGVkX1+DBD8cmeaDlE1SsVpUgNno/tzscJGYZG1Yyq9lyA
	hQbrLNVXSB9uul
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v4pozuncr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41531>

Hi,

On Mon, 5 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Just marking the parents uninteresting unless they are prerequisites 
> > would be better, probably.
> >
> >>  
> >>  	i = req_nr;
> >>  	while (i && (commit = get_revision(&revs)))
> >> -		if (commit->object.flags & BOUNDARY_SHOW)
> >> +		if (commit->object.flags & PREREQ_MARK)
> >>  			i--;
> >
> > The above-mentioned idea, then would be: instead of just i--; do
> 
> I explicitly wanted to avoid that.  If the generated bundle had
> prereqs that are not independent of each other, doing that would
> hide some prereqs.

Yes. I wanted to say SHOWN instead of UNINTERESTING, but reading the 
source again, it seems that add_parents_to_list() is called in 
get_revision_1() even if the commit is marked SHOWN.

So forget about that idea of mine.

> > This should help performance, as not all reachable commits are traversed 
> > any more.
> 
> You prevented that with "while (i &&" part already, didn't you?

Well, yes. I also wanted to prevent going down all paths, though.

> > Wasn't --skip meant for something like gitweb, where you just want to 
> > skip the first <n> commits from the list, but do not want to change 
> > the list otherwise?
> 
> Yes, but does the patch change that?

I _think_ that yes, it could. If the timestamp of HEAD is older than of 
HEAD^, and you say "git log HEAD^ HEAD", then HEAD^ will be actually shown 
first, right? If you then say "--skip 1", HEAD will be shown first, and 
then HEAD^...

> >> @@ -1305,6 +1309,9 @@ struct commit *get_revision(struct rev_info *revs)
> >>  	case -1:
> >>  		break;
> >>  	case 0:
> >> +		/* Although we grabbed it, it is not shown. */
> >> +		if (c)
> >> +			c->object.flags &= ~SHOWN;
> >>  		c = NULL;
> >
> > Is this really relevant in practice?
> 
> Absolutely.  But I have further updates on this series.

Sorry for interrupting your patch spree :-)

Ciao,
Dscho
