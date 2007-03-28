From: Junio C Hamano <junkio@cox.net>
Subject: Re: Sanity checking request
Date: Wed, 28 Mar 2007 12:38:02 -0700
Message-ID: <7vwt11f9b9.fsf@assigned-by-dhcp.cox.net>
References: <7vwt11itbz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703280759230.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:38:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWdyc-00060T-UQ
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 21:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933273AbXC1TiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 15:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933275AbXC1TiG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 15:38:06 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60025 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933273AbXC1TiF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 15:38:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328193804.ZPBG25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 28 Mar 2007 15:38:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gKe21W00R1kojtg0000000; Wed, 28 Mar 2007 15:38:02 -0400
In-Reply-To: <Pine.LNX.4.64.0703280759230.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 28 Mar 2007 08:13:38 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43381>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That said, I actually think the newer "git read-tree -m" behaviour makes 
> sense. So I think we're much better off adding "-i" to git-commit.sh, than 
> to force "-i" on when doing the one-way merge. The latter change just 
> effectively disables a possible check entirely, the former at least allows 
> other users to actually use that form if they ever want to.

Thanks, I agree.

> (Looking at git-commit.sh, the thing I *really* think we should do is to 
> have a "GIT_INDEX_FILE_OUTPUT" environment variable that does locking on 
> the input file, but writes the result to another file: rigth now 
> git-commit.sh (a) wastes time copying the old index file by hand and (b) 
> as a result doesn't even honor any locking on it. I think whether it uses 
> "-i" or not is actually less important - if you commit only a subset of 
> files, maybe the extra checks in git-read-tree are actually ok?)

Good point on locking.

The reason missing -i matters because it defeats the previous
158d0577:

commit 158d0577891441c01457bbcaf45585d3b50f5d75
Author: Junio C Hamano <junkio@cox.net>
Date:   Sat Dec 9 22:32:43 2006 -0800

    git-commit: allow --only to lose what was staged earlier.
    
    The command used to have a safety valve to prevent this sequence:
    
    	edit foo
    	git update-index foo
    	edit foo
    	git diff foo
    	git commit --only foo
    
    The reason for this was because an inexperienced user might
    mistakenly think what is shown with the last-minute diff
    contains all the change that is being committed (instead, what
    the user asked to check was an incremental diff since what has
    been staged so far).  However, this turns out to only annoy
    people who know what they are doing.  Inexperienced people
    would not be using the first "update-index" anyway, in which
    case they would see the full changes in the "git diff".
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

and that is why I noticed this issue.
