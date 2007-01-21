From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 03:17:07 -0800
Message-ID: <7vejpo39zg.fsf@assigned-by-dhcp.cox.net>
References: <20070118172408.GG15428@spearce.org>
	<20070118174244.GA14287@moooo.ath.cx>
	<20070118175134.GH15428@spearce.org>
	<20070118222919.GA22060@moooo.ath.cx>
	<7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>
	<20070119034404.GA17521@spearce.org>
	<20070119104935.GA5189@moooo.ath.cx>
	<7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
	<20070120111832.GA30368@moooo.ath.cx>
	<7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
	<20070121103724.GA23256@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 12:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8ahH-0006Uk-FH
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 12:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXAULRK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 06:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbXAULRK
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 06:17:10 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41634 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbXAULRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 06:17:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070121111708.ZCKF3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sun, 21 Jan 2007 06:17:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DnGD1W0031kojtg0000000; Sun, 21 Jan 2007 06:16:13 -0500
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <20070121103724.GA23256@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sun, 21 Jan 2007 11:37:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37318>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> I am considering to commit the attached instead.
> Looks fine.  Just one question:  You said normally unsigned long would
> be used for time_t but time_t itself seems to be signed.  Using
> unsigned long instead of int for prune_grace_period (which is used as
> time_t here) results in 'warning: comparison between signed and
> unsigned'.  Perhaps you want to change it here anyway to be consistent
> with the rest of the code (approxidate returns unsigned long too).

Although I've merged this and pushed out v1.5.0-rc2, I am
starting to think this whole implementation of grace period is
unfortunately busted and does not buy us much.  Running
git-prune in an uncontrolled way from a cron job is still not
safe.

Suppose there is a repository that has one old blob that is not
referenced from any existing ref (in other words, its been more
than the grace period since 'prune' was run in the repository,
and one of its heads were rewound which lost the last reference
to the blob).  You are pushing a new commit into it, whose tree
has that blob as one of the files.

You construct a pack, and unpack-objects starts to run to
extract the objects you send in the said repository.  The pack
you are sending does contain the blob (because no refs reached
it in the repository), but unpack-objects safety measure means
the blob is not re-extracted to overwrite the existing old blob.

Now, an automated prune runs and finishes reading the available
refs before your push concludes and updates the ref with your
new commit.

What happens?

If we wanted to apply this grace period conservatively,
protecting young objects is not enough.  You need to protect
everything they refer to as well.  In the above scenario, you
would protect the new commit object and probably the tree
objects contained within, but the code happily will lose the
blob that was already sitting there.
