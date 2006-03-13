From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sun, 12 Mar 2006 20:14:21 -0800
Message-ID: <7vwtezt202.fsf@assigned-by-dhcp.cox.net>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
	<7voe0bdeyr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
	<7vk6azcv9y.fsf@assigned-by-dhcp.cox.net>
	<7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603121700410.3618@g5.osdl.org>
	<Pine.LNX.4.64.0603121710110.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 05:14:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIeRz-0007Ry-CS
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 05:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWCMEO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 23:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWCMEO2
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 23:14:28 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:63922 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751430AbWCMEO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 23:14:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060313041127.ZOHQ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Mar 2006 23:11:27 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603121710110.3618@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 12 Mar 2006 17:29:45 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17543>

Linus Torvalds <torvalds@osdl.org> writes:

> However, it worries me a bit that you don't check the source strings, 
> especially since the hash you use seems somewhat suspect (why limit it to 
> essentially just 16 bits? Wouldn't it be best to have the _biggest_ prime 
> that fits in the "hashval" thing, which is at least 32 bits? Also, 
> shouldn't you make that spanhash thing use a "unsigned int" instead of 
> "unsigned long"?)
>
> So I would suggest instead the hash function to be:
>
> 	typedef unsigned long long u64;
>
> 	/* Biggest prime in 32 bits */
> 	#define HASHVAL (4294967291u)

Actually what you are seeing is the best compromise I've come up
with.  There were about a dozen crappoid that turned out to be
suboptimal I threw away.

The hashsize is an interesting example of such a compromise
between precision and performance.  It is true that full 32-bit
hash gives us more precise match detection.  If you change the
current hash function to divide with (4294967291u), the rename
similarity score assigned to some (but not all) paths in the
example dataset we have been using (diff between v2.6.12 and
v2.6.14) decreases by about 1% -- this comes from the fact that
the hashvalue capped to 16-bit gives some false hits that larger
hashbase value can tell apart.  Because of it, some paths near
the rename detection threshold stop being recognized as renames.

However, the runtime of the same dataset increases quite a bit
when we do this.  I think this is because we need to keep more
different hash values in the hashtable and the cost to randomly
access into a huge table starts to hurt, unlike the 16-bit
capped version whose hash table never needs to grow beyond 65k
entries.

        next    39.77user 0.22system 0:40.78elapsed
                0inputs+0outputs (0major+18855minor)

        32-bit  66.32user 0.15system 1:07.00elapsed
                0inputs+0outputs (0major+21057minor)

Admittedly, we should not optimize for one particular test case,
but we should start from somewhere.

Decreasing the hashsize to 14-bit or less had noticeable
degradation on the quality of renames the algorithm detects and
misses to detect, both in v2.6.12..v2.6.14 test and some tests
in git.git repository.

One obvious change we could do is to make the hashsize to
0x1800D (a prime halfway between 16- and 17-bit); currently the
hashtable grows double every time when the table of the current
size fills up sufficiently, but the current hashbase cannot fit
in 16-bit, so we _are_ already using a table with 128K entries
in some cases.
