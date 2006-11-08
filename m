X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's the meaning of `parenthood' in git commits?
Date: Tue, 07 Nov 2006 17:13:13 -0800
Message-ID: <7vy7qmyc46.fsf@assigned-by-dhcp.cox.net>
References: <878ximbwm3.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 01:13:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <878ximbwm3.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of
	"Wed, 08 Nov 2006 00:39:00 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31107>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghc0U-00007N-NQ for gcvg-git@gmane.org; Wed, 08 Nov
 2006 02:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753255AbWKHBNP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 20:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbWKHBNP
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 20:13:15 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:31712 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1753255AbWKHBNO
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 20:13:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061108011314.EHWX13632.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Tue, 7
 Nov 2006 20:13:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id k1Cq1V00V1kojtg0000000; Tue, 07 Nov 2006
 20:12:51 -0500
To: Nix <nix@esperi.org.uk>
Sender: git-owner@vger.kernel.org

Nix <nix@esperi.org.uk> writes:

> The idea being that if you have a tree like this:
>
>      B
> ------------- ref trunks/latest
>      \
>       ------ ref heads/some-change-foo
>
>  ... -------- ref trunks/old-and-grotty
>
>
> then this merge strategy, when asked to merge heads/some-change-foo into
> trunks/old-and-grotty would spot that point B was the most recent
> merge point into anything in trunks/, generate a diff between point B
> and heads/some-change-foo, and patch it into trunks/old-and-grotty.

This is a standard "cherry-picking" practice.

> After all that setup, my question's simple. Does a `parent' in git
> terminology simply mean `this commit was derived in some way from the
> commit listed here'?

When you think about commit ancestry, think of it this way:

   These commits I list as its parents of this new commit, and
   everything that leads to them, are what I considered when
   derived this commit.  This new child commit of them suits the
   purpose of _my_ branch better than any of these parent
   commits I took into consideration because of such and such
   reasons that I stated in its commit log message.

If you mark the resulting commit on old-and-grotty to have
some-change-foo as one of its parents, because some-change-foo
has almost everything 'latest' has (up to point B), you are also
saying "I have considered everything that happened between
old-and-grotty and B when making this commit".

What's implied by that statement is this, even though you do not
explicitly say:

   I reject everything that happened on the development line
   that led to 'latest' up to point B since old-and-grotty was
   forked.

This is not necessarily a bad thing, by the way.  For somebody
who is trying to maintain extremely-stable branch by cherry
picking only changes in a few narrow areas from the mainline
would _want_ to leave most of the "new good stuff" out from his
branch.  That's why I emphasized _my_ a few paragraphs above.

But it is _so_ different from the mindset of usual "every branch
makes progress _forward_ perhaps with different pace".  In this
example, this branch is actively choosing to stay behind and
refusing to take changes from the 'latest'.  So your users need
to really understand what they are doing.  For example, if there
is another topic forked off of B (or at a later commit from
there that leads to 'latest'), after your "funny merge" took
place, even the usual merge strategies would work as expected by
you --- it would still ignore the changes up to B because you
told git to do so.

Also, if you make a good change on top of the resulting merge
that _should_ be applicable to some-change-foo which is based on
the 'latest', you cannot merge that back in the usual way.
Usual git merge will find your first "funny merge" as the merge
base, and because it chooses to reject everything leading to B,
the merge result would look very similar to the set of changes
based on old-and-grotty.  Actually, that would even fast forward
to the version you made into a phony "merge" out of the
cherry-picked result.

But that is at least consistent with the statement you made when
you created that commit.  Staying behind at old-and-grotty
suited _your_ branch'es purpose better than being based on
'latest'.  And a person who is merging _your_ branch into
some-change-foo, by choosing to merge that branch into the
latter, is choosing to share your branch'es purpose, so it is
natural a lot of the "good things" that happened up to B is
rewound by that merge.

So I think as long as you and your users understand what is
going on, I do not see a problem at either the mechanical level
or the philosophical level.  But I am sure it would confuse a
lot of people, so please do not come back complaining that you
ended up getting your users heads explode ;-).


