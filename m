From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: sending changesets from the middle of a git tree
Date: Mon, 15 Aug 2005 10:27:23 +0100
Message-ID: <tnxiry77dok.fsf@arm.com>
References: <42FEBC16.9050309@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 11:28:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4bGf-0002v0-Fu
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 11:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVHOJ2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 05:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVHOJ2Y
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 05:28:24 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:41194 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932335AbVHOJ2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 05:28:24 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j7F9RCOU019838;
	Mon, 15 Aug 2005 10:27:17 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA18395;
	Mon, 15 Aug 2005 10:27:56 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 15 Aug 2005 10:27:55 +0100
To: Steve French <smfrench@austin.rr.com>
In-Reply-To: <42FEBC16.9050309@austin.rr.com> (Steve French's message of
 "Sat, 13 Aug 2005 22:35:50 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 15 Aug 2005 09:27:55.0796 (UTC) FILETIME=[9E3FD540:01C5A17B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

There are other ways to do these, explained in this thread. I will
only show the StGIT way, just choose which one suits you better.

Steve French <smfrench@austin.rr.com> wrote:
> 1) There is no way to send a particular changeset from the "middle"
> of a set from one tree to another, without exporting it as a patch
> or rebuilding a new git tree.  I have two changesets that, after
> testing last week, I now consider more important to send upstream
> than the few earlier and later changesets.

With StGIT, you create a new patch ('stg new <name>'), modify and
commit the changes with 'stg refresh'. All the modifications to a
patch are stored as a single GIT commit. If you manage a (contributor)
tree with StGIT, you shouldn't commit changes directly with GIT but
use the StGIT commands instead. You end up with a stack of changesets
on top of the main tree.

You can send the changesets upstream with the 'stg mail' command or
export them with 'stg export'.

> If I export those two changesets as patches, and send them
> on. presumably I lose the changset comments etc. and then when the
> upstream tree is merged back, it might look a little odd in the
> changeset history.

Pulling the latest changes from the main tree will keep your changes
on top, much like git cherry/rebase, but StGIT does a diff3 merge
instead of simply generating and applying patch. This has the
advantage of detecting when a patch (changeset) was not fully merged
or was modifed. If the upstream merge was complete, StGIT shows your
patch as empty (since your patch no longer needs to change the
tree). Otherwise, you can either have some changes in the patch or
even be notified of a conflict (patch modified before being merged).

> 2) There is no way to update the comment field of a changeset after
> it goes in (e.g. to add a bugzilla bug number for a bug that was
> opened just after the fix went in).

'stg refresh --edit' lets you modify the patch text. Since the GIT
commits are immutable, a new commit is generated but the parent of the
new commit is the same as the parent of the old commit (making this
commit unaccessible). Being able to create your own DAG structure with
GIT is what made StGIT possible.

> 3) There is no way to do a test commit of an individual changeset
> against a specified tree (to make sure it would still merge cleanly,
> automatically).

With StGIT you can pop all the patches from the stack and only push
the one you want to test (the push/pop operations also allow patch
reordering). Note that the push operation is done with a three-way
merge and, if successful, the patch might have a sligthly different
form (different offsets for example, or even chunks removed if they
are already in the tree).

If the push fails, it means that it doesn't apply cleanly because it
depends on changes made by other patches in your series. You can undo
the push operation with 'stg push --undo'.

-- 
Catalin
