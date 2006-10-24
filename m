From: Shawn Pearce <spearce@spearce.org>
Subject: Re: updating only changed files source directory?
Date: Tue, 24 Oct 2006 01:55:39 -0400
Message-ID: <20061024055539.GD9724@spearce.org>
References: <ehjqgf$ggb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 07:55:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcFGO-0003A0-5R
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 07:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbWJXFzo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 01:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbWJXFzo
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 01:55:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43994 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1752075AbWJXFzn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 01:55:43 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GcFGG-00082o-VM; Tue, 24 Oct 2006 01:55:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ED74B21269E; Tue, 24 Oct 2006 01:55:39 -0400 (EDT)
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Content-Disposition: inline
In-Reply-To: <ehjqgf$ggb$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29928>

Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
> For a VCS, this is slightly nonstandard use, as we don't do any work
> in the working dir, we just compile from it, but have many working
> directories.

Its not nonstandard use.  A lot of projects perform rolling builds
which trigger anytime there are changes; very active projects
would always be building and thus would always want to have the
VCS only update those files which actually changed, to minimize
the compile time.
 
> I have some questions and remarks
> 
> * Is there a command analogous to git-clone for updating a repository?
> Right now, I'm using a combination of

Yes, its called git-fetch and git-pull.  Which leads us to...
 
>   git-http-fetch -a <branch>  <url>
>   wget <url>/refs/head/<branch>    ## dump to <myrepo>/refs/head/<branch>
> 
> for all branches I want to know about.  I was looking for a command
> that would update the heads of all branches.

Why not use git-fetch?

Create a .git/remotes file named 'origin' and put in there the URL
you want to fetch from and the list of branches you want to download
and keep current.

Then downloading the changes to the build repository is as simple
as running `git-fetch` with no parameters (as it defaults to reading
the origin file).

> * How do I update a source directory?

Always keep the source directory on a branch that is not listed
in the .git/remotes/origin file.  This way the fetch will always
succeed without failure.

Then you can do after the fetch:

	git-reset --hard <committish>

and the source directory will be updated to <committish> (which
could just be a branch name of one of those branches you fetch,
or could be a full SHA1, or a tag, etc.).

The reset --hard process will only change the files that really have
to change.  This means it will run in linear time proportional to the
number of files needing to be updated; and only those files which are
different between the working directory and <committish> will have
new modification dates.  Therefore incremental rebuilds will work.
 
> * As far as I can see, there is no reason to have only one index in a
> git repository. Why isn't it possible to specify an alternate
> index-file with an option similar to --git-dir ?

The index is key to getting the fast update of the working directory.
You can change the index with the (rather undocuments) GIT_INDEX_FILE
environment variable.  I do this in a few tools I have written
around Git, but I don't do it very often.

-- 
Shawn.
