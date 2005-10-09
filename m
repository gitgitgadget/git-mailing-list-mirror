From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Sun, 09 Oct 2005 03:42:01 -0700
Message-ID: <7vk6gnezuu.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
	<7vachks7aq.fsf@assigned-by-dhcp.cox.net>
	<20051008133032.GA32079@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Sun Oct 09 12:43:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOYd7-0005rB-LY
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 12:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVJIKmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Oct 2005 06:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVJIKmE
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Oct 2005 06:42:04 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21739 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932257AbVJIKmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2005 06:42:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051009104148.OFG29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Oct 2005 06:41:48 -0400
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <20051008133032.GA32079@localhost> (Robert Fitzsimons's message
	of "Sat, 8 Oct 2005 13:30:32 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9863>

Robert Fitzsimons <robfitz@273k.net> writes:

> Instead of using //{LF}// and //{TAG}// to quote embedded tab and
> linefeed characters in pathnames use URI quoting.

I changed my mind, although I still do not particularly like the
innocuous looking C-style or URI-style quoting, simply because I
feel these funny characters should stand out loudly, but at the
same time I realize that is just a matter of personal taste.
Also the list does not seem to mind losing an extra unusual
character (either backslash or per-cent) for quoting too much.

After futzing with this a bit more, I decided that C-style
quoting is the cleanest way in the longer run.  I'll be talking
with the current maintainer of GNU patch about making it
understand C-style quoting in its input, when the program
operates under --quoting-style=c flag (or maybe some other
flag).

In addition to git-diff output, git-ls-files output is also
quoted for TAB and LF (and backslash) when not using '-z' in the
version I have in the "pu" branch.  I haven't converted
git-ls-tree yet, but that should also be done before these
changes can graduate out of "pu" branch.

Existing Porcelains or people's scripts should not break (any
more than they currently are broken ;-).  Any self-respecting
Porcelain should be either parsing '-z' output (in which case
there is no change), or parsing non '-z' output after declaring
that it does not support filenames with embedded TAB or LF (in
which case there is no new breakage, except that they have one
more character that their users cannot have in the filename --
backslash).

Here is an example output from my random repository, that has
files with TAB, LF and backslash in their names (Note that the
file "pc" + one backslash + "h.c" is shown with two backslashes).

	: siamese; git status
        # Updated but not checked in:
        #   (will commit)
        #
        #	new file: ab\n\tc/mno
        #	modified: abc/mno
        #	renamed: def\nghi/pqr -> dee/pqr
        #	new file: dee/www
        #	modified: j  k l
        #
        #
        # Changed but not updated:
        #   (use git-update-index to mark for commit)
        #
        #	deleted:  abc/mno
        #
        #
        # Ignored files:
        #   (use "git add" to add to commit)
        #
        #	diff-sample
        #	pc\\h.c
        #	pch.c.orig
        #	quote\targ.c
        #	quotearg.c.orig

	: siamese; git diff HEAD
        diff --git a/abc/mno b/ab\n\tc/mno
        similarity index 72%
        rename from abc/mno
        rename to ab\n\tc/mno
        index 0ac2a8c..3deac99 100644
        --- a/abc/mno
        +++ b/ab\n\tc/mno
        @@ -1 +1,3 @@
         Fri Oct  7 23:18:45 PDT 2005
        +foo
        +foo
        ...

        : siamese; git diff HEAD | git apply --index-info
        100644 0ac2a8c8cad088c3e843689dbd833aeabf6b1870	abc/mno
        100644 9ee055c103e84ffdd9ec15457481c92699d12fc8	def\nghi/pqr
	...

Anyway, I'll keep this in the "pu" branch a bit longer to let
the discussion simmer.
