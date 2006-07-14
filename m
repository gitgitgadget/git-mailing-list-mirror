From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 11:23:46 +0100
Message-ID: <1152872626.3191.56.camel@pmac.infradead.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
	 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
	 <1152840456.31372.75.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0607132157370.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 12:24:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1KqB-0002Wd-Gu
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 12:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWGNKYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 06:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWGNKYH
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 06:24:07 -0400
Received: from canuck.infradead.org ([205.233.218.70]:58518 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964812AbWGNKYG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 06:24:06 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1G1Kq1-0007sS-Pk; Fri, 14 Jul 2006 06:24:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607132157370.5623@g5.osdl.org>
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23882>

On Thu, 2006-07-13 at 22:16 -0700, Linus Torvalds wrote:
> So to give an example, let's say we have
> 
>         HEAD  ->     A
>                     / \
>                    B   C
>                   / \   \
>                  D   E   F
>                   \ /   / \
>                    G   H  I
>                   .......
> 
> the difference between --topo-order and the default ordering for
> 
>         git rev-list HEAD
> 
> is most visible for commit 'G'.
> 
> For --topo-order, we guarantee that before we show 'G', we _will_ have 
> shown both 'D' and 'E'. In other words, --topo-ordering guarantees that it 
> shows _all_ children before it shows the parent.

Ah, OK. Then it should probably be fine. I'll talk myself through it...

We're building a parallel graph of commits, containing a _subset_ of the
commits in the master tree -- only those which touch certain files. 

For each 'interesting' commit X, we create a corresponding commit X' in
the slave tree -- we create the corresponding tree object, and we also
recursively create its parent commits -- replacing each parent in the
original commit X with the slave-tree equivalent of the closest
_interesting_ ancestor commit. It's that "closest interesting ancestor"
which we're finding with the 'rev-list --max-count-1 -- myfile'
invocation. 

The extract-khdrs-stage2.sh script is a simple example of this, and
differs from the other script mostly in the way that it creates the
_tree_ objects.

So working from your example above, and assuming that only commits I and
E actually change the files we care about. This means that merges A, B
and F are _also_ going to show up in the output of 'rev-list -- myfile'.

So the slave tree will look like this:

        A'
       / \
      B'  F'
      |   |
      E'  I'

The interesting case, if I'm trying to convince myself that my 'slave'
tree is always going to have the correct topology, is when a merge
commit is _missing_ from the rev-list output -- for example, if commits
D and E in your original tree both make the _same_ change, then I
believe that the merge commit B will no longer show up, because 'myfile'
is identical in B and in both of its parents.

In that case, we accept that the representation isn't going to be
perfect -- the left-hand parent of A' is going to appear to be _either_
D' or E', but not B'. In fact, since D' and E' are _identical_ as far as
we're concerned, it doesn't really matter which is chosen. The other one
of the two becomes an unused branch with no children -- we end up with a
graph looking like this. 

      A'
     / \
D'  E'  F'
  \/    |
        I'

... and the parent of D' and E' is the closest ancestor of G which
actually touches the files we care about, of course.

All we care about, in this case, is that the first commit listed by
rev-list is _either_ D or E, and not something further down the tree.
And that's obviously true from your description of the 'weak ordering',
so yes -- it does look like I can drop the '--topo-order'. Thanks.

(It would actually be quite nice if I _could_ find a cheap way to
include commit B' in that final example, but it's such a rare case and
it would be so expensive to do it that I don't think it's worth
pursuing.)

-- 
dwmw2
