From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 05:56:16 -0500
Message-ID: <20070115105616.GE12257@spearce.org>
References: <200701151000.58609.andyparkins@gmail.com> <20070115101529.GB12257@spearce.org> <200701151042.12753.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVr-0000SF-AT
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:51 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9i-0003eK-13
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbXAOK4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbXAOK4U
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:56:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47919 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbXAOK4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:56:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6PVe-00082W-JT; Mon, 15 Jan 2007 05:56:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 31EE420FBAE; Mon, 15 Jan 2007 05:56:16 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701151042.12753.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36852>

Andy Parkins <andyparkins@gmail.com> wrote:
> On Monday 2007 January 15 10:15, Shawn O. Pearce wrote:
> As an added extra, the host of the central repository could have a list 
> of "allowed keys" so that only correctly signed commits would be allowed into 
> the repository.

But that might reject cases where one commit has been brought up
from other repositories yet its part of a chain of 1,000 commits
now being pushed into the central repository.  You need to allow
the head that is coming in, and everything in its past.
 
> As an example of why this would be useful: let's say we have a developer 
> committing to a maintainer repository who then merges those changes into 
> mainline and pushes up to the central repository (like what happens with 
> Linux).  The commits to the central repository are made using the ssh login 
> of the maintainer, but they are adding commits by someone else.  What if that 
> someone else isn't allowed to commit to the central?  With signed commits the 
> option is available to exclude them.

You can't just clip commits out during a push!  Are you going to
reject the push because the trusted SSH-logged in maintainer has
pulled in changes from elsewhere and has decided that they are good
enough for inclusion?

> I don't think the argument that Matthias offered ("You just explained why no 
> one should pull from people he does not trust.") is a good one.  One might 
> not want trust to be transitive.  Just because I trust you, doesn't not mean 
> that I trust those who you trust.  The path of getting commits in via a 
> trusted person, perhaps even via multiple levels of transitive trust might 
> not be something that is wanted in every project.  Having signed commits 
> would at least give the option.

Yes, that's very valid.  But if you trust me and I've gone and
built 100 commits on top of something I got from someone else I
trust but that you don't trust, you are going to reject all of my
changes and ask that I rewrite them?  That's quite paranoid.
 
> > What I'm actually doing in one particular environment is checking
> > the committer string against a database of known committer strings
> > associated with the current UNIX uid.
> 
> This addresses the problem somewhat.  However, the problem I'm talking about 
> is where a commit identity has been faked by someone committing to a 
> secondary (or tertiary) level repository.  While you are ensuring that the 
> current user is allowed to commit on behalf of someone else to your 
> repository, you haven't protected anything, because they could simply fake 
> their ID to one of the "allowed" set and your test will pass.

Actually I'm checking for exact matching against the committer
string.  Every UNIX uid has exactly one (and only one) committer
string associated with it.  The name on their payroll and security
paperwork, and the corporate email that was assigned to them.
So you *cannot* push something which was committed by another user
or which you committed for them on their behalf.  But you can set
the author field to anything you want; indeeded I often copy in
changes from other people and mark them as the author will retaining
the committer line as myself.

This causes a huge problem with our local mirror of git.git.
Normally I would just run git-fetch on the server to update the
mirror (thus bypassing the update hook, which screams out that I'm
not Junio) but that system doesn't have cURL or expat built and I
can only fetch over HTTP from there.  So I wind up having to go
through extra hoops to update commits which came from someone I
trust, but which ain't me.

-- 
Shawn.
