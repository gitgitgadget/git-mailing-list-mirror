From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 14:01:58 +0100
Message-ID: <1114693318.27227.111.camel@hades.cambridge.redhat.com>
References: <200504271251.00635.mason@suse.com>
	 <Pine.LNX.4.58.0504271027460.18901@ppc970.osdl.org>
	 <200504271423.37433.mason@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-gaaMG8c9sNpWFPXciQ+T"
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 14:58:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR8ao-0007qY-MT
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 14:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVD1NDf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 09:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVD1NDf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 09:03:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10477 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262111AbVD1NCU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 09:02:20 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DR8eX-0003zx-LO; Thu, 28 Apr 2005 14:02:04 +0100
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504271423.37433.mason@suse.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-gaaMG8c9sNpWFPXciQ+T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-04-27 at 14:23 -0400, Chris Mason wrote:
> Thanks.  I originally called diff-tree without the file list so that I could 
> do the regexp matching, but this is probably one of those features that will 
> never get used.

When I added this functionality to diff-tree I didn't want to add regexp
support, but I did make sure it could handle the simple case of "changes
within directory xxx/yyy". It can also take _multiple_ names. 

At the same time, I also posted a primitive script which attempted to do
something similar to what you're doing. The output of rev-tree is
useless, as Linus pointed out. Chronological sorting is
counterproductive in all cases and should be avoided _everywhere_.

My script is based on the original 'gitlog.sh' script, which walks the
commit tree from the head to its parents. It lists only those commits
where the file(s) in question actually changed, giving the commit ID and
the changes.

There's one problem with that already documented in my (attached) mail
-- we don't print merge changesets where the file in the child is
identical to the file in all the parents, but the changeset in question
_is_ relevant to the history because it's merging two branches on which
the file _independently_ changed.

The other problem is that we still don't have enough information to
piece together the full tree. With each commit we print, we're also
printing the last _relevant_ child (see $lastprinted in the script). 

