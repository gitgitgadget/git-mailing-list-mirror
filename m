From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 13:23:09 -0700
Message-ID: <20081015132309.76d3cc28.akpm@linux-foundation.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
	<alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
	<alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
	<alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
	<20081015124949.b657a8db.akpm@linux-foundation.org>
	<alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:24:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCvP-0005wf-NJ
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbYJOUXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 16:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbYJOUXq
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:23:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59421 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753579AbYJOUXo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 16:23:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FKN99D008691
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Oct 2008 13:23:11 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m9FKN9o7032412;
	Wed, 15 Oct 2008 13:23:09 -0700
In-Reply-To: <alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.869 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98319>

On Wed, 15 Oct 2008 13:08:36 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Wed, 15 Oct 2008, Andrew Morton wrote:
> > 
> > I treat my git directory as a read-only thing.  I only ever modify it
> > with git commands.
> 
> Ok. 
> 
> > > (By the filename, I realize it's a file that doesn't exist in one tree or 
> > > the other, and which doesn't get removed at some point. But have you had 
> > > merge failures, for example? Is it perhaps a file that was created during 
> > > a non-clean merge, and then got left behind due to the merge being 
> > > aborted? It would be interesting to know what led up to this..)
> > 
> > That's certainly a possibility - I get a lot of merge failures.  A real
> > lot.  And then quite a bit of rebasing goes on, especially in
> > linux-next.  And then there's all the other stuff which Stephen does on
> > top of the underlying trees to get something releasable happening.
> 
> Is "git checkout -f" part of the scripting? Or "git reset --hard"?

well, this script has been hacked on so many times I'm not sure what
it does any more.

Presently the main generate-a-diff function is

doit()
{
	tree=$1
	upstream=$2

	cd $GIT_TREE
	git checkout "$upstream"
	git reset --hard "$upstream"
	git fetch "$tree" || exit 1
	git merge --no-commit 'test merge' HEAD FETCH_HEAD > /dev/null

	{
		git_header "$tree"
		git log --no-merges ORIG_HEAD..FETCH_HEAD
		git diff --patch-with-stat ORIG_HEAD
	} >$PULL/$tree.patch
	{
		echo DESC
		echo $tree.patch
		echo EDESC
		git_header "$tree"
		git log --no-merges ORIG_HEAD..FETCH_HEAD
	} >$PULL/$tree.txt
	git reset --hard "$upstream"
}

usually invoked as

doit origin v2.6.27
doit origin linux-next

etc.

the above seemed fairly busted, so I'm now using

        git checkout -f "$upstream"
        git reset --hard "$upstream"
        git fetch "$tree" || exit 1

which seems a bit more sensible.  Perhaps I should do the reset before
the checkout, dunno.

That function has been through sooooooo many revisions and each time
some scenario get fixed (more like "improved"), some other scenario
gets busted (more like "worsened").  The above sorta mostly works,
although it presently generates thirty-odd rejects against
git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git#auto-latest,
which is way above my fix-it-manually threshold.  linux-next is still
dead because it's taking Stephen over two days to fix the mess he's
been fed so I'm madly rebasing everything on mainline over here.


> So what I could imagine is happening is:
> 
>  - you have a lot of automated merging
> 
>  - a merge goes south with a data conflict, and since it's all automated, 
>    you just want to throw it away. So you do "git reset --force" to do 
>    that.

didn't know about --force.

>  - but what "git reset --hard" means is to basically ignore all error 
>    cases, including any unmerged entries that it just basically ignores.
> 
>  - so it did set the tree back, but the whole point of "--hard" is that it 
>    ignores error cases, and doesn't really touch them.
> 
> Now, I don't think we ever really deeply thought about what the error 
> cases should do when they are ignored. Should the file that is in some 
> state we don't like be removed? Or should we just ignore the error and 
> return without removing the file? Generally git tries to avoid touching 
> things it doesn't understand, but I do think this may explain some pain 
> for you, and it may not be the right thing in this case.

Yeah, there's no easy solution here, and I suspect the real solution is
"read programmer's mind".  Providing a reliable override (like -f) is a
sensible solution.

> (And when I say "this case", I don't really know whether you use "git 
> checkout -f" or "git reset --hard" or something else, so I'm not even 
> going to say I'm sure exactly _which_ case "this case" actually us :)
> 
> Of course, the cheesy way for you to fix this may be to just add a
> 
> 	git clean -dqfx
> 
> to directly after whatever point where you decide to reset and revert to 
> an earlier stage. That just says "force remove all files I don't know 
> about, including any I might ignore". IOW, "git reset --hard" will 
> guarantee that all _tracked_ files are reset, but if you worry about some 
> other crud that could have happened due to a failed merge, that additional 
> "git clean" may be called for.

OK, I'll try git clean -dqfx if it blows up again.

> Of course, it's going to read the whole directory tree and that's not 
> really cheap, but especially if you only do this for error cases, it's 
> probably not going to be any worse. And I'm assuming you're not compiling 
> in that tree, so you probably don't want to save object files (you can 
> remove the "x" part, but then you could still at least in theory get a 
> filename clash with something that is ignored and thus didn't get cleaned 
> up).
