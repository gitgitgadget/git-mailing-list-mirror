From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Darcs-git: a few notes for Git hackers
Date: Mon, 09 May 2005 20:01:25 +0200
Message-ID: <7ihdhc5le2.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@abridgegame.org
X-From: git-owner@vger.kernel.org Mon May 09 20:38:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVCSi-0004yy-3s
	for gcvg-git@gmane.org; Mon, 09 May 2005 19:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVEISBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 14:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVEISBq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 14:01:46 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:17354 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S261466AbVEISBd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 14:01:33 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j49I1BhD090037
          ; Mon, 9 May 2005 20:01:11 +0200 (CEST)
X-Ids: 166
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id j49I1PMo020794
          ; Mon, 9 May 2005 20:01:27 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DVCZJ-00076C-1m; Mon, 09 May 2005 20:01:25 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.166]); Mon, 09 May 2005 20:01:13 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 427FA567.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Here are a few notes about Git that should probably be taken into
account by people working on Git itself or on Git wrappers.  The notes
apply to Linus' Git-0.6, which is the code I'm using in Darcs-git;
some of them might no longer be applicable to Darcs.


1. Darcs-git uses the fact that Git updates are atomic when reading
from a Git repository.  Darcs-git almost writes to Git repositories
atomically, with one exception: it performs a non-atomic
read/update/write cycle on .git/HEAD.

For that reason, I'm taking a high-level lock on .git repositories
whenever I write them.  The lockfile is ``.git/lock''.  I haven't
thought about whether Darcs can be easily coerced into accessing Git
repos atomically; have people writing Git wrappers found the need for
a global lock?


2. The files git.h and git.c in Darcs-git are a simple ``libgit'' that
contains just enough functionality for Darcs-git; they use the
functionality of sha1_file.c and read_cache.c from Git-0.6.

I've found a few problems with the interfaces in these files:

 - the global variables sha1_file_directory, active_cache, active_nr
   and active_alloc are not marked ``extern'' in cache.h.  This breaks
   linkers that don't grok common symbols, such as the one in GHCi
   (silly GHCi).

 - the function write_sha1_file takes the metadata and the data in a
   contiguous buffer, which is a problem when the data has been
   allocated by a higher layer.  I'm currently working around the
   problem by memcpy-ing everything into a temp buffer, but that's
   obviously not a good thing.  I don't care whether write_sha1_file
   is changed to use a writev-like interface, or to take the metadata
   explicitly (as in char *type, unsigned long length).

 - there is no (usable) function to write a tree; there's the code in
   write_tree.c, but it's not generally useful.  See the function
   ``git_write_tree_done'' in git.c for the type of interface I'm
   thinking of.

 - there's no way to have multiple simultaneous caches, short of
   hacking at the values of Git's global variables by hand.

As I'd rather not maintain my own version of Git, I'd be mighty
grateful if some friendly Git hacker could fix the above.

                                        Juliusz
