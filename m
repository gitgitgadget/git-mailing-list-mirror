From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 17:06:43 -0700
Message-ID: <7vzmc1jcz0.fsf@assigned-by-dhcp.cox.net>
References: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
	<20061012193107.44651.qmail@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 02:07:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYAZk-0001ue-Nx
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 02:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWJMAGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 20:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWJMAGq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 20:06:46 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:20886 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751356AbWJMAGp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 20:06:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013000644.DBPM13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 20:06:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Zc6Z1V00B1kojtg0000000
	Thu, 12 Oct 2006 20:06:33 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28821>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Renames are naturally supported?

Didn't I say you can see it yourself by doing this and that?  

A short answer is yes.  I'll do a re-write-up of algorithm
overview and directions to enhance it in a separate message when
I have time.

One interesting difference is that it can do partial file (line
range).  With the "parameter order" fix Linus asked, I can do:

$ git-pickaxe -L 551,554 master commit.c

which would run a lot faster than:

$ git-pickaxe -L 551,560 master commit.c

This is a made-up example, but you would get the idea.  In
short, it does not have to dig deeper outside the range
originally you specified.

> ---cut---
> The porcelain format is as follows:
>
> <SHA-1> <orig line> <line> [<num lines>

This is misleading.  <num lines> is always shown for the group
head, even if there was another group earlier from the same
commit (otherwise the Porcelain has to buffer the chunk, which
you did not like).  Second and subsequent lines in the same
group do not have <num lines>.

> author <name>
> author-mail <email format>
>...
> committer-tz <TZ>
> filename <string>
> summary <string>]
> <TAB><line data>
>
> Where
>   <SHA-1> is the SHA-1 of the commit which introduces this line.
>   <orig line> it the line number where this line is introduced.
>   <line> is the line number of the final file (at SHA-1 commit)
>
> Then, if <SHA-1> is different from the previous line's SHA-1 (if no
> previous then always different), a header follows.  It starts by the
> number of lines that this <SHA-1> commit introduces,...

So this description is wrong; <num lines> is not part of the
"extra".

>...
> ---cut----
>
> This kind of makes it slightly clearer.

I deliberately left it vague so that we can add things later to
the header.  Porcelains should ignore the fields that they do
not understand, and should not expect these fields listed above
come in the order the above list shows.

Also I deliberately left it vague so that Porcelains can get the
header for the same SHA-1 more than once.  This is needed when
we add "ciff" to pick more than one paths from the same commit.
In such a case, most likely we are better off not to repeat
header fields from author...committer-tz and summary but we
would need filename.  The expectation to the Porcelains is:

   Read one line, which begins with commit object name and two
   or three numbers; if it has three numbers, it is the
   beginning of a group.  Any such "object name" line can be
   followed by a header.  Read subsequent lines until you get a
   line that begins with a <TAB>.

   - do not get upset if you see a header field that you do not
     understand; you are reading from newer version of blame.

   - do not get upset if you see a header for the commit you
     have already seen.  Some of the header fields can be
     updated from the one you have seen the last time, so use
     the updated value from the new header.

   Lines that begin with a <TAB> is data from the file being
   annotated.  The object name and headers you saw before this
   line annotate it.

So Porcelains need to keep one set of these header fields per
commit object.
