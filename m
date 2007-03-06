From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] revision traversal: retire BOUNDARY_SHOW
Date: Tue, 6 Mar 2007 16:52:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703061643490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk5xvw6mg.fsf@assigned-by-dhcp.cox.net> <7vzm6rurst.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703060253140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pozuncr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703060322270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd53mppvb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 16:52:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HObxq-0000Th-T7
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 16:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbXCFPwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 10:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbXCFPwY
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 10:52:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:33568 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965202AbXCFPwX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 10:52:23 -0500
Received: (qmail invoked by alias); 06 Mar 2007 15:52:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 06 Mar 2007 16:52:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JhHUXWJ9JfNZg5cmUYFyXAI8Njutsn3efDsmrtE
	ZXTL+l2mHRLqCW
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vd53mppvb.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41587>

Hi,

On Tue, 6 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > This should help performance, as not all reachable commits are 
> >> > traversed any more.
> >> 
> >> You prevented that with "while (i &&" part already, didn't you?
> >
> > Well, yes. I also wanted to prevent going down all paths, though.
> 
> If we wanted to bundle "-8 A B", I think we would make 'x' and
> 'y' prereqs, as they are the direct parents commits that are
> shown, and that themselves are not shown.
> 
>          .---*---*---*---*---* A
>         /
>     ---x---y---*---*---* B
> 
> If we say upon hitting prereq (x and y) we stop traversal by
> marking the parent UNINTERESTING, I suspected that we may not
> find out 'x' with get_revision() loop, and that was why I chose
> not to.  Instead the loop stops by finding y and then x (and by
> saying "ok I needed to find two and now I have two".

Yes, that is correct. What I wanted to optimize for was this:

x--*--*--A

y--*--B

There is no need to traverse the parents of y to find x. I wanted for the 
traversal to just stop on paths where a prereq was found.

But setting the parents to UNINTERESTING or SHOWN was wrong, because that 
would not stop the traversal: see get_revision_1(). In case revs->limited 
is 0, and the cutoff date is not yet reached, the parents are added 
always. Even if the current commit is UNINTERESTING or SHOWN. (Which is 
correct, of course.)

BTW this behaviour with revs->limited = 1 made me set revs->limited in 
case of revs->reverse in the first place...

Ciao,
Dscho
