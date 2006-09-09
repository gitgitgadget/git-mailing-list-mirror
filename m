From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 14:40:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609091433460.27779@g5.osdl.org>
References: <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org> <17666.4936.894588.825011@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org> <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
 <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
 <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
 <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
 <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org> <20060909204307.GB16906@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 23:40:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMAZ8-0006XJ-Ht
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 23:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWIIVkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 17:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWIIVkj
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 17:40:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751392AbWIIVkj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 17:40:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k89LeVnW016348
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 9 Sep 2006 14:40:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k89LeUwU020833;
	Sat, 9 Sep 2006 14:40:31 -0700
To: Jeff King <peff@peff.net>
In-Reply-To: <20060909204307.GB16906@coredump.intra.peff.net>
X-Spam-Status: No, hits=-0.524 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26768>



On Sat, 9 Sep 2006, Jeff King wrote:
> 
> The problem you describe seems to come from doing a depth-first display
> of each branch

No, not at all.

We _don't_ do depth-first, or breadth-first. The thing is, neither would 
really work, since the "distance" between commits is very variable.

Instead, the rule is always to try to traverse the tree in date order. 
That's most likely the closest order to what you want - it ends up being 
breadth-first if there is a lot of concurrent work, and if there is one 
old branch and one new branch, we'll look at the new one first, and 
approximate depth-first there.

> Why not look at the tip of each "active" branch
> simultaneously and pick the one with the most recent date?

Which is _exactly_ what we do.

However, it's just a heuristic. "Most recent date" is not well-defined in 
a distributed environment that doesn't have a global clock. If somebody 
does commits on a machine that has the clock just set wrong, "most recent" 
may well not be _really_ recent.

So all the algorithms are actually very careful to just use the date as a 
heuristic. They have real guarantees, but they aren't about the ordering. 
The ordering is just used as a way to have _some_ non-random and likely 
good order to traverse the DAG in. Doing it depth-first would suck (you'd 
always reach the root before you reach a lot of much more interesting 
commits), and breadth-first is not well-defined either, since one "level" 
can be a year old for one parent, and a day old for another.

So you could kind of think of the ordering as "breadth-first, modified by 
date" kind of thing.

		Linus
