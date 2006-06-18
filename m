From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Remove "refs" field from "struct object"
Date: Sun, 18 Jun 2006 11:57:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606181147080.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606181137380.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jun 18 20:57:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs2Sz-0006FM-84
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 20:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWFRS5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 14:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWFRS5q
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 14:57:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20624 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932290AbWFRS5p (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 14:57:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5IIvfgt028664
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Jun 2006 11:57:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5IIvebQ001219;
	Sun, 18 Jun 2006 11:57:41 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606181137380.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22097>



On Sun, 18 Jun 2006, Linus Torvalds wrote:
>
> The "refs" field, which is really needed only for fsck, is maintained in
> a separate hashed lookup-table, allowing all normal users to totally
> ignore it.

Btw, in case people wondered: the cost to git-fsck-objects seems to be 
zero and sometimes apparently even negative.

In order to remove "refs" from "struct object", I had to add it to the 
object_refs structure instead, and so you'd think that the memory usage 
for git-fsck-objects (which needs the object refs) should be unchanged, 
while the hashed lookup should be more expensive than just the direct 
pointer lookup.

Actually testing it, though, implies that isn't the case. Lots of objects 
(every single blob object, in fact) have no refs at all, and for that case 
we don't create any "object_refs" structure at all, so we don't actually 
end up with a 1:1 relationship, and we win a small amount of memory.

And the hashing seems to be effective enough that it's no costlier than 
looking up the ref pointer directly from the object. There's probably 
some bad cache behaviour from the hashing, but it didn't show up in the 
benchmarking I did (ie fsck took as long before as it did afterwards, 
both for git and for the kernel archive).

It may be (probably is) that the reachability analysis is just a very 
small portion of the overall costs, and it's just not very noticeable. It 
may also be that whatever bad cache behaviours you get from the extra hash 
lookup are just balanced out by the objects themselves being slightly 
denser and better in the cache (although that is probably partly hidden 
again by the extra malloc padding).

Regardless, there doesn't really seem to be any downsides, but I didn't 
test it _that_ exhaustively.

		Linus
