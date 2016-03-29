From: Kazuki Yamaguchi <k@rhe.jp>
Subject: Re: [PATCH v2] branch -d: refuse deleting a branch which is
 currently checked out
Date: Tue, 29 Mar 2016 18:28:02 +0900
Message-ID: <20160329092802.GA17915@chikuwa.rhe.jp>
References: <CAPig+cSCC+OzotkTx89iS+t4DRd3F+QoHP4n-v_+rxXU2R+2LA@mail.gmail.com>
 <cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp>
 <1459149771-14790-1-git-send-email-k@rhe.jp>
 <CAPig+cSzTwup6ojboVkP8nMR91-ZUU9FCbAK5NcrcohfFh2taQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 11:34:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akpwq-0001QZ-Nc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 11:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbcC2J2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 05:28:08 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:53172 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbcC2J2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 05:28:06 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id D666F5C839;
	Tue, 29 Mar 2016 09:28:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPig+cSzTwup6ojboVkP8nMR91-ZUU9FCbAK5NcrcohfFh2taQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290106>

On Mon, Mar 28, 2016 at 12:51:21PM -0400, Eric Sunshine wrote:
> On Mon, Mar 28, 2016 at 3:22 AM, Kazuki Yamaguchi <k@rhe.jp> wrote:
> > When a branch is checked out by current working tree, deleting the
> > branch is forbidden. However when the branch is checked out only by
> > other working trees, deleting is allowed.
> 
> It's not quite clear from this description that it is bad for deletion
> to succeed in the second case. Perhaps:
> 
>     s/deleting is allowed/deletion incorrectly succeeds/
> 
> would make it more clear.

Thanks.

> 
> > Use find_shared_symref() to check if the branch is in use, not just
> > comparing with the current working tree's HEAD.
> 
> This version of the patch is nicer. Thanks. See a couple minor
> comments below which may or may not be worth a re-roll (you decide).
> 
> > Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> > ---
> >
> >   % git worktree list
> >   /path/to      2c3c5f2 [master]
> >   /path/to/wt   2c3c5f2 [branch-a]
> >   % git branch -d branch-a
> >   error: Cannot delete the branch 'branch-a' which is currently checked out at '/path/to/wt'
> 
> Thanks for an example of the new behavior. It's also helpful to
> reviewers if you use this space to explain what changed since the
> previous version, and to provide a link to the previous attempt, like
> this[1].
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/289413/focus=289932

I'll do from next time.

> 
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > @@ -215,16 +216,21 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
> >                 int flags = 0;
> >
> >                 strbuf_branchname(&bname, argv[i]);
> > -               if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
> > -                       error(_("Cannot delete the branch '%s' "
> > -                             "which you are currently on."), bname.buf);
> > -                       ret = 1;
> > -                       continue;
> > -               }
> > -
> >                 free(name);
> > -
> >                 name = mkpathdup(fmt, bname.buf);
> > +
> > +               if (kinds == FILTER_REFS_BRANCHES) {
> > +                       char *worktree = find_shared_symref("HEAD", name);
> > +                       if (worktree) {
> > +                               error(_("Cannot delete the branch '%s' "
> > +                                       "which is currently checked out at '%s'"),
> 
> This could be stated more concisely as:
> 
>     "Cannot delete branch '%s' checked out at '%s'"

I'll use it. Thanks.

> 
> > +                                     bname.buf, worktree);
> > +                               free(worktree);
> 
> Would it make sense to show all worktrees at which this branch is
> checked out, rather than only one, or is that not worth the effort and
> extra code ugliness?

I thought one is enough.
I think the worktrees usually won't be more than one, considering
"git worktree add" requires additional option to check out an already
checked out branch. Also, since the branch is not actually deleted at
that time, the user can safely retry after checking "git worktree list".


Thanks,

> 
> > +                               ret = 1;
> > +                               continue;
> > +                       }
> > +               }
> > +
> >                 target = resolve_ref_unsafe(name,
> >                                             RESOLVE_REF_READING
> >                                             | RESOLVE_REF_NO_RECURSE
