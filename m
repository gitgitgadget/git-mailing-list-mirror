From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 10:33:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com> 
 <20060908184215.31789.qmail@science.horizon.com> 
 <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com> 
 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>  <17666.4936.894588.825011@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>  <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
 <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, Jon Smirl <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 19:33:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM6hr-00005W-0E
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 19:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWIIRdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 13:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWIIRdN
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 13:33:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751333AbWIIRdM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 13:33:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k89HX4nW004865
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 9 Sep 2006 10:33:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k89HX36I015248;
	Sat, 9 Sep 2006 10:33:03 -0700
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
X-Spam-Status: No, hits=-0.526 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26758>



On Sat, 9 Sep 2006, Marco Costalba wrote:
> 
> Perhaps is total idiocy but why do not implement the fix-up logic
> directly in git-rev-list?

It's possible in theory, but in practice it's not worth it.

Why?

Because you really want the _asynchronous_ nature of having a separate 
user, that only shows _partial_ results.

In other words, we could reasonably easily make git-rev-list do something 
like

 - output all revisions in the normal non-topological ordering

 - when git-rev-list notices a topological sort error, it outputs a 
   "FIXME" line, and restarts the whole thing - printing out the commits 
   in the newly fixed ordering - and does it right the next time around

 - it then continues doing this until it's totally exhausted the whole 
   commit list and has done one final output in the proper topological 
   ordering.

Possible? Yes.

BUT:

 - as long as git-rev-list is entirely single-threaded (and trust me, it's 
   going to be that, because otherwise we'd be better off doing it in a 
   separate process - like gitk), this means that it will be _entirely_ 
   unaware of what has actually been _shown_, so it will restart a LOT 
   more than the external interactive process would do. So it would be 
   much worse than doing it externally and knowing what you've actually 
   shown to the user (if you haven't shown the bad thing yet, there's no 
   reason to restart).

 - Again, as long as it's single-threaded, git-rev-list will block once it
   has filled up the pipeline between the processes, so instead of parsing 
   everything in parallel with the "show it all", if will synchronize with 
   the showing process all the time, and especially so when it needs to 
   re-show the stuff that it already sent once. So it's also fairly 
   inefficient.

However, what you seem to imply is something different:

> Where, while git-rev-list is working _whithout sorting the whole tree
> first_, when finds an out of order revision stores it in a fixup-list
> buffer and *at the end* of normal git-rev-lsit the buffer is flushed
> to receiver, so that the drawing logic does not change and the out of
> order revisions arrive at the end, already packed, sorted and prepared
> by git-rev-list.

But this is exactly what we already do. We flush things *at the end* 
because that's when we actually know the ordering. And that's exactly why 
"git-rev-list --topo-ordering" has a latency ranging from a few seconds to 
a few minutes for large projects (depending on whether they are packed or 
not).

The "wait for the end" is _not_ good, exactly because the end will take 
some time to arrive. The whole point is to start outputting the data 
early, and thet BY DEFINITION means that the order of revisions isn't 
guaranteed to be in topological order.

		Linus
