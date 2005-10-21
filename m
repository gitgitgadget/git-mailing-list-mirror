From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not call git-rev-list from git-fetch-pack
Date: Fri, 21 Oct 2005 11:35:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510211111440.4950@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510210413210.26388@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virvrw8w1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 11:37:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EStJB-0007y6-H2
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 11:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVJUJfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 05:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVJUJfY
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 05:35:24 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:17382 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964906AbVJUJfX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 05:35:23 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6260C13F187; Fri, 21 Oct 2005 11:35:22 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 43ACFB4E48; Fri, 21 Oct 2005 11:35:22 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 238CEB4E43; Fri, 21 Oct 2005 11:35:22 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F221E13F187; Fri, 21 Oct 2005 11:35:21 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virvrw8w1.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10429>

Hi,

On Fri, 21 Oct 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +	   Branch1 has 40 commits since it last merged with branch2,
> > +	   and branch2 has 2 more commits since then.
> > +
> > +	   On the other end, branch1 is up-to-date, but branch2 is not.
> > +	   When fetching branch1, the 40 commits get sent, the first
> > +	   is acknowledged as common, and the local head of branch2
> > +	   never gets sent.
> > +
> > +	   As a consequence, the whole history of branch2
> > +	   (git-rev-list branch2 ^branch1) gets packed and transmitted.
> 
> Arrrgggggggh.  The description above captures the essense of the
> problem very well, but faking dates and still popping by recency
> looks like a really ugly hack to me.

It is ugly. But it is a good heuristic. And the code is simple, because I 
could use the existing functions for inserting into a commit_list.

> Wouldn't it be cleaner if you traversed commits starting from
> local refs, and assign distance from the tip of the branch to
> each object (use generic object->util field for it), and
> maintain an object_list that is sorted by depth, similar to
> commit_list sorted by commit date?  Then you can pop from the
> list by depth, closer to tip first, and tell the other end that
> you have branch1, branch2, branch1^, branch2^, branch1~2,
> branch2~1,...  which is the order the above situation benefits
> from.

I have an example from the real world why this is bad as well: I have a 
repository imported from CVS, which has this silly CVS initial import 
marked as it's own branch. This was long, long, long ago, but 
git-cvsimport faithfully creates the branch "initial" for it anyway.

Imagine now the case that I added 40 revisions locally between the last 
fetch and now. What would happen is this:

In both cases, your git-fetch-pack and mine, the tips would get sent, the 
(very old one) "initial" acknowledged. A few of those 40 revisions would 
get sent, too, (and in your case, the root rev), but not at all the 
optimal merge base. In essence, almost all would get sent again.

How about this on top of your idea:

Send only those branch{i}^n where n is a power of 2. This is a tradeoff 
between the speed we find sensible common revs, and the accurateness of 
the best pick.

Note that the best thing would probably be to add a binary search to that, 
and *not* stop at the first ack'ed rev, but rather count them, and stop at 
MAX_HAS.

Ciao,
Dscho
