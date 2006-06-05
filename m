From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 04 Jun 2006 23:20:06 -0700
Message-ID: <7vhd305dk9.fsf@assigned-by-dhcp.cox.net>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	<7vodx9cm3g.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606040254n1449b62ta70c209ad8e1a0c@mail.gmail.com>
	<7vbqt9ck05.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606040333h1180bbep88fa90ea9928d062@mail.gmail.com>
	<7v3belcicq.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606040657p5c1a3dceq3eef254ab64f0e3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 08:20:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn8Rk-00088O-Cl
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 08:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWFEGUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 02:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWFEGUJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 02:20:09 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:17334 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932427AbWFEGUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 02:20:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060605062007.YDAP11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Jun 2006 02:20:07 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21312>

"Marco Costalba" <mcostalba@gmail.com> writes:

> What I understand is that git-rev-list lists _first_ the given commit,
> then his parents, then his grandparents and so on _until_ a commit
> which is stated with a preceding '{caret}'  is found.
> So everything that is between the given commit and HEAD is never found
> and ignored.

As you now know, the way it works is that it takes an unordered
set of committishes, and performs a set operation that says
"include everybody reachable from positive ones while excluding
everybody reachable from negative ones".  --topo-order tells it
to topologically (instead of doing the commit date-order which
it does by default) sort the resulting list.  The resulting list
is then written out.

> Is it a problem to change the git-rev-list behaviour to reflect (my
> understanding of) documentation or it breaks something?

I suspect it would break quite many things.  Existing users use
the command knowing it is a set operation on an unordered set of
committishes, and expect the command to behave that way.  Also
the most typical use A..B translates to ^B A (either internally
or by rev-parse) so "the first" would typically be a negative
one.

I think your "start from positive ones, traverse one by one and
stop traversal that hits the negative one" logic requires the
negative one to be directly on the traversal paths starting from
positive ones to have _any_ effect.  We often ask "what's the
ones that are still not merged to the master from the side
branch" while dealing with topic branches:

         c-------d---e master         time flows from
        /       /                     left to right
 --a---b---x---y---z side

and the way to ask that question is "rev-list master..side"
(which is "rev-list side ^master").  It should list z and not
show y nor x nor b nor a.

In order for it to be able to notice that y should not be
listed, it needs to perform traversals from negative ones as
well in order to learn that y is reachable from master.  

How would you ask the same question to the modified rev-list
that does "start from positive ones, traverse one by one and
stop traversal that hits the negative one" logic?

I think one useful thing we can do is to generalize what
"describe", "nave-rev", and "merge-base" do to have a command
that takes a committish X and a set of other committish T1..Tn,
and examines if Ti (1<=i<=n) is reachable from X and if X is
reachable from Ti (1<=i<=n), and give a short-hand to specify
the set of T for common patterns like --heads --tags and --all.

But that would not be rev-list; I suspect you would end up doing
something quite similar to what show-branch does.
