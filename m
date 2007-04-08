From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/5] Treat D/F conflict entry more carefully in
 unpack-trees.c::threeway_merge()
Date: Sat, 7 Apr 2007 20:29:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704072018321.27922@iabervon.org>
References: <7vabxkcknp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704071456470.27922@iabervon.org> <7vfy7bbu3a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 02:29:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaLHc-0001lq-PD
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 02:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966013AbXDHA3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 20:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966018AbXDHA3Z
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 20:29:25 -0400
Received: from iabervon.org ([66.92.72.58]:2153 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966013AbXDHA3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 20:29:25 -0400
Received: (qmail 28971 invoked by uid 1000); 8 Apr 2007 00:29:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Apr 2007 00:29:24 -0000
In-Reply-To: <7vfy7bbu3a.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43993>

On Sat, 7 Apr 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Sat, 7 Apr 2007, Junio C Hamano wrote:
> >
> >> This fixes three buglets in threeway_merge() regarding D/F
> >> conflict entries.
> >> 
> >> * After finishing with path D and handling path D/F, some stages
> >>   have D/F conflict entry which are obviously non-NULL.  For the
> >>   purpose of determining if the path D/F is missing in the
> >>   ancestor, they should not be taken into account.
> >> 
> >> * D/F conflict entry is a phony entry and does not record the
> >>   path being processed, so do not pick up the name from there.
> >
> > This bit is unnecessary, because the first bit means we treat D/F conflict 
> > as missing in that conditional, and don't count it as an entry at all, let 
> > alone one with a useful name.
> 
> I am not sure about what you mean by "first bit"

Your first bullet point. You must have added the check to the path line 
before you added the same check to the condition a few lines above, making 
this check no longer necessary.

                if (!stages[i] || stages[i] == o->df_conflict_entry)
                        any_anc_missing = 1;
                else {

If we get here, stages[i] != o->df_conflict_entry...

                        if (!path && stages[i] != o->df_conflict_entry)
                                path = stages[i]->name;
                        no_anc_exists = 0;
                }

So you don't need the second check if you've got the first one, and the 
first one makes more sense anyway; for the purposes of this entire 
section, we want df_conflict_entry to count as missing, and we don't look 
at the paths of missing entries regardless of whether they're specially 
marked.

	-Daniel
*This .sig left intentionally blank*
