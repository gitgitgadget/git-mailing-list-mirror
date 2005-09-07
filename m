From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Wed, 07 Sep 2005 11:36:48 -0700
Message-ID: <7v1x407min.fsf@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 20:39:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED4mz-00066X-60
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 20:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVIGSgu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 14:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVIGSgu
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 14:36:50 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30866 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932204AbVIGSgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2005 14:36:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050907183648.WALT24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Sep 2005 14:36:48 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050907164734.GA20198@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Wed, 7 Sep 2005 18:47:34 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8173>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> I guess the need for this has decreased with Daniel's new read-tree
> code. Is there any chance of getting this code merged into mainline
> git?

I do not think Daniel's code decreased anything.  The two
algorithms are solving the same problem but they do it
differently.  There would be cases where multi-base merge would
give better results over your base-on-merge-bases merge; and in
other cases yours would perform better.  I'd like to leave what
merge strategy to use as an user option, and leave the door open
for other merge strategies to emerge later.  I know Pasky wants
to look into pcdv merge and other alternatives.

This is still off-the-top-of-my-head, but the top-level merge
entry point for the end user would be just:

    git merge <head> <remote> <merge-message>

and by default 'git-merge-script' (sorry, I am taking over the
name of your script for this 'generic driver for underlying
merge strategy scripts') would do something like:

 - Run 'git-merge-base -a' to find common ancestors.

 - If there is one single common ancestor, do what the current
   'git-resolve-script' does: if fast-forward, declare success
   and exit without touching anything but $GIT_DIR/HEAD;
   otherwise, run read-tree -m 3-way followed by merge-cache,
   and commit with the given message if the merge was clean and
   exit.  If the merge was not clean, go on to the next step.

 - User preference (maybe $HOME/.git/merge-preference, maybe
   command line option to 'git merge', maybe interactive
   prompting) can specify which complex merge strategies to use.
   we probably would want to be able to say "try this, that and
   that-over-there in this order" in the preference. One of the
   strategies could be 'I give up, just exit and sort it out by
   hand'.

 - The chosen merge backend, be it the one that uses Daniel's
   multi-base merge or your base-on-merge-bases merge, takes
   over.  In any case, the backend should attempt to resolve the
   two heads, and stop at the point just before committing.

 - Evaluate how good the merge is by looking at the result from
   the backend at this point, and if it is not good enough,
   reset the working tree back to the pre-merge state and try
   the next backend.  The looping code needs a termination
   clause that picks the best result after exhausting the list
   of backends.

 - Then, if the merge backend auto-resolved the heads, we
   commit with <merge-message>; otherwise we exit with
   non-zero status and have the user sort it out.

The above assumes that (1) we are already doing a reasonable
thing in simple one-common-ancestor case; (2) it is in the fast
path and we want the multiple backend code out of it.  You could
think of the current 'git-resolve-script' code equivalent of
having a single 'complex merge backend' that just 'gives up'.

If the above is a good user model, we need a couple of interface
convention between merge backends and the above driver:

 - Some merge backends (like yours) would require that the
   starting tree is clean while others may not care as long as
   the paths involved are clean (i.e. index matches <head> and
   the working file matches index -- the traditional code and
   Daniel's even allow such a working file being different from
   index if it happens to match the merge result).  They need to
   be able to say "declined to merge even though I might do a
   better job than others if given a clean working tree".  Then
   the user can retry the same merge after getting the working
   tree in a clean state.  I personally feel that we do not need
   this complexity and it is reasonable to always require the
   starting tree to be clean when the merge is not a
   fast-forward, though.

 - When a merge backend finishes, it may leave the working tree
   in a failed merge state.  If we were to try different
   backends in the loop to find the best result, we would need
   some way to assign scores to them.  The score should be able
   to tell us if the result can be auto-committable or not, and
   if not how bad it is.  I think exit status from the backend
   can be used to tell us the former (i.e. exit non-zero if your
   result has conflicts and you do not want your result to be
   committed immediately), and number of cache-dirty entries can
   be used as an indication of how bad it is (i.e. leave the
   paths you know have not been cleanly merged cache-dirty -- do
   not run git-update-cache on them).  This is essentially the
   same convention used by the current 'git-resolve-script'.

I think the 'renaming merge heuristics' Linus outlined in
another thread will fall naturally into this picture as a merge
backend.
