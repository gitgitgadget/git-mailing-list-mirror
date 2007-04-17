From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 15:40:00 -0700
Message-ID: <7vy7kqlj5r.fsf@assigned-by-dhcp.cox.net>
References: <200704171041.46176.andyparkins@gmail.com> <"200704171803.58940.a
	n dyparkins"@gmail.com> <200704172012.31280.andyparkins@gmail.com>
	<alpine.LFD.0.98.0704171530220.4504@xanadu.home>
	<Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
	<alpine.LFD.0.98.0704171624190.4504@xanadu.home>
	<Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
	<alpine.LFD.0.98.0704171708360.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:40:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdwLN-0005YD-G4
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 00:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161404AbXDQWkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 18:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161406AbXDQWkF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 18:40:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41817 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161404AbXDQWkD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 18:40:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417224002.GWLG1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Apr 2007 18:40:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oNg01W00W1kojtg0000000; Tue, 17 Apr 2007 18:40:01 -0400
In-Reply-To: <alpine.LFD.0.98.0704171708360.4504@xanadu.home> (Nicolas Pitre's
	message of "Tue, 17 Apr 2007 17:16:52 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44838>

Nicolas Pitre <nico@cam.org> writes:

>> I would like to, however this doesn't currently integrate
>> well with git. I've been told in the past that once
>> .gitattributes is in place then the hooks for the crlf stuff
>> can be generalized to allow for calls out to custom code to
>> do this sort of thing.
>
> And I agree that this is a perfectly sensible thing to do.  The facility 
> should be there for you to apply any kind of transformation with 
> external tools on data going in or out from Git.  There are good and bad 
> things you can do with such a facility, but at least it becomes your 
> responsibility to screw^H^H^H^Hfilter your data and not something that 
> is enforced by Git itself.

You have to be careful, though.  Depending on what kind of
transformation you implement with the external tools, you would
end up having to slow down everything we would do.

It boils down to this statement from Andy:

    ..., keywords (in other VCSs, and so why not in git) are
    only updated when a file is checked out.  There is no need
    to touch every file.  It's actually beneficial, because the
    keyword in the file is the state of the file at the time it
    was checked in - which is actually more useful than updating
    it to the latest commit every time.

    That means you're only ever expanding in a file that your
    changing anyway - so it's effectively free.  git-checkout
    would still be immediate and instantaneous.

Back up a bit and think what "when a file is checked out" means.
His argument assumes the current behaviour of not checking out
when the underlying blob objects before munging are the same.

But with keyword expansion and fancier "external tools" whose
semantics are not well defined (iow, defined to be "do whatever
they please"), does it still make sense to consider two blobs
that appear in totally different context "the same" and omit
checking out (and causing the external tools hook not getting
run)?  I already pointed out to Andy that the branch name the
file was taken from, if it were to take part of the keyword
expansion, would come out incorrectly in his printed svg
drawing.

If you want somebody's earlier example of "giving a file with
embedded keyword to somebody, who modifies and sends the result
back in full, now you would want to incorporate the change by
identifying the origin" to work, you would want "$Source$" (I am
looking at CVS documentation, "Keyword substitution/Keyword
List") to identify where that file came from (after all, a
source tree could have duplicated files) so that you can tell
which file the update is about, and this keyword would expand
differently depending on where in the project tree the blob
appears.

It is not just the checkout codepath.  We omit diffs when we
know from SHA-1 that the blobs are the same before decoration.
We even omit diffs when we know from SHA-1 that two trees are
the same without taking possible decorations that can be applied
differently to the blobs they contain into account.  Earlier,
Andy said he wanted to grep for the expanded text if he is
grepping in the working tree, and I think that makes sense, but
that means git-grep cannot do the same "borrow from working tree
when expanding from blob object is more expensive" optimization
we have for diff.  We also need to disable that optimization
from the diff, regardless of what the correct semantics for
grepping in working trees should be.

I suspect that you would have to play safe and say "when
external tools are involved, we need to disable the existing
content SHA-1 based optimization for all paths that ask for
them" to keep your sanity.
