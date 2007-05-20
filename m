From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Sun, 20 May 2007 21:59:30 +0200
Message-ID: <20070520195930.GX942MdfPADPa@greensroom.kotnet.org>
References: <11796842882917-git-send-email-skimo@liacs.nl>
 <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 21:59:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HprZ5-0008JQ-07
	for gcvg-git@gmane.org; Sun, 20 May 2007 21:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbXETT7d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 15:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755781AbXETT7d
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 15:59:33 -0400
Received: from smtp18.wxs.nl ([195.121.247.9]:55227 "EHLO smtp18.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755799AbXETT7c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 15:59:32 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIC00EZNVJ7CZ@smtp18.wxs.nl> for git@vger.kernel.org; Sun,
 20 May 2007 21:59:31 +0200 (CEST)
Received: (qmail 26312 invoked by uid 500); Sun, 20 May 2007 19:59:31 +0000
In-reply-to: <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47897>

On Sun, May 20, 2007 at 12:10:04PM -0700, Junio C Hamano wrote:
> > bash-3.00$ ./git-config --remote=http://www.liacs.nl/~sverdool/isa.git --get-regexp 'submodule\..*\.url' 
> > submodule.cloog.url /home/sverdool/public_html/cloog.git
> > submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git
> 
> You are priming the process by having these configuration
> variables in the superproject to be cloned (i.e. this is done by
> the owner of the superproject).

Is that a question?
The answer would be that if the user didn't put this information
in a config file, then git will try to get the information from
any remote it can get its hands on.

> What's the design like to make clone and checkout work together?
> When you run the first clone with -n ("do not checkout"), what
> should happen (I am not asking what your code does, but what the
> desired behaviour should be)?  My take on that question is
> "subproject cloning is done by checkout, not clone".

Then I guess you are not asking me.
I took the suggestion of doing the subproject cloning during checkout
from you.

> I am very worried about this big red switch that says "all
> subprojects to be cloned and checked out, or nothing".  I think
> this would not work well with projects that truly need
> superproject support (i.e. very large ones, where most people
> would not want to clone and check out every single subproject).

It's pretty easy to add a "submodule.*.skip" or "submodule.*.ignore".
Since the subcloning only happens at checkout, you could set these
before doing a checkout.

> > I currently do not fetch after the initial clone, since
> > I'm not sure what ref to use for the revision I need to
> > fetch for the supermodule.
> 
> I think fetching inside the subproject can be safely done with
> the default (i.e. refs/heads/*:refs/remotes/origin/*) of 1.5.0
> or later, as long as we tell the users of the feature that they
> should make sure that the commit referenced by superproject tree
> entries are available with such a fetch, which is a sane thing
> to require anyway.

Seems like a pretty strict requirement, but it's easy to implement,
so I guess I can do that in the fourth version.

> The more important issue I think is at what point in the
> superproject operation does a recursive checkout in a subproject
> should happen, and how we should do the checkout.  Issues I can
> think of offhand are (no way exhaustive):
> 
>  - Do we checkout a branch? if so which one?
> 
>  - Do we detach HEAD if the commit named by the superproject
>    tree is not at the tip of the current branch of subproject?
>    do we detach always even if the commit is at the tip?

I thought there was a consensus to detach the HEAD.
I don't have a strong opinion on this issue, but a detached
HEAD seems the most appropriate to me.

>  - What would we do when the subproject working tree is not
>    clean?

I was planning on adding a --dry-run to git-checkout.
The superproject would run this in each subproject before
doing the actual checkout of the superproject.

>  - How can a user decide which subproject to descend into and
>    which subproject to ignore, and how does git remember the
>    earlier decision made by the user without asking the same
>    again, and how does a user express "now I want to also track
>    that subproject I've ignored so far" and "now I am not
>    interested in following that subproject anymore"?

Just twiddle the "submodule.*.skip" option.

> So I tend to disagree with not having the indirection we
> discussed on the other thread about .gitmodules, but I consider
> it a minor detail of cloning, and it is not a major deal to me.

Some form of indirection is definitely required (although
not for my use of submodules) and I'll probably add it in a future round.

skimo
