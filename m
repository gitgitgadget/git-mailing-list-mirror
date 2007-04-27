From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] A utility to perform merges between Subversion branches using git
Date: Fri, 27 Apr 2007 15:38:40 -0700
Message-ID: <7v3b2lmoi7.fsf@assigned-by-dhcp.cox.net>
References: <20070427005528.GA12688@midwinter.com>
	<7vy7kephg8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Apr 28 00:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhZ5t-0005LS-8Y
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 00:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514AbXD0Wio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 18:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757513AbXD0Wio
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 18:38:44 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49391 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757514AbXD0Wil (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 18:38:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427223841.BEFN1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Apr 2007 18:38:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sNeg1W00H1kojtg0000000; Fri, 27 Apr 2007 18:38:40 -0400
In-Reply-To: <7vy7kephg8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 26 Apr 2007 21:30:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45758>

Junio C Hamano <junkio@cox.net> writes:

>> +if test "$Status" = "committed"; then
>> +	git svn dcommit || \
>> +		die "Can't commit to Subversion"
>> +
>> +	# dcommit will update our current HEAD to point to the newly committed
>> +	# svn revision. Update grafts file to tell git that it's a merge.
>> +	NewRevision="`git rev-list --max-count=1 HEAD`"
>> +	echo "$NewRevision $OldHead $RevToMerge" >> $GitDir/info/grafts
>
> This graft look very yucky, and would not scale.

Style issues aside...

I do not know what dcommit is supposed to do, but I wonder if
that graft part can be folded into it.  Even if git-svn cannot
deal with merges that happen on the svn side, assuming if your
grafting solution works, it indicates that git-svn itself does
not have trouble seeing a merge commit on git side, as its
invocation of "git-rev-list --parents" would show that the
commit you grafted an extra parent to has two parents and
git-svn needs to be able to deal with it.

The command sequence in your contrib script is:

 - make a commit on top of git-svn managed head by hand,
   recording what should have happened if git-svn knew how to
   merge two svn branches;

 - make svn dcommit to record it to svn side, and let it make an
   extra commit to mark the synchronization between git-svn
   managed head and svn repository;

 - pretend that the synchronization commit svn dcommit made has
   an extra commit, which is what you created by hand;

So perhaps you can add an option "git-svn dcommit --merge
$OldHead $RevToMerge" that does whatever it usually does and
record the resulting commit as a merge between these two
commits?
