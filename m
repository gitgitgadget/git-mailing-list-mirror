From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-pack SIGSEGV..
Date: Sat, 16 Jun 2007 14:05:10 -0700
Message-ID: <7vfy4r3915.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706142124380.14121@woody.linux-foundation.org>
	<7vvedp935y.fsf@assigned-by-dhcp.pobox.com>
	<7vr6od92nj.fsf@assigned-by-dhcp.pobox.com>
	<Pine.LNX.4.64.0706150949300.5848@iabervon.org>
	<7v7iq47j5z.fsf@assigned-by-dhcp.pobox.com>
	<Pine.LNX.4.64.0706152342490.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jun 16 23:05:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzfSq-00017s-M5
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 23:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545AbXFPVFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 17:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755536AbXFPVFO
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 17:05:14 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39677 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515AbXFPVFM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 17:05:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070616210512.OXJA3133.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Jun 2007 17:05:12 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CM5B1X0031kojtg0000000; Sat, 16 Jun 2007 17:05:11 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50308>

Daniel Barkalow <barkalow@iabervon.org> writes:

> That is, since "push = refs/heads/master" was already the same as "push = 
> refs/heads/master:refs/heads/master", the pattern fell into that code. I 
> was at least confidant enough of this to translate --tags into 
> "refs/tags/*" instead of "refs/tags/*:refs/tags/*" when I got to that 
> point.

This change sounds sensible.

> On the fetch side, the code isn't using my parser yet, anyway. But my 
> parser should be able to distinguish the one-sided refspec case, so that 
> the fetch logic can do whatever is determined to be right with the 
> combination of features.

Yes, but at the same time I know you are planning to rewrite
git-fetch using this code, so...

>> I think "fetch = refs/heads/*" syntax, if it just fetches
>> without storing, does not make much sense.  In a separate-remote
>> repository, "[remote "foo"] fetch = refs/heads/*" would probably
>> be useful if we treated it as "refs/heads/*:refs/remotes/foo/*".
>> In a bare repository used for mirrors, it would be useful if it
>> stood for "refs/heads/*:refs/heads/*".
>
> I'm kind of uncomfortable with this level of complexity for a fully 
> specified lhs pattern. Maybe "fetch = refs/heads/*" should be prohibited, 
> while something DWIM-y like "fetch = heads/*" or even "fetch = head *" 
> could come up with clever and useful patterns. In any case, the parser 
> should report "refs/heads/*" as pattern,refs/heads/,NULL and let the fetch 
> code decide what to do with it, rather than having the special case in the 
> parser.

Yeah, I am not very happy about DWIMmery either, especially a
magic that changes behaviour depending on the bareness [*1*].
As long as the parser can distinguish these five cases, I'd be
happy.

                        [push]			[fetch]
 (1) $any/*		same name		TBD
 (2) $any/*:		error			TBD
 (3) $any1/*:$any2/*	map any1 => any2	map any1 => any2
 (4) :$any/*		error			error
 (5) $any1/*:$any2	error			error
     $any1:$any2/*

(1-fetch) should probably be an error to avoid newbie confusion.

(2-push) is clearly an error.

(2-fetch) does not make much sense (octopus of random branches
    you do not even control what they are), but I do not have
    too strong an objection against it, so marked it TBD for now.

(3) is what we have always done.

(4-fetch) is clearly an error.

(4-push) could be "remove all refs", but I'd rather make that an
error.

(5) is clearly an error.  If you explicitly have both sides,
    they should both be wildcard, or non-wildcard.

[Footnote]

*1* Sometimes I see an incorrect suggestion given on #git to do
"mv .git ../project.git" to "make an incorrectly made repository
bare".  This is incorrect---at least you must update core.bare,
and also should make sure .git/object/info/alternates points at
a right directory if you used a relative path to specify one.
Luckily, we see much smaller number of such incorrect "help" on
the mailing list.
