From: Kazuki Yamaguchi <k@rhe.jp>
Subject: Re: [PATCH v3 1/2] refs: add a new function set_worktree_head_symref
Date: Fri, 8 Apr 2016 15:37:13 +0900
Message-ID: <20160408063713.GA17696@chikuwa.rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp>
 <cover.1459087958.git.k@rhe.jp>
 <39bc3c1da6daf31f2a10e592dbb5d3daadc96199.1459087958.git.k@rhe.jp>
 <CAPig+cQym57U-izza5_Hn0xCDcG0MHFMcWJFc==ohKnr7acFWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 08:37:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQ2o-0004om-Ue
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 08:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757832AbcDHGhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:37:20 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:41278 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756998AbcDHGhS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:37:18 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 5B03761753;
	Fri,  8 Apr 2016 06:37:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPig+cQym57U-izza5_Hn0xCDcG0MHFMcWJFc==ohKnr7acFWQ@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290998>

On Thu, Apr 07, 2016 at 05:20:10PM -0400, Eric Sunshine wrote:
> On Sun, Mar 27, 2016 at 10:37 AM, Kazuki Yamaguchi <k@rhe.jp> wrote:
> > Add a new function set_worktree_head_symref, to update HEAD symref for
> > the specified worktree.
> >
> > To update HEAD of a linked working tree,
> > create_symref("worktrees/$work_tree/HEAD", "refs/heads/$branch", msg)
> > could be used. However when it comes to updating HEAD of the main
> > working tree, it is unusable because it uses $GIT_DIR for
> > worktree-specific symrefs (HEAD).
> >
> > The new function takes git_dir (real directory) as an argument, and
> > updates HEAD of the working tree. This function will be used when
> > renaming a branch.
> >
> > Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> > ---
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > @@ -2894,6 +2894,41 @@ int create_symref(const char *refname, const char *target, const char *logmsg)
> > +int set_worktree_head_symref(const char *gitdir, const char *target)
> > +{
> > +       static struct lock_file head_lock;
> > +       struct ref_lock *lock;
> > +       struct strbuf err = STRBUF_INIT;
> > +       struct strbuf head_path = STRBUF_INIT;
> > +       const char *head_rel;
> > +       int ret;
> > +
> > +       strbuf_addf(&head_path, "%s/HEAD", absolute_path(gitdir));
> > +       if (hold_lock_file_for_update(&head_lock, head_path.buf,
> > +                                     LOCK_NO_DEREF) < 0) {
> > +               error("%s", err.buf);
> 
> 'err' has not been populated at this point, so I suspect that this
> error message is likely to be rather uninformative.

Yes, unable_to_lock_message() is missing. Thank you for pointing it out.

> 
> > +               strbuf_release(&err);
> > +               strbuf_release(&head_path);
> > +               return -1;
> > +       }
> > +
> > +       /* head_rel will be "HEAD" for the main tree, "worktrees/wt/HEAD" for
> > +          linked trees */
> > +       head_rel = remove_leading_path(head_path.buf,
> > +                                      absolute_path(get_git_common_dir()));
> > +       /* to make use of create_symref_locked(), initialize ref_lock */
> > +       lock = xcalloc(1, sizeof(struct ref_lock));
> > +       lock->lk = &head_lock;
> > +       lock->ref_name = xstrdup(head_rel);
> > +       lock->orig_ref_name = xstrdup(head_rel);
> > +
> > +       ret = create_symref_locked(lock, head_rel, target, NULL);
> > +
> > +       unlock_ref(lock); /* will free lock */
> > +       strbuf_release(&head_path);
> > +       return ret;
> > +}
> > +
