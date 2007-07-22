From: David Kastrup <dak@gnu.org>
Subject: Re: Empty directories...
Date: Sun, 22 Jul 2007 23:35:10 +0200
Organization: Organization?!?
Message-ID: <85sl7gf7g1.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <7v8x9ea1rg.fsf@assigned-by-dhcp.cox.net> <85d4yqz24s.fsf@lola.goethe.zz> <7vhco28aoq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 23:36:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICj5n-0000UM-Pv
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbXGVVfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbXGVVfw
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:35:52 -0400
Received: from main.gmane.org ([80.91.229.2]:32910 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832AbXGVVfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 17:35:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ICj5T-0002lK-R6
	for git@vger.kernel.org; Sun, 22 Jul 2007 23:35:36 +0200
Received: from dslb-084-061-022-107.pools.arcor-ip.net ([84.61.22.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 23:35:35 +0200
Received: from dak by dslb-084-061-022-107.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 23:35:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-022-107.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:sGjujzW3a8Nplc3jQGp0te5/kbk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53324>


Coming full circle...

Junio C Hamano <gitster@pobox.com> writes:

> The right approach to take probably would be to allow entries of
> mode 040000 in the index.  Traditionally, we allowed only 100644
> (blobs as regular files) and 120000 (blobs as symlinks).  We
> recently added 160000 (commit from outer space, aka subproject).
>
> And we do that for all directories, not just empty ones.  So if
> you have fileA, empty/, sub/fileB tracked, your index would
> probably have these four entries, immediately after read-tree
> of an existing tree object:
>
> 	100644 15db6f1f27ef7a... 0	fileA
> 	040000 4b825dc642cb6e... 0	empty
> 	040000 e125e11d3b63e3... 0	sub
> 	100644 52054201c2a872... 0	sub/fileB

This would be very much what I am proposing now, except that instead
of 040000 we would have 040755 usually, so that when the index makes
it into the repository where 040000 already has a meaning (a
disappear-when-empty tree) we get the right information.  Also note
that the above comes about when doing
git-add *
but not when doing
git-add fileA empty sub/fileB (in the latter case, the entry for sub
                               would be missing)

> If you add sub/fileC, with "update-index" (and "add"), you
> invalidate the SHA-1 object name you stored for "sub" (because
> there is no point recomputing the tree object until you know you
> need a subtree for "sub" part, which does not happen until the
> next "write-tree"), and end up with something like:
>
> 	100644 15db6f1f27ef7a... 0	fileA
> 	040000 4b825dc642cb6e... 0	empty
> 	040000 00000000000000... 0	sub
> 	100644 52054201c2a872... 0	sub/fileB
> 	100644 705bf16c546f32... 0	sub/fileC
>
> These "missing" SHA-1 would need to be recomputed on-demand.

Ah, ok.  Does it even make sense to compute the SHA-1 values in the
index in advance?  What would they be useful for?

> We have had necessary infrastructure to do this "keeping
> untouched tree object names in the index" for quite some time,
> but it is not a part of the index proper (it is stored in an
> extension section in the index file, to keep the index
> compatible with older versions of git).

What is the application for which this is being used?

> Having made it sound so easy, here are the issues I would expect
> to be nontrivial (but probably not rocket surgery either).
>
>  * unpack-trees, which is the workhorse for twoway merge (aka
>    "switching branches") and threeway merge, has a convoluted
>    logic to avoid D/F conflicts; it can probably be cleaned up
>    once we do the above conversion so that the index starts
>    saying "Hey, I have a directory here" more explicitly.  The
>    end result would probably be a code easier to follow.

I am afraid that this is unlikely to happen, and that is because
directory tracking remains optional at a fundamental level as long as
we want to support the current behavior as an option.  However, one
could conceivably add 040000 entries (rather than 040755) for
directories that have not been passed into tracking but are required
by git, if this simplifies matters.  But it sounds like something that
might complicate working with several different git versions on the
same index.

>  * status, update-index --refresh, and diff-files cares about
>    the information cached in the index from the last time
>    lstat(2) is run on each entry.  What we should store there
>    for "tree" entries is very unclear to me, but probably we
>    should teach them to ignore the stat-matching logic for
>    these entries.

At the current point of time, git tracks just the u+x bit for normal
files, and for directories, there is really nothing worth tracking as
long as no attempt of restoring more mode bits is done.  Modification
times are probably a bit too risky to pay attention to.

>  * diff-index walks the index and a tree in parallel but does
>    not currently expect to see a tree object in the index.  It
>    needs to be taught to ignore these "tree" entries.

Or do something sensible when comparing.  Understood.

>  * merge-recursive and merge-index walk the index, coming up
>    with the merge results one path at a time.  They also need to
>    be taught to ignore these "tree" entries.

Same here.

>  * diff-index and "read-tree -m" should be taught to take
>    advantage of the "tree" entries in the index.  For example,
>    if diff-index finds the "tree" entry in the index and the
>    subtree found from the tree object exactly match, it does not
>    even have to descend into the tree, which would be a huge
>    performance win (because you do not have to open the subtree
>    and its subtrees from the tree side; you already have read
>    everything on the index side, and still have to skip the
>    entries in the directory).  "read-tree -m" also should be
>    able to optimize two identical subtrees in the 2 or 3 trees
>    involved.
>
>    Even if we follow the "lazy invalidate" strategy to maintain
>    the "tree" entries in the normal codepath, we could have a
>    special operation that says "now update all the tree entries
>    by recomputing the tree object names as needed".  Perhaps we
>    might want to initiate such an operation before "read-tree
>    -m" automatically.

Over my head, but it would appear that it can safely left for later.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
