From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cloning speed comparison, round II
Date: Sat, 12 Nov 2005 12:13:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511121159470.3263@g5.osdl.org>
References: <20051112155302.GD30496@pasky.or.cz> <Pine.LNX.4.64.0511121134170.3263@g5.osdl.org>
 <20051112194646.GE30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 21:14:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb1kr-0005i0-ST
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 21:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVKLUNh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 15:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVKLUNh
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 15:13:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932490AbVKLUNg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 15:13:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jACKDQnO010112
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 12 Nov 2005 12:13:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jACKDKjb009847;
	Sat, 12 Nov 2005 12:13:23 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051112194646.GE30496@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11702>



On Sat, 12 Nov 2005, Petr Baudis wrote:

> Dear diary, on Sat, Nov 12, 2005 at 08:40:11PM CET, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
> > 
> > 
> > On Sat, 12 Nov 2005, Petr Baudis wrote:
> > >
> > >              rsync   git+ssh(*)   git(**)   http
> > > 
> > > git.git      0m45s   0m34s        5m30s     4m01s (++)
> > > 
> > > cogito.git   2m09s   1m54s (+)    4m30s     15m11s (only single run)
> 
> Well, at the time of fetching, master.kernel.org with git+ssh had load
> about ~3.5 and some wild gzip was eating most of the CPU there. So if
> the git protocol still manages to be TEN times slower while rsync goes
> full speed from that machine, I would say that this means the git server
> requires way too much CPU.

Look again.

master.kernel.org was _faster_ than rsync using the native git protocol, 
despite being under a load of 3.5.

Look at the numbers: 45 secs for rsync, 34 secs for git protocol to 
master.

Now, I don't know which rsync machine you used (you can rsync both from 
master and from rync.kernel.org), since you don't say. 

Now, it's unquestionably true that rsync can be faster under many 
circumstances. Most notably when disk IO is really slow, since the native 
git protocol will do a lot more synchronous operations, since it actually 
tests what it is doing.

But I _guarantee_ you that rsync is at least ten times slower than the 
native git protocol in many circumstances. It can't handle repacking 
(which is critical for good server performance).

And in fact it can't handle totally unpacked directories and small updates 
well either (the reason I totally stopped doing rsync was because it took 
minutes to go through the whole list of unpacked objects for a small 
update, while the native protocol would just fetch the needed objects and 
be done with it.

So sometimes rsync is faster, sometimes the git protocol is faster. But 
the git protocol is _always_ better from a sanity standpoint.

The things you get with the native git protocol:

 - you don't have to trust the other end. If the other end lies about the 
   SHA1's of its objects, rsync will never know. It will just download the 
   thing, and you may have a corrupt database.

   With the git protocol, we just get the objects, and recompute their 
   names. The other end can't lie about what their SHA is.

 - the rsync protocol totally breaks down with multiple branches. It 
   fetches stuff it shouldn't because it doesn't know better.

 - the rsync protocol scales with project size, not with change size. This 
   works well for small projects, where the changes are usually not all 
   that hugely different from the total size of the project, but it really 
   sucks for big projects.

 - the rsync protocol fundamentally cannot handle two differently packed 
   trees well. That doesn't matter if you only track one tree, but it 
   matters _hugely_ for people (like me) who pull from tens of different 
   trees.

So the fact is: rsync is often slower, and _always_ less capable. 

			Linus
