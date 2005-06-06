From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Last mile for 1.0
Date: Sun, 5 Jun 2005 23:13:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
 <20050606054356.GB3669@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 08:08:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfAm6-0003GA-Es
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 08:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVFFGLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 02:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFFGLX
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 02:11:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:12190 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261185AbVFFGLP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 02:11:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j566B7jA026607
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 23:11:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j566B6Zr010106;
	Sun, 5 Jun 2005 23:11:06 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050606054356.GB3669@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 6 Jun 2005, Thomas Glanzmann wrote:
> 
> I think the simplest and effectivies way to handle this is the
> following: Add a flag to the current merge script which indicates that
> on conflicts the user will be dropped to a shell per conflict to solve:

Well, there was actually a much more fundamental problem, which is that 
the merge script depended on being able to do

	git-checkout-cache -f -u -a

which in turn obviously meant that _whatever_ it did, it would end up 
overwriting any dirty state in the working tree.

And you can't remove the git-checkout-cache, because after the merge we've 
lost the original state anyway, so there's no way to know whether whatever 
you had in the working directory was dirty or not.

So I've actually been working now to make the very low-level git-read-tree 
Do The Right Thing (tm), and I think I'm getting there. It basically 
depends on "git-read-tree" noticing when the state is dirty enough that we 
can't safely do the merge, and then for the safe cases it can actually 
update anything it merged properly. As a result, there's never any need 
for git-checkout-cache, and the only thing that needs updating in the 
working directory is the stuff that we end up merging by hand _outside_ of 
git-read-tree.

There's two cases: fast-forward and a real merge. And the thing is, to do 
even just the fast-forward safely, it actually needs to know what the base 
tree was (otherwise it can only tell that the file was up-to-date in the 
index, but it can't know whether the index actually matched the original 
HEAD..). So now the fast-forward case is actually a two-way merge:

	git-read-tree -u -m HEAD NEW_HEAD

where "-u" stands for "update", and tells read-tree that it should check 
out the files it merges up. 

And now git-read-tree also tries to be very careful: if one of the files 
that needs to be updated is already dirty, or it doesn't match the 
original HEAD, then git-read-tree will just exit with an error and not do 
anything at all.

But for a file that wasn't touched at all by the merge, we can leave it
dirty in the index, since whatever dirty index state was valid before the
merge is obviously valid after it too. So now you can have dirty state in 
your tree, and merges will complain only if it matters to them.

Same goes for the (much more complex) three-way merge, of course. There
the rules are a bit more complicated, and I'll have to double-check this
thing, but it all looks like even if the current state might be buggy, the 
basic _notion_ looks fine.

So now we have a one-way merge for "just update to this tree", a two-way 
merge for "update from this tree to that tree", and a three-way merge for 
"merge these two trees with that third tree as a base".

By now, I'd really like to have some test-cases. Things like "file dirty 
in working directory, removed by merge" would be good.

And the "git-merge-one-file-script" thing needs to be updated to keep the
tree updated as it merges things by hand, since it can't depend on the
git-checkout-cache fixing things up any more. Anybody?

			Linus
