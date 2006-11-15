X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 10:41:34 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611151023160.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org>
 <7virhhy76h.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142048350.2591@xanadu.home>
 <200611150917.23756.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 15:42:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200611150917.23756.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31447>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkMtY-0001kd-Lw for gcvg-git@gmane.org; Wed, 15 Nov
 2006 16:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030595AbWKOPlp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 10:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030597AbWKOPlp
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 10:41:45 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40183 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030595AbWKOPlo
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 10:41:44 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8S00DDP3LA4990@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Wed,
 15 Nov 2006 10:41:35 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006, Andy Parkins wrote:

> On Wednesday 2006 November 15 04:32, Nicolas Pitre wrote:
> 
> > OK..... let's pretend this is my follow-up to your "If I were redoing
> 
> Personally, I agree with almost everything in this email.  Except the 
> implementation of point 3.
> 
> > 3) remote branch handling should become more straight forward.
> 
> I was completely confused by this origin/master/clone stuff when I started 
> with git.  In hindsight, now I understand git a bit more, this is what I 
> would have liked:
> 
>  * Don't use the name "origin" twice.  In fact, don't use it at all.  In a 
> distributed system there is no such thing as a true origin.

I agree, sort of.  Not because"origin" is ambigous as a name.  But 
rather because there is a magic translation from "master" to "origin", 
and I think this is wrong to do that.

As mentioned elsewhere (and let's start using "get" instead of "pull" as 
suggested by Johannes), a "get" should probably always create a branch 
group even if it contains only one branch.  This way the remote branch 
called "master" will still be called "master" locally, under the branch 
group used to represent the remote repository.  And if a local name is 
not provided then let's just call it "default".  This way, amongst the 
remote references, there would be a "default/master" that would be used 
when nothing else is provided by the user. So...

	git get repo.com/time_machine.git

would create a local branch named "remotes/default/master" if the remote 
repo has only a master branch.

Then, a simple:

	git merge

could be the same as

	git merge default

which would be equivalent to

	git merge default/master

Afterwards, because the "default" remote already exists, then:

	git get

would be the same as

	git get default

to get changes for all branches in the "default" remote branches, of 
which "master" might be the only one in the simple case.

But again I think it is important that the URL to use must be a per 
branch attribute i.e. attached to "default/master" and not just 
"default".  This way someone could add all branches of interest into the 
"default" group even if they're from different repositories, and a 
simple  get without any argument would get them all.


