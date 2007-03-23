From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git / Subversion Interoperability
Date: Thu, 22 Mar 2007 20:43:36 -0400
Message-ID: <20070323004335.GA17773@spearce.org>
References: <20070322224829.GA7048@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Fri Mar 23 01:43:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUXsh-0002Dt-0B
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 01:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934216AbXCWAnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 20:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934221AbXCWAnm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 20:43:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46237 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934216AbXCWAnl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 20:43:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HUXsN-0000fE-OK; Thu, 22 Mar 2007 20:43:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C997720FBAE; Thu, 22 Mar 2007 20:43:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070322224829.GA7048@c3sl.ufpr.br>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42890>

Bruno Cesar Ribas <ribas@c3sl.ufpr.br> wrote:
> I'm going to apply for the Git / Subversion Interoperability project.
> 
> I saw that there is no mentor yet assigned for the "job". So i'm sending this
> mail to get some help to start the project by submiting to GSOC and begin to
> work :)

I'll consider being a mentor for this project, but I know very
little of the SVN protocol or how its server behaves.  I also
don't really have the time to learn those nitty-gritty details
myself, nor do I have any burning desire to.
 
> My idea on this project is to create:
> 1.  git-svnserver
> 2.  write a backend for Subversion

These are two different approaches to the same problem.  I think
what was meant here was:

> 1.  git-svnserver

Here we create a new program that can be invoked via SSH that runs
the server-side of the SVN protocol.  Or we create a CGI program that
acts as the extended-WebDAV server for SVN.  Sam Vilain (mugwump
on #git) is suggesting using this approach as it probably will be
easier to debug.

> 2.  write a backend for Subversion

In this case we try to reuse the existing SVN server code by
creating a library module that plugs into that system and uses a
Git repository to store data, rather than say the existing bdb or
fsfs stores.  Git should be much faster than fsfs, use a lot less
disk space, and be just as atomic.

By using this approach you avoid the need to reimplement their
network protocol.  Which is a nice part of this approach.  But the
downside is you have to write code to run within their library and
address space, and that conforms to their storage API.


But either approach has a few key issues:

- Assigning repository-wide revision numbers.  Git doesn't have
such a concept, but its key to SVN.  These would need to be stored
in a file so the server can quickly map from revision number to
Git commit SHA-1.  The reflogs may help here, but currently they
also expire.  Any reflog that is being used to do this mapping
cannot be expired, ever.

- Branches.  In SVN these are in the repository wide namespace,
but in Git they aren't.  I imagine we'd want to just enforce the
standard layout that the SVN people recommened:

  /trunk/    --> refs/heads/master
  /branches/ --> refs/heads/ (minus master)
  /tags/     --> refs/tags/

That's all I can think of right now.  But I'm sure there are more.

> And make it easy to work with SSH using those "common" flags in
> authorized_keys like:
> command="svnserve -t -r /home/svn --tunnel-user=bruno" ssh-dss bla bla

Not following you...
 
> And as an idea i would like to make the same funcionality to git, as it is
> not as easy today to do something like above :)

Again, not following you...

-- 
Shawn.
