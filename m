From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use a hashtable for objects instead of a sorted list
Date: Sun, 12 Feb 2006 15:31:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602121517050.15392@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87slqpg11q.fsf@wine.dyndns.org>
 <Pine.LNX.4.63.0602120254260.10235@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virrli9am.fsf@assigned-by-dhcp.cox.net> <87oe1dez7k.fsf@wine.dyndns.org>
 <7vaccwdbfs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Feb 12 15:31:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8IGP-0006Wq-JU
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 15:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWBLObm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 09:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWBLObm
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 09:31:42 -0500
Received: from mail.gmx.net ([213.165.64.21]:19884 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750764AbWBLObm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 09:31:42 -0500
Received: (qmail invoked by alias); 12 Feb 2006 14:31:40 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp010) with SMTP; 12 Feb 2006 15:31:40 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vaccwdbfs.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15998>

Hi,

On Sun, 12 Feb 2006, Junio C Hamano wrote:

> Alexandre Julliard <julliard@winehq.org> writes:
> 
> > Junio C Hamano <junkio@cox.net> writes:
> >
> >> Alexandle, if you have a chance, could you try Johannes' patch
> >> on your workload to see if it works OK for you?
> >
> > It works great for me, CPU time is down to 15 sec instead of 20 sec
> > with my patch.
> 
> Thanks.  Now we have three independent numbers to back up that
> Johannes is the winner....
> 
> Grrrrrrr.  Please, DO NOT USE THIS ONE YET.
> 
> At least, not with your production repository.
> 
> I am trying to nail it down but it appears at least fsck-objects
> using this version gives bogus results.  I am first trying to
> see if my primary working repository is sane.
> 
> Oh, and thanks again for your initial patch, which was what
> started this drastic improvement.

I am sorry! I tested fsck, but only *once*, since I did not think such a 
creepy bug was in there. And then, I had to run to sing Beethoven's Missa 
Solemnis, and missed all the action about this patch.

Just a few remarks around the comments in this thread:

- the doubling of obj_allocs is arbitrary. Originally, I planned to do the 
growing much faster, which would have been helped by the fact. But it 
turned out my thinking was defective. So, you can grow the hashtable by 
whatever you like (doubling is quite effective, though).

- hashtable has expected O(1) insertion, and that is what boosts the 
performance. Since the table growing is linear in the number of objects 
(both size and computing time), and all operations afterwards are linear 
on the table, *and the hash is already computed*, the hashtable is 
preferrable over other data structures (sorted list has O(n) insertion 
time, and tree still O(log n)).

- the bug Junio fixed was not triggered here, since I did all the testing 
on my venerable iBook. The PowerPC architecture evidently aligns 
all pointers to 32-bit, so I could reinterpret the pointer as to an 
unsigned int. Note that there is a small overhead in Junio's version, but 
it is probably not worth the hassle to make that a compile time option. 
But I agree with Florian that memcpy would be more efficient.

- Arithmetic and Boolean operations on 32-bit integers typically are 
handled very efficiently in modern 32-bit CPUs, so there should be no 
reason to use "&" instead of "%" (especially since understanding the code 
wouldn't be helped by that).

Ciao,
Dscho
