From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Sun, 01 Oct 2006 01:07:58 -0700
Message-ID: <7vbqow5uht.fsf@assigned-by-dhcp.cox.net>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
	<Pine.LNX.4.64.0609272232040.9349@xanadu.home>
	<7vfyec63jx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281029300.9349@xanadu.home>
	<7vd59ejokp.fsf@assigned-by-dhcp.cox.net>
	<20060930045037.GB18479@spearce.org>
	<7v4pupizix.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609301033460.3952@g5.osdl.org>
	<7vd59d7y8v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609301712340.3952@g5.osdl.org>
	<7v64f47uix.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 01 10:08:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTwMo-0007cB-Pf
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 10:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWJAIIB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 04:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWJAIIB
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 04:08:01 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:3723 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932172AbWJAIH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 04:07:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061001080759.KKVU26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sun, 1 Oct 2006 04:07:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Uw811V0091kojtg0000000
	Sun, 01 Oct 2006 04:08:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v64f47uix.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 30 Sep 2006 17:24:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28171>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Sat, 30 Sep 2006, Junio C Hamano wrote:
>>> 
>>> Especially, "find the closest ancestor" behaviour means when you
>>> get "tag-gXXXX" as an answer, the tag proper does _not_ contain
>>> the given commit (e.g. commit v1.4.2-g4839bd8 is not part of
>>> v1.4.2).
>>
>> Correct.
>>
>> But that just means that we should take the _next_ one in the time-ordered 
>> list, no?
>
> I do not think so.
>
> Extending the example (sorry for doing the same topic on two
> separate threads) I just gave Jeff on "fix based on v0.99",
> after finding that the fix is based on v0.99, finding another
> commit that immediately followed the v0.99 commit on my master
> branch does not help finding out that I very recently merged the
> fix in at all.  I think we cannot get away without honestly
> doing the first descendant, which is unfortunately a lot more
> expensive.

Maybe not *that* expensive.  Here is an outline, thinking aloud.

When describing a commit and a ref, we first run the ancestry
traversal algorithm merge-base uses internally.  If the tip of
the ref is not a descendant of the commit, abort (I'll justify
this in a moment).

Otherwise, we would already have parsed all the necessary
commits we need to determine which commits on the given ref's
ancestry is the first one that is a descendant of the target
commit at this point.  We collect these commits in a set, and
then mark the ones that are immediate children of the target
commit, then the ones that are children of them, etc. until we
find all the descendant of the target commit.

After that, we can bisect the reflog for the ref to find the
first commit that we have marked as a descendant of the target
commit in the above process.

If the tip of the ref is not a descendant of the commit to begin
with, that does not automatically mean that the target commit
has never been part of the ref -- the ref _could_ have contained
it and then later got rewound.  But then the question "when did
the commit has become part of this branch" itself stops being
interesting.  It would not do us much good if we know it was
part of the branch for only two days last week but it is not
contained in the branch anymore.
