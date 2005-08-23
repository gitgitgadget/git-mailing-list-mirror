From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Removing deleted files after checkout
Date: Tue, 23 Aug 2005 17:27:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508231713450.23242@iabervon.org>
References: <20050823162156.GA32240@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0508231533570.23242@iabervon.org> <20050823205052.GA13311@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 23:27:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7gFD-00010r-2W
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 23:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVHWVXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 17:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVHWVXk
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 17:23:40 -0400
Received: from iabervon.org ([66.92.72.58]:43020 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932151AbVHWVXj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 17:23:39 -0400
Received: (qmail 15465 invoked by uid 1000); 23 Aug 2005 17:27:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Aug 2005 17:27:12 -0400
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050823205052.GA13311@hpsvcnb.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7673>

On Tue, 23 Aug 2005, Carl Baldwin wrote:

> On Tue, Aug 23, 2005 at 03:43:56PM -0400, Daniel Barkalow wrote:
> > On Tue, 23 Aug 2005, Carl Baldwin wrote:
> >
> > > Hello,
> > >
> > > I recently started using git to revision control the source for my
> > > web-page.  I wrote a post-update hook to checkout the files when I push
> > > to the 'live' repository.
> > >
> > > In this particular context I decided that it was important to me to remove
> > > deleted files after checking out the new HEAD.  I accomplished this by running
> > > git-ls-files before and after the checkout.
> > >
> > > Is there a better way?  Could there be some way built into git to easily
> > > find out what files dissappear when replacing the current index with one
> > > from a new tree?  Is there already?  The behavior of git should NOT
> > > change to delete these files but I would argue that some way should
> > > exist to query what files disappeared if removing them is desired.
> >
> > If you don't use -f, git-checkout-script removes deleted files. Using -f
> > tells it to ignore the old index, which means that it can't tell the
> > difference between removed files and files that weren't tracked at all.
>
> Maybe I'm doing something wrong.  This does not happen for me.
>
> I tried a simple test with git v0.99.4...
>
> cd
> mkdir test-git && cd test-git/
> echo testing | cg-init
> echo contents > file
> git-add-script file
> git-commit-script -m 'testing'

[point 1]

> cd ..
> cg-clone test-git/.git/ test-git2
> cd test-git2
> cg-rm file
> git-commit-script -m 'testing'
> ls

> cg-push
> cd ../test-git
> git-checkout-script

Ah, okay. I think "push" and "checkout" don't play that well together;
"push" changes the ref, which "checkout" uses to determine what it expects
for the old contents, and then it's confused.

What you probably actually want is:

cd ../test-git
git pull ../test-git2

which will correctly identify before and after, and remove any files that
were removed.

Alternatively, you could do, at point 1:

cp .git/refs/master .git/refs/deployed
git checkout deployed

Then, after the push and cd:

git checkout master
cp .git/refs/master .git/refs/deployed
git checkout deployed

because checkout does remove files if you switch from a branch with them
(e.g., deployed) to one without them (master, after the push).

	-Daniel
*This .sig left intentionally blank*
