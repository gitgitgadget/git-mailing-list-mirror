From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 17:18:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609091708340.27779@g5.osdl.org>
References: <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com> 
 <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>  <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org> 
 <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com> 
 <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org> 
 <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com> 
 <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>  <20060909204307.GB16906@coredump.intra.peff.net>
  <Pine.LNX.4.64.0609091433460.27779@g5.osdl.org>
 <9e4733910609091554m2a8a001axd575defff9a0e7a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Marco Costalba <mcostalba@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	"linux@horizon.com" <linux@horizon.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 10 02:18:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMD1l-0007oM-MS
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 02:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWIJASW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 20:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWIJASW
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 20:18:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965052AbWIJASU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 20:18:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8A0ICnW022813
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 9 Sep 2006 17:18:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8A0IA9n024607;
	Sat, 9 Sep 2006 17:18:11 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609091554m2a8a001axd575defff9a0e7a9@mail.gmail.com>
X-Spam-Status: No, hits=-0.523 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26776>



On Sat, 9 Sep 2006, Jon Smirl wrote:
> 
> When a merge happens could git fix things up in the database by adding
> a corrected, hidden time stamp that would keep things from having an
> out of order time sequence? That way you wouldn't need to rediscover
> the out of order commit each time the tree is generated.

I don't think any such algorithm exists, and it's too late now ;)

I was thinking of some "sequence number" algorithm, but the thing is, it's 
not _merges_ that are the problem per se, it's the "branch points". And 
you don't actually know that a commit is a branch point in advance: it's 
a branch point not because you branched, but because somebody else 
happened to use the same parent as the basis of their independent work.

So we could make the rule be something like "when we commit, the new 
commit must have a datestamp that is equal to or in the future from the 
parent commits". However, that results in some really strange problems in 
a distributed environment, where _if_ somebody has their clock set wrong, 
you'll end up either unable to merge with them, or you have to generate a 
totally bogus time yourself (which then moves up the chain).

It might be simpler to then not think of the thing as a "date" at all, but 
as a pure sequence number. Then the rule would be: a new commit has to 
have a sequence number that is "max(of-the-parent-sequence-numbers) + 1".
That _may_ or may not actually help.

It was discussed (a bit) early on - summer-05 - but I wasn't convinced 
enough that it would help that I was willing to change the format and add 
that sequence number. I still am not. I'm not even sure it would really 
work.

In other words, it's probably just not worth it. It's better to just say 
"dates don't really _matter_, and all that matters is the parenthood 
information". Which is really what git does - the dates aren't _important_ 
for any real operation, they are literally just a heuristic.

But hey, maybe somebody can come up with some operation that becomes 
_much_ cheaper with the above kind of sequence number. It shouldn't be 
hard to test..

		Linus
