From: Junio C Hamano <junkio@cox.net>
Subject: Re: I'm missing isofs.h
Date: Wed, 27 Apr 2005 22:27:59 -0700
Message-ID: <7vhdhra2sg.fsf@assigned-by-dhcp.cox.net>
References: <20050426214338.32e9ac27.akpm@osdl.org>
	<20050427235115.GN22956@pasky.ji.cz>
	<Pine.LNX.4.58.0504271708550.18901@ppc970.osdl.org>
	<20050428003246.GV22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 07:22:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR1U3-0000Cu-SG
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 07:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVD1F2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVD1F2J
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:28:09 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59831 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262012AbVD1F2B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 01:28:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428052800.RKUM8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 01:28:00 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050428003246.GV22956@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 28 Apr 2005 02:32:47 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Actually, I can't; the patch generator is not on par with mine yet.
PB> It does not show modes and does not indicate file adds/removals by
PB> /dev/null - basically, I need something cg-patch can eat (and it should
PB> be backwards compatible). I think throwing the sha1 hashes away will not
PB> harm; I got used to the Index: field and === marker, but I don't care if
PB> I loose it.

I've looked at what cg-Xdiffdo does.  From the above paragraph,
I sense that it does more than what cg-patch requires, so I took
a look at cg-patch, too.  

Can you help me verify if I understand the requirements cg-patch
has on its input correctly?

 - Follow the convention of showing newly added files with
   "--- /dev/null" and removed files with "+++ /dev/null";

 - Label matches this Perl regexp:

     m|^(---|\+\+\+)\s+[^/]+\/(\S+)\s+.*mode:([0-7]{3,}).*/|

   and you only care about sign ($1), filename ($2) and mode ($3).

To illustrate, cg-Xdiffdo generates something like:

 (modified files)
 --- FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF/fs/ext3/Makefile  (mode:0644)
 +++ EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE/fs/ext3/Makefile  (mode:0664)

 (deleted files)
 --- FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF/fs/ext3/Makefile  (mode:0644)
 +++ /dev/null  (tree:EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE)

 (added files)
 --- /dev/null  (tree:EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE)
 +++ FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF/fs/ext3/Makefile  (mode:0644)

but they could be like the following to satisfy cg-patch:

 (modified files)
 --- a/fs/ext3/Makefile  (mode:0644)
 +++ b/fs/ext3/Makefile  (mode:0664)

 (deleted files)
 --- a/fs/ext3/Makefile  (mode:0644)
 +++ /dev/null

 (added files)
 --- /dev/null
 +++ b/fs/ext3/Makefile  (mode:0644)

Is my understanding correct?  If so it should not be too much
work to generate something like it from within the builtin
stuff.

Provided if that is what the kernel folks can live with (I do
see why the tool wants the mode bits, but it is unusual to see
non-timestamp strings after filenames).

Linus & Andrew, is the above (second) format acceptable for the
kernel work?

