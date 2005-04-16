From: Junio C Hamano <junkio@cox.net>
Subject: Issues with higher-order stages in dircache
Date: Sat, 16 Apr 2005 07:03:34 -0700
Message-ID: <7vll7i95u1.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<20050414121624.GZ25711@pasky.ji.cz>
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
	<Pine.LNX.4.58.0504152256520.7211@ppc970.osdl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 16:00:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMnq9-0007LU-O7
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 16:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVDPODl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 10:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVDPODl
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 10:03:41 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14826 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262662AbVDPODg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 10:03:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416140335.WXYA2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 10:03:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis2ncf8j.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 16 Apr 2005 01:12:12 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> So what's next?

Here is my current thinking on the impact your higher-order
stage dircache entries would have to the rest of the system and
how to deal with them.

 * read-tree

   - When merging two trees, i.e. "read-tree -m A B", shouldn't
     we collapse identical stage-1/2 into stage-0?

 * update-cache

   - An explicit "update-cache [--add] [--remove] path" should
     be taken as a signal from the user (or Cogito) to tell the
     dircache layer "the merge is done and here is the result".
     So just delete higher-order stages for the path and record
     the specified path at stage 0 (or remove it altogether).

   - "update-cache --refresh" should just ignore a path that has
     not been merged,  Maybe say "needs merge", just like "needs
     update" [*1*].

   - "update-cache --cacheinfo" should get an extra "stage"
     argument.  Unmerged state is typically produced by running
     "read-tree -m", but the user or Cogito can do it by hand
     with this if he wanted to.

   - I do not think we need a separate "remove the entry for
     this path at this stage" thing.  That is only necessary if
     the user or Cogito is doing things by hand (as opposed to
     "read-tree -m"), which should be a very rare case.  He can
     always do "update-cache --remove" followed by "update-cache
     --cacheinfo" to obtain the desired result if he really
     wanted to.  For that, "update-cache --force-remove" may
     come in handy.

 * show-diff

   - What should we do about unmerged paths?  Showing diffs
     between the combinations (1->2), (1->3), and (2->3) that
     exist may not be a bad idea.  It would not be confusing
     because by definition dircache with higher-order stages is
     a merge temporary directory and the user should not have a
     working file there to begin with.

     I think the current implementation does a very bad thing:
     repeating the same diff as many times as it has
     higher-order stages for the same path.

 * checkout-cache

   - When checkout-cache is run with explicit paths that are
     unmerged, what should we do?  What does that mean in the
     first place?  One use scenario I can think of is that the
     user or Cogito wants the contents at all three stages, in
     order to run a merge tool on them.  From this point of
     view, checking out all the available stages for the path
     makes sense.

     My "cunning plan" is to drop ".1-$file", ".2-$file", and
     ".3-$file" in the working directory.  How does that sound?

   - When checkout-cache -a is run, presumably the user wants to
     check out everything to verify (e.g. build-test) the
     result.  In this case, we should skip unmerged paths, give
     a warning, and check out only the merged ones.


[Footnotes]

*1* Unrelated note.  Who is the intended consumer of this "needs
    update" message?  Should we make it machine readable with
    '-z' flag as well?  Otherwise, shouldn't it go to stderr?
    Currently it goes to stdout.

