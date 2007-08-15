From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix initialization of a bare repository
Date: Wed, 15 Aug 2007 12:09:21 -0700
Message-ID: <7vlkccr4wu.fsf@gitster.siamese.dyndns.org>
References: <7v643hrnh1.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0708151821260.19496@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 15 21:21:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILOQv-0006sN-7c
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 21:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259AbXHOTVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 15:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757190AbXHOTVD
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 15:21:03 -0400
Received: from fed1rmmtai107.cox.net ([68.230.241.53]:42587 "EHLO
	fed1rmmtai107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259AbXHOTVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 15:21:00 -0400
X-Greylist: delayed 698 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2007 15:21:00 EDT
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070815190923.TVQQ25808.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 15 Aug 2007 15:09:23 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id cK9N1X0031gtr5g0000000; Wed, 15 Aug 2007 15:09:22 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55938>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Maybe this is not enough, though.  Maybe we need to check if the 
> 	GIT_DIR=. too, since 7efeb8f0 would set the work tree to ".", too.
>
> 	But maybe this would merit a separate fix in set_work_tree(), like
>
> 		if (!strcmp(getenv(GIT_DIR_ENVIRONMENT), ".")) {
> 			inside_work_tree = 0;
> 			return NULL;
> 		}
>
> 	Hmm?

I do not know.  If you treat "." differently from a pathname
that is the same as what $(pwd) would give you, you will confuse
even more users.

Currently we have:

 - char *git_work_tree_cfg: the location of the work tree when
   $GIT_WORK_TREE nor --work-tree option is in use.  Contrary to
   the name of the variable, it does not necessarily come from
   core.worktree.  This comes from core.worktree if set,
   otherwise derived from the location of the repository
   (i.e. unless $GIT_DIR is set, above "/.git" of the found
   repository, otherwise ".").

 - char *work_tree: the location of the work tree, which comes
   from $GIT_WORK_TREE (or --work-tree option) if set, otherwise
   git_work_tree_cfg above.

 - int inside_work_tree: is $(cwd) inside of the work tree (if
   we have one)?

 - int is_bare_repository_cfg: are we treating this repository
   as bare?  Contrary to the name of the variable, it does not
   necessarily come from core.bare (get_git_work_tree()
   overwrites the value found in core.bare to false in if we
   have a work_tree).

 - int is_bare_repository(): are we treating this repository
   as bare?  This is the function the callers usually use.

I think tying the presense of work_tree and repository bareness
as is_bare_repository() does is almost always right for the
normal callers.  One valid use of GIT_WORK_TREE is to put a work
tree to a repository otherwise declared as a bare one.

But obviously init-db is rather a special case with a chicken
and egg problem.  What it wants to know is not if we are
currently treating the repository as a bare one, but if we would
want to mark its core.bare with "this should be normally treated
as bare".  Your patch treats this special case as such without
affecting the normal codepath, which I think is a sane thing to
do.

Thanks for a quick fix.
