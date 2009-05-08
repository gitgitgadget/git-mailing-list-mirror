From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/2] Make Repository.isValidRefName compatible
	with Git 1.6.3
Date: Fri, 8 May 2009 07:34:36 -0700
Message-ID: <20090508143436.GX30527@spearce.org>
References: <1241708714-20326-2-git-send-email-spearce@spearce.org> <200905080102.44053.robin.rosenberg@dewire.com> <alpine.LFD.2.01.0905071620240.4983@localhost.localdomain> <7vprekbfik.fsf@alter.siamese.dyndns.org> <20090508004741.GU30527@spearce.org> <81b0412b0905080024r211864bfhe7f70acabe0880c6@mail.gmail.com> <alpine.DEB.1.00.0905081003460.18521@pacific.mpi-cbg.de> <7vljp80yt4.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0905081153050.4601@intel-tinevez-2-302> <81b0412b0905080445j6d91f05jb13169ebd0245935@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 16:35:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2RAd-0002W4-8J
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 16:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbZEHOeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 10:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbZEHOeh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 10:34:37 -0400
Received: from george.spearce.org ([209.20.77.23]:53070 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbZEHOeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 10:34:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E77DA381D1; Fri,  8 May 2009 14:34:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <81b0412b0905080445j6d91f05jb13169ebd0245935@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118607>

Alex Riesen <raa.lkml@gmail.com> wrote:
> 2009/5/8 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > On Fri, 8 May 2009, Junio C Hamano wrote:
> >>
> >> Could there be people with slightly older git and shiny new jgit (or the
> >> other combination) working on the same repository?

Yes, Gerrit Code Review runs a JGit daemon 24/7.  I have a lot
of folks running Gerrit servers inside their company networks,
and two running them on the public internet.  Gerrit runs bleeding
edge JGit, and would most certainly pick up a "..lck" patch there
before they upgrade their git-core package.

This is one of those cases where the locking is really important,
because you should be able to concurrently access the same git
repository from the command line with git-core utilities while
Gerrit's daemon process is servicing network based user requests.

> > You mean concurrently? ??Sure, but do we have to care? ??People doing this
> > certainly know what they are doing, and live happily even with a 0.5"
> > hole in their foot.

Yes, dammit, we should care.

> Of course people run git concurrently on the same repo. Even from different
> machines.

Even ignoring JGit and Gerrit's daemon process entirely as "useless
stupid projects that never should have happened", _this_ is enough
of a reason to care.  People use Git on NFS all of the time.
With different machines.  Accessing the same repo.  Those different
machines most likely have different versions of Git installed.

> That's _why_ we have the locking in the first place.

Yes.

I've actually thought about this "fix.vm.lock" being invalid for
quite a while now, and wanted to change lockfile.c to use another
pattern that was already an invalid ref name, like Junio's "..lck"
proposal does.  But I've never been able to come up with a sane way
to deal with the transition.  So I never brought the topic up before.

I still don't have a sane way to deal with the transition.

The only thing I can think of is:

  - grab ".lock"
  - grab "..lck"
  - do stuff
  - commit by link("..lck", orig)
  - ulink ".lock"

And maybe in a year we stop writing ".lock".

But, here's news for you, *#@!#@@!$@!*&@! distributions are still
shipping 1.5.0-1.5.0.3.  In particular I've spent the better part
of this past two weeks telling new Git users to upgrade off of these
versions due to the pread() bug introduced in [1] and fixed in [2].

I've seen WAAAAY too many "fatal: cannot pread pack file:" errors.
Enough for a lifetime.

[1] http://repo.or.cz/w/git.git?a=commit;h=6d2fa7f1b489c65e677c18eda5c144dbc5d614ab
[2] http://repo.or.cz/w/git.git?a=commit;h=a91d49cd369ac5fc8e1a17357a975d09cf6c8cb3

-- 
Shawn.
