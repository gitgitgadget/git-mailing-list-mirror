From: Junio C Hamano <junkio@cox.net>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 11:31:26 -0700
Message-ID: <7vmzry7ev5.fsf@assigned-by-dhcp.cox.net>
References: <20050416131528.GB19908@elte.hu>
	<Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 20:28:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMs1L-0002Z2-8y
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 20:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVDPSbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 14:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbVDPSbf
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 14:31:35 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:14018 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262718AbVDPSba (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 14:31:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416183127.CJLE22013.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 14:31:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 16 Apr 2005 10:04:31 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> What do people think? I'm not so much worried about the data itself: the
LT> git architecture is _so_ damn simple that now that the size estimate has
LT> been confirmed, that I don't think it would be a problem per se to put
LT> 3.2GB into the archive. But it will bog down "rsync" horribly, so it will
LT> actually hurt synchronization untill somebody writes the rev-tree-like
LT> stuff to communicate changes more efficiently..

LT> IOW, it smells to me like we don't have the infrastructure to really work 
LT> with 3GB archives, and that if we start from scratch (2.6.12-rc2), we can 
LT> build up the infrastructure in parallell with starting to really need it.

LT> But it's _great_ to have the history in this format, especially since 
LT> looking at CVS just reminded me how much I hated it.

LT> Comments?

I have been cooking this idea before I dove into the merge stuff
and did not have time to implement it myself (Hint Hint), but I
think something along the following lines would work nicely:

 * A script git-archive-tar is used to create a "base tarball"
   that roughly corresponds to "linux-*.tar.gz".  This works as
   follows:

    $ git-archive-tar C [B1 B2...]

   This reads the named commit C, grabs the associated tree
   (i.e.  its sub-tree objects and the blob they refer to), and
   makes a tarball of ??/??????????????????????????????????????
   files.  The tarball does not have to contain any extra
   information to reproduce any ancestor of the named commit.

   When extra parameters, B1 B2..., are given, it also creates
   "diff package" that roughly corresponds to "patch-*.gz" for
   each Bn given.  They must be ancestors of commit.  The
   intention is to store enough information to ensure that the
   recipient can recreate all the SHA1 files "base tarball" for
   commits between (Bn, C] would contain, provided if the
   recipient already has all the SHA1 files "base tarball" for
   Bn.

 * A script git-archive-patch is used to read such a "diff
   package".

So a user needs to:

 * First pick some baseline B and download the base tarball for
   commit B.  It is up to him to make trade-offs between how far
   back he wants to see the history and how much bandwidth he
   wants to waste.  Untar it to get the baseline.

 * Then periodically pick up "diff package" for (C, B] where C
   is the latest available.  Run git-archive-patch to populate
   the rest.

 * In addition the user can run rsync with timestamp option to
   pick up SHA1 files created upstream since C after this
   happens.

What git-archive-tar needs to do to produce "diff package" for
(Bn, C] is fairly obvious.

 * From rev-tree output, find all the commits that are on path
   from Bn to C.

 * Find all the SHA1 objects that appear on this commit chain;
   subtract what is in Bn since we assume the recipient has them
   already.

 * Run diff-tree between neighboring commits [*1*] to find out
   the set of blobs that are "related".  Extract those related
   blobs and run "diff" [*2*] between them to see if it produces
   a patch smaller than the whole thing when compressed.  If
   diff+patch is a win, then we do not have to transmit the blob
   that we could reproduce by sending the diff.  Note that fact.

 * When you are all done, you have a single patch file that
   contains small edits on numerous blobs, and set of SHA1 files
   that are cheaper to transmit than in the patch form.
   Compress the patch file and package them together to make a
   tar archive.

Given the above, the operation of git-archive-patch is also
quite obvious.  Extract the "diff package" tarball into the
objects/ directory that has (at least) the full Bn, uncompress
the patch file part, and run patch on it. 


[Footnotes]

*1* Alternatively, this diff-tree can be run between Bn and each
commit between (Bn, C].  It is like incremental dump strategy.
We should experiment and find a good balance.

*2* This does not have to be "diff -u" --- we are assuming the
exact patch so diff -e or xdelta would do.  We should experiment
and find a good diff+patch pair.


