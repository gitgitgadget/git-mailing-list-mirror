From: Junio C Hamano <junkio@cox.net>
Subject: Now I think I am done with diff...
Date: Sun, 22 May 2005 23:50:34 -0700
Message-ID: <7vmzqm77wl.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
	<7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211004400.2206@ppc970.osdl.org>
	<7v4qcwihu1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 08:50:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da6kq-0007sk-QG
	for gcvg-git@gmane.org; Mon, 23 May 2005 08:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVEWGuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 02:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVEWGuu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 02:50:50 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:16120 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261841AbVEWGug (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 02:50:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523065034.EHAE7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 02:50:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v4qcwihu1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 10:56:06 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "I" == Junio C Hamano <junkio@cox.net> said:

JCH> Now I think I am done with diff,...

I think I have fixed the diff-raw output routine enough to
address the rename and copy distinction issues (although I chose
not to give individual entries "this is a copy" or "this is a
rename" indicators).

And I thought I was really done with diff this time, but here
are some leftover issues I would like to further address, not
necessarily in this order, and not necessarily promising to do
all of them.

 - Make "diff-raw human readable" output quite different from
   "diff-raw machine readable" format.  I think human readable
   format should be more like "concise version of diff-patch
   format for human consumption", not the current "LF and TAB
   separated version of machine readable output", to enhance
   readability.  This includes:

   (1) not repeating paths when src and dst are the same
       (i.e. most of the time);

   (2) substituting src/dst with /dev/null when talking about
       creation or deletion;

   (3) prefixing the src and dst with '+' or '*' or '-'.

   Currently I do not intend to add _parsing_ of such output to
   diff-helper because you can always use -z on both ends of the
   pipe (and as yourself said "Sure. Although I doubt people use
   the raw diff output except to (a) feed to diff-helper or (b)
   check that it's non-empty."), but I have to sleep on this.

 - Add an option to cause diff-tree three-brothers not to call
   diffcore_prune() at all.  This will essentially produce
   something like a merge of two output from ls-files or
   ls-trees commands, but with renames/copies resolved.  I do
   not know how useful this would be, especially now the
   immediate problem of diff_flush() pruning all the
   "non-change" entries is (hopefully) fixed.

 - Give pickaxe an option to cause it to produce diffs for the
   entire commit, not just the found file.

 - Experiment with the patch reordering I talked about in the
   previous message.

 - Add the support of "copied from post-edit image" detection in
   rename/copy logic.  Currently I compare only with pre-edit
   image for modified files.

 - Read and understand the patch-delta.c, to make rename/copy
   similarity estimator more accurate.  As you pointed out, it
   does very bad things on big consecutive deletes.

 - Think about performance issues around "diff-tree -C" stuff.

 - Think more about the problem with the patch output between
   two symbolic links, and how to fix it (I've been quietly
   thinking about this for some time ;-)).  I think the current
   output of just comparing the two readlink results and
   generating a normal diff between them is broken and hazardous
   if such a thing is mistakenly fed to patch -p1.

 - Teach JIT about the diff-raw format changes.

