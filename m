From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rename handling
Date: Tue, 20 Mar 2007 01:33:53 -0700
Message-ID: <7vfy8071qm.fsf@assigned-by-dhcp.cox.net>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
	<45FED31B.8070307@midwinter.com>
	<alpine.LFD.0.83.0703191427140.18328@xanadu.home>
	<Pine.LNX.4.64.0703191145530.6730@woody.linux-foundation.org>
	<45FEEB0C.3080602@midwinter.com>
	<46a038f90703191319y54251f63ldc6060ffbc89deea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Steven Grimm" <koreth@midwinter.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Nicolas Pitre" <nico@cam.org>,
	"John Goerzen" <jgoerzen@complete.org>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 09:34:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTZn5-0000zW-Dd
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 09:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbXCTId4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 04:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbXCTId4
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 04:33:56 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:41255 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbXCTIdz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 04:33:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320083354.MHJC2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 20 Mar 2007 04:33:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cwZt1W00k1kojtg0000000; Tue, 20 Mar 2007 04:33:54 -0400
In-Reply-To: <46a038f90703191319y54251f63ldc6060ffbc89deea@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 20 Mar 2007 08:19:11 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42728>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> In that area, git's mergers still have a bit to go -- I do hope for a
> day when I can say git-merge -s refactor or just git-merge -s
> tryharder so that it if hunks don't apply, git will try and trace
> where the block of code the hunk applies to has gone.

Let's say Oliver creates this project with a single file,
frotz.c.

-- >8 -- Oliver:frotz.c -- >8 --
 1 struct frotz {
 2     int nitfol;
 3     int xyzzy;
 4 };
 5
 6 int add_frotz(struct frotz *it)
 7 {
 8     return it->nitfol + it->xyzzy;
 9 }
-- 8< -- Oliver:frotz.c -- 8< --

Then Alice and Bob forks this project, and makes their own
modification.

Alice does this:

-- >8 -- Alice:frotz.c -- >8 --
 1 struct frotz {
 2     int filfre;
 3     int nitfol;
 4     int xyzzy;
 5 };
 6
 7 int add_frotz(struct frotz *it)
 8 {
 9     return it->filfre + it->nitfol + it->xyzzy;
10 }
-- 8< -- Alice:frotz.c -- 8< --

while Bob does this:

-- >8 -- Bob:frotz.h -- >8 --
 1 #ifndef FROTZ_H
 2 #define FROTZ_H
 3
 4 struct frotz {
 5     int nitfol;
 6     int xyzzy;
 7 };
 8 #endif /* FROTZ_H */
-- 8< -- Bob:frotz.h -- 8< --
-- >8 -- Bob:frotz.c -- >8 --
 1 #include <frotz.h>
 2
 3 int add_frotz(struct frotz *it)
 4 {
 5     return it->nitfol + it->xyzzy;
 6 }
-- 8< -- Bob:frotz.c -- 8< --

Now, Alice wants to merge the results of their efforts.

The "perfect merge strategy" (git-merge-blame) should be able to
detect the situation and ask Alice:

	On Bob's branch, the original file "frotz.c" was split
	into "frotz.h" and "frotz.c", while on your branch, the
	file was not split.  Both branches changed the file(s).

	Do you want to take the split [Y/n]?

We can do this by blaming from Alice:frotz.c, Bob:frotz.c and
Bob:frotz.h down to Oliver (which is the common ancestor
commit).

Let's say Alice likes the split and said yes.  Then, from the
"git-blame -C Bob -- frotz.h" output, git-merge-blame should be
able to figure out that this is what happened:

    B:1 +#ifndef FROTZ_H
    B:2 +#define FROTZ_H
    B:3 +
O:1 B:4  struct frotz {
O:2 B:5     int nitfol;
O:3 B:6     int xyzzy;
O:4 B:7  };
    B:8 +#endif /* FROTZ_H */

Similarly for "git-blame -C Bob -- frotz.c":

    B:1 +#include <frotz.h>
O:5 B:2  
O:6 B:3  int add_frotz(struct frotz *it)
O:7 B:4  {
O:8 B:5      return it->nitfol + it->xyzzy;
O:9 B:6  }

and for "git-blame -C Alice -- frotz.c",

O:1 A:1  struct frotz {
    A:2 +    int filfre;
O:2 A:3      int nitfol;
O:3 A:4      int xyzzy;
O:4 A:5  };
O:5 A:6 
O:6 A:7  int add_frotz(struct frotz *it)
O:7 A:8  {
O:8     -    return it->nitfol + it->xyzzy;
    A:9 +    return it->filfre + it->nitfol + it->xyzzy;
O:9 A:10 }

Looking at this, and because Alice chose to take the file split
Bob made, the merge strategy can insert line A:2 between B:4 and
B:5 to add filfre member to "struct frotz", and update B:5 with
A:9.
