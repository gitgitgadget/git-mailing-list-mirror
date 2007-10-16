From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 03:03:52 -0400
Message-ID: <E1IhgT2-0000bg-O6@fencepost.gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org> <Pine.LNX.4.64.0710160032020.7638@iabervon.org>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: raa.lkml@gmail.com, Johannes.Schindelin@gmx.de, ae@op5.se,
	tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhgTI-0000KB-4b
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbXJPHDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 03:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbXJPHDz
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:03:55 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:41556 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbXJPHDy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 03:03:54 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1IhgT2-0000bg-O6; Tue, 16 Oct 2007 03:03:52 -0400
In-reply-to: <Pine.LNX.4.64.0710160032020.7638@iabervon.org> (message from
	Daniel Barkalow on Tue, 16 Oct 2007 01:56:46 -0400 (EDT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61096>

> Date: Tue, 16 Oct 2007 01:56:46 -0400 (EDT)
> From: Daniel Barkalow <barkalow@iabervon.org>
> cc: raa.lkml@gmail.com, Johannes.Schindelin@gmx.de, ae@op5.se, 
>     tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
> 
> Ah, that's helpful. We don't actually care too much about the particular 
> info in stat; we just want to know quickly if the file has changed, so we 
> can hash only the ones that have been touched and get the actual content 
> changes.

As I wrote in my other message, using native APIs improves performance
by at least a factor of two.

> The tricky thing is that, while the optimization 
> process is running, other programs may be reading the database, so (1) the 
> files that are no longer needed, because better-optimized versions are in 
> place, may be open in another task

Is this because another user might be accessing the database, or are
there other popular use cases that cause this?  If the former, then
this is not terribly important on Windows, since the situation when
more than one user is logged and actively works is quite rare,
basically limited to some scheduled task (the equivalent of a cron
job) running for some user while another one is logged in
interactively.

This might be different on machines that use Cygwin, though.

> Now, it's entirely possible that a completely different database 
> implementation would be better on Windows, but our current one does a lot 
> of creating files under different names, moving them to names where 
> they'll be seen (since this is atomic under POSIX, and partial files are 
> never seen by other tasks). Also, once we have new files in place, we 
> unlink the files that they replace, so that new tasks will use the new 
> ones and tasks that already have old ones open can still get the data out 
> of them. Also, the files generally get mmaped, 

Perhaps mmap introduces complications (I simply don't know), but in
general, as I show elsewhere in this thread, you can do similar things
on Windows, if you use native APIs (as opposed to emulations of Posix,
like `open'), although you may need to rename the old file to get it
out of the way of the new one with the same name, because otherwise
the old file will still be seen, even if deleted, as long as it's open
in some process.
