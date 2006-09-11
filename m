From: Paul Mackerras <paulus@samba.org>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 19:56:52 +1000
Message-ID: <17669.13028.198886.947400@cargo.ozlabs.ibm.com>
References: <e5bfff550609092214t4f8e195eib28e302f4d284aa@mail.gmail.com>
	<20060910152122.31694.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, mcostalba@gmail.com, git@vger.kernel.org,
	jonsmirl@gmail.com, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Sep 11 11:57:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMiXU-0005ro-Gv
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 11:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWIKJ5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 05:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWIKJ5E
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 05:57:04 -0400
Received: from ozlabs.org ([203.10.76.45]:51889 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751320AbWIKJ5C (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 05:57:02 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2BDBA67B93; Mon, 11 Sep 2006 19:57:00 +1000 (EST)
To: linux@horizon.com
In-Reply-To: <20060910152122.31694.qmail@science.horizon.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26847>

linux@horizon.com writes:

> I'm trying to figure out the gitk code, but I'm not fluent in tcl, and
> it has 39 non-boilerplate comment lines in 229 functions and 6308 lines
> of source, so it requires fairly intensive grokking.

Sorry :)

> Still, while it obviously doesn't render bitmaps until the data
> appears in the window, it appears as though at least part of the
> layout (the "layoutmore" function) code is performed eagerly as
> soon as new data arrives via the getcommitlines callback.

It doesn't render bitmaps as such at the Tcl level, what it does is
create items on canvases, add text to text widgets, etc.  Tk takes
care of turning it into bitmaps.

The work of drawing the graph is done in three stages - layout,
optimization and drawing.  The layout and optimization stages are done
when we have enough data because, at least for the layout stage,
earlier rows can affect later rows arbitrarily far away.  For the
optimization stage, I don't think the changes it makes can propagate
arbitrarily far, so it would be possible to defer that stage, and I am
looking into implementing that.  The drawing stage is done on demand,
just for the part that's actually visible.

> (Indeed, it appears that Tk does not inform it of window scroll
> events, so it can't wait any longer to decide on the layout.)

The Tcl code does get to know when the canvas has been scrolled - see
the scrollcanv procedure.

> In case 2, I utterly fail to see how delaying emitting the out-of-order
> commit is of the slightest help to the UI.  The simplest way to merge

Indeed.  I would want to see it as early as possible.

> out-of-order data is with an insertion sort (a.k.a. roll back and
> reprocess forward), and the cost of that is minimized if the distance
> to back up is minimized.

That part isn't too hard; I already have modifications to gitk to
handle that much of it.  The harder part is backing up the graph
drawing algorithm.

> For example, is fixing a small number of out-of-place commits practical,
> or is it better to purge and restart?  The former avoids deleting
> already-existing objects, while the latter avoids moving them.

For gitk, I'm thinking of a reorder buffer of say 10 entries at the
front end to cope with minor misorderings; then if misordering occurs
that is outside the scope of the reorder buffer to fix, freeze the
layout algorithms at that point, read in the rest of the commits and
reorder as necessary, then at the end restart the layout algorithm
from scratch, probably with a popup to inform the user what happened.
If the user could set the size of the reorder buffer then they could
avoid having that happen in future, at the cost of it taking longer to
show the first screenful of commits.

Paul.
