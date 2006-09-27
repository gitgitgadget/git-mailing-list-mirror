From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Tue, 26 Sep 2006 23:19:57 -0700
Message-ID: <7vejtxhlv6.fsf@assigned-by-dhcp.cox.net>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu>
	<7vmz8lj3pl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64N.0609262216390.12560@attu2.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 08:20:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSSm2-0005VL-3M
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 08:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965376AbWI0GT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 02:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbWI0GT7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 02:19:59 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53403 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965376AbWI0GT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 02:19:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927061957.LLON12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 02:19:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TJKu1V00M1kojtg0000000
	Wed, 27 Sep 2006 02:19:55 -0400
To: David Rientjes <rientjes@cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0609262216390.12560@attu2.cs.washington.edu>
	(David Rientjes's message of "Tue, 26 Sep 2006 22:32:47 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27879>

David Rientjes <rientjes@cs.washington.edu> writes:

> When I read "x > 0", my mind parses that very easily.  When I read "0 < 
> x", it takes me a few cycles longer.  I think the goal of any software 
> project is to not only emit efficient and quality code, but also code that 
> can be read and deciphered with ease unless it's impossible otherwise.

Well, the thing is, I end up being the guy who needs to stare at
git code longer than you do ;-).

Before --stat-width was introduced there was code like this:

	if (max + len > 70)
		max = 70 - len;

Here "len" is the width of the filename part, and "max" is the
number of changes we need to express.  The code is saying "if we
use one column for each changed line, does graph and name exceed
70 columns -- if so use the remainder of the line after we write
name for the graph".  Your "constant at right" rule makes this
kosher.

If we make that to a variable, say line_width, we can still
write:

	if (max + len > line_width)
        	...

I however tend to think "if line_width cannot fit (max + len)
then we do this", which would be more naturally expressed with:

	if (line_width < max + len)
        	...

Now, at this point, it is really the matter of taste and there
is no real reason to prefer one over the other.  Textual
ordering lets my eyes coast while reading the code without
taxing the brain.  I can see that the expression compares two
quantities, "line_width" and "max + len", and the boolean holds
true if line_width _comes_ _before_ "max + len" on the number
line (having number line in your head helps visualizing what is
compared with what).  If you write the comparison the wrong way,
it forces me to stop and think -- because on my number line
smaller numbers appear left, and cannot help me reading the
comparison written in "a > b" order.

I could try writing constants on the right hand side when
constants are involved, but I do not think it makes much sense.
It means that I would end up doing:

-	if (max + len > 70)
-		max = 70 - len;
+	if (line_width < max + len)
+		max = line_width - len;

Consistency counts not only while reading the finished code, but
also it helps reviewing the diff between the earlier version
that used constant (hence forced to have it on the right hand
side by your rule) and the version that made it into a variable.

> To change the code itself because of a hard 80-column limit or because 
> you're tired of hitting the tab key is poor style.

Well, the program _firstly_ matches the logic flow better, and
_in_ _addition_ if you write it another way it becomes
unnecessarily too deeply indented.  So while I agree with you as a
general principle that indentation depth should not dictate how
we code it does not apply to this particular example.
