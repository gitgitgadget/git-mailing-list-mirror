From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix object re-hashing
Date: Sun, 12 Feb 2006 11:10:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602121101040.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602121006360.3691@g5.osdl.org> <7vaccwbf6v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602121037460.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 20:10:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Mc6-0005c6-4h
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 20:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWBLTKQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 14:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWBLTKQ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 14:10:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:645 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751415AbWBLTKP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 14:10:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1CJABDZ017729
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Feb 2006 11:10:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1CJABQp016264;
	Sun, 12 Feb 2006 11:10:11 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602121037460.3691@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16012>



On Sun, 12 Feb 2006, Linus Torvalds wrote:
> 
>  - the "overflow of the overflow": when the linear probing itself 
>    overflows the size of the hash queue, it will "change direction" by 
>    overflowing back to index zero.
> 
>    Happily, the re-hashing does not need to care about this case, because 
>    the new hash is bigger: the rule we have when doing the re-hashing is 
>    that as we re-hash, the "i" entries we have already re-hashed are all 
>    valid in the new hash, so even if overflow occurs, it will occur the 
>    right way (and if it overflows all the way past the current "i", we'll 
>    re-hash the already re-hashed entry anyway).

Btw, this is only always true if the new hash is at least twice the size 
of the old hash, I think. Otherwise a re-hash can fill up the new entries 
and overflow entirely before we've actually even re-hashed all the old 
entries, and then we'd need to re-hash even the overflowed entries (which 
are now below "i").

If the new size is at least twice the old size, the "upper area" cannot 
overflow completely (there has to be empty room), and we cannot be in the 
situation that we need to move even the overflowed entries when we remove 
an old hash entry.

Anyway, if all this makes you nervous, the conceptually much simpler way 
to do the re-sizing is to not do the in-place re-hashing. Instead of doing 
the xrealloc(), just do a "xmalloc()" of the new area, do the re-hashing 
(which now _must_ re-hash in just the "0..oldcount-1" old area) into the 
new area, and then free the old area after rehashing.

That would make things more obviously correct, and perhaps simpler.

Johannes, do you want to try that?

Btw, as it currently stands, I worry a tiny tiny bit about the

	obj_allocs = (obj_allocs < 32 ? 32 : 2 * obj_allocs)

thing, because I think that second "32" needs to be a "64" to be really 
safe (ie guarantee that the new obj_allocs value is always at least twice 
the old one).

Anyway, I'm pretty sure people smarter than me have already codified 
exactly what needs to be done for a in-place rehash of a linear probe hash 
overflow algorithm. This must all be in some "hashing 101" book. I had to 
think it through from first principles rather than "knowing" what the 
right answer was (which probably means that I slept through some 
fundamental algorithms class in University ;)

		Linus
