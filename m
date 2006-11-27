X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Working copy as a pseudo-head
Date: Mon, 27 Nov 2006 01:20:39 -0800
Message-ID: <7vlklxi6u0.fsf@assigned-by-dhcp.cox.net>
References: <456A9F93.1060801@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 09:20:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456A9F93.1060801@midwinter.com> (Steven Grimm's message of "Mon,
	27 Nov 2006 00:19:31 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32405>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GocfM-0006oq-Io for gcvg-git@gmane.org; Mon, 27 Nov
 2006 10:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757551AbWK0JUl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 04:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757554AbWK0JUl
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 04:20:41 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:10434 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1757551AbWK0JUk
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 04:20:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127092040.SEXW27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Mon, 27
 Nov 2006 04:20:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rlLo1V00E1kojtg0000000; Mon, 27 Nov 2006
 04:20:48 -0500
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> writes:

> Comments? Is this just nuts?

It is not "nuts", but we do not do it currently because it is a
bit too combersome to make it recoverable when things go wrong
while keeping the cost of making the necessary back-up for
recovery low.  When switching branches with local changes,
"git-checkout -m" needs to deal with a similar issue, but that
case only deal with two trees and a working tree.  To do this
for three-way merge, the conflicts you need to deal with become
more complex.

What needs to be done is very simple and straightforward.  You
first stash away the working tree state in a "virtual" tree,
then perform the usual 3-way merge using the common ancestor,
your HEAD and the other head, and come up with the merge result
without any of your changes.  Then you run another three-way
merge between the merge result and your previous working tree
state using the HEAD before the merge as the common ancestor.

       o---o---X (other head)
      /
  ---o---o---H (your head)
              \  
               W (your working tree)

==>

       o---o---X (other head)
      /         \
  ---o---o---H---M (merge between the base trees)
              \  
               W (your working tree)

==>

       o---o---X (other head)
      /         \
  ---o---o---H---M (merge between the base trees)
              \   \   
               W---W'(your working tree, updated for the merge result)

The design goal here is that you do not want to get any of your
local changes (i.e. "diff H W") to be included when you record
the result of the base merge 'M', and you would want the diff
between H and W to be forward-ported to the diff between M and
W'.

The first goal is already quite cumbersome when the merge
between X and H involve conflicing merges.  We use the working
tree to perform the file level merge (i.e. you edit them with
your favorite editor, and tell git when you are done), so while
that is happening we temporarily need to remove what was between
H and W.  If the merge is too complex and the user decides to
revert the whole thing, we would need to rewind the index and
working tree to the state at W (that means we would at least
need to stash the diff between H and index, and index and
working tree before starting the merge).

After the base merge is done, we would need to update the HEAD
to point at M.  Then we would perform the second three-way merge
between M and W using the original HEAD as their common
ancestor to come up with W'.  When this conflicts, there is no
easy way for the user to recover, other than going back to the
original state (that is, HEAD points at H and working tree is
W), even after having spent effort to merge between X and H to
produce M.

In common usage (call that "best current practice" if you may),
you do not have local changes in the working tree that would
conflict with the merge, so the current behaviour feels
cumbersome only when the safety valve kicks in.  After seeing it
fail due to the safety valve, you can do the same as what the
above pictures depict using existing tools.

 * preserve the local changes (i.e. come up with the virtual
   "W"):

	git commit -a -m WIP
	git tag -f WIP
        git reset --hard HEAD^

 * perform the merge in the now-clean tree:

	git pull ;# again from the same place
	edit edit
        test test
        git commit -a ;# resolve conflicts, test and commit

 * recover what you have preserved, and discard the virtual W:

	git pull --no-commit . WIP ;# merge in
	git reset ;# revert index to HEAD aka base merge result.
	git tag -d WIP
