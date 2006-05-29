From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] git commit --branch
Date: Mon, 29 May 2006 18:16:29 -0400
Message-ID: <20060529221629.GB29054@spearce.org>
References: <20060529202851.GE14325@admingilde.org> <20060529204158.GC28538@spearce.org> <20060529212249.GF14325@admingilde.org> <20060529213543.GA29054@spearce.org> <20060529215537.GH14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 00:16:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkq2O-0006vg-MB
	for gcvg-git@gmane.org; Tue, 30 May 2006 00:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWE2WQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 18:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWE2WQe
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 18:16:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37352 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751429AbWE2WQd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 18:16:33 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fkq2A-0000bZ-D0; Mon, 29 May 2006 18:16:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B4C0820E445; Mon, 29 May 2006 18:16:29 -0400 (EDT)
To: Martin Waitz <tali@admingilde.org>
Content-Disposition: inline
In-Reply-To: <20060529215537.GH14325@admingilde.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20986>

Martin Waitz <tali@admingilde.org> wrote:
> hoi :)
> 
> On Mon, May 29, 2006 at 05:35:43PM -0400, Shawn Pearce wrote:
> > Now that diff+apply is probably faster than a 3 way merge in
> > read-tree precisely because it doesn't need to run merge-recursive
> > I'm starting to look at how we can use apply to do partial
> > application of a patch and use RCS' diff3 or just drop a reject
> > file out when a hunk doesn't apply cleanly.
> 
> but when applying patches, we have to be careful not to overwrite
> any changes in the working tree which have not yet been committed.
> With read-tree it should operate entirely in its temporary index without
> touching the working tree.

Agreed.  But that's not always what you want.  There's two cases of
applying a patch:

	1) Apply this patch but only affect my working tree if everything
	is going to patch clean.  If anything goes wrong fail without
	touching anything.  git-apply already does this.

	2) I know that not all hunks in this patch will apply cleanly. So
	do the best you can by applying what you can and leave me the
	remainder for manual merging.  git-merge-recursive does this
	through RCS' diff3.

But I think I want #2 built into git-apply where it can handle
add/rename/delete cases without the expense of git-merge-recursive.
I also want it to apply what it can and leave me reject files _NOT_
a messy RCS style conflict in the file.  Some people just prefer
reject files.  I know someone has asked about this in the past as
Emacs has a good merge tool based on reject files.

But in the case of #2 we get a mess in our working directory and in
our index as the patch didn't go in cleanly.  That's OK.  I want
the unmerged stages in the index and I want the working directory
to contain the conflicts as I want to fix that all up before commit.

> > > But then an operation as important as commit has to be bullet-proof
> > > and I don't like to do anything complex in there.
> > 
> > I agree.  But I'd like to see some sort of functionality to
> > automatically handle some common topic branche cases in commit.
> > Of course I consider the current commit tool to already be too
> > complex (like being able to pull the commit message from any
> > random commit).
> 
> And I really feel guilt for trying to add even more.
> Is there some other way to add such a feature?

Not really.  Short of adding a new command which is a variant of
git-commit specialized for this type of work.  Which may be what I
wind up doing to get what I want.
 
> I have been dreaming of such a system for years now, and with GIT
> it really feels feasible at last.
> Graphics programs could compose an image out of different layers for
> ages, now it is time for version control software to do the same :-)

Heh.  Its not quite as simple as it is in an image editor.  But yes,
I agree.  Darcs can sort of do this I believe.  StGIT and pg both
attempt to do some basic operations but don't really get everything
right.

-- 
Shawn.
