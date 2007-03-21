From: Junio C Hamano <junkio@cox.net>
Subject: Re: Be more careful about zlib return values
Date: Wed, 21 Mar 2007 01:11:57 -0700
Message-ID: <7vodmn2eya.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703201124260.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 09:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTvvR-0000Nc-Q9
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 09:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbXCUIL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 04:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbXCUIL7
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 04:11:59 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34044 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbXCUIL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 04:11:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321081157.LUOY1312.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 04:11:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dLBx1W00E1kojtg0000000; Wed, 21 Mar 2007 04:11:57 -0400
In-Reply-To: <Pine.LNX.4.64.0703201124260.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 20 Mar 2007 11:38:34 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42782>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> When creating a new object, we use "deflate(stream, Z_FINISH)" in a loop 
> until it no longer returns Z_OK, and then we do "deflateEnd()" to finish 
> up business.
>
> That should all work, but the fact is, it's not how you're _supposed_ to 
> use the zlib return values properly:
> ...
> Somebody who has worked more with zlib should probably double-check me, 
> but this is what <zlib.h> claims is the right thing to do.
>
> 		Linus

I am observing a very curious performance regression with this
patch.  I do not see anything obviously wrong correctness-wise
nor performance-wise with it.

This is driving me crazy, as the benchmark is in that repository
with a 1.7GB pack:

	$ git-rev-list HEAD -- org.eclipse.debug.ui/ >/dev/null

and the patch is ONLY ABOUT write_sha1_file() codepath.  The function
should not even be called!

Without the patch (3 typical runs):

16.16user 0.16system 0:16.32elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+79008minor)pagefaults 0swaps
15.84user 0.14system 0:16.02elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+79009minor)pagefaults 0swaps
16.04user 0.12system 0:16.17elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+79008minor)pagefaults 0swaps

With the patch:

17.62user 0.20system 0:17.94elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+79009minor)pagefaults 0swaps
17.79user 0.19system 0:18.03elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+79011minor)pagefaults 0swaps
17.40user 0.14system 0:17.63elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+79009minor)pagefaults 0swaps

Another funny thing is that if I replace the body of
write_sha1_file() with just:

int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
{
	setup_object_header(NULL, NULL, 0);
	die("foo");
}

I get somewhat faster number.

I guess I probably should write it off as some curiosity coming
from insn cacheline bouncing between hot functions, that is
caused by the size of this unused function changing.
