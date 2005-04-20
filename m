From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Wed, 20 Apr 2005 09:01:57 +0200
Message-ID: <20050420070157.GA12584@elte.hu>
References: <20050416233305.GO19099@pasky.ji.cz> <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org> <20050419011206.GT5554@pasky.ji.cz> <42646967.9030903@dwheeler.com> <4264CCFF.30400@dgreaves.com> <20050419092812.GE2393@pasky.ji.cz> <1113905110.1262.1.camel@nosferatu.lan> <20050419105008.GB12757@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
	David Greaves <david@dgreaves.com>, dwheeler@dwheeler.com,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 08:59:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO9Al-0002zJ-N6
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 08:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVDTHDB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 03:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVDTHDB
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 03:03:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61674 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261398AbVDTHCl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 03:02:41 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 17E973186E0;
	Wed, 20 Apr 2005 09:01:01 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id D424F1FC2; Wed, 20 Apr 2005 09:02:01 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050419105008.GB12757@pasky.ji.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Petr Baudis <pasky@ucw.cz> wrote:

> > I think pull is pull.  If you are doing lots of local stuff and do not
> > want it overwritten, it should have been in a forked branch.
> 
> I disagree. This already forces you to have two branches (one to pull 
> from to get the data, mirroring the remote branch, one for your real 
> work) uselessly and needlessly.
> 
> I think there is just no good name for what pull is doing now, and 
> update seems like a great name for what pull-and-merge really is. Pull 
> really is pull - it _pulls_ the data, while update also updates the 
> given tree. No surprises.

yeah. In fact most of the times i did 'git pull pasky' in the past, the 
'merge' phase was unsuccessful, and i had to nuke the tree and recreate 
it.  All i did with the snapshots was to build them, so there were no 
local changes. Waiting a couple of days with doing a 'git pull pasky', 
or installing Linus' tree is a sure way to break the merging.

e.g. to reproduce the last such failure i had today, do:

 cd git-pasky-base
 echo 8568e1a88c086d1b72b0e84ab24fa6888b5861b9 > .git/HEAD
 read-tree $(tree-id $(cat .git/HEAD))
 checkout-cache -a -f
 make
 make install           # make sure to use the older tools
 rm -rf .git/objects
 git pull pasky

and i get:

 [...]
 fatal: unable to execute 'gitmerge-file.sh'
 fatal: merge program failed

        Conflicts during merge. Do git commit after resolving them.

note that with earlier versions of pasky, i had other merge conflicts.  
Sometimes there were .rej files, sometimes some sort of script failure.  
So it seems rather unrobust at the moment. Especially if i happen to 
install Linus' tree and try to sync the pasky tree with those tools.

another thing: it's confusing that during 'git pull', the rsync output 
is not visible. Especially during large rsyncs, it would be nice to see 
some progress. So i usually use a raw rsync not 'git pull', due to this.

yet another thing: what is the canonical 'pasky way' of simply nuking 
the current files and checking out the latest tree (according to 
.git/HEAD). Right now i'm using a script to:

  read-tree $(tree-id $(cat .git/HEAD))
  checkout-cache -a

(i first do an 'rm -f *' in the working directory)

i guess there's an existing command for this already?

	Ingo
