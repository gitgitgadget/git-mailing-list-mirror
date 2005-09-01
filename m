From: Junio C Hamano <junkio@cox.net>
Subject: Re: Any plans to make export work?
Date: Thu, 01 Sep 2005 14:58:14 -0700
Message-ID: <7vfysowivd.fsf@assigned-by-dhcp.cox.net>
References: <200509020053.20471.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 23:58:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAx4e-0002AU-Ap
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 23:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVIAV6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 17:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbVIAV6Q
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 17:58:16 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44260 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030415AbVIAV6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2005 17:58:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050901215814.ONPI6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Sep 2005 17:58:14 -0400
To: michael@ellerman.id.au
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8002>

Michael Ellerman <michael@ellerman.id.au> writes:

> I realise I'm trying to represent a DAG as a linear series of patches. But the 
> merge order is a linear sequence of commits, and so it *should* be 
> representable as a linear series of patches. I think.
>
> Any thoughts?

All true, and more.  It does not show the initial import so you
cannot bootstrap from an emptiness.

git-export is among one of the things that were there before all
the modern core features were invented (especially git-rev-list,
let alone --merge-order flag to it) and could use an overhaul.
I would script around rev-list --merge-order and diff-tree
instead of hacking on that C code if I were doing it myself.

But we need to define what we _want_ to see first.

Here is a simple example:

         ---> B --> C --> D
       /          /
     O ---> A ---

The original O forked into branch A and B, merged at C and then
continued on to D.

What the current (admittedly ancient) 'git export' gives is:

    commit object O
    diff between void and O should be given but it doesn't.
    commit object A
    diff O A
    commit object B
    diff O B
    commit object C
    diff A C
    commit object D
    diff C D

I just noticed that diff between B and C is not shown.  Come to
think of it, this is _not_ a bug (unlike the initial import not
showing which I think is just a bug).  The purpose of export is
to give you everything that lets you recreate each tree
associated with all commits and their ancestry information, so
as long as you know C is a child of A and B, enough information
to get trees A and B, and diff between A and C, diff between B
and C is simply redundant.  So, in short, export is perfect if
we fix it to show the initial import.  It just is not designed
for doing whatever you are trying to do with its output.

To be usable in your quilt workflow, what output would we want?

Off the top of my head, I can think of this:

    commit object O
    diff between void and O
    commit object A
    diff between O and A
    commit object B
    diff between O and B
    commit object C
    diff between A and C
    diff between B and C
    commit object D
    diff between C and D

Is this what you can use?  If you can live with something like
the above, 'git whatchanged -p -m --merge-order --root' would
give you exactly that in a reverse order.  It would give you:

    commit object D
    diff between C and D
    commit object C
    diff between A and C
    diff between B and C
    commit object B
    diff between O and B
    commit object A
    diff between O and A
    commit object O
    diff between void and O

You earlier said "diff between (automerged A+B) and C", but the
former is not something git even records, so you have to compute
it yourself from the given information, if you really want it.
