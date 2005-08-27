From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Comments in read-tree about #nALT
Date: Sat, 27 Aug 2005 17:57:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508271709530.23242@iabervon.org>
References: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
 <7vwtm726xq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 23:54:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E98ch-0002DW-2S
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 23:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVH0Vxw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 17:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVH0Vxw
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 17:53:52 -0400
Received: from iabervon.org ([66.92.72.58]:62733 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750814AbVH0Vxu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2005 17:53:50 -0400
Received: (qmail 5404 invoked by uid 1000); 27 Aug 2005 17:57:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Aug 2005 17:57:29 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtm726xq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7855>

On Sat, 27 Aug 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
> > Part of threeway_merge, however, wants to search the rest of the cache for
> > interfering entries in some cases, which would have to happen differently,
> > because I won't have the cache completely filled out beforehand. I'm
> > trying to figure out what the comments are talking about, and they seem to
> > refer to a list of the possible cases. Is that list somewhere convenient?
>
> Please look for END_OF_CASE_TABLE in t/t1000-read-tree-m-3way.sh;
> the table talks about some of the (ALT) not implemented, but
> some of them are ("git whatchanged t/t1000-read-tree-m-3way"
> would tell you which).

It looks like all of them are implemented:

#2ALT, #3ALT, #5ALT, and #14ALT, according to the commit comments, and the
others seem from the email you quote to have been done in the process of
getting #5ALT.

> Two way cases are described in Documentation/git-read-tree.txt,
> if you care.  If you were not touching the three-way case right
> now, I'd move/copy the three way cases there as well, but that
> can wait until after your changes.

I'd actually like to introduce Documentation/technical/trivial-merge for
this stuff; I think it would be good to have documentation for people who
need to know how the stuff works, rather than just how to use it, so we
get a balance between reams of information that users don't want to wade
through and being too vague for future developers.

Okay, so it looks to me like the only cases that care about the contents
of the index, other than in stage 0 (which is effectively another tree,
but already in index-form rather than tree-form), are 2 and 3, and these
only care because read-tree modifies the stage of entries, rather
than removing them and adding a stage-0 replacement entry; if it went
through the add logic without SKIP_DFCHECK, that would reject the same
things that causes_df_conflict rejects (at the point where whichever is
second is done).

So if I do the merge on tree entries (plus a stage-0 ce for the input from
the index), and then add the result(s) to the cache, I can skip
causes_df_conflict() in favor of just not using SKIP_DFCHECK. Is this
right?

Also, there doesn't actually seem to be a DF test in t1000; I think the
t1005 DF test covers these cases (by the emu23 path into this code). Is
this right?

	-Daniel
*This .sig left intentionally blank*
