From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cache-tree: replace a sscanf() by two strtol() calls
Date: Tue, 02 May 2006 16:26:18 -0700
Message-ID: <7v1wvcknz9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605020327400.31493@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 01:26:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb4G6-00014D-NN
	for gcvg-git@gmane.org; Wed, 03 May 2006 01:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWEBX0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 19:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWEBX0U
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 19:26:20 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:19189 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751006AbWEBX0T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 19:26:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060502232619.KBPZ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 19:26:19 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19439>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On one of my systems, sscanf() first calls strlen() on the buffer. But
> this buffer is not terminated by NUL. So git crashed.

Interesting.

"git grep sscanf next -- '*.c'" reports handful sscanf() there.
Most of them scan argv[], which are NUL terminated, so they
should be OK.  The rest in convert-objects.c, tree-walk.c, and
tree.c all scan the mode bits in tree objects, which will later
have the pathname component terminated with NUL, so that would
also be OK.

But I think your patch is wrong, and makes it ignore cache-tree
structure; I suspect you have two off-by-one errors and are
making buf and size out of sync.

> 	Maybe, a better solution would be to store the integers in 
> 	binary form. But I am not familiar with that part of git, and
> 	further, it would break setups which already have an index
> 	with cache-tree information.

In theory, it is stashed in the extension section of index so we
could define a new extension type, say "TRE2" and store the
information in the new format.  But this is purely a cache used
as optimiation, so we could just say, "make sure to save local
modifications before doing an update, then run 'rm .git/index &&
git-read-tree HEAD' please".

I've applied a fixed up one, but I am actually thinking about
ripping out the whole cache-tree thing and redoing it all in the
index.
 
Currently the index stores set of blobs after flattening the
hierarchical tree structure, losing the original "tree"
information.  We could instead store something that looks like
"ls-tree -t -r" output (plus the toplevel tree information which
"ls-tree -t -r" does not give you).  Just like an update-index
on the path t/t0000-basic.sh invalidates the cache-tree entry
for "" and "t/", we could either invalidate or recompute (I am
inclined to do the former to make things lazy) these "tree"
entries in the index.  This would be more direct way to store
what I am storing in the cache-tree.

Keeping the object names of unchanged subtrees available will
allow us to walk the index and a tree (or two or more trees) in
parallel in various applications.  "diff-index --cached" and
"read-tree -m" extract one entry from tree and index for each
blob, but when we have an up-to-date information for a subtree
in the index, and when that subtree matches the corresponding
subtree in the tree object diff-index or read-tree is reading,
the application can short-cut without reading anything in the
subtree.
