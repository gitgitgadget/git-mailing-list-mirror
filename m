From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Fri, 13 Oct 2006 15:50:56 -0700
Message-ID: <7v8xjjbzjj.fsf@assigned-by-dhcp.cox.net>
References: <20061013215942.36919.qmail@web31806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 00:51:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYVs4-00011n-UF
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 00:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbWJMWu7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 18:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbWJMWu6
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 18:50:58 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:10629 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751961AbWJMWu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 18:50:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013225057.PHXQ22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Oct 2006 18:50:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Zyqz1V0171kojtg0000000
	Fri, 13 Oct 2006 18:51:00 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20061013215942.36919.qmail@web31806.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 13 Oct 2006 14:59:42 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28867>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> If there were a corresponding line
>> in "the parent commit" for that line, we would not have assigned
>> the blame to the commit, but the blame would have been passed
>> down to "the parent commit" already.
>
> Indeed.

So is the topic retracted?

Actually, I kind of know what you want.  However, I just do not
think blame is the right place to do that.

Suppose you have three lines with this history (for simplicity
the ancestry is linear, time flows from left to right):

        Revisions	0 1 2 3 4 5
        line 1          a a a A A A
        line 2          b b x y B B
        line 3          c C C C C C

and we dig from commit 5.  The three lines will get blamed to
commit 3, 4 and 1 respectively.

	last change	lineno	data
	3		1	A
        4		2	B
        1		3	C

You click lineno #2 and what you will see is this:
	
        Revisions	0 1 2 3 4
        line 1          a a a A A
        line 2          b b x y B
        line 3          c C C C C

	last change	lineno	data
	3		1	A
        4		2	B
        1		3	C

In such a case, we already know the current commit we are
looking at (commit 4) is what introduced 'B', so there is no
more digging down from that line, but we would like to peel that
'B' to reveal what was behind it (in this case, 'y').  Clicking
line 1 would take you to commit 3 and that happens to show the
line after the line that had 'A' had 'y', but clicking line 3
would take you to commit 1 and you would miss changes that had
'x' or 'y' on the line before the line that had 'C'.  So "click
surrounding ones to see how things changed" is not quite the
right answer to the question "Ok, we know 'B' appeared in the
commit that got blamed.  What, if anything, was there instead
before that?"

You would need to diff commit 4 and commit 3 (after all, we know
4 introduced 'B' on line 2 so we know rev 3 is already different
and does not have 'B' there) and guess what's on that line, and
if you have more than one parent for commit 4 you would need to
do that for each parent and show that in some human readable
way.  This will be expensive but is a useful thing to do "on
demand".

I think "on demand" is really the key word here.  We can spend
extra cycles to find that out when we know we are interested in
what, if any, was there where we have 'B' today.  Spending that
extra cycle to all lines in the blamed file will end up wasted
if we are using this for "iteratively dig deeper" in gitweb.
That is why I do not think blame is the right place to do this.

What you can do to improve gitweb is to change the URL that each
lineno on the blame page has, so that when it is pointing at the
current commit (i.e. the commit we are looking at is the one
that was blamed for the line), have it run an equivalent of
"git-diff-tree -m -p commit", and guess what line that line that
did not exist in any of the parent (in our example, line 2 that
had 'B') is in the parent, and show 'git-blame' for that file in
that parent around that line.
