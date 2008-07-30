From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: git-fetch a tad slow?
Date: Wed, 30 Jul 2008 21:06:57 +0200
Message-ID: <20080730190657.GC26389@elte.hu>
References: <20080728160138.GA12777@elte.hu> <20080729055014.GE11947@spearce.org> <20080729090802.GA11373@elte.hu> <20080730044855.GA7225@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:09:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOH28-0007Le-2x
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581AbYG3THQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 15:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756429AbYG3THQ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 15:07:16 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:49167 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756544AbYG3THO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 15:07:14 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KOH0l-00061g-Q0
	from <mingo@elte.hu>; Wed, 30 Jul 2008 21:07:13 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id E41CB3E2191; Wed, 30 Jul 2008 21:06:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080730044855.GA7225@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90835>


* Shawn O. Pearce <spearce@spearce.org> wrote:

> > should i pack on both repos? I dont explicitly pack anything, but on 
> > the server it goes into regular gc runs. (which will pack most 
> > stuff, right?)
> 
> git-gc automatically runs `git pack-refs --all --prune` like I 
> recommended, unless you disabled it with config gc.packrefs = false. 
> So its probably already packed.
> 
> What does `find .git/refs -type f | wc -l` give for the repository on 
> the central server?  If its more than a handful (~20) I would suggest 
> running git-gc before testing again.

ah, you are right, it gave 275, then git-gc brought it down to two:

  earth4:~/tip> find .git/refs -type f | wc -l
  275
  earth4:~/tip> git gc
  earth4:~/tip> find .git/refs -type f | wc -l
  2

i turned off auto-gc recently (two weeks ago) because it was 
auto-triggering _way_ too frequently. (like on every fifth merge i was 
doing or so)

alas, fetching still seems to be slow:

  titan:~/tip> time git-fetch origin

  real    0m5.112s
  user    0m0.972s
  sys     0m3.380s

(but the gc run has not finished yet on the central repo so this isnt 
fully valid.)

> But I'm really suspecting that this is just our quadratic matching 
> algorithm running up against a large number of branches, causing it to 
> suck.
> 
> jgit at least uses an O(N) algorithm here, but since it is written in 
> Java its of course slow compared to C Git.  Takes a while to get that 
> JVM running.
> 
> I'll try to find some time to reproduce the issue and look at the 
> bottleneck here.  I'm two days into a new job so my git time has been 
> really quite short this week.  :-|

fetching the -tip repo:

   http://people.redhat.com/mingo/tip.git/README

and then running 'git remote update' will i think already show this 
problem for you too. People have been complaining about how slow the 
update is.

	Ingo
