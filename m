From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Change set based shallow clone
Date: Fri, 8 Sep 2006 16:09:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com> 
 <20060908184215.31789.qmail@science.horizon.com>
 <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux@horizon.com" <linux@horizon.com>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 01:09:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLpTV-0006tK-Ew
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 01:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWIHXJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 19:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWIHXJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 19:09:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751255AbWIHXJ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 19:09:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k88N9HnW021181
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 8 Sep 2006 16:09:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k88N9Fdx021933;
	Fri, 8 Sep 2006 16:09:16 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
X-Spam-Status: No, hits=-0.531 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26724>



On Fri, 8 Sep 2006, Jon Smirl wrote:
> 
> gitk would need to be modified to only run enough of the commit tree
> to draw what is displayed in the window.  As you page down it would
> retrive more commits if needed. There is no need for gitk to run 250K
> commits when I'm usually never going to look at them all. Of course
> this may mean some rework for gitk.

Actually, it's more than a little rework.

The _real_ problem is that gitk uses "--topo-order" to git-rev-list, which 
basically means that git-rev-list needs to parse EVERY SINGLE COMMIT.

So far, nobody has written a topological sort that can reasonably 
efficiently handle partial trees and automatically notice when there is no 
way that a DAG cannot have any more references to a commit any more (if 
you can show that the result would cause a cycle, you could output a 
partial topological tree early).

It's possible that no such topological sorting (ie the efficient kind, 
that can work with partial DAG's) even exists.

So if you want to be able to visualize a partial repository, you need to 
teach git to not need "--topo-order" first. That's likely the _big_ 
change. After that, the rest should be easy.

[ One way to do it might be: the normal ordering of revisions without 
  "--topo-order) is "_close_ to topological", and gitk could just decide 
  to re-compute the whole graph whenever it gets a commit that has a 
  parent that it has already graphed. Done right, it would probably almost 
  never actually generate re-computed graphs (if you only actually 
  generate the graph when the user scrolls down to it).

  Getting rid of the --topo-order requirement would speed up gitk 
  absolutely immensely, especially for unpacked cold-cache archives. So it 
  would probably be a good thing to do, regardless of any shallow clone 
  issues ]

Hmm?

		Linus
