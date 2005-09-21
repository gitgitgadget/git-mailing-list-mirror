From: Junio C Hamano <junkio@cox.net>
Subject: Re: Please undo "Use git-merge instead of git-resolve in git-pull"
Date: Wed, 21 Sep 2005 14:48:46 -0700
Message-ID: <7vu0genlc1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 23:50:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EICSR-0001Jj-IW
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 23:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVIUVss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 17:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVIUVss
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 17:48:48 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:22490 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965041AbVIUVsr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 17:48:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050921214847.EQBX13739.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Sep 2005 17:48:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 21 Sep 2005 13:15:39 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9082>

Linus Torvalds <torvalds@osdl.org> writes:

> Local changes are a problem ONLY IF THOSE LOCAL CHANGES INTERFERE WITH THE 
> MERGE.

True, sorry, and reverted.

* Regardless of whatever else, we could detect when there is
  only one strategy applicable and bypass that check -- "reset
  --hard" should never happen in that case and 'git pull -s
  stupid' would regain the traditional behaviour and we should
  probably make this the default for 'git pull'.

* Otherwise, if the user wants it to try multiple strategies, we
  need to detect the local changes in the tree that _could_
  interfere with the merge more precisely.

  In order for that, we need to have a way to figure out the set
  of paths that _could_ potentially be involved in the merge.
  Once we have that set, we can just check if we have local
  changes on those paths, and the "restoring to the pre-merge
  state" currently done with "reset --hard" kludge could just
  restore those paths from the pre-merge HEAD.

  This is however harder than it sounds once we start allowing
  renaming merges.  If the ancestor had A/foo, you kept it and
  have an addition of A/bar as a local change, and the head that
  is being merged renames stuff in A/ to B/A/, it is more likely
  than not that you would want to have A/bar moved to B/A/bar in
  your merge result.  Once we go this route, the only thing it
  makes sense would be to make it responsibility for each merge
  strategy to preserve before starting its work and to restore
  after it has failed.

* I thought you do not multitask and wonder why you are merging
  while you still have local changes, but that does not justify
  this regression.
