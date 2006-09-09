From: linux@horizon.com
Subject: Re: Change set based shallow clone
Date: 9 Sep 2006 14:44:41 -0400
Message-ID: <20060909184441.23764.qmail@science.horizon.com>
References: <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
Cc: git@vger.kernel.org, jonsmirl@gmail.com, linux@horizon.com,
	paulus@samba.org
X-From: git-owner@vger.kernel.org Sat Sep 09 20:44:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM7ot-00036N-33
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 20:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWIISom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 14:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWIISom
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 14:44:42 -0400
Received: from science.horizon.com ([192.35.100.1]:819 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S964798AbWIISom
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 14:44:42 -0400
Received: (qmail 23765 invoked by uid 1000); 9 Sep 2006 14:44:41 -0400
To: mcostalba@gmail.com, torvalds@osdl.org
In-Reply-To: <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26760>

> Anyhow the basic is:
> 
> -git-rev-list starts outputting the data early (order is not guaranteed)
> 
> -before to mark for output a revision check if it breaks --topo-order
> 
> -if the above is true store the revision away and *do not send*
> 
> - at the end you get an early started steram of topological corrects
> revisions without
> preordering, just because you filter away the (few?) revisions that
> are not in order.
> The list you get is guaranteed to be in topo order although my not be complete.
> 
> - _then_  you send the missing revisions that where previously
> filtered out. At this stage the receiver has already drwan the graph,
> indeed it has start drwaing as soon as the first revisons arrived and
> *very important* receiver used old and fast topo-order parsing code.
> 
> - finally the fixup routine at receiver's end updates the graph with
> the info from the small set of out of order revisions filtered out
> before and sent at the end (only this small set is sent at the end).

The problem is that the gitk display code doesn't *like* input like this;
it's only designed to append to a list.  Handling insertions would be
hard work for a rare corner case, and a perpetual source of bugs.

Unless gitk does a complete second pass, or course, which would
guarantee an annoying flicker a few seconds after startup.
And Twice the work.

The original alternative was to note that out-of-order commits
usually aren't *very* out of order.  So if gitk could checkpoint
the state of its display algorithm periodically, it could just, when
seeing an out-of-order commit, rewind to the last checkpoint
before the problem and replay while merging in the corrections.

While that is potentially O(n^2) (if you feed it all the commits
in reverse order), in practice it
- Is less than 2*n work, and
- Always maintains the longest possible correct prefix of
  recent commits.  It's the old stuff that takes a while to
  fill in.

Either way, gitk has to have topo-sorting code added to it.  I think
Linus' idea was to avoid that.
