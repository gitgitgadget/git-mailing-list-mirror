From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 15:37:30 -0700
Message-ID: <7vfy83qyxh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703162257560.18328@xanadu.home>
	<Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 23:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HShX1-0007TU-N1
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 23:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbXCQWhd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 18:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbXCQWhd
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 18:37:33 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33365 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbXCQWhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 18:37:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070317223731.DHSN321.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Mar 2007 18:37:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bydW1W00N1kojtg0000000; Sat, 17 Mar 2007 18:37:31 -0400
In-Reply-To: <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 17 Mar 2007 14:45:49 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42455>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ie, we still re-generate some of the objects multiple times, but now, 
> rather than generating them (on average) 20+ times each, we now generate 
> them an average of just 1.3 times each. Which explains why the wall-time 
> goes down by over a factor of two.

This is beautiful.  You only cache what we were about to discard
anyway, and when giving a cached one out, you invalidate the
cached entry, so there is no way the patch can introduce leaks
nor double-frees and it is absolutely safe (as long as we can
pin the packed_git structure, which I think is the case --- even
when we re-read the packs, I do not think we discard old ones).

I've thought about possible ways to improve on it, but came up
almost empty.

When unpacking a depth-3 deltified object A, the code finds the
target object A (which is a delta), ask for its base B and put B
in the cache after using it to reconstitute A.  While doing so,
the first-generation base B is also a delta so its base C (which
is a non-delta) is found and placed in the cache.  When A is
returned, the cache has B and C.  If you ask for B at this
point, we read the delta, pick up its base C from the cache,
apply, and return while putting C back in the cache.  If you ask
for A after that, we do not read from the cache, although it is
available.

Which feels a bit wasteful at first sight, and we *could* make
read_packed_sha1() also steal from the cache, but after thinking
about it a bit, I am not sure if it is worth it.  The contract
between read_packed_sha1() and read_sha1_file() and its callers
is that the returned data belongs to the caller and it is a
responsibility for the caller to free the buffer, and also the
caller is free to modify it, so stealing from the cache from
that codepath means an extra allocation and memcpy.  If the
object stolen from the cache is of sufficient depth, it might be
worth it, but to decide it we somehow need to compute and store
which delta depth the cached one is at.

In any way, your code makes a deeply delitified packfiles a lot
more practical.  As long as the working set of delta chains fits
in the cache, after unpacking the longuest delta, the objects on
the chain can be had by one lookup and one delta application.

Very good job.

> In general, this all seems very cool. The patches are simple enough that I 
> think this is very safe to merge indeed: the only question I have is that 
> somebody should verify that the "struct packed_git *p" is stable over the 
> whole lifetime of a process - so that we can use it as a hash key without 
> having to invalidate hashes if we unmap a pack (I *think* we just unmap 
> the virtual mapping, and "struct packed_git *" stays valid, but Junio 
> should ack that for me).

Ack ;-)
