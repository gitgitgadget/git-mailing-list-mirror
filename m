From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-refs: use lockfile as everybody else does.
Date: Wed, 04 Oct 2006 23:15:48 -0700
Message-ID: <7vodsrguej.fsf@assigned-by-dhcp.cox.net>
References: <7v7izhrc2v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610041954480.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 08:16:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVMX7-0007L8-Q2
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 08:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWJEGPv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 02:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWJEGPv
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 02:15:51 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:27878 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751152AbWJEGPu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 02:15:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005061549.WLWZ6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 02:15:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WWFr1V00T1kojtg0000000
	Thu, 05 Oct 2006 02:15:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610041954480.3952@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 4 Oct 2006 19:55:42 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28345>

Linus Torvalds <torvalds@osdl.org> writes:

> Yes, there should be a fflush() there before the fsync.

While I have your attention...  The code that follows the
committing of packed-refs file by calling rename() to move the
lock file to its final name prunes already packed refs, and we
should really make sure the effect of rename() survives before
starting to remove loose refs from the filesystem.

How would one ensure the effect of rename(2) hits the disk
platter before proceeding to do something else?  We seem to do
sync(1) in git-repack.sh for similar reasons, and I wonder if we
should do a sync(2) there.  I doubt it would be worth it though;
the function can return before the actual writing is done.

If the write-out of metainfo is ordered enough that if we rename
the packed-refs lock file to its final destination and then we
unlink loose refs, it might be reasonably safe to assume that
rename(2)'s effect has already hit the disk when the effect of
unlink(2) does, of the machine crashes in the meantime, as long
as none of the later unlink hits the disk before rename does it
is Ok.
