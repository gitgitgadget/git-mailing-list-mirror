X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Two conceptually distinct commit commands
Date: Tue, 05 Dec 2006 17:13:20 -0800
Message-ID: <7vejrdbzdb.fsf@assigned-by-dhcp.cox.net>
References: <87d56z32e1.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 01:13:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87d56z32e1.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	04 Dec 2006 11:08:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33396>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrlLn-0001uM-0v for gcvg-git@gmane.org; Wed, 06 Dec
 2006 02:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759397AbWLFBN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 20:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759432AbWLFBN1
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 20:13:27 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41486 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759397AbWLFBN1 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 20:13:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206011326.FXFU4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 20:13:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vDDc1V00H1kojtg0000000; Tue, 05 Dec 2006
 20:13:36 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

>     ... The case I would use it for is fairly common,
>     (and something that I think will speak to Junio who often brings
>     up a similar scenario).
>
>     Here's where I would like this functionality:
>
> 	I receive a patch while I'm in the middle of doing other work,
> 	(but with a clean index compared to HEAD, which is what I've
> 	usually). The patch looks good, so I want to commit it right
> 	away, but I do want to separate it into two or more pieces,
> 	(commonly this is because I want to separate the "add a test
> 	case demonstrating a bug" part from the "fix the bug"
> 	part).

(This is offtopic)

I often faced situations like that during git.git history.  One
patch to expose the bug in the existing code, and another to fix
it.  And there are three ways to make that commit.

 (1) one commit exposes, then another fixes.
 (2) one commit fixes, then another verifies the bug is no more.
 (3) one commit to include both.

In my experience, (1) is only useful during the time I am coming
up with the fix (if I am fixing it myself) or during the time I
am reviewing and committing the fix (if I am applying somebody
else's patch).  Committing in that order lets me validate the
brokenness after making the first commit, and then lets me feel
good by not seeing that problem after the second commit.  But
this means I deliberately record a state that is known not to
pass the test, which means it is a problem for somebody else in
the future when the history needs to be bisected to hunt for an
unrelated bug.  If the "test" is just an optional test in the
test suite, then it is easy to work around (the person who is
bisecting can ignore that bug by not running that particular
test), but if it is an assert somewhere deep inside the code,
ignoring it is not very easy, especially if the person who is
bisecting is not familiar with that part of the code.

What I recommend people to do these days is either (2) or (3),
but do so _after_ verifying the fix in the reverse order.  The
criteria to choose between (2) or (3) is fairly simple: if the
"test" is easily separable (e.g. changes to a test script file
that does not overlap with the "fix" patch), roll both in one
commit.  Then it would not later cause problems for bisection.

Enough of offtopic.

The sequence to split a patch in place would be (I'll speak in
the present tense and pretend Nico's "git add" does not exist
yet):

	git apply
        git update-index <files for the first batch>
        git commit
        git commit -a ;# the remainder

so you do not necessarily need a new "concept".  It is
inconvenient that you need to deal with new files, but that is a
minor detail compared to a bigger problem I'll mention in the
next paragraph.

I think the problem with your thinking is that you still are
talking from "file boundary matters" point of view.  The above
sequence is only useful if the patch to be split is separable
cleanly at the file boundary, in which case, I would (and I've
done so often) split the patch file in my editor and run two
independent "git apply + git commit" sequences.  That way, I
could test each in isolation (perhaps with some dirty working
tree state if I do not stash them away and do reset --hard).
Anything more realistic and practically useful would require
splitting of the patch in semantic ways regardless of file
boundaries.

As I have already said (and you seemed to share the same
discipline), I do not like people committing anything
non-trivial that is not tested.  The patch you received might
not have been tested by the submitter, but there is a chance
that it might have been ;-).  But with the way you said you want
to make the commits in the message I am responding to, the first
commit would never have been tested by anybody in isolation, not
by the original submitter even if he tested the patch before
giving it to you, nor you -- your working tree had either none
of his patch or all of it, and never was in the state with only
the first batch.

So while at the theoretical level I understand what you would
want to achieve with the "single patch that should have been
sent as two patch series" example, from the practical point of
view I do not see much value in it (because "file boundary
matters" is a minority case that is not very interesting), and
from the discipline point of view I would rather not want to
have such a too-convenient way to commit things that were
different in nontrivial ways from what you had in your working
tree (if we use something like Darcs record to update
hunk-by-hunk).

>     The old behavior is still available with the --include option, but
>     nobody has ever come out in favor of that being a useful command,

That is a slight overstatement.  When committing with paths
argument to conclude a merge, --include semantics is the only
variant that makes sense (--only semantics is so wrong that
there is a safety valve that catches it).  Most of the time,
however, if I need to resolve and record a complicated merge, I
would either do "update-index" to clear the deck of the paths
that I already dealt with, and by the time I would type "git
commit", I have an index that has exactly what I want in the
merge commit.  That makes --include a less often used form.  If
a merge is small and easy to resolve at only a few paths, it
still is handy to say "git commit -i resolved-path.c".  It does
not add anything to the semantics -- it is only a typesaver.

