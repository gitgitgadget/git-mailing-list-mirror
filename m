From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's new in git.git master branch
Date: Thu, 01 Dec 2005 01:38:47 -0800
Message-ID: <7vmzjljgwo.fsf@assigned-by-dhcp.cox.net>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
	<20051201085433.GA7866@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 10:39:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehktx-0003F1-Fv
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 10:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVLAJiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 04:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVLAJiu
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 04:38:50 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:2214 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932116AbVLAJit (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 04:38:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201093814.POWF15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 04:38:14 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051201085433.GA7866@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Thu, 1 Dec 2005 09:54:33 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13044>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> It turns out that this change breaks the directory/file conflict
> handling in git-merge-recursive.
>
>    git-ls-tree -r -z <tree SHA1>
>
> Should we do it that way or should ls-tree be changed?

Ouch.  Sorry, I should have been more careful.  For this
particular one, I think updating merge-recursive is less work,
so for now I'd vote for that approach.  However, as you might
already be aware, I am not convinced that the new behaviour is
better than the previous round (there is no question about the
implementation quality and the clean-up value the rewrite
brings), so we might want to also add the "show tree entry in
recursive cases too" option to ls-tree as well.  What I am
saying is essentially, "why not do both?" ;-).

I was looking at the merge-recursive, and there is another topic
I wanted to discuss with you about.  Conflicts in renaming
merges and index collapsing.  The latest merge-one-file leaves
index entries uncollapsed when the file content changes cannot
be automerged, and I think we would want to match that in
merge-recursive.  When there is no rename involved it can do the
same thing as merge-one-file does -- just leave the index
unmerged.  Renaming case is different.

Currently, rename result is recorded by using "git-update-index
--cacheinfo" to populate the index.  This method unfortunately
can only create a stage0 entry.  We can go two ways.  One way is
to support "register this mode/sha1 tuple at stageN for path" to
update-index.  Another would be for merge-recursive to first
construct three trees with the final directory structure
(i.e. prepare three temporary trees with renames applied) and
run read-tree 3-way merge on these temporary trees.  I suspect
the former is probably of lesser impact.  Thoughts?

Also I think I broke the case where base trees need to be merged
in 58cce8a8 commit (I changed processEntry not to collapse the
index entry when file content changes cannot be automerged, but
that change has to be done only for the final merge, and merges
between base trees must collapse to be able to write the index
file out as a tree).
