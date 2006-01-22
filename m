From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What is in git.git
Date: Sun, 22 Jan 2006 12:53:51 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601221106330.25300@iabervon.org>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net> <200601211636.02340.lan@ac-sw.com>
 <7vek31mkyg.fsf@assigned-by-dhcp.cox.net> <200601220033.26321.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 18:52:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0jNc-0002lo-O7
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 18:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWAVRvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 12:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWAVRvv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 12:51:51 -0500
Received: from iabervon.org ([66.92.72.58]:59148 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751297AbWAVRvu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2006 12:51:50 -0500
Received: (qmail 4394 invoked by uid 1000); 22 Jan 2006 12:53:51 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jan 2006 12:53:51 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200601220033.26321.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15055>

On Sun, 22 Jan 2006, Josef Weidendorfer wrote:

> On Saturday 21 January 2006 20:37, you wrote:
> > Alexander Litvinov <lan@ac-sw.com> writes:
> > >> 1. Can I bind some branch instead of tag (commit) ?
> > ... 
> > If you mean by "binding a branch", to record how each subproject
> > relates to the toplevel project (i.e. "the subproject bound to
> > X/ subdirectory of the toplevel project comes from branch Y"),
> > that information needs to be somewhere, but recording it in the
> > commit object goes against the whole git philosophy.
> 
> The original gitlink proposal did exactly this: it recorded
> the place where a subproject is bound by putting a gitlink into
> a tree. This way, the binding point can be changed, and is subject to
> versioning itself.
> 
> I just realized that this is not currently possible with the bind lines.
> What about the following usage szenario:
> - in a superproject, I use a subproject X implementing some lib by 
>   binding it at X/. My Makefile recurses into X/ for this.
>   This is recorded at commit point (A)
> - later on, I realize I need another lib from a probject Y; I want
>   to put the libs X and Y into subdirectory lib/ of my superproject;
>   i.e. I bind Y at lib/Y/ and move the binding point of X to lib/X/.
>   The Makefile is changed accordingly to build the subprojects.
>   This is recorded at commit point (B)
> 
> A $GITDIR/bind alone will no work, as moving back to (A) would keep
> the binding point of subproject, and make is broken.

I think you're misunderstanding the use of the "bind" file or equivalent. 
It isn't a configuration file that specifies where the subprojects go; 
it's a state file that tracks where the subprojects currently are. The 
commits by themselves are sufficient to indentify the locations of the 
subprojects, and the bind file would be written by "git checkout" reading 
a commit with subprojects. It's used to create the next commit, in much 
the same way that MERGE_HEAD is used to create the next commit by storing 
information between the git call that starts a merge that needs user 
interaction and the git call to commit the merge.

So moving back to (A) wouldn't keep the binding point of subproject, 
because it would rewrite bind to what it had been.

I'm going to suggest again keeping this information in the index file (but 
not in the index data structure, so the changes to the code are only in 
the library routines to read and write the file, and, of course, anything 
that's actually trying to manipulate the binding locations). I started 
working on a patch to pu to skip S_IFDIR entries from the index file when 
building the table in memory, and that was straightforward, but I got into 
sysadmin issues when I was going to test giving it something to skip.

	-Daniel
*This .sig left intentionally blank*
