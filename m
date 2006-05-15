From: Junio C Hamano <junkio@cox.net>
Subject: Re: The git newbie experience
Date: Mon, 15 May 2006 13:47:22 -0700
Message-ID: <7vhd3rhv6t.fsf@assigned-by-dhcp.cox.net>
References: <446778B8.7080201@inoi.fi>
	<7vfyjcntro.fsf@assigned-by-dhcp.cox.net> <44680C54.8040206@inoi.fi>
	<7vy7x3x3ux.fsf@assigned-by-dhcp.cox.net>
	<20060515053133.GB28068@spearce.org>
	<7v1wuvvg0j.fsf@assigned-by-dhcp.cox.net>
	<20060515164610.GA24295@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tommi Virtanen <tv@inoi.fi>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 22:47:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfjyX-000072-37
	for gcvg-git@gmane.org; Mon, 15 May 2006 22:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWEOUr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 16:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWEOUr1
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 16:47:27 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:46332 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751508AbWEOUr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 16:47:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515204724.KXWU27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 16:47:24 -0400
To: Carl Baldwin <cnb@fc.hp.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20082>

Carl Baldwin <cnb@fc.hp.com> writes:

> My implementation actually wrote the working file state into the object
> store as a tree and stored a reference to the tree under something like
> .git/refs/undo (or .git/refs/stash).  Redo was a simple merge of this
> tree back onto the current working files.
>
> I think I would like something like this better than the 'generate
> binary patch and reapply the patch later.

When you think of the "binary patch" as a human readable
representation of your (hierarchical set of) tree objects, you
would realize that these two approaches aren't that much
different at the tree merge level, and it's just a matter of
which representation is more convenient and human readable.

Pros and cons I see are:

 * Branch approach needs to teach users only one thing -- create
   a branch, merge with it, throw it away.  Which is something
   the user needs to know anyway, so it is a plus.

 * Branch approach needs to store a full postimage tree and the
   base commit (so you can use it as a merge base); the
   postimage tree includes paths that are not involved in the
   change being stashed.

 * Patch records only the object names of paths that are relevant
   to the stash.  Instead of keeping the full postimage tree, it
   creates one on the fly when you actually do the unstashing.

 * Patch is human readable and can be used for purposes other
   than falling back to a three-way merge.  When cleanly applies
   apply + write-tree is faster than a tree merge.

 * Patch could be verbose if the change being stashed is large;
   after all the primary information used are the object names
   recorded on the "index" lines and the patch text itself is a
   waste from storage point of view.  This is a disadvantage of
   the "patch" approach, but its readability might offset it.
   If a change being stashed is large, the user had better be
   doing it on a separate topic branch anyway, so this might not
   be a big issue.
