From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-refs: dereference .git/packed-refs if it is a symlink
Date: Sat, 21 Apr 2007 13:05:50 -0700
Message-ID: <7vk5w5trvl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk>
	<7vfy6xird9.fsf@assigned-by-dhcp.cox.net>
	<20070418174350.GB5913@xp.machine.xx>
	<7vlkgph7i0.fsf@assigned-by-dhcp.cox.net>
	<20070418183156.GF5913@xp.machine.xx>
	<7v647th6cv.fsf@assigned-by-dhcp.cox.net>
	<20070418210819.GG5913@xp.machine.xx>
	<7v4pndfjym.fsf@assigned-by-dhcp.cox.net>
	<20070419053518.GK5913@xp.machine.xx>
	<7vabx499u2.fsf@assigned-by-dhcp.cox.net>
	<20070420165256.GA14318@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 21 22:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfLqF-0007xC-7d
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 22:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbXDUUFw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 16:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbXDUUFw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 16:05:52 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57722 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbXDUUFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 16:05:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421200551.EFIQ1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 21 Apr 2007 16:05:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id pw5r1W0021kojtg0000000; Sat, 21 Apr 2007 16:05:51 -0400
cc: git@vger.kernel.org
In-Reply-To: <20070420165256.GA14318@xp.machine.xx> (Peter Baumann's message
	of "Fri, 20 Apr 2007 18:52:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45194>

Peter Baumann <waste.manager@gmx.de> writes:

> git-new-workdir creates a new working directory where everything
> necessary, including .git/packed-refs, is symlinked to your master repo.
> But git-pack-refs breaks the symlink, so you could accidentally loose some
> refs.
>
> This fixes git-pack-refs to first dereference .git/packed-refs if it is a
> symlink. While we are it, add some tests to prevent this from happening
> again.

Because you are only fixing the case where the worktree is
borrowing the packed-refs file from a real repository with a
symlink trick, and we do not know if somebody had his
packed-refs as a symlink to some random place for reasons other
than creating a lightweight worktree (maybe there was a
mistake), I am wondering if it makes sense to be more strict
about the value we read from readlink().

For example, if it does not end with "/packed-refs", doesn't it
suggest that the reason because the symlink is there is
different from the case you are handling (i.e. it is not a
packed-refs symlink in a lightweight worktree that points at the
corresponding real repository)?  I wonder if in such a case we
would want to signal an error, instead of overwriting whatever
real file the symlink points at.  Or is it too strict and
paranoid?  I dunno.
