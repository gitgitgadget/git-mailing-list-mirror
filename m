From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some git performance measurements..
Date: Wed, 28 Nov 2007 20:32:21 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org> <alpine.LFD.0.99999.0711282244190.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 05:33:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixb59-0004dH-6P
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 05:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339AbXK2Ecj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 23:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756938AbXK2Ecj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 23:32:39 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37877 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756922AbXK2Eci (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 23:32:38 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAT4WMHU031693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Nov 2007 20:32:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAT4WLYp003559;
	Wed, 28 Nov 2007 20:32:22 -0800
In-Reply-To: <alpine.LFD.0.99999.0711282244190.9605@xanadu.home>
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66502>



On Wed, 28 Nov 2007, Nicolas Pitre wrote:
> 
> Tree objects aren't all together.  Related blob objects are interlaced 
> with those tree objects.

Yeah, I noticed that a few minutes after saying this.

> But for a checkout that should actually correspond to a nice linear 
> access.

For the initial check-out, yes. But the thing I timed was just a plain 
"git checkout", which won't actually do any of the blobs if they already 
exist checked-out (which I obviously had), which explains the non-dense 
patterns.

The reason I care about "git checkout" (which is totally uninteresting in 
itself) is that it is a trivial use-case that fairly closely approximates 
two common cases that are *not* uninteresting: switching branches with 
most files unaffected and a fast-forward merge (both of which are the 
"two-way merge" special case).

I also suspect it is pretty close to a real three-way merge (again, with 
just a few files changed).

IOW, there's a lot of these "tree operations" that actually leave 99% of 
the tree totally unchanged, at least in the kernel. Even a fairly big 
merge tends to change just a few hundred files. And when there are 23,000 
files in the tree, a few hundred files is a fairly small percentage!

So it's actually fairly common to have "git checkout"-like behaviour with 
no blobs needing to be updated, and the "initial checkout" is in fact 
likely a less usual case. I wonder if we should make the pack-file have 
all the object types in separate regions (we already do that for commits, 
since "git rev-list" kind of operations are dense in the commit).

Making the tree objects dense (the same way the commit objects are) might 
also conceivably speed up "git blame" and path history simplification, 
since those also tend to be "dense" in the tree history but don't actually 
look at the blobs themselves until they change.

		Linus
