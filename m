From: Junio C Hamano <junkio@cox.net>
Subject: Re: maintenance of cache-tree data
Date: Tue, 25 Apr 2006 16:05:56 -0700
Message-ID: <7vy7xttfvv.fsf@assigned-by-dhcp.cox.net>
References: <7v3bg3etnv.fsf@assigned-by-dhcp.cox.net>
	<7vodyrdas9.fsf@assigned-by-dhcp.cox.net>
	<7v8xpvd69s.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvesz8r8o.fsf@assigned-by-dhcp.cox.net>
	<7vodyq64p7.fsf_-_@assigned-by-dhcp.cox.net>
	<7vk69e61s4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Apr 26 01:06:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYWbk-00072f-Ck
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 01:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWDYXF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 19:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWDYXF6
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 19:05:58 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64148 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932104AbWDYXF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 19:05:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060425230557.DQCT27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Apr 2006 19:05:57 -0400
To: git@vger.kernel.org
In-Reply-To: <7vk69e61s4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 24 Apr 2006 15:34:35 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19177>

Junio C Hamano <junkio@cox.net> writes:

> Well, I was blind ;-).  As long as the whole-file SHA1 matches,
> read_cache() does not care if we have extra data after the
> series of active_nr cache entry data in the index file.
>
> I'm working on a patch now.

So I did.

There is one bad thing; so far "write-tree" was a read-only
consumer of the index file, but now it primes the cache-tree
structure and needs to update the index.  But that is minor.

While I was at it, I made this "stuffing extra cruft in the
index" slightly more generic than I needed it for this
particular application.  What I see this _might_ be useful for
are:

 - We would want to store which commit of a subproject a
   particular subdirectory came from.  This was one missing
   piece from the "bind commit" proposal that wasn't implemented
   in the jc/bind branch.

 - We might want to record "at this path there is a directory,
   albeit empty"; this cannot be expressed with an usual index
   entry.

   We might be able to use cache-tree for that, but I think this
   is something different at the logical level.  While
   cache-tree is to be fully populated (by write-tree and
   perhaps read-tree later) and invalidated partially when
   update-index and friends smudge part of the tree, this is not
   something we would want to even invalidate (IOW, it should
   always be up-to-date), so they serve different purposes.


I still haven't looked at the read-tree yet, but as I outlined
in a previous message, its intra-index merge could take
advantage of cache-tree.  "diff-index", especially "--cached"
kind, also could use it to skip unchanged subtrees altogether.
