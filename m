X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Two conceptually distinct commit commands
Date: Wed, 06 Dec 2006 10:31:21 -0800
Message-ID: <7virgo511i.fsf@assigned-by-dhcp.cox.net>
References: <87d56z32e1.wl%cworth@cworth.org>
	<7vejrdbzdb.fsf@assigned-by-dhcp.cox.net>
	<874ps91v79.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 18:31:38 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33503>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs1YE-0000nk-KU for gcvg-git@gmane.org; Wed, 06 Dec
 2006 19:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937058AbWLFSbY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 13:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937061AbWLFSbX
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 13:31:23 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36078 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937058AbWLFSbX (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 13:31:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206183122.WKOT4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Wed, 6
 Dec 2006 13:31:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vWXY1V00H1kojtg0000000; Wed, 06 Dec 2006
 13:31:32 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> ... Even if this functionality
> weren't made available at all, I'd still be interested in your
> comments on the main thrust of my proposal. I think that consists of:
>
> 	1. Unifying the two current commands that provide
> 	   commit-working-tree-content semantics into a single,
> 	   use-oriented description.
>
> 	2. Avoiding a change of semantics triggered by merely applying
> 	   pathname arguments without any command-line option or
> 	   alternate command name.

I am not sure what needs to be commented on at this point, since
it is not yet clear to me where you want your proposal to lead
us.

I do not agree with your "three commands" or "two semantics"
characterization of the current way "git commit" works.  "git
commit" without any optional argument already acts as if a
sensible default arguments are given, that is "no funny business
with additional paths, commit just what the user has staged
already."

"git commit" is primarily about committing what has been staged
in the index, and "--all" is just a type-saver short-hand (just
like "--include" is) to perform update-index the last minute and
nothing more.  In other words, "--all" is a variant of the
pathname-less form "git commit".  It is not a variant of "git
commit --only paths..." form, as you characterized.

The pathname form (the "--only" variant) on the surface seem to
work differently, but when you think about it, it is not all
that different from the normal commit.  We explain that it
ignores index, but in the bigger picture, it does not really.

In this sequence:

	edit a b
	git update-index a
	git commit --only b
	git commit --all

the first commit does "jump" the changes already made to the
index, but after it makes the commit, the index has the same
contents as if you did "git update-index a b" where you ran that
"git commit".  In other words, it is just a handy short-hand to
pretend as if you did the above sequence in this order instead:

	edit a b
        git update-index b
        git commit
        git update-index a
        git commit

So I actually think it is a mistake to stress the fact that "git
commit --only paths..." seems to act differently from the normal
"git commit" too much.  It just helps to split the changes in
your working tree if the changes happen to be cleanly separable
at file boundaries (aka "CVS mentality").  When the changes are
not cleanly separable at file boundaries, the "more painfully
index aware" variant also allows you to split the changes in
your working tree in the time dimension:

        edit a
	git update-index a
        edit a
        git commit ;# without paths
	git update-index a
        git commit

In short, while I understand that your "proposal" shows your own
way to summarize the semantics of "git commit", I am not seeing
what it buys us, and I do not see the need to come up with a
pair of new two commands for making commits (if that is what the
proposal is about, that is, but it is not clear to me if that is
what you are driving at).  I think it would only confuse users.

> 	I receive a patch while I'm in the middle of doing other work,
> 	(but with a clean index compared to HEAD, which is what I've
> 	usually). The patch looks good, so I want to commit it right
> 	away, but I do want to separate it into two or more pieces,
> 	(commonly this is because I want to separate the "add a test
> 	case demonstrating a bug" part from the "fix the bug"
> 	part).
> ...
> Who said I wouldn't test it? I do split commits like this precisely so
> that I _can_ test it this way---and git helps a lot here. I do the
> split commit, then easily back up to the revision that adds the test
> case, verify the test fails before the bug fix, (which is something
> the maintainer doesn't get a chance to do with your (2) approach),
> then move forward and verify that the test passes after the fix.
>
> So, sure, I haven't ever had that working tree before the commit. But
> git makes it easy to get that working tree after I commit and test
> everything before I push anything out.

You saw a good patch in the middle of something that you did not
want to lose your working tree changes for.  That good patch was
not really good enough to be applied straight into your tree but
needed tweaking and splitting.  Nevertheless you went ahead and
made two commits out of that patch, even though you were in the
middle of something.  You could not test them right away after
committing because your tree was in no shape to test them in
isolation.  But that is excusable because you would not push
these commits out right away, before you have a chance to test
them by rewinding your working tree when you are done with what
you were originally doing.

Is it just me who finds the above a very much made-up example?

It means the patch (which is good and not good at the same time)
was not all that urgent after all, and it could well have waited
until you are done with what you were originally doing.

In any case, I should clarify my aversion to partial commits a
bit.  What is more important is to notice that, while you cannot
compile-and-run test what is in the index in isolation (without
a fuse that exports the index contents as a virtual filesystem
-- anybody interested?), you _can_ preview and verify the text
that is going to be committed by comparing the index and the
HEAD.  And for that, your "staging" action (i.e. Nico's "git
add") needs to be a separate step from your "committing" action.

In other words, I would even love Johannes's "per hunk commit"
idea, at least if it had an option to preview the whole thing
just one more time before committing, and I would love it better
if it had an option for not committing but just updating.  You
could:

	$ edit foo bar
	: the whole mess in working tree is in no shape to be committed.
        $ git add foo	;# stage the state of the entire file
        $ git hunk-add bar ;# go interactive and update index selectively
	$ git status -v	;# that is "git commit --dry-run --diff"

to review what would be committed.  So while the commit that
would be made may not be compile-and-run tested, I would not
mind partial commit that much (and after all not all the
projects that track their contents with git are not "compiled"
nor "need testing" projects -- they could be tracking plain text
documentation, and the last-minute eyeballing may be a good
enough test for such contents).
