From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git,
 dscms and a "whole product" approach)
Date: Fri, 1 May 2009 14:43:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905011431460.5379@localhost.localdomain>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3ocugod96.fsf@localhost.localdomain> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <20090430142244.GA23550@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 01 20:46:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzxke-0001l5-6P
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 20:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbZEASqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 14:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbZEASqQ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 14:46:16 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40994 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753395AbZEASqP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2009 14:46:15 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n41IhoPK029845
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 May 2009 11:44:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n41IhnM5003085;
	Fri, 1 May 2009 11:43:49 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090430142244.GA23550@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118087>



On Thu, 30 Apr 2009, Jeff King wrote:
> 
> Like all generalizations, this is only mostly true. Fast network servers
> with big caches can outperform disks for some loads.

That's _very_ few loads.

It doesn't matter how good a server you have, network filesystems 
invariably suck.

Why? It's not that the network or the server sucks - you can easily find 
beefy NAS setups that have big raids etc and are much faster than most 
local disks.

And they _still_ suck.

Simple reason: caching. It's a lot easier to cache local filesystems. Even 
modern networked filesystems (ie NFSv4), that do a pretty good job on a 
file-per-file basis with delegations etc, and they still tend to suck 
horribly at metadata.

In contrast, a workstation with local filesystems and enough memory to 
cache it well will just be a lot nicer.

> So I wouldn't rule out the possibility of a pleasant VCS experience on a
> network-optimized system backed by beefy servers on a local network.

Hey, you can always throw resources at it.

But no:

> I have never used perforce, but I get the impression that it is more 
> optimized for such a situation.

I doubt it. I suspect git will outperform pretty much anything else in 
that kind of situation too.

One thing that git does - and some other VCS's avoid - is to actually 
stat() the whole working tree in order to not need special per-file "I use 
this file" locking semantics. That can in theory make git slower over a 
network filesystem than such (very broken) alternatives.

If your VCS requires that you mark all files for editing somehow (ie you 
can't just use your favourite editor or scripting to modify files, but 
have to use "p4 edit" to say that you're going to write to the file, and 
the file is otherwise read-only), then such a VCS can - by being annoying 
and in your way - do some things faster than git can.

And yes, perforce does that (the "p4 edit" command is real, and exists).

And yes, in theory that can probably mean that perforce doesn't care so 
much about the metadata caching problem on network filesystems - because 
p4 will maintain some file of its own that contains the metadata.

But I suspect that the git "async stat" ("core.preloadindex") thing means 
that git will kick p4 *ss even on that benchmark, and be a whole lot more 
pleasant to use. Even on networked filesystems.

			Linus
