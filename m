From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at end of file
Date: Sat, 19 May 2007 16:18:00 -0700
Message-ID: <7vabw0tnbr.fsf@assigned-by-dhcp.cox.net>
References: <464EF7D2.4030406@gmail.com>
	<7vhcq8v97k.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705191458o3fa1d1a0ndd916d1efafdd2a7@mail.gmail.com>
	<7vsl9stnzp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 01:18:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpYC1-0005qr-3e
	for gcvg-git@gmane.org; Sun, 20 May 2007 01:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765043AbXESXSG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 19:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765036AbXESXSF
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 19:18:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55223 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763244AbXESXSD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 19:18:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519231800.WOQF6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 19:18:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1BJ01X00E1kojtg0000000; Sat, 19 May 2007 19:18:01 -0400
In-Reply-To: <7vsl9stnzp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 19 May 2007 16:03:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47782>

Junio C Hamano <junkio@cox.net> writes:

> ... these may or may not be at the end of the file, so
> inspecting what blank lines they have at the end is not
> sufficient.  If "new" does not introduce new blank lines at its
> end, then you can be sure that you are not adding trailing blank
> lines, but even if "new" does introduce a new blank line at the
> end, you do not know if that is adding it to the end of the
> file, or in the middle.
>
> You do not know where the hunk is applied until you do the loop
> that follows the part your patch we are discussing.

If I were doing this, I would probably do it this way:

 (1) Inside apply_one_fragment(), where "case '+':" appears, count
     the blank (not just '\n', but matches /^\s*$/) lines at the
     end of "new" side.  As soon as you fall into "case ' ':" or
     "case '-':" or non-blank line in "case '+':", you reset the
     counter to zero, so that what you are counting is the
     number of blank lines that would have get added, if the
     hunk were to be applied at the end of the file.  Keep that
     number ofter you separated the fragment into new and old.

 (2) In the same function, inside the big "for (;;)" loop that
     figures out where to apply that "old" => "new" change, use
     the number you gathered in the step (1) to trim what is
     applied, where the real application happens, which is the
     part that has memmove()/memcpy(), only when you know you
     are applying the hunk at the end of the file.  That is the
     only place in the function that knows where the hunk is
     being applied.
