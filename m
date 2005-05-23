From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 17:35:51 -0700
Message-ID: <7vu0kubwyg.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
	<20050522184237.GG18500@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org>
	<7v64xbdq4y.fsf@assigned-by-dhcp.cox.net>
	<7vy8a7cavf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221259110.2307@ppc970.osdl.org>
	<7vis1adfvq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221611020.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 02:35:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da0uJ-0002K8-1G
	for gcvg-git@gmane.org; Mon, 23 May 2005 02:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVEWAgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 20:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVEWAgG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 20:36:06 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:51599 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261825AbVEWAfx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 20:35:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523003553.AEZ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 20:35:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505221611020.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 22 May 2005 16:14:23 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> You seem to think that it's a feature that you can't get the same output 
LT> out of git-diff-helper, and I think that's not a feature, but a total bug.

I do agree that it is a real problem.

And I think you've filled some holes in the idea I originally
had while working on the following (the part you omitted from
the quote):

    ...  Unfortunately, the current diffcore interface does not
    let the callers (diff-tree family) to tell it to keep the
    "stay" entries in its output.  I've been working on that
    part this morning before this discussion started, so that
    electively they can tell the diffcore layer not to do the
    "stay" pruning ("stay pruning" will simply become another
    diffcore transformation).

The change I am making right now is essentially what the above
paragraph says, with your "hole-filling", to do something like
this:

 (1) diff-tree family feeds unmodified entries to the diffcore,
     in addition to changes.  diffcore-rename matches and merges
     them into rename/copy; diffcore-pickaxe filters; other
     diffcore transformations may later be written (e.g
     reordering the patch so that .h files come first before .c
     files).  The result of the sequence of these
     transformations is fed to the diff_flush() for output.
     Essentially this is the same architecture as we already
     have.

 (2) diff_flush() currently prunes _all_ the unmodified entries
     just before output happens.  This is a _bug_ as you said.
     To fix this, first, separate that pruning part (which is
     currently embedded in diff_flush_one as the first
     statement) out, so this pruning happens independently and
     before diff_flush() happens; and make the pruning more
     careful, not to prune entries that we _need_ to express
     rename/copy distinction in diff-raw output.  Namely, it
     should keep the unmodified entry for a path _if_ the path
     is to be used as the source of a rename or copy entry.
     Also diff-patch output needs to be taught to take notice
     and ignore such entries.

     Optionally, the callers may want to tell diffcore not to do
     _any_ pruning, making diff-raw output similar to a merge of
     ls-files --stage outputs of two trees.

LT> I'm arguing that we should consider it a _requirement_ that "raw diffs" 
LT> can be translated into te same thing the "-p" flag internally does.

To this, I 100% agree, and I think it is doable.  Give me a bit
more time for testing and tweaking.

