From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Add ALL_LDFLAGS to the git target.
Date: Tue, 28 Mar 2006 11:46:28 -0800
Message-ID: <15693.1143575188@lotus.CS.Berkeley.EDU>
References: <7vu09jks1u.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 28 21:46:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOK9A-0001AS-St
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 21:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWC1Tq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 14:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWC1Tq3
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 14:46:29 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:26777 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751310AbWC1Tq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 14:46:28 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k2SJkSgH015695
	for <git@vger.kernel.org>; Tue, 28 Mar 2006 11:46:28 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k2SJkSb7015694
	for <git@vger.kernel.org>; Tue, 28 Mar 2006 11:46:28 -0800 (PST)
To: git@vger.kernel.org
In-reply-to: <7vu09jks1u.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18127>

And Junio C Hamano writes:
 - Hmph.  We do fprintf(stderr, "blah\r") to draw them.  The
 - standard says that "standard error stream is not fully
 - buffered", but I guess it does not necessarily mean it is
 - unbuffered, so we probably need to fflush(3) there.  Would
 - something like this help?

I suppose I should have mentioned that I tried flushing 
stderr.  Your more comprehensive flushing also does not 
fix it, giving outputs like:
> Unpacking Total 3333 objects
> , written 33 (delta 1), reused 0 (delta 0)

The problem is that stderr from a child is not tied to any 
stream of its parent.  Generally, as far as I know, you 
cannot make any assumptions about how pipes from separate 
processes are interleaved in the output.  Some standard may 
say something, but I have no idea what or if anyone listens.
And this particular system is a busy SMP node, making the
problem worse.

Line-buffered streams like stdout tend to work, but not 
unbuffered streams like stderr.  We can't make stderr line-
buffered without breaking the status indicator...

If I add a third fd to all the pipes and dup it to stderr,
the tests work.  I never read from that fd, so I never get
the status output...  Progress needs to be part of the 
protocol so front ends can handle it cleanly rather than 
using stderr tricks.

So some possibilities:
  1) Add the ability to pass options through the whole
     connect system.  Then pass -q in the tester.
  2) Add a specific "quiet" command to the protocol for
     just passing -q from git-fetch-pack.  Pass -q in the 
     tester.
  3) Add an option to pack-objects that dumps progress
     output to stdout in a special packet format.  Then
     update everyone who talks through upload-pack to
     expect another phase of informational messages after
     negotiating object differences and before the pack
     data.

The first two are cosmetic fixes only, and #2 is a cheap,
ugly, but easy hack.

This problem is (to me) low priority.  It unfortunately 
breaks a test case on AIX, but I can live with it for now.
If others here start to listen to the gospel of git, well,
I'll need to fix it.  (But I once recommended Arch, and
people stopped listening after they tried it.)

Folks using moderately-loaded SMPs may experience similar 
problems.  But if they're fetching large packs, the problem
likely won't appear at all.

Jason

P.S. For the whole finding-a-function-name business, some of 
us are using git on fixed-format Fortran.  Every non-comment
line begins with whitespace...  ;)  And in free format, many
people don't add that first indentation within subroutines.
