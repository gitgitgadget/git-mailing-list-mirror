From: Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Tue, 11 Oct 2005 12:42:12 -0700
Message-ID: <87slv7zvqj.fsf@penguin.cs.ucla.edu>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
	<7vachks7aq.fsf@assigned-by-dhcp.cox.net>
	<20051008133032.GA32079@localhost>
	<7v64s7svya.fsf@assigned-by-dhcp.cox.net>
	<7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
	<87mzlgh8xa.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
	<87ek6s0w34.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Tue Oct 11 21:45:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPQ1o-0005oK-7k
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 21:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVJKTnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 15:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVJKTnI
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 15:43:08 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:35051 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S1751139AbVJKTnG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 15:43:06 -0400
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
	by kiwi.cs.ucla.edu (8.11.7p1+Sun/8.11.7/UCLACS-5.2) with ESMTP id j9BJgC413488;
	Tue, 11 Oct 2005 12:42:12 -0700 (PDT)
Received: from eggert by penguin.cs.ucla.edu with local (Exim 4.50)
	id 1EPQ0q-0001L9-6t; Tue, 11 Oct 2005 12:42:12 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 11 Oct 2005 11:37:46 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9980>

Linus Torvalds <torvalds@osdl.org> writes:

> the simplest question to ask is "what are we protecting against?"

I'd like to protect against:

  1.  File names that cannot be handled correctly with the current
      formats.  Newline is the obvious problem here, along with
      (arguably) tab and space.

  2.  Common transliterations of patches.  Many programs (and mailers,
      alas) expand tabs to spaces, append CR to lines, prepend spaces
      to lines, break lines at spaces, etc.  'patch' already deals
      with this to some extent, but it'd be nice if the format
      resisted these transliterations better.

  3.  Humans misreading patches.  The patch format is intended to be
      human-readable, after all.

  4.  Reencoded patches.  Programs like Emacs can and will convert
      patches from UTF-8 to EUC-JP, for example.

You convinced me that (4) is not worth the hassle, but I'd still like
to address (1)-(3) when it's easy.

> invalid UTF-8 [is] invalid UTF-8

Yes, but (2) and (3) can lose information about invalid UTF-8 if we
don't suitably protect the encoding errors.  I daresay that many
mailers will mishandle invalid UTF-8, for example.

> There _is_ something you may want to quote, namely the standard CSI
> terminal escapes.

If I understand you aright, we could do that by modifying my previous
proposal to escape all bytes in the UTF-8 representation of a control
character.  In Unicode, the characters 0080 through 009F are control
characters, so that should suffice to quote the terminal escapes you
mentioned.  (Perhaps we should also escape unassigned Unicode
characters too, on the theory that they might become control
characters in the future.)

> For any UTF-8 quoting scheme you come up with, I'll point out
> something that it does wrong or looks horrible for a Latin1 filename
> ;)

Yes, quite true.  But we don't have to come up with something that's
perfect in all cases, just something that's good enough to handle
cases that we expect will be common in practice, in a world where
UTF-8 is the preferred encoding for non-ASCII characters.
