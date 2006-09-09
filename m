From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Change set based shallow clone
Date: Fri, 8 Sep 2006 21:04:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
 <20060908184215.31789.qmail@science.horizon.com>
 <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org> <17666.4936.894588.825011@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org> <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 06:04:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLu4p-0001hJ-Tu
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 06:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWIIEEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 00:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWIIEEL
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 00:04:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932100AbWIIEEK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 00:04:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k89444nW002380
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 8 Sep 2006 21:04:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k89444oA029284;
	Fri, 8 Sep 2006 21:04:04 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-0.528 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26735>



On Sat, 9 Sep 2006, Paul Mackerras wrote:
> 
> > The menu would help, of course. But it would be even nicer if you'd be 
> > able to make do without the --topo-order.
> 
> The graph does seem to look a little nicer with --topo-order, in that
> it tends to do a whole string of commits on a single branch in a
> bunch, whereas without --topo-order it seems to hop from branch to
> branch more.

Yeah, see "--date-order". It's topologically sorted, but within that 
topological sort it is in the "date order", which approximates the normal 
non-sorted output.

Without sorting, you also won't see any sorting by branch, although it 
could be done by the consumer of the rev-list data (ie you could do it in 
gitk, similarly to how you'd effectively do a topological sort of your 
own).

So it actually boils down to the exact same thing:

 - git-rev-list doing whatever sorting is "convenient", in that it's the 
   one common interface to git revisions, so once you do it there, you do 
   it for everybody.

 - however, for much the same reason, git-rev-list by definition doesn't 
   know _who_ it is sorting things for, or how it's going to be visualized 
   (exactly because it's the "one convenient central place", of course), 
   and as a result it needs to not only get the right answer, it needs to 
   get it on the first try and can't go back incrementally to fix up the 
   list of commits.

So the convenience of doing any kind of sorting in git-rev-list is by 
definition also the thing that causes it to have bad latency, in that it 
needs to parse the _whole_ history.

In contrast, doing some of the same sorting that git-rev-list already does 
in the consumer instead, is obviously duplicating the same basic notions, 
but once you do it in the consumer, you can suddenly do things that simply 
weren't possible in git-rev-list - do things incrementally, and then if 
you notice half-way that you did something wrong, you can go back and fix 
it up (which can be quite acceptable). That just isn't an option in a 
linear environment like the git-rev-list output.

			Linus
