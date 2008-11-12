From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: hosting git on a nfs
Date: Wed, 12 Nov 2008 10:14:44 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Koch <thomas@koch.ro>, git@vger.kernel.org, dabe@ymc.ch
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:16:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0KGK-0000lY-07
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbYKLSPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 13:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYKLSPE
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 13:15:04 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55960 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752799AbYKLSPD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2008 13:15:03 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mACIEi22012243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Nov 2008 10:14:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mACIEiPJ027847;
	Wed, 12 Nov 2008 10:14:44 -0800
In-Reply-To: <20081112173651.GA9127@linode.davidb.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.435 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100797>



On Wed, 12 Nov 2008, David Brown wrote:
> 
> We had occasionally run into locking problems with 1.5.4.x with
> renames between different directories.  This should be fixed in
> 1.6.0.3, but we have since migrated to a server model so I don't have
> any way of testing this.

I suspect it also depends very much on the particular client/server 
combination. Renaming across directories is one of those NFS things that 
some servers don't mind at all.

> The configuration we did find completely unworkable was using git with 
> the work tree on NFS.

Doing an 'lstat()' on every single file in the tree would tend to do that 
to you, yes. Even with a fast network and a good NFS server, we're talking 
millisecond-range latencies, and if your tree has tens of thousands of 
files, you're going to have each "git diff" take several seconds.

NFS metadata caching can help, but not all clients do it, and even clients 
that _do_ do it tend to have rather low timeouts or rather limited cache 
sizes, so doing "git diff" twice may speed up the second one only if it's 
done really back-to-back - if even then.

And once you get used to "git diff" being instantaneous, I don't think 
anybody is ever agan willing to go back to it taking "a few seconds" (and 
depending on speed of network/server and size of project, the "few" can be 
quite many ;)

So putting the work-tree on NFS certainly _works_, but yes, from a 
performance angle it is going to be really irritatingly slower. I don't 
even think the newer versions of NFS will help with directory and 
attribute caching - the delegations are per-file afaik, and there is no 
good support for extending the caching to directories.

That said, I don't think git is any _worse_ than anybody else in the 
"worktree on NFS" model. A "git diff" will still be superior ot a CVS diff 
in every way. It's just that when people compare to their home machines 
where they have the work tree on local disk and aggressively cached, when 
they then use a NFS work-tree, they'll likely be very very disappointed.

				Linus
