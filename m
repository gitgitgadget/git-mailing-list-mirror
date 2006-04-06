From: Junio C Hamano <junkio@cox.net>
Subject: Re: blame not working well?
Date: Wed, 05 Apr 2006 18:26:11 -0700
Message-ID: <7vwte3wl3g.fsf@assigned-by-dhcp.cox.net>
References: <7vacazy33w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 06 03:26:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRJGa-0008Jj-H9
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 03:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWDFB0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 21:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWDFB0N
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 21:26:13 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1788 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750851AbWDFB0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 21:26:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060406012612.IWSD3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 21:26:12 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <7vacazy33w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 05 Apr 2006 17:11:47 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18463>

Junio C Hamano <junkio@cox.net> writes:

> I was having fun updating blame.c to use the built-in xdiff
> instead of spawning and reading from external GNU diff (it is
> currently in "next" branch).  It seems to pass the trivial
> testsuite case but I noticed for example annotating Makefile,
> sha1_name.c, or blame.c in git.git repository seems to show
> quite bogus annotation.  One extreme case is the Makefile; for
> all but one line is blamed for the very initial commit made by
> Linus X-<.  One good news for me is that the version before this
> change has the same breakage.  One bad news is this seems to
> have been broken for some time.
>
> Bisecting indicates 2a0925be3512451834ec9a3e023f4cff23c1cfb7 is
> the first bad commit, but I do not see how the change can break
> it.  I'll continue digging it, but if you have a chance, could
> you take a look, too?

It turns out that the only change needed to revert the breakage
was this one-liner.  get_revision() used to always rewrite
parents when prune and dense are specified, but the updated code
simply skips during the output filtering phase the parents that
would have been culled by calling rewrite_parents() unless the
caller tells it that it is interested in the parent field by
setting rev.parents.

-- >8 --
[PATCH] blame.c: fix completely broken ancestry traversal.

Recent revision.c updates completely broken the assignment of
blames by not rewriting commit->parents field unless explicitly
asked to by the caller.  The caller needs to set revs.parents.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 blame.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

ba3c93743a8151e3663e1fda6b3cb165d8373ddf
diff --git a/blame.c b/blame.c
index 98f9992..9bb34e6 100644
--- a/blame.c
+++ b/blame.c
@@ -813,6 +813,7 @@ int main(int argc, const char **argv)
 	rev.prune_fn = simplify_commit;
 	rev.topo_setter = topo_setter;
 	rev.topo_getter = topo_getter;
+	rev.parents = 1;
 	rev.limited = 1;
 
 	commit_list_insert(start_commit, &rev.commits);
-- 
1.3.0.rc2.g9cda
