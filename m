X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add log.fulldiff config option
Date: Wed, 20 Dec 2006 02:01:35 -0800
Message-ID: <7vr6uuga2o.fsf@assigned-by-dhcp.cox.net>
References: <20061220060102.GA540@coredump.intra.peff.net>
	<7v8xh3j86h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 10:01:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v8xh3j86h.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 20 Dec 2006 00:14:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34914>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwyGb-00054V-3H for gcvg-git@gmane.org; Wed, 20 Dec
 2006 11:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964973AbWLTKBh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 05:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWLTKBh
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 05:01:37 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:40404 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964973AbWLTKBg (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 05:01:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220100136.GUTJ18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 20
 Dec 2006 05:01:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0y1o1W0041kojtg0000000; Wed, 20 Dec 2006
 05:01:48 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Your understanding needs to be clarified on how paths are
> filtered, and how log family and diff interacts, and probably
> these need to be better documented.

Having said that, I realized that I was making the same mistake
that our existing documentation was criticized for.

Let me first digress to address the documentation criticism.
The description on plumbing were (and still are) far more
thorough than porcelain-ish, and the conjecture by the person
who criticized them was because developers were keen documenting
the real work (plumbing) soon after they finished coding than
the frill (porcelain-ish).

I think the real reason for this is somewhat different.  At
least to me, git.git was about the plumbing, and I did not want
to be in the Porcelain business at all [*1*].  Instead, I wanted
to encourage healthy competition among Porcelains.  What was
shipped with git.git was meant to be "barely usable examples".
But this vision has not materialized fully yet, fortunately
because we did not end up splitting the userbase too early on.
But this was unfortunate for two reasons.  One of them is that
different Porcelains would have brought completely different
ways of thinking and workflows into the picture.

Because git.git was primarily about the plumbing, the main focus
of the interface the plumbing offers was not about integration
and uniformity but modularity.  Designing them as independent
building blocks as much as practical, and describing them fully,
were part of completing the plumbing.  And the "barely usable
examples" started their lives as a set of trivial pipelines,
whose meaning was quite obvious and straightforward when you
understand the plumbing parts used in them.  It also had UI
warts.  "barely usable examples" cheated their command line
parsing, and the flags used by the plumbing showed through its
thin veneer to the UI used by the end users.

But that was a long time ago.  Now we are in the v1.5.0 process,
whose theme is "usability and teachability".

Now, viewing in that light, what I described in the previous
message may have been a precise description of how things happen
to work currently, but it was not about the reason how and why
they were designed to be (because there was little design at the
UI level).  We should instead (or at least "in addition") be
talking more about how things ought to be.

I described why --full-diff and --pickaxe-all are different
options, you can give 4 combinations of them, and how the
combinations work differently and why.  That does not justify
that all of these four combinations make sense.  In fact, I do
not think they do.

When pickaxe is used and --full-diff is given to 'log', I think
it does not make any sense not to use --pickaxe-all.  So, I
think at the level of log family commands, unifying these two
flags make a lot of sense (although I earlier said "no").

Although --diff-filter does not have a corresponding option that
makes it behave all-or-none (i.e. an equivalent to --pickaxe-all),
it is conceivable that you might want to say:

    $ git log --diff-filter=A --full-diff --diff-filter-all

to view commits that add new files with full diffs (not just
added paths).  If we were to add that, I think it makes sense to
internally have a flag separate from pickaxe-all to express it
but when 'log' uses --full-diff, it does not make any sense not
to enable it.  In other words,

    $ git log -M --diff-filter=R -Sstring --full-diff

should internally enable pickaxe-all and diff-filter-all and
show all of diff that has renames in the paths that change
"string" [*2*].


[Footnote]

*1* I once wanted to do a Porcelain of my own, after finding it
distasteful that Cogito tried to hide the index back when it did
not even use the index properly for merges.  But things have
been improved quite a lot in Cogito land and I do not have
anything against it anymore.  And as you all know, I like StGIT
very much.

*2* This is actually in line with what we did in 582af688.  As a
member of 'log' family, 'git log' were originally meant to show
commit messages for all commits that revision traversal gave it,
regardless of the diff output (and without the diffcore
transformation, when revision traversal said a commit is
interesting, the commit always has some diff or a merge).  When
used in conjunction with --pickaxe and --diff-filter, however,
this layering made the command much less useful.  We fixed the
problem by violating the layering and made the log command aware
of the underlying diff machinery's output filter.  I think the
same would apply to the issue we are currently discussing.
