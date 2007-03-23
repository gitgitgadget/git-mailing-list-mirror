From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 01:03:31 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 02:03:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUYBu-0003Fr-Sh
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 02:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbXCWBDf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 21:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934260AbXCWBDf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 21:03:35 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:50725 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932079AbXCWBDe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2007 21:03:34 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 4EBF1C60D3
	for <git@vger.kernel.org>; Fri, 23 Mar 2007 01:03:32 +0000 (GMT)
Received: (qmail 30025 invoked by uid 103); 23 Mar 2007 01:03:31 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2896. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.035381 secs); 23 Mar 2007 01:03:31 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 23 Mar 2007 01:03:31 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070323004335.GA17773@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42892>

On Thu, 22 Mar 2007, Shawn O. Pearce wrote:

> Bruno Cesar Ribas <ribas@c3sl.ufpr.br> wrote:
>> 2.  write a backend for Subversion
>
> In this case we try to reuse the existing SVN server code by
> creating a library module that plugs into that system and uses a
> Git repository to store data, rather than say the existing bdb or
> fsfs stores.  Git should be much faster than fsfs, use a lot less
> disk space, and be just as atomic.
>
> By using this approach you avoid the need to reimplement their
> network protocol.  Which is a nice part of this approach.  But the
> downside is you have to write code to run within their library and
> address space, and that conforms to their storage API.

This might run headlong into some of the issues facing the libification 
project - in particular the tendancy of git code to die as a primary error 
handling mechanism.  This approach may not viable without access to a 
libified git?

> But either approach has a few key issues:
>
> - Assigning repository-wide revision numbers.  Git doesn't have
> such a concept, but its key to SVN.  These would need to be stored
> in a file so the server can quickly map from revision number to
> Git commit SHA-1.  The reflogs may help here, but currently they
> also expire.  Any reflog that is being used to do this mapping
> cannot be expired, ever.

You could probably do something similar to the system used by 
git-svnimport to record the Subversion revision to git SHA1 mapping - 
perhaps with a hook script to update?

>
> - Branches.  In SVN these are in the repository wide namespace,
> but in Git they aren't.  I imagine we'd want to just enforce the
> standard layout that the SVN people recommened:
>
>  /trunk/    --> refs/heads/master
>  /branches/ --> refs/heads/ (minus master)
>  /tags/     --> refs/tags/

That would probably be good enough for the majority of 
one-project-per-repo Subversion projects at least.  Though there is still 
the issue that Subversion will actually let you create a "tag" simply by 
committing whatever you currently have in your working copy (including 
localally modified files ... yeuch).

>
> That's all I can think of right now.  But I'm sure there are more.

Properties are probably the next biggest headache.  Subversion allows you 
to associate arbitrary keyword value pairs with files (which are 
versioned) and with revisions (which are not versioned).  You would need 
to find someway to support this in git.  Since revision properties are 
disabled by default in Subversion you may be able to simply disallow them 
permanently - but I don't know anything about the Subversion protocol ...

-- 
Julian

  ---
Practical politics consists in ignoring facts.
 		-- Henry Adams
