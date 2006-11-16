X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 13:49:36 -0800
Message-ID: <7vr6w33vv3.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org>
	<7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
	<20061116051240.GV7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 21:50:08 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061116051240.GV7201@pasky.or.cz> (Petr Baudis's message of
	"Thu, 16 Nov 2006 06:12:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31623>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkp7K-0007CZ-KE for gcvg-git@gmane.org; Thu, 16 Nov
 2006 22:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424707AbWKPVtj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 16:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424708AbWKPVtj
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 16:49:39 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:13720 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1424707AbWKPVth
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 16:49:37 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116214937.EFMS97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 16:49:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nZpj1V00F1kojtg0000000; Thu, 16 Nov 2006
 16:49:44 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> (vi) Coding issues. This is probably very subjective, but a blocker for
> me. I have no issues about C here, but about the shell part of Git.
> Well, how to say it... It's just fundamentally incompatible with me. I
> *could* do things in/with it, but it's certainly something I wouldn't
> _enjoy_ doing _at all_, on a deep level. I think the current shell code
> is really hard to read, the ancient constructs are frequently strange at
> best, etc. It's surely fine code at functional level and there'll be
> people who hate _my_ style of coding and my shell code which isn't
> perfect either, but it's just how it is with me.

I've been thinking about revamping the style of shell scripts in
git-core Porcelain-ish for some time, and I have a feeling that
now may be a good time to do so, after one feature release is
out and the list is discussing UI improvements.

But before mentioning the specifics, let me mention one tangent.
I recently installed an OpenBSD bochs (it was actually a qemu
image) without knowing much about the way of the land, and after
adjusting myself to necessary glitches (like "make" being called
"gmake" there), I saw git properly built and pass its selftest.
I was pleasantly surprised when I noticed there was no 'bash' on
the system after all that.

I would like to keep it that way.

I'll list things I would want to and not want to change.
Comments from the list are very appreciated.  You can say things
in two ways:

 * I guarantee that the _default_ shell on all sane platforms we
   care about handle this construct correctly, although it was
   not in the original Bourne.  There is no reason to stay away
   from it these days.

or

 * You've stayed away from this construct but now you say you
   feel it is Ok to use it.  Don't.  It would break with the
   shell on my platform (or "it is a bad practice because of
   such and such reasons").

I do not think many people can say the former with authority
unless you have a portability lab (the company I work for used
to be like that and it was an interesting experience to learn
all about irritating implementation differences).  And "POSIX
says shell should behave that way" is _not_ what I want to hear
about.

But the latter should be a lot easier to say, and would be
appreciated because it would help us avoid regressions.

Things I would want to change:

 - One indent level is one tab and the tab-width is eight
   columns.  Some of our scripts tend to use less than eight
   spaces for indentation to avoid line wrapping.

 - More use of shell functions are fine.   Especially if the
   above change makes lines too long, the logic should be
   refactored.

 - It is so 80-ish to follow certain portability and performance
   wisdom.  The following should go:

   . Use "case" when you do not have to use "if test".

   . Avoid ${parameter##word} and friends and use `expr` instead
     to pick a string apart.

   . Avoid "export name=word", write "name=word; export name"
     instead.

   . Avoid ${parameter:-word} and friends when ${parameter-word}
     would do.

Things I do not want to change:

 - The shell scripts should start with #!/bin/sh, not
   #!/bin/bash (nor even worse "#!/usr/bin/env sh").

 - Shell functions are written as "name () { ... }" without 
   "function" noiseword.

 - 'foo && bar || exit' exits with the error code of what
   failed; no need to say 'exit $?'.

 - String equality check for "test" is a single =, not ==. 

 - Do not use locals.

 - Do not use shell arrays.

 - In general, if something does not behave the same way in ksh,
   bash and dash, don't use it (that does not mean these three
   are special; it just means if something is not even portable
   across these three, it is a definite no-no).

I do not think I need to list other common-sense shell idioms in
the latter category (e.g. 'using "test z$name = zexpected" when
we do not know what $name contains' falls into that).
