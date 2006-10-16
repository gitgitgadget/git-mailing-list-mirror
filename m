From: Junio C Hamano <junkio@cox.net>
Subject: Re: On blame/pickaxe
Date: Sun, 15 Oct 2006 23:43:55 -0700
Message-ID: <7v8xjgvjys.fsf@assigned-by-dhcp.cox.net>
References: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net>
	<7vwt739org.fsf@assigned-by-dhcp.cox.net>
	<7vfydq79ae.fsf@assigned-by-dhcp.cox.net>
	<7vr6xddm7h.fsf@assigned-by-dhcp.cox.net>
	<20061016022159.GZ20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 08:44:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZMCt-0007QK-QA
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 08:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbWJPGoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 02:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbWJPGoH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 02:44:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:14993 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161198AbWJPGn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 02:43:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061016064356.NIFC28934.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Oct 2006 02:43:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aujz1V00D1kojtg0000000
	Mon, 16 Oct 2006 02:43:59 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061016022159.GZ20017@pasky.or.cz> (Petr Baudis's message of
	"Mon, 16 Oct 2006 04:21:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28953>

Petr Baudis <pasky@suse.cz> writes:

>   Thanks for the nice writeup!
>
> Dear diary, on Fri, Oct 13, 2006 at 03:43:46AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> When done with one parent, if you are a merge, you will then try
>> to pass the blame on the remaining part that you are still
>> suspected for to other parents.
>
>   (This got me nervous but I guess it actually makes sense - if only one
> parent modified a line, it's right to pass the blame up; else if you
> took one parent's version verbatim, it's right to pass the blame up as
> well (I think); else you've already got the blame assigned to the merge
> commit and everything is all right.)

Well, this part is the classic blame algorithm.  The beauty of
it is that a merge case falls out as a natural consequence of
the one-parent case and you do not have to do anything special.
You either inherited a line from your parent (or one or more of
your parents) or you created the line yourself.  If you subtract
what you can blame your parents for, the remainder is what you
introduced.  The number of parents you have does not have any
effect on that logic.

>   Now, this is very nifty and so for moving functions around, but I
> think it is very dangerous for anything where ordering matters - large
> arrays definitions, patch series files, etc. In that case, you've
> completely ommitted the fact that the movement occured, which can be
> crucial and based on the current behaviour of the tools, I think people
> expect this now. To put it shortly, "who wrote this line" vs "who put
> this line here".

That's exactly why we have -f and -n options, so that the
program that reads from blame output can tell where things came
from.  It is not about "who wrote it" vs "who put it here";
pickaxe gives a lot more than that: "where did this originally
come from", i.e. "by whom in which file at what line number was
the line created".

If the user is not prepared to see code movement, pickaxe can be
run without -M nor -C to get the classic blame output.

By the way, We would not want to do the code movement (or
copying from unrelated file) for very trivial lines.  E.g. you
would not want to blame the following three lines:

        +	}
        +}
        +#endif

to a random file that happens to have the exact copy of the
above that is not related at all.  Something like the above can
happen almost anywhere.  The current implementation of -M/-C
does not do this very well.  find_copy_in_blob() currently
passes blame to the parent when it finds nontrivial copies, but
instead it should inspect the patch and return a score, and the
caller should take the parent with the best match and assign
blame to it.
