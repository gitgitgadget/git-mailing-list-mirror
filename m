From: Junio C Hamano <junkio@cox.net>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Wed, 16 May 2007 22:21:40 -0700
Message-ID: <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net>
References: <11793556363795-git-send-email-junkio@cox.net>
	<11793556371774-git-send-email-junkio@cox.net>
	<200705170539.11402.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 07:21:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoYQz-0000uz-57
	for gcvg-git@gmane.org; Thu, 17 May 2007 07:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759504AbXEQFVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 01:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759520AbXEQFVm
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 01:21:42 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:42701 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759504AbXEQFVm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 01:21:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070517052142.PZJP13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 17 May 2007 01:21:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 05Mg1X00T1kojtg0000000; Thu, 17 May 2007 01:21:41 -0400
In-Reply-To: <200705170539.11402.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 17 May 2007 05:39:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47502>

Andy Parkins <andyparkins@gmail.com> writes:

> Our in-tree .gitmodules will have the same problem.  I recognise that 
> you've mitigated that with some "confirm with the user, store in the 
> config" hand waving; but that is just hiding the problem: the submodule 
> URL is not something that should be version controlled; it is an 
> all-of-history property; when it changes for revision N it changes for 
> revision N-1, N-2, N-3, etc.  Storing it in .gitmodules implies that 
> it's value in the past has meaning - it doesn't.

I think that depends _WHY_ the URL recorded .gitmodules are
updated.  It would perfectly be reasonable for release #1 of an
appliance project to bind linux 2.4 tree at kernel/ subdirectory
while release #2 source to have 2.6 one; they come from two
different repository URLs.  When you seek the superproject back
to release #1, you would still want to fetch from 2.4 upstream
if you are updating.

If the URL is changed only because the logically same project
was relocated to different hosting service, then what you say is
true.

What I was "handwaving" (or "envisioning") was to have something
like this in .gitmodules:

	[subproject "kernel/"]
        	URL = git://git.kernel.org/pub/linux-2.4.git

(or 2.6, depending on the revision of the superproject) and per
repository configuration would maps this with these two entries:

	[subproject "git://git.kernel.org/pub/linux-2.4.git"]
        	URL = http://www.kernel.org/pub/linux-2.4.git

	[subproject "git://git.kernel.org/pub/linux-2.6.git"]
        	URL = http://www.kernel.org/pub/linux-2.6.git

The intent is 

	(1) "kernel/" directory is found to be a gitlink in the
            tree/index; .gitmodules is consulted to find the
            "URL", which is just a handle and the initial hint

	(2) That "initial hint" is used to look up the
            subproject entry from the configuration, to find the
            "real" URL that is used by this repository

> You mentioned yourself that that problem is not confined to the temporal 
> accuracy of .gitmodules, there is spatial accuracy too - there is no 
> guarantee that user A wants to use the same submodule URL as user B.  

which hopefully is already answered by the above handwaving ;-).

The case of "relocated to different hosting site" would also be
solved by having more than one entries in the configuration
file.  If a project that used to be hosted at git.or.cz has
migrated to git.sf.net, its .gitmodules file from an earlier
revision would have URL pointing at git.repo.cz and newer ones
would point at git.sf.net.  If you started following that
project before the migration, you would have:

	[subproject "git://git.or.cz/sub.git"]
        	URL = git://git.or.cz/sub.git

in your .git/config.  After the repository migrates to
git.sf.net, you would update that existing entry and also add
another entry, so that .git/config would have these two entries:

	[subproject "git://git.or.cz/sub.git"]
        	URL = git://git.sf.net/sub.git

	[subproject "git://git.sf.net/sub.git"]
        	URL = git://git.sf.net/sub.git
