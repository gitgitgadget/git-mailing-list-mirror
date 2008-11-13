From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 13:18:26 -0500
Message-ID: <20081113181826.GA16741@fieldses.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <git@davidb.org>, Thomas Koch <thomas@koch.ro>,
	git@vger.kernel.org, dabe@ymc.ch
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 19:19:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0gnO-0007lW-5s
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 19:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbYKMSSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 13:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbYKMSSh
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 13:18:37 -0500
Received: from mail.fieldses.org ([66.93.2.214]:37674 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264AbYKMSSg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 13:18:36 -0500
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1L0glu-0004VR-ML; Thu, 13 Nov 2008 13:18:26 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100894>

On Wed, Nov 12, 2008 at 10:14:44AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 12 Nov 2008, David Brown wrote:
> > 
> > We had occasionally run into locking problems with 1.5.4.x with
> > renames between different directories.  This should be fixed in
> > 1.6.0.3, but we have since migrated to a server model so I don't have
> > any way of testing this.
> 
> I suspect it also depends very much on the particular client/server 
> combination. Renaming across directories is one of those NFS things that 
> some servers don't mind at all.

On the linux server you want to make sure you're exporting with
no_subtree_check (see "man exports").

> > The configuration we did find completely unworkable was using git with 
> > the work tree on NFS.
> 
> Doing an 'lstat()' on every single file in the tree would tend to do that 
> to you, yes. Even with a fast network and a good NFS server, we're talking 
> millisecond-range latencies, and if your tree has tens of thousands of 
> files, you're going to have each "git diff" take several seconds.
> 
> NFS metadata caching can help, but not all clients do it, and even clients 
> that _do_ do it tend to have rather low timeouts or rather limited cache 
> sizes, so doing "git diff" twice may speed up the second one only if it's 
> done really back-to-back - if even then.
> 
> And once you get used to "git diff" being instantaneous, I don't think 
> anybody is ever agan willing to go back to it taking "a few seconds" (and 
> depending on speed of network/server and size of project, the "few" can be 
> quite many ;)

Yep.

> So putting the work-tree on NFS certainly _works_, but yes, from a 
> performance angle it is going to be really irritatingly slower. I don't 
> even think the newer versions of NFS will help with directory and 
> attribute caching - the delegations are per-file afaik, and there is no 
> good support for extending the caching to directories.

File delegations do cover a file's attributes, so in theory they could
help.  But they're only given out on open.  The upcoming 4.1 spec has a
few improvements here, and it might be worth looking at whether they're
sufficient to make this work.

--b.

> That said, I don't think git is any _worse_ than anybody else in the 
> "worktree on NFS" model. A "git diff" will still be superior ot a CVS diff 
> in every way. It's just that when people compare to their home machines 
> where they have the work tree on local disk and aggressively cached, when 
> they then use a NFS work-tree, they'll likely be very very disappointed.
> 
> 				Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
