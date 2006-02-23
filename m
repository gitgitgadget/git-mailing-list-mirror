From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 11:32:27 -0800
Message-ID: <7virr5hnw4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
	<Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
	<7vwtfmihts.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
	<81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com>
	<43FD84EB.3040704@op5.se>
	<81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
	<43FDB8CC.5000503@op5.se>
	<81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
	<Pine.LNX.4.64.0602230911410.3771@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 20:32:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCMCa-0006aU-93
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 20:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWBWTcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 14:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWBWTcd
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 14:32:33 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17406 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751639AbWBWTcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 14:32:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060223193234.TDMO25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Feb 2006 14:32:34 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602230911410.3771@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 23 Feb 2006 09:13:43 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16658>

Linus Torvalds <torvalds@osdl.org> writes:

> There are many portable interpreters out there, and I don't mean perl. And 
> writing a small "specialized for git" one isn't even that hard. In fact, 
> most of the shell (and bash) hackery we do now would be unnecessary if we 
> just made a small "git interpreter" that ran "git scripts".

Before anybody mentions tcl ;-).

I agree with the above in principle, but I am afraid that is
only half of the solution to the problem Alex is having.

In the longer term, libified git with script language bindings
would make the way git things work together a lot better.  I've
always wanted to make merge-base a subroutine callable from
other things, so that I can say "git diff A...B" to mean "diff
up to B since B forked from A" ;-).

That way, we would eliminate the current common pattern of
piping rev-list output to diff-tree, or ls-files/diff-files
output to update-index --stdin.  These components live in the
single process, a calling "git script", and will talk with each
other internally.

But we do need to talk to non-git things.  git-grep needs a way
for ls-files to drive xargs/grep, for example.  diff --cc reads
from GNU diff output.  And for these external tools, the way
they expect the input to be fed to them or their output is taken
out is via UNIXy pipe.

And the breakage Alex wants to work around is that the platform
is not friendly to pipes, if you deny Cygwin.  So I suspect
avoiding shell would not help much.
