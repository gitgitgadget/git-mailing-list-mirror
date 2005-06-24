From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.12 hangs on boot
Date: Fri, 24 Jun 2005 15:20:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506241446440.11175@ppc970.osdl.org>
References: <200506221813.50385.gluk@php4.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	admin@list.net.ru, Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263298AbVFXWT4@vger.kernel.org Sat Jun 25 00:17:50 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263298AbVFXWT4@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlwUI-0001r7-Pu
	for glk-linux-kernel@gmane.org; Sat, 25 Jun 2005 00:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbVFXWT4 (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Fri, 24 Jun 2005 18:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbVFXWT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 18:19:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9438 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263316AbVFXWSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 18:18:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5OMI1jA007526
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Jun 2005 15:18:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5OMHuH2015962;
	Fri, 24 Jun 2005 15:17:58 -0700
To: "Alexander Y. Fomichev" <gluk@php4.ru>
In-Reply-To: <200506221813.50385.gluk@php4.ru>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2005, Alexander Y. Fomichev wrote:
> 
> I've been trying to switch from 2.6.12-rc3 to 2.6.12 on Dual EM64T 2.8 GHz
> [ MoBo: Intel E7520, intel 82801 ]
> but kernel hangs on boot right after records:
> 
> Booting processor 2/1 rip 6000 rsp ffff8100023dbf58
> Initializing CPU#2

Hmm.. Since you seem to be a git user, maybe you could try the git
"bisect" thing to help narrow down exactly where this happened (and help
test that thing too ;).

You can basically use git to find the half-way point between a set of
"known good" points and a "known bad" point ("bisecting" the set of
commits), and doing just a few of those should give us a much better view
of where things started going wrong.

For example, since you know that 2.6.12-rc3 is good, and 2.6.12 is bad, 
you'd do

	git-rev-list --bisect v2.6.12 ^v2.6.12-rc3

where the "v2.6.12 ^v2.6.12-rc3" thing basically means "everything in 
v2.6.12 but _not_ in v2.6.12-rc3" (that's what the ^ marks), and the 
"--bisect" flag just asks git-rev-list to list the middle-most commit, 
rather than all the commits in between those kernel versions.

You should get the answer "0e6ef3e02b6f07e37ba1c1abc059f8bee4e0847f", but
before you go any further, just make sure your git index is all clean:

	git status

should not print anything else than "nothing to commit". If so, then
you're ready to try the new "mid-point" head:

	git-rev-list --bisect v2.6.12 ^v2.6.12-rc3 > .git/refs/heads/try1
	git checkout try1

which will create a new branch called "try1", where the head is that 
"mid-point", and it will switch to that branch (this requires a fairly 
recent "git", btw, so make sure you update your git first).

Then, compile that kernel, and try it out.

Now, there are two possibilities: either "try1" ends up being good, or it
still shows the bug. If it is a buggy kernel, then you now have a new
"bad"  point, and you do

	git-rev-list --bisect try1 ^v2.6.12-rc3 > .git/refs/heads/try2
	git checkout try2

which is all the same thing as you did before, except now we use "try1" as 
the known bad one rather than v2.6.12 (and we call the new branch "try2" 
of course).

However, if that "try1" is _good_, and doesn't show the bug, then you 
shouldn't replace the other "known good" case, but instead you should add 
it to the list of good commits (aka commits we don't want to know about):

	git-rev-list --bisect v2.6.12 ^v2.6.12-rc3 ^try1 > .git/refs/heads/try2
	git checkout try2

ie notice how we now say: want to get the bisection of the commits in 
v2.6.12 (known bad) but _not_ in either of v2.6.12-rc3 or the 'try1' 
branch (which are known good).

After compiling and testing a few kernels, you will have narrowed the 
range down a _lot_, and at some point you can just say

	git-rev-list --pretty try4 ^v2.6.12-rc3 ^try1 ^try3

(or however the "success/failure" pattern ends up being - the above
example line assumes that "try1" didn't have the bug, but "try2" did, and
then "try3" was ok again but "try4" was buggy), and you'll get a fairly
small list of commits that are the potential "bad" ones.

After the above four tries, you'd have limited it down to a list of 95
changes (from the original 1520), so it would really be best to try six or
seven different kernels, but at that point you'd have it down to less than
20 commits and then pinpointing the bug is usually much easier.

And when you're done, you can just do

	git checkout master

and you're back to where you started.

		Linus
