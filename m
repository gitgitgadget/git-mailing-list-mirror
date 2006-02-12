From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix object re-hashing
Date: Sun, 12 Feb 2006 10:53:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602121037460.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602121006360.3691@g5.osdl.org> <7vaccwbf6v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 19:53:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8MLd-0001Ub-NI
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 19:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWBLSxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 13:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWBLSxX
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 13:53:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750861AbWBLSxW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 13:53:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1CIrJDZ016982
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Feb 2006 10:53:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1CIrI0B015726;
	Sun, 12 Feb 2006 10:53:18 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vaccwbf6v.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16010>



On Sun, 12 Feb 2006, Junio C Hamano wrote:
> 
> This "fix" makes the symptom that me fire two (maybe three)
> Grrrrr messages earlier this morning disappear.

Goodie. I assume that was the fixed fix, not my original "edit out the 
useless optimization and then break it totally" fix ;)

> I haven't had my caffeine nor nicotine yet after my short sleep, so I 
> need to take some time understanding your explanation first, but I am 
> reasonably sure this must be it (not that I do not trust you, not at all 
> -- it is that I do not trust *me* applying a patch without understanding 
> when I have a bug reproducible).

The basic notion is that this hashing algorithm uses a normal "linear 
probing" overflow approach, which basically means that overflows in 
a hash bucket always just probe the next few buckets to find an empty one.

That's a really simple (and fairly cache-friendly) approach, and it makes 
tons of sense, especially since we always re-size the hash to guarantee 
that we'll have empty slots. It's a bit more subtle - especially when 
re-hashing - than the probably more common "collission chain" approach, 
though.

Now, when we re-hash, the important rule is:

 - the re-hashing has to walk in the same direction as the overflow.

This is important, because when we move a hashed entry, that automatically 
means that even otherwise _already_correctly_ hashed entries may need to 
be moved down (ie even if their "inherent hash" does not change, their 
_effective_ hash address changes because their overflow position needs to 
be fixed up).

There are two interesting cases:

 - the "overflow of the overflow": when the linear probing itself 
   overflows the size of the hash queue, it will "change direction" by 
   overflowing back to index zero.

   Happily, the re-hashing does not need to care about this case, because 
   the new hash is bigger: the rule we have when doing the re-hashing is 
   that as we re-hash, the "i" entries we have already re-hashed are all 
   valid in the new hash, so even if overflow occurs, it will occur the 
   right way (and if it overflows all the way past the current "i", we'll 
   re-hash the already re-hashed entry anyway).

 - the old/new border case. In particular, the trivial logic says that we 
   only need to re-hash entries that were hashed with the old hash. That's 
   what the broken code did: it only traversed "0..oldcount-1", because 
   any entries that had an index bigger than or equal to "oldcount" were 
   obviously _already_ re-hashed.

   That logic sounds obvious, but it falls down on exactly the fact that 
   we may indeed have to re-hash even entries that already were re-hashed 
   with the new algorithm, exactly because of the overflow changes.

So the boundary for old/new is really: "you need to rehash all entries 
that were old, but then you _also_ need to rehash the list of entries that 
you rehashed that might need to be moved down to an empty spot vacated by 
an old hash".

So the stop condition really ends up being: "stop when you have seen all 
old hash entries _and_ at least one empty entry after that", since an 
empty entry means that there was no overflow from earlier positions past 
that position. But it's just simpler to walk the whole damn new thing and 
not worry about it.

		Linus
