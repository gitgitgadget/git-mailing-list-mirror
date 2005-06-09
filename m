From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 08 Jun 2005 19:15:15 -0700
Message-ID: <7vll5kxolo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
	<7voeag1j9y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081757170.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 04:12:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgCW0-00032d-QB
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 04:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVFICP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 22:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVFICP0
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 22:15:26 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:8099 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262126AbVFICPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 22:15:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609021514.HCEP19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Jun 2005 22:15:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506081757170.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 8 Jun 2005 18:08:44 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I think that sounds reasonable. Is it not the case now?

Well, except that $I may validly be an empty tree ;-), so not
quite.

In case it was not clear, where I am headed is this.  I would
like to rip out the two-tree "carry forward" implementation from
read-tree, and replace it with:

    read_cache() -- current goes to stage0
    read_tree(H) -- H goes to stage1
    read_tree(M) -- M goes to stage3
    for each path
        if it appears in stage0, copy it to stage2
        else if it appears in stage1, copy it to stage2
    threeway_merge() !!

And then the resulting possibly unmerged cache can be resolved
exactly the same way with merge-cache.

The trouble I feel with the current "carry forward" code is that
when it works it does sensible thing, but otherwise does not
help the end user at all.  With all the work going into making
merge-one-file-script nicer today, I think leveraging three-way
merge support for two-tree fast forward case would make a lot
more sense than keeping the all-or-nothing carry forward code I
recently added to it.

When/if that happens, then the current fast-forward code would
need to be changed from:

    read-tree -m $H $M && echo $M >.git/HEAD

to

    read-tree -m $H $M &&
    if unmerged paths in the resulting cache
    then
        merge-cache -o merge-one-file-script -a
    fi &&
    echo $M >.git/HEAD

and the user's local changes since H when fast forwarding to M
would be handled with the same workflow as the three-way case.

Hmm.

