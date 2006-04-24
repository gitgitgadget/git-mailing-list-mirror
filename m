From: Junio C Hamano <junkio@cox.net>
Subject: maintenance of cache-tree data
Date: Mon, 24 Apr 2006 14:31:32 -0700
Message-ID: <7vodyq64p7.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v3bg3etnv.fsf@assigned-by-dhcp.cox.net>
	<7vodyrdas9.fsf@assigned-by-dhcp.cox.net>
	<7v8xpvd69s.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvesz8r8o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Apr 24 23:32:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY8f1-0008AA-Rf
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 23:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWDXVbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 17:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWDXVbe
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 17:31:34 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50571 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751280AbWDXVbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 17:31:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060424213133.IRUD25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Apr 2006 17:31:33 -0400
To: git@vger.kernel.org
In-Reply-To: <7vvesz8r8o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 23 Apr 2006 22:41:43 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19111>

Junio C Hamano <junkio@cox.net> writes:

>  (1) When git-write-tree writes out trees from the index, we
>      store <directory, tree SHA1> pair for all the trees we
>      compute, in .git/index.aux file.

There are two reasons I did not make this extra information part
of the index file.

The number one reason was because the current index file format
is pretty dense, and I did not find an obvious hole in the
front, in the middle or at the tail to sneak extra data in
without upsetting existing code and without updating index file
version.  If this were a change to add a great new feature, that
might have warranted bumping the version up, but the cache-tree
is an optimization and if you lose that information, all you
have lost is that now your write-tree needs to recompute the
whole tree as before (IOW, not much).

The second reason was I wanted to do this step-by-step, and
wanted to do a demonstration of an end-to-end workflow that
gains from this set of changes (apply followed by write-tree
was an obvious minimum set of commands), and while doing so I
did not have to disrupt other commands that are unaware of this
extension.

Having said that, cache-tree.c has an internal interface to
serialize the cache-tree data in-core, primarily because I was
unsure if I wanted to append this information somewhere inside
the main index file or have it external when I did it; so we
could later push it into the index if we wanted to.

Ideally, everybody who writes index should be converted to
update cache-tree to help eventual write-tree.  Right now, if a
command updates index without updating a matching cache-tree,
the whole thing is invalidated; this way, you do not risk using
stale "cached" data.

Currently the command that primes the cache-tree is write-tree.
This may be counterintuitive -- even I myself would expect that
read-tree would prime it, and various index-updaters invalidate
subtrees they touch, and write-tree to use the surviving parts
to speed up what it needs to do, and write out an updated,
fully-vaild cache-tree.  I did not do it only because it was not
necessary for "apply then write-tree" cycle, but read-tree
should be taught about cache-tree to help others, _and_ to help
itself.

When "read-tree -m O A B" merges three trees, we iterate over
all index entries, even when only a small part of the tree has
changed.  This could be helped in a big way if the current index
has valid cache-tree information for the parts unaffected by the
merge.  If all three trees have identical tree in higher level
subdirectory (e.g. "fs/" in the kernel source), and if the index
has not touched anything in "fs/" since it read from our tree
(i.e. "A"), then we do not even have to descend into that
directory in the working tree to see which index entries are
dirty.  We can just keep index entries that begin with "fs/"
intact, keep the cache-tree entry for that directory as it was
read from "A".  This would be a big win -- we do not have to
read tree objects under "fs/" (there are 62 trees under "fs/",
so we save uncompressing and undeltifying 180 objects).  This
operation would need to invalidate entries in cache-tree that
are involved in the actual merge.  Branch-switching two-tree
form "read-tree -m OLD NEW" probably can benefit from the same
optimization.

Obviously, a single-tree form of read-tree should be able to
prime the cache-tree with fully valid data before writing the
index out.

Having said that, I am not touching read-tree myself for now; I
am lazy.
