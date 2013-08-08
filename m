From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over unneeded objects
Date: Thu, 8 Aug 2013 11:50:55 +0700
Message-ID: <CACsJy8CP6pGRwEn6H=cbKxTMuOjzAF3=Qh8qsLbJaw6feK3NMw@mail.gmail.com>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Matthijs Kooijman <matthijs@stdin.nl>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 08 06:51:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7ICB-0001R5-5Y
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 06:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab3HHEv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 00:51:27 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:53902 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271Ab3HHEv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 00:51:26 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so2702071pbb.13
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 21:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=vm23/YAXnTcMMzHRkufgblqx4XN8wh3IgksGwpCXQcc=;
        b=HCJLJe8SrpZgw++zW035J5XK470cBdjLWEhV65EBkOsofiWAkxmCQPqEi4WTvFHxfq
         4WqyTT/3woIqLPSomYomokX9lKu0mWOZf/RsxHR58mbq9mgIrEwo4LBCIq8G8QL0EUCY
         1zZ6aO4sceqpwN3+4KS51uvthR4lwsCMShpYKgM+qRcqQbMI0TUy2mE/qVfsoDJncI27
         5Ov2RoPgU7fGud8uumk/dR8HWATCvftutJfuEQoFBht9jT/W5rOAY43eBzHKVZzE87BA
         QzpUoYAgZSVHlEDAxuBpPpryWz3X+3oVxZnug88sjLIwrIpcJVINta0s4I3/Y9Jguy8z
         1TNA==
X-Received: by 10.66.26.112 with SMTP id k16mr4058009pag.65.1375937485929;
 Wed, 07 Aug 2013 21:51:25 -0700 (PDT)
Received: by 10.70.102.163 with HTTP; Wed, 7 Aug 2013 21:50:55 -0700 (PDT)
In-Reply-To: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231861>

On Fri, Jul 12, 2013 at 5:01 AM, Matthijs Kooijman <matthijs@stdin.nl> wrote:
> Hi folks,
>
> while playing with shallow fetches, I've found that in some
> circumstances running git fetch with --depth can return too many objects
> (in particular, _all_ the objects for the requested revisions are
> returned, even when some of those objects are already known to the
> client).
>
> This happens when a client issues a fetch with a depth bigger or equal
> to the number of commits the server is ahead of the client. In this
> case, the revisions to be sent over will be completely detached from any
> revisions the client already has (history-wise), causing the server to
> effectively ignore all objects the client has (as advertised using its
> have lines) and just send over _all_ objects (needed for the revisions
> it is sending over).
>
> I've traced this down to the way do_rev_list in upload-pack.c works. If
> I've poured over the code enough to understand it, this is what happens:
>  - The new shallow roots are made into graft points without parents.
>  - The "want" commits are added to the pending list (revs->pending)
>  - The "have" commits are marked uninteresting and added to the pending list
>  - prepare_revision_walk is called, which adds everything from the
>    pending list into the commmit list (revs->commits)
>  - limit_list is called, which traverses the history of each interesting
>    commit in the commit list (i.e., all want revisions), up to excluding
>    the first uninteresting commit (i.e. a have revision). The result of
>    this is the new commit list.
>
>    This means the commit list now contains all commits that the client
>    wants, up to (excluding) any commits he already has or up to
>    (including) any (new) shallow roots.
>  - mark_edges_uninteresting is called, which marks the tree of every
>    parent of each edge in the commit list as uninteresting (in practice,
>    this marks the tree of each uninteresting parent, since those are by
>    definition the only kinds of revisions that can be beyond the edge).
>  - All trees and blobs that are referenced by trees in the commit list
>    but are not marked as uninteresting, are passed to git-pack-objects
>    to put into the pack.
>
> Normally, the list of commits to send over is connected to the
> client's existing commits (which are marked as uninteresting). This
> means that only the trees of those uninteresting ("have") commits that
> are actually (direct) predecessors of the commits to send over are
> marked as uninteresting. This is probably useful, since it prevents
> having to go over all trees the client has (for other branches, for
> example) and instead limits to the trees that are the most likely to
> contain duplicate (or similar, for delta-ing) objects.
>
> However, in the "detached shallow fetch" case, this assumption is no
> longer valid. There will be no uninteresting commits as parents for
> the commit list, since all edge commits will be shallow roots (hence
> have no parents).  Ideally, one would find out which of the "detached"
> "have" revisions are the closest to the new shallow roots, but with the
> current code these shallow roots have their parents cut off long before
> this code even runs, so this is probably not feasible.

I think this applies to general case as well, not just shallow.
Imagine I have a disconnected commit that points to the latest tree
(i.e. it contains most of latest changes). Because it's disconnected,
it'll be ignored by the server side. But if the servide side does
mark_tree_interesting on this commit, a bunch of blobs might be
excluded from sending. I used to (ab)use git and store a bunch of tags
point to trees. These trees share a lot. Still, fetching a new tag
means pulling all objects of the new tree even though it only needs a
few new blobs and trees. So perhaps we could go over have_obj list
again, if it's not processed and is

 - a tree-ish, mark_tree_uninteresting
 - a blob, just mark unintesting

and this does regardless of shallow state or edges. The only downside
is mark_tree_uninteresting is recursive so in unpacks lots of trees if
have_obj is long, or the worktree is really big. Commit bitmap should
help reduce the cost if have_obj is a committish, at least.
-- 
Duy
