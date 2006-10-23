From: Sean <seanlkml@sympatico.ca>
Subject: Re: git bisect with history manipulation
Date: Mon, 23 Oct 2006 11:47:38 -0400
Message-ID: <BAYC1-PASMTP01856E85F8D54BE3CBF69EAE000@CEZ.ICE>
References: <a425f86c0610230718i556537dei9a4b2a5fa8d7f003@mail.gmail.com>
	<a425f86c0610230722r2a0ae473o467d303f915b6c1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 17:47:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc21h-0007Uw-TH
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 17:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWJWPrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 11:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWJWPrm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 11:47:42 -0400
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:44891 "EHLO
	bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751054AbWJWPrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 11:47:41 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 23 Oct 2006 08:47:39 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1Gc15W-0003aG-FQ; Mon, 23 Oct 2006 10:47:38 -0400
To: "Kalle Pokki" <kalle.pokki@iki.fi>
Message-Id: <20061023114738.f77efec3.seanlkml@sympatico.ca>
In-Reply-To: <a425f86c0610230722r2a0ae473o467d303f915b6c1e@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 23 Oct 2006 15:47:40.0275 (UTC) FILETIME=[9222EC30:01C6F6BA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Oct 2006 17:22:41 +0300
"Kalle Pokki" <kalle.pokki@iki.fi> wrote:

> I'm still pretty new with git, and cannot quite figure out how to use
> "git bisect" effectively in this special case: I'm running an embedded
> powerpc board, to which I need about a dozen platform patches in the
> kernel. Originally I made the patches with quilt on top of 2.6.15.4. I
> recently started using git, and just applied the patches on top of
> v2.6.18. However, the system seems to oops at every boot now. So I did
> "git branch downgrade && git reset --hard v2.6.15" and applied my
> patches on top of it to create a starting state similar to what I had
> previously. There everything is ok.
> 
> Wanting to try to bisect the kernel versions, I then merged the master
> branch into the downgrade branch. Then I marked my last platform
> commit as good, and v2.6.18 as bad. However the bisect algorithm seems
> to group the platform patches near v2.6.18 instead of v2.6.15, since I
> don't have the platform files in the bisect checkout. And since I
> don't have the platform files, I can't compile a kernel that would run
> on my board.
> 
> So is there any way to insert a few patches to an arbitrary point
> backwards in time and start bisecting from that to the present time?
> Or am I thinking this somehow all wrong?
> 

Well, there is no way to insert the patches into the history at an old
point so that they're always available at each bisection point in your
search.  The history is immutable.

What you will have to do, is apply your patches manually at each
bisection point before you compile/test.  After testing you'll have
to remove your manual patches and continue with your next git
bisect command.  However, there are a few ways that you can make this
easier to do.

You could use the Stacked Git utility (which is a Quilt like clone
built on top of Git) to help you along in this process.  Actually,
you may be able to do the same thing with Quilt itself, but i don't
know i've never used it.

That said, i'll try to outline one way to do this that should work
using just native Git commands.  The first thing you need to do is
prepare a git branch based on the first known-good commit that 
contains all your extra patches.  So:

$ git checkout -b mypatches v2.6.15
$ patch < patch1
$ git commit -a
$ patch < patch2
$ git commit -a
etc...

Then you can go back to the master branch and start the bisection:

$ git checkout master
$ git bisect start
$ git bisect bad
$ git bisect good v2.6.15

At which point git will create and move you to a temporary "bisect"
branch to do your compile/testing.  Now before you compile, you want
to append your patch series from the branch you prepared earlier, so:

$ git pull . mypatches

Now compile and test.  After you've tested, you will  have to remove
your patches from this branch before continuing with the git bisection
process so:

$ git reset --hard ORIG_HEAD

And now continue with your bisection, let's assume the first bisection
point still didn't work:

$ git bisect bad

Which will move you to a new bisection point where you can go back to
the "git pull . mypatches" step to apply your patch series again and
do another compile/test.  Continue with this process as needed.

Hope that is clear enough,
Sean
