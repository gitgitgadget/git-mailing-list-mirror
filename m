From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 23:24:14 +0300
Message-ID: <20080512202414.GA8620@mithlond.arda.local>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <alpine.DEB.1.00.0805121810501.30431@racer> <20080512184334.GB5160@mithlond.arda.local> <alpine.LFD.1.10.0805121453250.23581@xanadu.home> <20080512190946.GC5160@mithlond.arda.local> <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon May 12 22:27:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvea6-0003St-DH
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbYELUYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755515AbYELUYU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:24:20 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:36958 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754571AbYELUYT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:24:19 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 48232FF0002F453C; Mon, 12 May 2008 23:24:15 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JveZC-0002zu-7v; Mon, 12 May 2008 23:24:14 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81943>

Nicolas Pitre wrote (2008-05-12 15:36 -0400):

> On Mon, 12 May 2008, Teemu Likonen wrote:
> 
> > > On Mon, 12 May 2008, Teemu Likonen wrote:
> > > 
> > > > Well, I don't really have any problems with the current
> > > > behaviour; it just feels a bit strange that, for example,
> > > > Linus's kernel repository grew about 90MB after just one update
> > > > pull and gc.

> > As I used the kernel repo just for testing this behaviour in
> > question I did both things today. Timestamps tell that there were
> > six hours between the initial .keep pack and the new pack created by
> > manual "git gc".
> 
> This is way too big a difference.  Something is going on.
> 
> What git version is this? And can you send me the content of your
> .git/logs directory?

I'm using Git from the "master" branch; compiled it today. I have the
following gc/repack-related patches applied from the "pu" branch:

  builtin-gc.c: deprecate --prune, it now really has no effect
  git-gc: always use -A when manually repacking
  repack: modify behavior of -A option to leave unreferenced objects unpacked

But I have experienced the same earlier with some other post-1.5.5
version so I believe you can reproduce this yourself. After cloning
Linus's linux-2.6 repo its .git directory weights 209MB. After single
"git pull" and "git gc" it was 298MB in my test.

I'll send you the .git/logs directory but I'm afraid it doesn't tell
much. There are just three files:

  .git/logs/HEAD
  .git/logs/refs/heads/master
  .git/logs/refs/remotes/origin/master

They containt one line for the initial clone and one line for
the fast-forward pull.

> > I think it can contain at some later point. For example, if a user
> > first fetches all the branches but later decides to track only one
> > branch. After deleting unneeded tracking branches and expiring the
> > reflog there'll be dangling objects in the original .keep pack
> > created with "git clone".
> 
> Sure.  But to decide to track only one branch and exclude the others
> require some higher level of git knowledge already.  At that point if
> you really care about top packing performances you certainly can deal
> with the .keep file as well.

Perhaps so. Although I don't consider this very high level Git
knowledge:

  $ git remote rm origin
  $ git remote add -t wanted_branch origin git://...

The first command removes all the tracking branches. The latter starts
to track only one branch.
