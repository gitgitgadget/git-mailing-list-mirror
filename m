From: Theodore Tso <tytso@mit.edu>
Subject: Re: mercurial to git
Date: Thu, 15 Mar 2007 17:04:07 -0400
Message-ID: <20070315210406.GA8568@thunk.org>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070306215459.GI18370@thunk.org> <20070306230802.GA17226@filer.fsl.cs.sunysb.edu> <20070307001105.GJ18370@thunk.org> <20070314111257.GA4526@peter.daprodeges.fqdn.th-h.de> <20070314132951.GE12710@thunk.org> <20070315094434.GA4425@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rocco Rutte <pdmef@gmx.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 22:04:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRx7Y-0005bu-9c
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 22:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbXCOVER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 17:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbXCOVER
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 17:04:17 -0400
Received: from THUNK.ORG ([69.25.196.29]:36400 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbXCOVER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 17:04:17 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HRxD8-0000ct-If; Thu, 15 Mar 2007 17:10:11 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HRx7H-00040m-7S; Thu, 15 Mar 2007 17:04:07 -0400
Content-Disposition: inline
In-Reply-To: <20070315094434.GA4425@peter.daprodeges.fqdn.th-h.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42298>

Hopefully you won't mind that I'm adding the git list back to the cc
line, since it would be useful for others to provide some feedback.

On Thu, Mar 15, 2007 at 09:44:35AM +0000, Rocco Rutte wrote:
> >So I'll go try it out in the near future.  Are you planning on being
> >able to make it be bi-directional?  (i.e., so that changes in the git
> >tree can get propagated back to the hg tree?)
> 

> But as there's no hg-fast-import, I think git to hg not so trivial to 
> implement and convert-repo already exists, so I'd rather prefer 
> extending it to do the job.

Actually, there *is* an hg-fast-import.  It exists in the hg sources
in contrib/convert-repo, and it is being used in production to do
incremental conversion from the Linux kernel git tree to an hg tree.
So it does handle octopus merges already (it has to, the ACPI folks
are very ocotpus merge happy :-).

> However, I never even used hg and have only some knowledge about the API 
> so that I see some difficulties and need more time to think about it 
> (e.g. how to detect whether a change in hg originates at git and vice 
> versa, what to do with octopus merges, cherry-picks, etc).

So actually I have thought about this a fair amount, so if you don't
mind my pontificating a bit.   :-)

At the highest architectural viewpoint, there are three levels of
difficulty of SCM conversions:

A) One-way conversion utilities.  Examples of this would be the
	hg2git, hg-fast-import scripts that convert from hg to git,
	and the convert-repo script which will convert from git to hg.

B) Single point bidrectional conversion.  At this level, the hg/git
	gateway will run on a single machine, and with a state file,
	can recognize new git changesets, and create a functionally
	equivalent hg changeset and commit it to the hg repository,
	and can also recognize new hg changeset, and create a
	functionaly equivalent git changeset, and commit it to the git
	repository.  

C) Multisite bidirectional conversion.  At this level, multiple users
	be gatewaying between the two DSCM systems, and as long as
	they are using the same configuration parameters (more on this
	in a moment), if user A converts changeset from hg to git, and
	that changeset is passed along via git to user B, who then
	running the birectional gateway program, converts it back from
	git to hg, the hg changeset is identical so that hg recognizes
	is the same changeset when it gets propgated back to user A.

(C) would be the ideal, given the distributed nature of hg and git.
It is also the most difficult, because it means that we need to be
able to do a lossless, one-to-one conversion of a Changeset.  It is
also somewhat at odds with doing author mapping and signed-off-by
parsing, since that could prevent a reversible transformation.
However, what may very well be common for projects is for them to
start with (B), and to convert over some of the historical changesets,
and then later on allow multiple users to clone from the two git/hg
repositories and then do the multisite conversion.

So what that also means is that even if we only do (B) at first, it
might be useful if we have some of the characteristics needed to
eventually get to (C), even if we can't get there right away.

So more practially, here are some of the things that we would need to
do, looking at hg-fast-export:

*) Change the index/marks file to map between hg SHA hash ID's instead
of the small integer ordinals.  This is useful for enabling multisite
conversion, but it is also useful for tracking tag changes in .hgtags.

*) Have a mode so that instead of only checking changes greater than
last run, to simply iterate over all changesets in mercurial and check
to see if hg SHA1 commit ID is already in the marks file; if so, skip
it.  

*) Have a mode where the COMMITER id is "hg2git" and the COMMITER_DATE
is the same as the AUTHOR_DATE (so that the changelog converesion is
the same no matter where or who does the converation).  This is mainly
to enable multisite converstaion.

						- Ted
