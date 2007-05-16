From: Junio C Hamano <junkio@cox.net>
Subject: Re: Opinions on bug fix organisation
Date: Wed, 16 May 2007 10:55:17 -0700
Message-ID: <7v1whgfybe.fsf@assigned-by-dhcp.cox.net>
References: <200705161138.30134.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 19:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoNiv-0001pl-Sq
	for gcvg-git@gmane.org; Wed, 16 May 2007 19:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760759AbXEPRzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 13:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759871AbXEPRzV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 13:55:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:47452 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760759AbXEPRzT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 13:55:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516175518.BOGO13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 16 May 2007 13:55:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ztvH1W00V1kojtg0000000; Wed, 16 May 2007 13:55:18 -0400
In-Reply-To: <200705161138.30134.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 16 May 2007 11:38:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47445>

Andy Parkins <andyparkins@gmail.com> writes:

> I quite like option 2 because it records intent - i.e. "I wish I could have 
> gone back and changed this revision, but I can't", but it makes a more 
> complicated history.
>
> What do people think?

I think that largely depends on your taste and what other things
you have between B and the tip when you contemplate on the fix.

If you ever have a forkpoint (e.g. maybe soon after B you had a
tagged release, and maintenance track for that forked from it),
then the latter is much more manageable in the long run.  That
is how 'master' and 'maint' in git.git are managed.  An old bug
is fixed as close to the introduction of bug as practical (so I
would _not_ fork a fix on top of B itself, but apply fix to the
tip of 'maint'), and then all newer development track that
contain breakage B merges the fix from that branch (i.e. 'maint'
is then merged into 'master' to propagate the fix forward).

The way 'next' and 'master' works in git.git looks a bit
different from it, but you will realize that the idea is the
same if you look at individual topic branches.  Each topic is
forked from 'master', gain its own commits and merged to 'next'.
Its bugs may be discovered later while it still hasn't been
merged to 'master'.  I'd _never_ commit a fix to 'next'
directly, but a fix goes to the tip of the topic branch that
introduces the bug, and then merged to 'next'.  When the topic
is reasonably bug-free, it then is merged to 'master' -- at that
point, the history of the topic has all the relevant fixes.

If you think of your straight single strand of pearls (the first
picture) as a degenerated case that has a topic that includes B
and ends with the tip, "merged" to 'master' in a fast forward
fashion (i.e. the rightmost commit in the picture is the tip of
the topic and at the same time the tip of the 'master'), then
having a fix on top of the 'master' like in your first solution
is perfectly fine -- it is in line with how topic branches in my
repository gets fixed and how the fix is propagated to 'next'
and then eventually to 'master'.

On the other hand, if your commits between B and the tip of your
master contain enhancements and fixes to random issues (iow, it
is not a degenerated merge of a single topic into 'master', but
just a random set of development), I think your latter approach
to have only the fix as a separate (temporary) topic and merge
that to the tip is inconsistent with your current practice to
begin with, and I do not see much merit in it by itself.  If you
prefer the latter solution (and I obviously do, as that is the
way git.git repository is maintained), you would also want to
have topic branches, where all the enhancements, advances _and_
fixes related to a single theme go to and then merged to the
mainline.  That's the history of a theme.  Having branch and
merge only for fixes but not for advancement may be "the history
of a bug", but it probably would not buy you much by itself.
