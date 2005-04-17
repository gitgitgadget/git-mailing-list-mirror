From: Junio C Hamano <junkio@cox.net>
Subject: Summary of "read-tree -m O A B" mechanism
Date: Sun, 17 Apr 2005 03:00:22 -0700
Message-ID: <7v4qe5yb7t.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
	<7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
	<7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org>
	<7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
	<Pine.LNX.4.58.0504152256520.7211@ppc970.osdl.org>
	<7vis2ncf8j.fsf@assigned-by-dhc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 11:57:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN6Wd-0006YY-8t
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 11:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVDQKAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 06:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDQKAk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 06:00:40 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:21932 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261295AbVDQKAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 06:00:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417100023.DOWV1497.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 06:00:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vll7i95u1.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 16 Apr 2005 07:03:34 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Earlier I wrote down a list of issues your recent "merge
stage" changes have introduced to the rest of the plumbing, with
a set of suggested adaptions.  I think all of them are cleared
now (you have a pile of patches from me in your mailbox).

I do not know what percentage of people on this list are using
git without the Cogito part, but I suspect that the number might
be quite small.  I also suspect, from the description Petr gave
us on how the merging in Cogito works, Cogito does not currently
use the "read-tree -m O A B" mechanism, and those majority who
do not deal with the low level tools themselves would not have
to know about the merge issues yet.  But I think it is a good
time, now things have started to settle down, to summarize how
various commands work when they see those "funny" dircache
entries created after "read-tree -m O A B" has run.  Of course,
people working on Cogito needs to know them, once they decide to
use the "reed-tree -m O A B" mechanism.

 * read-tree -m O A B

   - For description on how this works, the definitive reading
     is [*R1*].  In short:

     - unlike ordinary read-tree, "-m" form reads up to three
       trees and creates paths that are "unmerged".  

     - trivial merges are done by read-tree itself.  only
       conflicting paths will be in unmerged state when
       read-tree returns.

 * write-tree

     - write-tree refuses to give you a tree until all the
       unmerged paths are resolved.

 * show-files

   - "show-files --unmerged" and "show-files --stage" can be
     used to examine detailed information on unmerged paths.
     For an unmerged path, instead of recording a single
     mode/SHA1 pair, the dircache records up to three such
     pairs; one from tree O in stage 1, A in stage 2, and B in
     stage 3.  This information can be used by the user (or
     Cogito) to see what should eventually be recorded at the
     path.

 * update-cache

   - An explicit "update-cache [--add] path" or "update-cache
     [--add] --cacheinfo mode SHA1 path" tells the plumbing that
     the user (or Cogito) wants to resolve it by storing
     mode/SHA1 of the given working file or mode SHA1 specified
     on the command line.  The path ceases to be in unmerged
     state after this happens.

     Similarly, "update-cache --remove path" resolves the
     unmerged state and the merge result is not having anything
     at that path.

   - "update-cache --refresh", in addition to the "needs update"
     message people are now familiar with, says "needs merge"
     for unmerged paths.

 * show-diff

   - show-diff on an unmerged path simply says "unmerged" (the
     plumbing would not know what to diff with what among three
     stages and the working file).  

 * checkout-cache

   - "checkout-cache -a" warns about unmerged paths and checks
     out only the merged paths.

   - "checkout-cache [-f] path" on an unmerged path says
     "Unmerged", just like the same command on non-existent path
     says "not in the cache", and does not touch the working
     file.
 

I hope the descriptions in this summary is correct enough to be
useful to somebody.


[Reference]

*R1* http://marc.theaimsgroup.com/?l=git&m=111363270608902&w=2

