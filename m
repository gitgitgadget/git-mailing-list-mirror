From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 09 Jan 2007 14:37:35 -0800
Message-ID: <7vy7obj07k.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
	<20070109142130.GA10633@coredump.intra.peff.net>
	<7virffkick.fsf@assigned-by-dhcp.cox.net>
	<20070109213117.GB25012@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 23:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4PbB-0005NA-4U
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 23:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbXAIWhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 17:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbXAIWhi
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 17:37:38 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:63516 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbXAIWhh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 17:37:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109223736.OCIL9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 17:37:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9Acl1W00Q1kojtg0000000; Tue, 09 Jan 2007 17:36:46 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070109213117.GB25012@fieldses.org> (J. Bruce Fields's message
	of "Tue, 9 Jan 2007 16:31:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36416>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Tue, Jan 09, 2007 at 01:20:27PM -0800, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > For example, with what's in next now, I can do this:
>> >
>> >   git checkout v1.4.0
>> >   hack hack hack
>> >   git commit -m -a 'some changes which will never be seen again'
>> >   git checkout v1.2.0
>> >
>> > I thought the _point_ of the safety valve was not to lose those changes.
>> 
>> Fair enough.
>> 
>> We could always do the check upon "git checkout" from a detached
>> HEAD state, whether it takes you back on some existing branch or
>> leaves your HEAD still detached.
>
> Stupid question: why can't checkout do something like this?
>
> 	if we're currently not on a branch, fail if .git/PREV
> 		doesn't point to the same commit as .git/HEAD.
>
> 	if we're checking out a non-branch, store its SHA1 into
> 		.git/PREV.

I do not want to think about the consequences of adding more
cruft under .git/ directory.  For example, should PREV be
noticed by fsck and prune?  What should various forms of
'git-reset' do with it?  How does it interact with 'git-bisect'?

Being able to test merge or even make commits without being on a
branch is vastly useful.  It might or might not lead to anywhere
even after you make a handful commits -- and I would imagine
that it would be very handy to be able to be lazy and not having
to decide if it is worth a new branch.

But that may be just my imagination; I generally prefer any
feature that allows me to defer decision over something that
makes me decide early.  If Carl wants to do a patch to teach
'git-commit' (and all other things that can create commits) not
to do things from working in a detached HEAD, I would probably
not opposed to it too much, but I am fairly certain that I won't
be coding it myself.

It's tempting to forget about this whole "safety" business.
Because we allow "reset --hard" and other forms of operations
that can lose history if they were done while on a branch, only
giving the safety to "git checkout" feels somewhat silly.  And
the primary motive for detached HEAD as I understand it is for
sightseeing, and not allowing "reset --hard" to jump around is
just plain silly.

That is, after:

	git checkout v1.4.0

you are not on any branch, and we would still allow

	git reset --hard v1.2.0

which is exactly the same as:

	git checkout v1.2.0

You can still say:

	git checkout master

and we do not even check.

Which makes the "merge-base --check-ancestry" stuff I did last
night pretty much unnecessary, but that's Ok.  It will find
other uses.
