From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit as a jira plugin
Date: Fri, 31 Oct 2008 07:42:58 -0700
Message-ID: <20081031144258.GS14786@spearce.org>
References: <5915DAE3-7BDF-4296-9DB3-6FBEE504A317@xiplink.com> <20081029230816.GA31926@spearce.org> <D7D18CE8-BDBD-430A-BCB6-D1BEFD21C949@xiplink.com> <20081029235317.GC31926@spearce.org> <C9B1B0D7-6F99-48DE-8593-A13F1187ADE2@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Longman" <longman@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 15:44:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvvEV-0004iu-7b
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 15:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbYJaOnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 10:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbYJaOnA
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 10:43:00 -0400
Received: from george.spearce.org ([209.20.77.23]:52041 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYJaOm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 10:42:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9BAF038360; Fri, 31 Oct 2008 14:42:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <C9B1B0D7-6F99-48DE-8593-A13F1187ADE2@xiplink.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99591>

"J. Longman" <longman@xiplink.com> wrote:
> Right, I see now, I thought there was going to be more detail.  Anyways, 
> I'm wondering if there is some action required to ensure it reads from 
> the database vs. the working directory?  I'm assuming it is still looking 
> at the workspace as this is what I'm seeing:
>
> ...RevisionIndexer] Latest indexed revision for repository=1 is :  
> 29ed4398d047ba5e0d6fbad9ebbf98304b0fc503
> ...GitManagerImpl] Fetch...
> ...GitManagerImpl] From /Users/longman/workspace2/work/../masterRepo/
> ...GitManagerImpl]    c209b0f..594e8ff  master     -> origin/master
> ...GitManagerImpl] scan for repo changes...  
> repository.scanForRepoChanges();
> ...GitManagerImpl] scan for repo changes... complete
> ...RevisionIndexer] testing 29ed4398d047ba5e0d6fbad9ebbf98304b0fc503 at 
> CORE-23 sdjskl
> ...RevisionIndexer] 	update latest as  
> 29ed4398d047ba5e0d6fbad9ebbf98304b0fc503 at Wed Oct 29 18:49:54 EDT 2008

Oh.

Your RevisionIndexer must be looking at HEAD, which is the current
branch data.  However the fetch process updated the remote tracking
refs, which are in a different namespace.

You should point your indexer at "origin/master", or use a bare
repository (one with no working directory) and fetch directly into
"refs/heads/*" instead of into "refs/remotes/origin/*", that way
the indexer can look at branch "master".

Fetch doesn't ever touch the working directory; it only updates
the database in the background and the refs/remotes/ namespace so
that other applications can see the data that was transferred and
choose how to process it.

In command line Git "git pull" uses "git fetch" to get the data
and then uses the received data to update the working directory.
But a lot of workflows also will just issue "git fetch" on their own
to get the data, then examine it with "gitk --all", or do nothing
at all because they are mirroring the data, or have to close their
laptop and catch a bus, etc...

If all you are doing is scanning the revision history and the
files via JGit you just have to run a Transport.fetch() call and
then look at the refs that were updated during that call.  See the
FetchResult object you get returned for the list; it is what the
pgm.Fetch class uses to display the output cited above.

-- 
Shawn.
