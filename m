From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: please pull powerpc-merge.git
Date: Sat, 19 Nov 2005 10:24:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511190957320.13959@g5.osdl.org>
References: <17279.1674.22992.607091@cargo.ozlabs.ibm.com> <20051119140736.GA24901@lst.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Nov 19 19:25:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdXOR-000647-Ep
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 19:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVKSSYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 13:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVKSSYh
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 13:24:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750728AbVKSSYh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 13:24:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAJIOHnO011416
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 19 Nov 2005 10:24:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAJIOEBu005540;
	Sat, 19 Nov 2005 10:24:15 -0800
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20051119140736.GA24901@lst.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12347>



[ Junio, Fredrik, you're cc'd because the "merge-one-file" logic doesn't 
  clean up empty directories after removing a file in merge ]

On Sat, 19 Nov 2005, Christoph Hellwig wrote:
> 
> Btw, in current Linus' tree arch/ppc64/ contains various empty
> directories, anyone care to git rm -r arch/ppc64 (and include/asm-ppc64
> now) ?

Actually, a git tree can never contain an empty subdirectory (well, it 
technically _can_, but it really shouldn't - the index only tracks 
_files_, and directories in git are created only as needed to contain 
those files. An empty directory tree - while technically possible in a 
data structure sense - would be a bug in git if git ever created one).

So when you say "in current Linus' tree", I suspect that in my tree it 
very much does not, but in _your_ tree the stale directories still exist 
because "git pull" just hasn't removed them.

It's a git bug/misfeature: git does not remove directories when the last 
file in it has been removed, simply because git doesn't actually really 
even _track_ directories at all. It only tracks files that just happen to 
be in directories.

[ Side note: this is not strictly true: git _will_ actually remove 
  directories that become empty when you switch between different branches 
  with "git checkout". However, even then it will not actually ever remove 
  a directory that contains any non-tracked files, so if you have old 
  object files etc, git will never remove that directory even if all the 
  tracked files got removed. ]

The reason I say "bug/misfeature" and not outright "bug" is the fact that 
removing directories is not something that git can really always do. 
Exactly because directories are often used for things that aren't tracked. 
Should it just remove old object files? Hell no. Stuff git doesn't know 
about (even if they have been marked in ".gitignore") it definitely 
shouldn't touch.

So in general, after you've merged somebody elses tree, the final pruning 
of your own old checked-out directories is really up to you.

But I agree that git should maybe at least _tell_ people about "there's a 
directory there that I'm not tracking". And it could perhaps remove the 
empty ones outright a bit more aggressively (ie now it effectively does it 
only for "git checkout" and for the _trivial_ cases of merges that happen 
with "git pull", but it doesn't do it if the merge ended up being of the 
more involved case that needed higher-level - but still automatic - help).

Frederik - I don't do perl, but I think for the recursive merge strategy, 
it's the "removeFile()" thing. And for the old git-merge-one-file.sh, it's 
that "deleted in both or deleted in one and unchanged in the other" case.

In both cases, I think it should do something like

	.. remove the file itself ..
	#
	# remove all directories leading up the path if they
	# have become non-empty
	#
	path=$(dirname $path)
	while [ "$path" ] && rmdir "$path"; do
		path=$(dirname $path)
	done

or similar.

But as mentioned, quite often, this still won't remove the directories, 
since it will have various old stale build-files in them. 

			Linus
