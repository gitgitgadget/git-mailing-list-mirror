From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Reorganize read-tree
Date: Sun, 04 Sep 2005 19:04:16 -0700
Message-ID: <7virxg6zj3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508302317380.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Sep 05 04:04:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC6LN-00072o-FM
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 04:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVIECET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 22:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVIECET
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 22:04:19 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:41693 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932178AbVIECES (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 22:04:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905020416.NKAR8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Sep 2005 22:04:16 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508302317380.23242@iabervon.org> (Daniel
	Barkalow's message of "Tue, 30 Aug 2005 23:48:27 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8077>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I got mostly done with this before Linus mentioned the possibility of
> having multiple index entries in the same stage for a single path. I
> finished it anyway, but I'm not sure that we won't want to know which of
> the common ancestors contributed which, and, if some of them don't have a
> path, we wouldn't be able to tell. The other advantages I see to this
> approach are:

I've finished reading your patch, after beating it reasonably
heavily by feeding combinations of nonsense trees to make sure
it produces the same result as the original implementation.  I
have not found any regression from the read-tree in "master"
branch, after you fixed the path ordering issues.

> There are various potential refinements, plus removing a bunch of memory
> leaks, still to do, but I think this is sufficiently close to review.

I am not so worried about the leaks right now; they are
something that could be fixed before it hits the "master"
branch.

I like your approach of reading the input trees, along with the
existing index contents, and re-populating the index one path at
a time.  It probably is more readable.

I further think that you can get the best of both worlds, by
inventing a convention that mode=0 entry means 'this path does
not exist in this tree'. This would allow you to have multiple
entries at the same stage and still tell which one came from
which tree.  Instead of calling fn in unpack_trees(), you could
make it only unpack the tree into the index, and then after
unpacking is done, call fn() repeatedly to resolve the resulting
index.  Of course the semantics of merge_fn_t needs to change
but if you feed N trees, the caller of a merge_fn_t function
needs to pick up the first N entries (because you use mode=0
entry to mean 'missing from this tree', each path will always
have N entries) and feed them to the merge function in one call,
then pick up the next N entries and feed them in the next call,
and so on.  I think that would simplify that part of the code
even further.

So if you are making an octopus of 4 trees (one being our
current branch) using 2 merge bases, your intermediate index
would look like:

    mode   SHA1   stage path
    100644 XXXXX  0     foo	from original index
    000000 0{40}  1     foo	merge base #1 did not have foo
    100644 ZZZZZ  1     foo	merge base #2 has it
    100644 XXXXX  2     foo	our current head
    100644 ZZZZZ  3     foo	other head #1 being merged into us
    100644 YYYYY  3     foo	other head #2 being merged into us
    100644 ZZZZZ  3     foo	other head #3 being merged into us

We cannot write something like this out without breaking
backward compatibility, but I personally think this breakage is
OK, because what is being broken is the index file format, not
tree object format, and the index file is by definition local to
a repository.  IOW, it is not too much to ask people not to use
old tools to read new index file they created using new tools.
