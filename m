From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Tue, 28 Mar 2006 19:58:15 -0800
Message-ID: <7vlkutc36w.fsf@assigned-by-dhcp.cox.net>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
	<Pine.LNX.4.64.0603281749060.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 05:58:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FORp9-0003ep-11
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 05:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWC2D6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 22:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWC2D6T
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 22:58:19 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:56729 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750763AbWC2D6T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 22:58:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060329035817.PLVH26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 22:58:17 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603281749060.15714@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 28 Mar 2006 18:10:46 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18158>

Linus Torvalds <torvalds@osdl.org> writes:

>   Personally, I think the rebase syntax sucks, because the _natural_ way 
>   to do it is to just describe the set of commits to rebase the same way 
>   we describe all _other_ commit sets: as a "begin..end" sequence.

I'd agree in general, and I am not happy about them.

But I have an excuse.

rev-parse's A..B notation was invented on June 13th (178cb24).
But format-patch was originally posted on May 30th:

	http://article.gmane.org/gmane.comp.version-control.git/4279

before the convenience of rev-parse was invented ;-).

>   So I think rebase _should_ work something like this:
>
> 	git rebase origin.. [--onto] linus
>
>   ie just giving an arbitrary range.

In addition, both rebase and format-patch does a bit more than
straight his..mine.

    *---x---x---o---o---o---o
     \                      ^mine
      .---.---.---.
                  ^his

We do _not_ want to process all six of his..mine commits when
doing "format-patch his mine" in the above picture, because
upstream might have accepted some of them already, and we filter
them out with git-cherry.  

>   This is even more noticeable for "git-format-patch", where
>   that insane "<his> [<mine>]" syntax is even worse, for no
>   good reason, when again it should really just work like "git
>   diff" where giving a single revision implies a single
>   revision, and giving a range implies a range, and no strange
>   "mine" vs "his" rules ]

Having said that, you have been able to say format-patch A..B
C..D E..F for quite some time (since November 21, 2005).

Rebase is even more strange, especially with --onto.  When you do

    $ rebase --onto his origin mine

in this picture,

    *---x---x---o---o---o---o
     \      ^origin         ^mine
      .---.---.---.
                  ^his

you are discarding two 'x' commits, and lost-found is the only
thing that would help you to recover them.

Unlike format-patch which takes ranges, rebase does not let you
say "rebase --onto base A..B C..D E..F"; what happens might be
too confusing, especially if B, D, F are not coming from the
current branch.  The current branch is rewound to base and then
the chosen sets of patches are applied, which is kind-of scary.
It would feel safer to do:

	$ git checkout -b newbranch base
        $ git format-patch --stdout A..B C..D E..F | git am -3

and after making sure the result is really what you want
resetting the original branch to the current (newbranch) head.
