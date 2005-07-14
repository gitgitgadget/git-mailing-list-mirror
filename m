From: James Ketrenos <jketreno@linux.intel.com>
Subject: Re: Getting list of changed objects...
Date: Thu, 14 Jul 2005 15:20:17 -0500
Message-ID: <42D6C901.2060409@linux.intel.com>
References: <42D6ACF0.30303@linux.intel.com> <Pine.LNX.4.58.0507141053540.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 22:25:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtAGS-0003Pw-TU
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 22:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVGNUY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 16:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVGNUWs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 16:22:48 -0400
Received: from fmr17.intel.com ([134.134.136.16]:39069 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S263150AbVGNUUj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 16:20:39 -0400
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j6EKKKPw004751;
	Thu, 14 Jul 2005 20:20:20 GMT
Received: from [192.168.1.154] (logicsbox.jf.intel.com [134.134.16.142])
	by orsfmr100.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j6EKKH65030184;
	Thu, 14 Jul 2005 20:20:18 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050519
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507141053540.19183@g5.osdl.org>
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:

>Since you haven't merged A and B in the above, they _are_ needed, aren't 
>they?
>  
>
My original email wasn't worded quite right.  I think you are tracking
what I'm trying to do... but here is a different view anyway:

time
      |
1     A ------->  B  clone A to B
2     |           |  make changes on B and A
3     | --> C     |  clone A to C
4     |     | <---'  merge B into C
5     |     |
      A     C

I am merging B (as it was at time 3, or B3) into C (as it was at time 3,
or C3) via:

    git-read-tree -m $(git-merge-base B3 C3) C3 B3

where $(git-merge-base B3 C3) resolves to A1.  After I run git-read-tree,
I resolve any conflicts via git-merge-cache, etc. and write the
tree via git-write-tree.

>Maybe what you want is 
>
>	git-rev-list --objects B ^A ^C
>
>ie "objects that are in B, but not in A or in C", since you seem to 
>consider A uninteresting too?
>  
>
That does seem to work here by doing:

    git-rev-list --objects C5 ^C3 ^$(git-merge-base C3 B3)

>, and also, "git-rev-list
>--objects" is actually not 100% careful - it can include objects that are
>in the "not" group, just because it doesn't actually bother to do a full
>negative list (it only creates a negative list for the "boundary" objects,
>but it won't even do "mark_tree_uninteresting()" for commits that it has
>decided cannot be meaningful, so it's not in any way guaranteed to be a
>_minimal_ set of objects).
>  
>
Good to know.  If git-rev-list is just checking the boundary, and the merge
commit is between C5 and C3 (at C4) then that explains why I see what I
see.  It would grab all the objects listed in C4 and not exhuaustively be
removing them via one of its ancestors.

The goal is to create the list of objects (tree, commit, and blob)
required such
that if someone already has all the objects for repo A, they just need to
download the 'in C, not in A' objects and the HEAD from C and then they can
create a full copy of C.

I'll look to modify my scripts that merge the parent repository to cache
the parent
repository's SHA.  I can then pass that list of merge points to
get-rev-list as a
set of boundaries.

Thanks,
James
