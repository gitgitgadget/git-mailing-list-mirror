From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] read-tree A B C: do not create a bogus index and do not
 segfault
Date: Thu, 12 Mar 2009 10:46:45 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903121024400.19665@iabervon.org>
References: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com> <alpine.DEB.1.00.0903102120290.14295@intel-tinevez-2-302> <35476bd20903110059v7d6d8aa0g93af17a940c91919@mail.gmail.com> <alpine.DEB.1.00.0903111300330.10279@pacific.mpi-cbg.de>
 <7vtz5zjnai.fsf@gitster.siamese.dyndns.org> <7vfxhjjkcm.fsf@gitster.siamese.dyndns.org> <7v3adjjj1y.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 15:51:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhmDl-0003wo-7i
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 15:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757184AbZCLOqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 10:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbZCLOqt
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 10:46:49 -0400
Received: from iabervon.org ([66.92.72.58]:56353 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757173AbZCLOqs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 10:46:48 -0400
Received: (qmail 23606 invoked by uid 1000); 12 Mar 2009 14:46:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Mar 2009 14:46:45 -0000
In-Reply-To: <7v3adjjj1y.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113073>

On Thu, 12 Mar 2009, Junio C Hamano wrote:

> "git read-tree A B C..." without the "-m" (merge) option is a way to read
> these trees on top of each other to get an overlay of them.
> 
> An ancient commit ee6566e (Rewrite read-tree, 2005-09-05) passed the
> ADD_CACHE_SKIP_DFCHECK flag when calling add_index_entry() to add the
> paths obtained from these trees to the index, but it is an incorrect use
> of the flag.  The flag is meant to be used by callers who know the
> addition of the entry does not introduce a D/F conflict to the index in
> order to avoid the overhead of checking.

I think that this implementation actually thought it knew that the entry 
couldn't cause a D/F conflict. (Of course, it turned out 2.5 years later 
that it was wrong, on account of missing an implication of the way the 
index is sorted.)

> This bug resulted in a bogus index that records both "x" and "x/z" as a
> blob after reading three trees that have paths ("x"), ("x", "y"), and
> ("x/z", "y") respectively.  34110cd (Make 'unpack_trees()' have a separate
> source and destination index, 2008-03-06) refactored the callsites of
> add_index_entry() incorrectly and added more codepaths that use this flag
> when it shouldn't be used.
>
> Also, 0190457 (Move 'unpack_trees()' over to 'traverse_trees()' interface,
> 2008-03-05) introduced a bug to call add_index_entry() for the tree that
> does not have the path in it, passing NULL as a cache entry.  This caused
> reading multiple trees, one of which has path "x" but another doesn't, to
> segfault.

I think one of the later refactorings may have given up on seeing 
conflicts while reading trees, but didn't drop the flag (perhaps because 
Linus knew at the time that my assumption that conflicts would actually 
have been recognized was false, and didn't realize that it was also the 
source of the flag).

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * I suspect that we can probably remove SKIP_DFCHECK option by fixing
>    tree.c::read_tree(); the only caller the big comment at the beginning
>    of it talks about is overlay_tree_on_cache() in builtin-ls-files.c and
>    we haven't gained any new callers of the function.
> 
>    It is a bit sad that a very good looking refactoring and rewriting
>    patch introduced this kind of regression that has gone unnoticed for a
>    long time.  I managed to point three fingers and they turn out to be
>    all ancient commits before v1.5.5.

I'm not too surprised that "read-tree" with multiple trees without -m 
doesn't actually work, because I don't think this has ever been useful for 
anything, and nobody's been able to come up with an implementation 
of read-tree that's particularly easy to understand. So regular testing 
wouldn't find this problem, and inspection wouldn't find it, either.

I think it might be a good idea to take this as evidence that nobody is 
using read-tree with multiple trees without merge, and just disallow it. 
If it takes a year to hit a pretty big bug in a code path, and using the 
code path was due to a typo anyway, it's unlikely that the code path is 
actually used for anything.

	-Daniel
*This .sig left intentionally blank*
