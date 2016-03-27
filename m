From: Kazuki Yamaguchi <k@rhe.jp>
Subject: Re: [PATCH v2 0/5] branch: fix branch operations with multiple
 working trees
Date: Sun, 27 Mar 2016 16:29:42 +0900
Message-ID: <20160327072942.GA13750@chikuwa.rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp>
 <cover.1458927521.git.k@rhe.jp>
 <xmqqzitm1ct8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 09:29:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak58x-00073Z-71
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 09:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbcC0H3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 03:29:47 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:54706 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbcC0H3q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 03:29:46 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id B943D5B737;
	Sun, 27 Mar 2016 07:29:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqzitm1ct8.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289998>

On Fri, Mar 25, 2016 at 02:13:07PM -0700, Junio C Hamano wrote:
> Kazuki Yamaguchi <k@rhe.jp> writes:
> 
> > [1/5]
> > Adds RESOLVE_REF_COMMON_DIR to resolve_ref_unsafe(). The second - fourth
> > patch depend on this. At the same time, this allows us to remove
> > reimplementation of resolve_ref_unsafe() in worktree.c: parse_ref().
> >
> > [2/5]
> > Adds REF_COMMON_DIR flag to lock_ref_sha1_basic().
> 
> While the code reduction in 1/5 is a very good and welcome change,
> these new flags make me wonder if they can be easily misused in a
> way that contradicts with what other parts of the system (e.g.
> path.c::common_list[]) tell us.  Am I worried too much without a
> good reason?
> 

Umm...
Certainly I can't come up with other use cases of there flags,
especially the latter one.
I'll reconsider.

> > [3/5]
> > Adds create_symref_common_dir(). Same as create_symref() except it
> > doesn't consider $GIT_DIR. create_symref_common_dir("HEAD", some) always
> > updates .git/HEAD. The next patch uses this.
> 
> Similarly, would this allow updating "refs/remotes/origin/HEAD"
> (which is also a symbolic ref) to different values for different
> worktrees?  In other words, I am wondering if this new function
> should be narrower in scope--e.g. used only to update "HEAD" and
> no other symbolic refs.  Or will the additional flexibility be
> useful?
> 

For non-per-worktree ref names, create_symref_common_dir() and
create_symref() should work in the same way.
But yes, as far as I know, there is no other chance to update other
worktree's per-worktree symrefs.

How about like this (will update per-worktree-gitdir/HEAD):
set_worktree_head_symref("per-worktree-gitdir", "refs/heads/master")

Thanks, 

> > [4/5]
> > Fixes the issue of git branch -m.
> > The behavior when one failed has changed from v1: print an error and
> > continue.
> >
> >   % git branch -m oldname newname
> >   error: Unable to create '/path/to/.git/worktrees/wt/HEAD.lock': Permission denied
> >   error: HEAD of working tree /path/to/wt is not updated.
> >   error: Unable to create '/path/to/.git/worktrees/wt2/HEAD.lock': Permission denied
> >   error: HEAD of working tree /path/to/wt2 is not updated.
> >   fatal: Branch renamed to newname, but HEAD is not updated!
> 
> Sounds like a good goal.
