From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: q: git-fetch a tad slow?
Date: Tue, 29 Jul 2008 21:48:55 -0700
Message-ID: <20080730044855.GA7225@spearce.org>
References: <20080728160138.GA12777@elte.hu> <20080729055014.GE11947@spearce.org> <20080729090802.GA11373@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 30 06:50:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO3dT-0002LU-Im
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 06:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbYG3Es6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 00:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbYG3Es5
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 00:48:57 -0400
Received: from george.spearce.org ([209.20.77.23]:35683 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbYG3Esz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 00:48:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4BD4E383A4; Wed, 30 Jul 2008 04:48:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080729090802.GA11373@elte.hu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90735>

Ingo Molnar <mingo@elte.hu> wrote:
> * Shawn O. Pearce <spearce@spearce.org> wrote:
> > Ingo Molnar <mingo@elte.hu> wrote:
> > > 
> > > Setup/background: distributed kernel testing cluster, [...]
> > > 
> > > Problem: i noticed that git-fetch is a tad slow:
> > > 
> > >   titan:~/tip> time git-fetch
> > >   real    0m2.372s
>
> note that titan is a very beefy box, almost 3 GHz Core2Duo:

That isn't going to matter if you have a quadratic algorithm and a
large dataset.  Especially when the inner loops are doing multiple
system calls per item in a long list of items.  :-|   Linux is fast,
but it isn't magic pixie dust.  It cannot fix broken applications.
 
> [...] So if we have a quadratic overhead on number of 
> branches, that's going to be quite a PITA.

Right.

> > I wonder if git-pack-refs + fetching only a single branch will get you 
> > closer to the tip-fetch time.
> 
> should i pack on both repos? I dont explicitly pack anything, but on the 
> server it goes into regular gc runs. (which will pack most stuff, 
> right?)

git-gc automatically runs `git pack-refs --all --prune` like I
recommended, unless you disabled it with config gc.packrefs = false.
So its probably already packed.

What does `find .git/refs -type f | wc -l` give for the repository
on the central server?  If its more than a handful (~20) I would
suggest running git-gc before testing again.

But I'm really suspecting that this is just our quadratic matching
algorithm running up against a large number of branches, causing
it to suck.

jgit at least uses an O(N) algorithm here, but since it is written
in Java its of course slow compared to C Git.  Takes a while to
get that JVM running.

I'll try to find some time to reproduce the issue and look at the
bottleneck here.  I'm two days into a new job so my git time has
been really quite short this week.  :-|

-- 
Shawn.
