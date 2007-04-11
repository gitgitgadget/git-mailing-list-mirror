From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 13:01:17 -0700
Message-ID: <7vmz1eof3m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
	<20070411080641.GF21701@admingilde.org>
	<81b0412b0704110129q56ee0628jafe8fca808ef9ef8@mail.gmail.com>
	<20070411083642.GH21701@admingilde.org>
	<7virc3p8zr.fsf@assigned-by-dhcp.cox.net>
	<20070411100328.GK21701@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 22:01:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbj0T-0008EF-5l
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 22:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbXDKUBT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 16:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbXDKUBT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 16:01:19 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:47760 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030302AbXDKUBS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 16:01:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411200119.GCYJ1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 16:01:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lw1H1W00B1kojtg0000000; Wed, 11 Apr 2007 16:01:18 -0400
In-Reply-To: <20070411100328.GK21701@admingilde.org> (Martin Waitz's message
	of "Wed, 11 Apr 2007 12:03:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44252>

Martin Waitz <tali@admingilde.org> writes:

> What is stored in the supermodule?  It stores a reference to a specific
> point in the history of the submodule.  As such I am convinced that
> the right counterpart inside the submodule is a refs/heads/whatever,
> and not the branch selector HEAD.

Because 'submodule' is a project on its own, it can make
progress while the parent project is still using the stable
commit.  Think of this:

 - Your application uses product of another project as a
   library (e.g. you are doing video application and embedding
   ffmpeg).
   
 - Your 'master' commit records a commit in the library
   subproject.  Maybe library subproject declared stable 1.0 and
   that is what you used to integrate.

 - But being an independent project on its own, the library
   project can make progress, outside the context of this
   aggregated work (i.e. your application).  Next time you do:

	$ cd ffmpeg ; git fetch

   there may not be any branch that points at the exact "stable 1.0"
   commit.

When you do a "checkout -f --recurse-into-subprojects" from the
toplevel, I suspect that you would need to detach HEAD in the
subproject repository grafted in your application tree to move
it to the exact commit the toplevel project (i.e. your
application) wants, and match the working tree to that commit.
The toplevel simply should _not_ have to care what branch that
commit comes from.