That allows us to piece together most of the graph, but when we
eventually reach a commit which has already been processed (but not
necessarily _printed_, we just stop -- so we don't have useful parent
information for the oldset change in each branch and can't tie it back
to the point at which it branched. We know the _immediate_ parent, but
that parent isn't necessarily going to have been one of the commits we
actually printed.

I suspect the best way to do this is to start with a copy of rev-tree
and do something like..

	1. Add a 'struct commit_list children' to 'struct commit'

	2. Make process_commit() set it correctly:
@@ wherever @@ process_commit
	        while (parents) {
	                process_commit(parents->item->object.sha1);
+	                commit_list_insert(obj, &parents->item->children);
	                parents = parents->next;
	        }

	3. Check each 'interesting' commit to see if it affects the
	   file(s) in question.
	   
	4. Prune the tree: For each commit which isn't a merge and which
	   doesn't touch the file(s), just dump it from the tree,
	   changing the child pointer of its parent and the parent
	   pointer of its child accordingly to maintain the tree.
	   For each merge where there are no changes to the file(s)
	   between the merge point and the point at which the branch was
	   taken, drop that too.

	5. Print the remaining commits.


-- 
dwmw2

--=-gaaMG8c9sNpWFPXciQ+T
Content-Disposition: inline
Content-Description: Attached message - Re: [GIT PATCH] Selective diff-tree
Content-Type: message/rfc822

Return-path: <git-owner@vger.kernel.org>
Envelope-to: dwmw2@baythorne.infradead.org
Delivery-date: Wed, 13 Apr 2005 18:00:52 +0100
Received: from [2002:d592:9a28::1] (helo=pentafluge.infradead.org) by
	baythorne.infradead.org with esmtps (Exim 4.43 #1 (Red Hat Linux)) id
	1DLlES-0006MH-3L for dwmw2@baythorne.infradead.org; Wed, 13 Apr 2005
	18:00:52 +0100
Received: from vger.kernel.org ([12.107.209.244]) by
	pentafluge.infradead.org with esmtp (Exim 4.43 #1 (Red Hat Linux)) id
	1DLlEP-0003JX-Va for dwmw2@infradead.org; Wed, 13 Apr 2005 18:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S261405AbVDMRAs (ORCPT <rfc822;dwmw2@infradead.org>); Wed, 13 Apr 2005
	13:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVDMRAs
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 13:00:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16345 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP id S261405AbVDMQ7f
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 12:59:35 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98]
	helo=hades.cambridge.redhat.com) by pentafluge.infradead.org with esmtpsa
	(Exim 4.43 #1 (Red Hat Linux)) id 1DLlD9-0003It-Dx; Wed, 13 Apr 2005
	17:59:34 +0100
Subject: Re: [GIT PATCH] Selective diff-tree
From:	David Woodhouse <dwmw2@infradead.org>
To:	torvalds@osdl.org
Cc:	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <1113400651.20848.135.camel@hades.cambridge.redhat.com>
References: <1113400651.20848.135.camel@hades.cambridge.redhat.com>
Content-Type: multipart/mixed; boundary="=-sOgNnYhlHXFQKKOAi1EA"
Date:	Wed, 13 Apr 2005 17:59:29 +0100
Message-Id: <1113411570.20848.171.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
	pentafluge.infradead.org See http://www.infradead.org/rpr.html
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org
X-Evolution-Source: imap://dwmw2@pentafluge.infradead.org/


--=-sOgNnYhlHXFQKKOAi1EA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-04-13 at 14:57 +0100, David Woodhouse wrote:
> The plan is that this will also form the basis of a tool which will report the
> revision tree for a given file, which is why I really want to avoid the
> unnecessary recursion rather than just post-processing the output.

Script attached. Its output is something like this:

commit 97c9a63e76bf667c21f24a5cfa8172aff0dd1294 child
*100664->100644 blob    6e4064e920792d5b0219b9f8f55a38ab4a1af856->c1091cd15e2ed1be65b50eaa910f7b45c08d93ac      rev-tree.c

--------------------------
commit 13b6f29ac1686955e15f0250f796362460b4992e child 97c9a63e76bf667c21f24a5cfa8172aff0dd1294
*100644->100644 blob    5b3090780d49cc610339a19f070a5954dce9a8bc->c1091cd15e2ed1be65b50eaa910f7b45c08d93ac      rev-tree.c

--------------------------
commit 6420f0732f695269c0e3f28e62ed4b9aa6578d9f child 13b6f29ac1686955e15f0250f796362460b4992e
*100644->100644 blob    7429b9c4d0aab2e4a494eb4b65129a59da138106->5b3090780d49cc610339a19f070a5954dce9a8bc      rev-tree.c
*100664->100644 blob    28a980482bf2053e022409cc3e50b2ad8adafd55->5b3090780d49cc610339a19f070a5954dce9a8bc      rev-tree.c

 <...>

As we walk the tree from the HEAD to its parents, we print only those
commits which modify the file(s) in question. We remember the last
commit we printed as we recurse, so that we can generate a complete
graph. The SHA-1 of the blobs themselves aren't good enough on their own
because they're not guaranteed to be unique -- if the same change
happens on two different branches, the SHA-1 will be the same, and we
won't know how it fits together.

As it is, it's not quite perfect because I'm still omitting merge
commits where the resulting file is identical to the same file in _all_
of the parents. So if we have the following tree (for the _file):

       ----- (AB) ----,
      /                \ 
  (A) ------ (AB) ----- (AB) --,
      \                         \
       ----- (AC) --------------(ABC)

(Where the delta A->AB is a trivial one-line fix which two people
independently reproduce, then they merge their trees together)

.. the point where the two independent instances of (AB) are merged
together won't be shown in the output of the attached script. The output
would show only this:

       ----- (AB) ----,
      /                \ 
  (A) ------ (AB) ----- (ABC)
      \                /           
       ----- (AC) ----'

Do we care about this? Or is it good enough? I don't really want to emit
output for _every_ merge commit we traverse, just in _case_ it happens
to be relevant later. Should just give in to the voices in my head which
are telling me I should through the damn thing away and rewrite it in C?

Given this output, it should be possible to display a pretty graph of
the history of the file, and easily find both diffs and whole files.
Creating a graphical tool which does this is left as an exercise for the
reader.
 
-- 
dwmw2

--=-sOgNnYhlHXFQKKOAi1EA
Content-Disposition: inline; filename=gitfilelog.sh
Content-Type: application/x-shellscript; name=gitfilelog.sh
Content-Transfer-Encoding: 7bit

#!/bin/bash
#
# Make a log of changes in a GIT branch.
#
# This script was originally written by (c) Ross Vandegrift.
# Adapted to his scripts set by (c) Petr Baudis, 2005.
# Major optimizations by (c) Phillip Lougher.
#
# Takes an id resolving to a commit to start from (HEAD by default).

# regex for parent declarations
PARENTS="^parent [A-Za-z0-9]{40}$"

TMPCL=$(mktemp -t gitlog.XXXXXX)
TMPCM=$(mktemp -t gitlog.XXXXXX)
TMPCD=$(mktemp -t gitlog.XXXXXX)

# takes an object and generates the object's parent(s)
changelog () {
	local parents new_parent mylastprinted
	declare -a new_parent

	new_parent=("$@")
	parents=$#

	while [ $parents -gt 0 ]; do
		parent=${new_parent[$(($parents-1))]}
		echo $parent >> $TMPCL

		cat-file commit $parent >$TMPCM

		mylastprinted=$lastprinted
		ignoredparents=0
		parents=0
		printedcommit=0
		while read type text; do
			if [ "$type" = "" ]; then
				break;
			elif [ $type = 'tree' ]; then
				tree=$text
			elif [ $type = 'parent' ]; then
				diff-tree -r `tree-id $text` $tree $file >$TMPCD
				if [ -s $TMPCD ]; then
					if [ "$lastprinted" != "$parent" ]; then
						echo commit $parent child $lastprinted
						lastprinted=$parent
					fi
					cat $TMPCD | xargs -0 -n 1 echo
				fi
				
				if grep -q $text $TMPCL; then
					ignoredparents=$(($ignoredparents+1))
				else
					new_parent[$parents]=$text
					parents=$(($parents+1))
				fi
			fi
		done < $TMPCM
	        if [ "$lastprinted" = "$parent" ]; then
		    echo -e "\n--------------------------"
		fi
		i=0
		mylastprinted=$lastprinted
		while [ $i -lt $(($parents-1)) ]; do
			changelog ${new_parent[$i]}
			i=$(($i+1))
			lastprinted=$mylastprinted
		done
	done
}

file=$1
base=$(gitXnormid.sh -c $2) || exit 1

if [ -n "$3" ]; then
    endpoint=$(gitXnormid.sh -c $3) || exit 1
    if rev-tree $base $endpoint | grep -q $base:3; then
	base=
    else
	rev-tree --edges $base $endpoint | sed 's/[a-z0-9]*:1//g' > $TMPCL
    fi
fi
changelog $base
rm $TMPCL $TMPCM $TMPCD

--=-sOgNnYhlHXFQKKOAi1EA--

--=-gaaMG8c9sNpWFPXciQ+T--

