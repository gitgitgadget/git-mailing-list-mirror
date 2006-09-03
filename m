From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sun, 03 Sep 2006 15:34:04 -0700
Message-ID: <7vodtwtw9v.fsf@assigned-by-dhcp.cox.net>
References: <20060829165811.GB21729@spearce.org>
	<9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>
	<20060829175819.GE21729@spearce.org>
	<9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
	<20060829190548.GK21729@spearce.org>
	<9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
	<20060829232007.GC22935@spearce.org>
	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	<20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
	<7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609021138500.27779@g5.osdl.org>
	<7vslj8tydc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609031456520.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 00:34:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK0Xr-0007yL-5g
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 00:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWICWeJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 18:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWICWeA
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 18:34:00 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28156 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751076AbWICWdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 18:33:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060903223348.ZKJU6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Sep 2006 18:33:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HyZp1V0031kojtg0000000
	Sun, 03 Sep 2006 18:33:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609031456520.27779@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 3 Sep 2006 15:00:16 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26389>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 3 Sep 2006, Junio C Hamano wrote:
>> 
>> Quite bad.  For the kernel archive of today (I usually am nearly
>> fully packed):
>
> Ok. Is it less painful if it just checks the zlib CRC...

I haven't checked myself but somebody said that zlib CRC is of
preimage so we would need to incur inflate cost anyway if that
is the case.  But I think it may be a reasonable comproise to
assume that an existing delta that inflates properly would apply
to its base object, and if we can assume that we do not have to
check the inflated xdelta data.  Oops, not really, there is no
check other than the pack overall SHA-1 checksum that protects
the 20-byte base object name recorded in the pack.

> ... and that the SHA1 
> _exists_ for a delta - although I guess we check that indirectly by just 
> accepting the delta in the first place)? That combination should still be 
> a fairly strong check, of course.

Another thing the current check is _not_ doing is for this
pathological case:

 - .idx table says the pack entry is N bytes

 - unpack_entry_gently() used in the revalidate code uses the
   usual codepath that says "here is the start of the pack
   entry; inflate using as much data as you need"; .idx is
   somehow wrong and it needed N+M bytes where 0 < M.

 - we copy out N bytes because we belive .idx.


-- 
VGER BF report: U 0.626721
