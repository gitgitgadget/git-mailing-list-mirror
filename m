From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: git-checkout sometimes silently fails
Date: Tue, 6 May 2008 17:54:42 -0700
Message-ID: <20080506175442.845ca8fa.akpm@linux-foundation.org>
References: <20080506122256.04ca7d77.akpm@linux-foundation.org>
	<20080506215049.GC4647@steel.home>
	<20080506171052.340d643e.akpm@linux-foundation.org>
	<20080507001919.GA8633@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 07 02:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtXwi-0007Qu-Ir
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 02:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbYEGAy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 20:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbYEGAy7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 20:54:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48739 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752553AbYEGAy6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 20:54:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m470sgoj023670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 May 2008 17:54:44 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m470sg5S003605;
	Tue, 6 May 2008 17:54:42 -0700
In-Reply-To: <20080507001919.GA8633@sigill.intra.peff.net>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.778 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81396>

On Tue, 6 May 2008 20:19:19 -0400 Jeff King <peff@peff.net> wrote:

> On Tue, May 06, 2008 at 05:10:52PM -0700, Andrew Morton wrote:
> 
> > > > y:/usr/src/git26> git-checkout master
> > > > Switched to branch "master"
> > > > y:/usr/src/git26> cat kernel/*.c|sum
> > > > 34439  2057
> > > > y:/usr/src/git26> git-checkout linux-next
> > > > Switched to branch "linux-next"
> > > > y:/usr/src/git26> cat kernel/*.c|sum     
> > > > 34439  2057
> > > 
> > > This is not a good indication of a failed checkout (they could point
> > > to the same commit, for one).
> > 
> > How could they?  linux-next includes a directory called ./Next and a file
> > in that directory called ./Next/Trees, and that is not present after the
> > `git-checkout linux-next'.
> 
> But you don't show us that in your example. There is nothing in your
> example to indicate that they are not simply pointing at the same
> commit...
> 
> > > Try "gitk master...linux-next" (or "git
> > > log master..linux-next", "git diff master linux-next")
> > 
> > These come up empty.  But there is a 12.4MB diff between mainline and
> > linux-next.
> 
> And if these all come up empty, then they _are_ pointing to the same
> commit. When you say "but there is a 12.4MB diff..." do you mean "there
> _should_ be such a diff?" In that case, it seems that your linux-next
> ref is pointing to an unexpected commit.
> 
> So the problem is not with git-checkout, but rather that you are not
> checking out what you think you are checking out.

That sounds a decent theory.

> And so we need to
> figure out how you got into that state.

Well it happens pretty regularly.  I have now lost that state but I'll save
it next time.  I'm not able to pinpoint exactly what causes it to occur.

> What command did you use to create the linux-next branch?

I edited 

y:/usr/src/git26> cat .git/branches/linux-next 
git+ssh://master.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git

and did git-fetch once per day, approx.

> Have you used
> git-reset to move the branch tip around?

My git-fetching script does that:

doit()
{
	tree=$1
	upstream=$2

	cd $GIT_TREE
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

(Linus suggested an updated version of this but afaict that won't change
anything)

But, as I say, usually this script leaves the tree in a sane state.  But
sometimes it leaves it in a i-cant-check-stuff-out state.  It's not
specific to linux-next, either: I've seen this for a long time, on and off.
Prior to linux-next's existence.
