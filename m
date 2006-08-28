From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] parse_object: check if buffer is non-NULL before freeing it
Date: Sun, 27 Aug 2006 22:46:09 -0700
Message-ID: <7v3bbhtntq.fsf@assigned-by-dhcp.cox.net>
References: <20060828003129.GE20904@diku.dk>
	<7vsljhtrsv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0608272131020.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 07:45:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHZwP-00069I-96
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 07:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWH1Fpg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 01:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWH1Fpg
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 01:45:36 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:28116 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750915AbWH1Fpf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 01:45:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060828054535.QAOS6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 28 Aug 2006 01:45:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id FHlY1V00K4Noztg0000000
	Mon, 28 Aug 2006 01:45:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608272131020.27779@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 27 Aug 2006 21:33:16 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26143>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 27 Aug 2006, Junio C Hamano wrote:
>> 
>> Eh, free(NULL) should work just fine.  It is "other places" that
>> is misguided and needs to be fixed.
>
> Well, some very old libraries will SIGSEGV on free(NULL). 
>
> Admittedly those libraries are either very old or _very_ broken, but if 
> you want to be strictly portable, you should not ever pass NULL to free(), 
> unless you actually got it from a malloc(0) (and even then, it might be a 
> really broken libc that just ran out of memory).

Fair enough, but I think there are many places we already assume
the library handles free(NULL) sensibly.

> I actually suspect we should wrap all free() calls as "xfree()", which may 
> also help us some day if we want to do any memory usage statistics.

That sounds sensible.

Another thing I was thinking about was to extend the existing
XMALLOC_POISON debugging to allow also xrealloc()'ed area.  That
would unfortunately involve wrapping strdup() and x*alloc() to
make sure all allocations we do go through xmalloc() and then
store the current allocation size somewhere hidden (immediately
before, perhaps) in the area xmalloc() returns, but at that
point running git under valgrind would probably be easier.
