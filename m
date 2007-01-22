From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 18:03:52 -0800
Message-ID: <7v1wlnyfzr.fsf@assigned-by-dhcp.cox.net>
References: <20070118175134.GH15428@spearce.org>
	<20070118222919.GA22060@moooo.ath.cx>
	<7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>
	<20070119034404.GA17521@spearce.org>
	<20070119104935.GA5189@moooo.ath.cx>
	<7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
	<20070120111832.GA30368@moooo.ath.cx>
	<7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
	<20070121103724.GA23256@moooo.ath.cx>
	<7vejpo39zg.fsf@assigned-by-dhcp.cox.net>
	<20070121220114.GA24729@coredump.intra.peff.net>
	<45B415B1.30407@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthias Lederhofer <matled@gmx.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 03:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8oXS-0006r9-4I
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 03:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbXAVCDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 21:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbXAVCDy
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 21:03:54 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:32814 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbXAVCDx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 21:03:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122020353.WMTC25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jan 2007 21:03:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E24A1W0101kojtg0000000; Sun, 21 Jan 2007 21:04:11 -0500
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <45B415B1.30407@midwinter.com> (Steven Grimm's message of "Sun,
	21 Jan 2007 17:38:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37384>

Steven Grimm <koreth@midwinter.com> writes:

> Shouldn't the repository be locked against operations like prune while
> a commit is in progress anyway? That seems like it's pretty prudent
> and reasonable to me -- doing otherwise is just asking for a zillion
> little race conditions.

The primary problem is not "while a commit is in progress"
anyway.  I do not think of a single sane reason to run git-prune
from a cron job in a repository that is used for an active
development.  It would make sense for management types to run
count-objects from a cron job and yell at offenders to repack,
but even then the primary disk saving and performance
enhancement would come from repacking and not from pruning.
Especially, 1.5.0 and onwards the objects reachable from reflog
are protected from pruning and reflogs are enabled by default
for developer repositories with working trees, even rewind and
rebae would not create crufts (the only two exceptions that
create cruft are running "git add" more than once on the same
file between commits to leak blobs and intermediate tree objects
recursive merge needs to make when there are more than one
common ancestors).

It is a possibility to have a single timestamp file that any
command that intends to eventually update refs should touch
before it starts creating any object.  Then prune can stat the
file and remember its timestamp before it starts reading the
refs, and then before starting to actually prune the objects it
can stat the file again and if the timestamp is different it can
abort.  Commit, receive-pack (invoked by git-push from the
remote side), fetch-pack (invoked by clone, fetch and pull), etc.
all needs to touch the file upfront before they create even a
single object.  But that would create a very hot spot on the
filesystem, and I am not sure what its ramifications are.

My take on this issue is rather different.  I do agree with you
that prune is a rare enough operation, and I think it should not
penalize the primary thing developers would want to do many
times an hour.  I think its much simpler and saner to teach
people not to run prune in an uncontrolled way.

We may want to remove the call to git-prune from git-gc, and
tell people that if they want to run something from a cron job,
run git-gc and not git-prune.
