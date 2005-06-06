From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Last mile for 1.0
Date: Mon, 6 Jun 2005 08:44:56 +0200
Message-ID: <20050606064456.GC3669@cip.informatik.uni-erlangen.de>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org> <20050606054356.GB3669@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 08:42:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfBJ0-0006r6-Mf
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 08:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVFFGpS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 02:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVFFGpS
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 02:45:18 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:60054 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261179AbVFFGpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 02:45:06 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j566iuS8014190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Jun 2005 06:44:56 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j566iufa014189;
	Mon, 6 Jun 2005 08:44:56 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Well, there was actually a much more fundamental problem, which is that 
> the merge script depended on being able to do

> 	git-checkout-cache -f -u -a

> which in turn obviously meant that _whatever_ it did, it would end up 
> overwriting any dirty state in the working tree.

true. But I don't see the problem. Just ensure that there are no
uncommitted data and no dirty files before proceeding with the merge by
calling:

git-diff-files -z -r (but ignore the deleted)
git-diff-cache -r --cached HEAD

> And you can't remove the git-checkout-cache, because after the merge we've 
> lost the original state anyway, so there's no way to know whether whatever 
> you had in the working directory was dirty or not.

> So I've actually been working now to make the very low-level git-read-tree 
> Do The Right Thing (tm), and I think I'm getting there. It basically 
> depends on "git-read-tree" noticing when the state is dirty enough that we 
> can't safely do the merge, and then for the safe cases it can actually 
> update anything it merged properly. As a result, there's never any need 
> for git-checkout-cache, and the only thing that needs updating in the 
> working directory is the stuff that we end up merging by hand _outside_ of 
> git-read-tree.

> There's two cases: fast-forward and a real merge. And the thing is, to do 
> even just the fast-forward safely, it actually needs to know what the base 
> tree was (otherwise it can only tell that the file was up-to-date in the 
> index, but it can't know whether the index actually matched the original 
> HEAD..). So now the fast-forward case is actually a two-way merge:

> 	git-read-tree -u -m HEAD NEW_HEAD

> where "-u" stands for "update", and tells read-tree that it should check 
> out the files it merges up. 

> And now git-read-tree also tries to be very careful: if one of the files 
> that needs to be updated is already dirty, or it doesn't match the 
> original HEAD, then git-read-tree will just exit with an error and not do 
> anything at all.

Now I see your point. And a cmp-and-xchg HEAD would be useful here, too.  What
if a user tries to shoot himself in the head by pull from two trees
simultaneous?

> But for a file that wasn't touched at all by the merge, we can leave it
> dirty in the index, since whatever dirty index state was valid before the
> merge is obviously valid after it too. So now you can have dirty state in 
> your tree, and merges will complain only if it matters to them.

Nice to have. :-)

> ...

> And the "git-merge-one-file-script" thing needs to be updated to keep the
> tree updated as it merges things by hand, since it can't depend on the
> git-checkout-cache fixing things up any more. Anybody?

I can't follow you there. AFAIK it retrieves all his files from
git-merge-cache and just calls git-update-cache to update the index.

	Thomas
