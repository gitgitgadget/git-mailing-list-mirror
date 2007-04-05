From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Added use of xmalloc() on diff-delta.c
Date: Wed, 04 Apr 2007 22:14:12 -0700
Message-ID: <7vy7l7wggr.fsf@assigned-by-dhcp.cox.net>
References: <11757126093105-git-send-email-ribas@c3sl.ufpr.br>
	<7vejn02bcv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704041525220.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruno Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 07:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZKIq-00071L-La
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 07:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbXDEFOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 01:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbXDEFOO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 01:14:14 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:49801 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161184AbXDEFON (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 01:14:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405051414.ZVNX25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 01:14:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jHEC1W00T1kojtg0000000; Thu, 05 Apr 2007 01:14:13 -0400
In-Reply-To: <Pine.LNX.4.64.0704041525220.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 4 Apr 2007 15:31:21 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43793>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 4 Apr 2007, Junio C Hamano wrote:
>> 
>> These patches take that nice property away, making libification
>> more difficult, which is the downside.  Is there an upside?
>
> Well, we could just make the libification rule very simple:
>
>  - the library does *not* include "xmalloc()", and you have to handle 
>    out-of-memory situations yourself inside the xmalloc() that *you* as a 
>    libification user provide!.
>
> Then, we just make our xmalloc() be non-inlined (which we should do 
> *anyway* - it's long since grown so big that it shouldn't be inlined in 
> the first place), and we make it part of a non-library git object file.

I agree that is probably a sane thing to do for existing callers
of xmalloc() -- the callers are not prepared to handle
(near-)oom case gracefully to begin with.

Your "libified git decides how xmalloc() copes with (near-)oom
condition gracefully" is much better than "memory-allocating
function in git declares that oom in xmalloc() is fatal", which
is what we currently have.

I however think it is an independent issue, wrt the part Bruno's
patch touches.  In the case of this particular call chain
between create_delta()/create_delta_index() and its caller, I
think the code that is there allows nicer arrangement.  The
caller could instead easily attempt to cope with (near-)oom
condition more gracefully.  And that was my suggestion about
returning 0 when delta_index cannot be built instead of dying.

Of course, this caller is in memory-hungry "pack-objects", and
all of the above is mostly academic, as failure to allocate
memory in create_delta_index() would most likely mean you would
have trouble allocating memory for other more important data.
