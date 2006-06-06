From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] revision limiter in git-rev-list
Date: Tue, 06 Jun 2006 03:29:37 -0700
Message-ID: <7v7j3uvapa.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550606060136l59143ef2mdb9dc68ab78e9ff1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 06 12:29:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnYog-0001ce-1y
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 12:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWFFK3j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 06:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWFFK3j
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 06:29:39 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:11946 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750815AbWFFK3i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 06:29:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606102938.ZZVF27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 06:29:38 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21372>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Of course I really ignore any implementation difficult/feasibility issues ;-)

I do not think your problem is ignoring difficulty/feasibility.
The bigger problem is ignoring to describe the semantics of what
you are proposing.

For example:

> As example, given the following revisions history:
>
> a
> b-
> | c
> | d
> e
> f
>
> We could add a new option --filtered so that
>
> git-rev-list --topo-order --filtered HEAD -- a d e
>
> Gives the following
>
> a
> b-
> | d
> e

Why does it give that?  Where is the HEAD in the example, and
how does it affect the result?  I presume when you wrote the
unfiltered graph, you meant time flows from top to bottom.  In
other words, I would have written the original graph like this,
time flowing from left to right:

          c---d
         /
    a---b---e---f

Does your rev-list given above give different results depending
on HEAD being d or f?  If so how, and for which case is the
example output produced?  If not, what significance does the
HEAD argument have in the algorithm that generates the result
you are proposing (maybe your example had time flowing from
bottom to top, then the HEAD might be at a, and you did not have
to think about this question when you wrote the message)?  These
are rhetorical questions, so do not waste time thinking about
answers to them before reading to the end of this message.

> Note that the merge point b has been added implicitly as in
> path limiter case.

I do not think path limiter case adds anything.  A merge is
shown if it touches the path in an nontrivial way, but otherwise
it isn't.  Also b is not a merge unless time is flowing from
bottom to top in your picture -- it is a fork point.

While I really do not think this belongs to rev-list, I suspect
what you want is a command that takes a set of commits you are
interested in and gives you an abbreviated topology across them.
I think it might be a good thing to have in our toolset (didn't
I say that already?).

So your example would become:

        Given this graph (and there may be other nodes before a or after
        d or f):

                  c---d
                 /
            a---b---e---f

	the user is interested in A, D, and E.  Show an
	abbreviated topology containing them.

which would give you

                  D
                 /
            A---B---E

BTW, interestingly enough if the time flowed from right to left,
the answer is the same here.

The command line would not involve HEAD unless it is also one of
the commits you are interested in.  So it would be something
like:

	git graph-reduce A D E

which would give you:

	E B
        D B
        B A

or even (since you are interested in reachability):

	E B A
        D B A
        B A

Unfortunately, your description is a bit too fuzzy to me, so I
am making guesses as to what you really want.  For example,
although you said "b is included because it is a merge", I
strongly suspect you have cases where you would want to and not
want to include a fork point or a merge point in the result,
depending on the commits you are interested in.  If you are
reducing this graph for A, H, and J:

                f---g
               /     \
              c---d---e---h
             /    
	a---b---i---j

I think you would want to see this as the result of graph
reduction:

              H
             /    
	A---B---J

instead of:

              C---E---H
             /   
        A---B---J

That is, although e is a merge and c is a fork point, they do
not bring anything interesting in the bird's eye view picture,
and are filtered out.  However, b is a point where lines of
development leading to H and J (two of the commits the user is
interested in) forks, and it is interesting.

Is this kind of graph reduction what you are after?
