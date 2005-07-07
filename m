From: "Alexander Y. Fomichev" <gluk@php4.ru>
Subject: Re: 2.6.12 hangs on boot
Date: Thu, 7 Jul 2005 18:18:02 +0400
Message-ID: <200507071818.03380.gluk@php4.ru>
References: <200506221813.50385.gluk@php4.ru> <Pine.LNX.4.58.0506241446440.11175@ppc970.osdl.org>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	admin@list.net.ru, Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261551AbVGGOVa@vger.kernel.org Thu Jul 07 16:24:28 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261551AbVGGOVa@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqXI8-0005Ya-16
	for glk-linux-kernel@gmane.org; Thu, 07 Jul 2005 16:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVGGOVa (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Thu, 7 Jul 2005 10:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVGGOT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:19:26 -0400
Received: from village.ehouse.ru ([193.111.92.18]:58629 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261551AbVGGOSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 10:18:15 -0400
Received: from [193.111.92.114] (helo=breuss-254.ws.ehouse.ru)
	by mail.ehouse.ru with esmtp
	(Exim 3.22) id 1DqXCW-0003yj-00 ; Thu, 07 Jul 2005 18:18:04 +0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8.1
In-Reply-To: <Pine.LNX.4.58.0506241446440.11175@ppc970.osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 June 2005 02:20, Linus Torvalds wrote:
> On Wed, 22 Jun 2005, Alexander Y. Fomichev wrote:
> > I've been trying to switch from 2.6.12-rc3 to 2.6.12 on Dual EM64T 2.8
> > GHz [ MoBo: Intel E7520, intel 82801 ]
> > but kernel hangs on boot right after records:
> >
> > Booting processor 2/1 rip 6000 rsp ffff8100023dbf58
> > Initializing CPU#2
>
> Hmm.. Since you seem to be a git user, maybe you could try the git
> "bisect" thing to help narrow down exactly where this happened (and help
> test that thing too ;).
>
> You can basically use git to find the half-way point between a set of
> "known good" points and a "known bad" point ("bisecting" the set of
> commits), and doing just a few of those should give us a much better view
> of where things started going wrong.
>
> For example, since you know that 2.6.12-rc3 is good, and 2.6.12 is bad,
> you'd do
>
> 	git-rev-list --bisect v2.6.12 ^v2.6.12-rc3
>
> where the "v2.6.12 ^v2.6.12-rc3" thing basically means "everything in
> v2.6.12 but _not_ in v2.6.12-rc3" (that's what the ^ marks), and the
> "--bisect" flag just asks git-rev-list to list the middle-most commit,
> rather than all the commits in between those kernel versions.
>
> You should get the answer "0e6ef3e02b6f07e37ba1c1abc059f8bee4e0847f", but
> before you go any further, just make sure your git index is all clean:
>
> 	git status
>
> should not print anything else than "nothing to commit". If so, then
> you're ready to try the new "mid-point" head:
>
> 	git-rev-list --bisect v2.6.12 ^v2.6.12-rc3 > .git/refs/heads/try1
> 	git checkout try1
>
> which will create a new branch called "try1", where the head is that
> "mid-point", and it will switch to that branch (this requires a fairly
> recent "git", btw, so make sure you update your git first).
>
> Then, compile that kernel, and try it out.
>
> Now, there are two possibilities: either "try1" ends up being good, or it
> still shows the bug. If it is a buggy kernel, then you now have a new
> "bad"  point, and you do
>
> 	git-rev-list --bisect try1 ^v2.6.12-rc3 > .git/refs/heads/try2
> 	git checkout try2
>
> which is all the same thing as you did before, except now we use "try1" as
> the known bad one rather than v2.6.12 (and we call the new branch "try2"
> of course).
>
> However, if that "try1" is _good_, and doesn't show the bug, then you
> shouldn't replace the other "known good" case, but instead you should add
> it to the list of good commits (aka commits we don't want to know about):
>
> 	git-rev-list --bisect v2.6.12 ^v2.6.12-rc3 ^try1 > .git/refs/heads/try2
> 	git checkout try2
>
> ie notice how we now say: want to get the bisection of the commits in
> v2.6.12 (known bad) but _not_ in either of v2.6.12-rc3 or the 'try1'
> branch (which are known good).
>
> After compiling and testing a few kernels, you will have narrowed the
> range down a _lot_, and at some point you can just say
>
> 	git-rev-list --pretty try4 ^v2.6.12-rc3 ^try1 ^try3
>
> (or however the "success/failure" pattern ends up being - the above
> example line assumes that "try1" didn't have the bug, but "try2" did, and
> then "try3" was ok again but "try4" was buggy), and you'll get a fairly
> small list of commits that are the potential "bad" ones.
>
> After the above four tries, you'd have limited it down to a list of 95
> changes (from the original 1520), so it would really be best to try six or
> seven different kernels, but at that point you'd have it down to less than
> 20 commits and then pinpointing the bug is usually much easier.
>
> And when you're done, you can just do
>
> 	git checkout master
>
> and you're back to where you started.
>
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

	Thank you for your answer, i've been on vacations last two weeks,
and i didn't have an access to my mail account.
	Hmmm... it seems that 'bisect' method not applicable to this host, this
is production server, not so critical to one or two reboots but 'bisect' will
require much more, i suspect. I've another host, nearly the same as of
hardware and non-critical where such tests could be done , but i haven't a 
serial console on it as now. It takes some time to link console because both 
of this are remote hosts.

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
