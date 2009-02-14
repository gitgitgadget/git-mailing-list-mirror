From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [DRAFT] Create stash from index state
Date: Sat, 14 Feb 2009 23:59:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142356200.10279@pacific.mpi-cbg.de>
References: <20090214223929.GA29472@chistera.yi.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-126348321-1234652393=:10279"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sun Feb 15 00:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYTUs-0007HV-My
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 00:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbZBNW7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 17:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbZBNW7B
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:59:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:49687 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752148AbZBNW7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:59:00 -0500
Received: (qmail invoked by alias); 14 Feb 2009 22:58:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 14 Feb 2009 23:58:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186xm4nuRk6PltJCXqFhigyI46TQ8VwaSLwktPv45
	DOEpx77qjoWV4o
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090214223929.GA29472@chistera.yi.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109949>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-126348321-1234652393=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 14 Feb 2009, Adeodato Simó wrote:

> I've always missed a way to do what `bzr shelve` does: interactive
> stash, where you just select hunks à-la `add -p`, and then those gets
> stashed away.

I recently wrote this in my blog:

-- snip --
I think something like an interactive stash is needed. A method to 
specify what you want to keep in the working directory, the rest should 
be stashed. The idea would be something like this:

   1. Add the desired changes into a temporary index.
   2. Put the rest of the changes in another temporary index.
   3. Stash the latter index.
   4. Synchronize the working directory with the first index.
   5. Clean up temporary indices. 

Or in code:

$ cp .git/index .git/interactive-stash-1
$ GIT_INDEX_FILE=.git/interactive-stash-1 git add -i
$ cp .git/index .git/interactive-stash-2
$ GIT_INDEX_FILE=.git/interactive-stash-1 git diff -R |
        (GIT_INDEX_FILE=.git/interactive-stash-2 git apply--index)
$ tree=$(GIT_INDEX_FILE=.git/index git write-tree)
$ commit=$(echo Current index | git commit-tree $tree -p HEAD)
$ tree=$(GIT_INDEX_FILE=.git/interactive-stash-2 git write-tree)
$ commit=$(echo Edited out | git commit-tree $tree -p HEAD -p $commit)
$ git update-ref refs/stash $commit
$ GIT_INDEX_FILE=.git/interactive-stash-1 git checkout-index -a -f
$ rm .git/interactive-stash-1 .git/interactive-stash-2

This should probably go into git-stash.sh, maybe even with a switch to 
start git-gui to do the interactive adding instead of git-add.
-- snap --

Now, the main reason I did not implement this already is that I am not 
quite sure if you should select the changes you _want_ to keep (which 
would seem the more natural way to say what needs stashing), or if it 
would be better to select the changes you do _not_ want to keep (this 
would seem more consistent, as "git add -i" is about selecting what goes 
into the index, so "git stash -i" should be about selecting what goes into 
the stash).

Maybe you want to give it a try?

Ciao,
Dscho

--8323328-126348321-1234652393=:10279--
