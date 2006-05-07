From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 7 May 2006 08:27:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605070802590.16343@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
 <87mzdx7mh9.wl%cworth@cworth.org> <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org> <e3fqb9$hed$1@sea.gmane.org>
 <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
 <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
 <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net> <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
 <20060507075631.GA24423@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 17:27:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FclA6-0007ul-Dh
	for gcvg-git@gmane.org; Sun, 07 May 2006 17:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWEGP1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 11:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWEGP1H
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 11:27:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932178AbWEGP1G (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 11:27:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k47FR3tH008685
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 May 2006 08:27:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k47FR2xg022017;
	Sun, 7 May 2006 08:27:03 -0700
To: Jeff King <peff@peff.net>
In-Reply-To: <20060507075631.GA24423@coredump.intra.peff.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19704>



On Sun, 7 May 2006, Jeff King wrote:
>
>   - Total savings by going shallow: 10.7%
> 
> So basically, trees and commits DON'T compress as well as historical
> blobs (potentially because git-pack-objects isn't currently optimized
> for this -- I haven't checked). As a result, we're saving only 10% by
> going shallow instead of a potential 50%.

The biggest size savers from packing is (in rough order of relevance, if 
I recall the rough statistics I did):

 - avoiding block boundaries. 
 - delta packing of blobs
 - delta packing of trees
 - regular compression

The block boundaries are huge, we have tons of small objects, and that was 
one of the primary reasons for packing. I'd suspect that this is a 3:1 
factor for a lot of things for many "common" filesystem setups. You 
probably didn't even account for the size of inodes in your "du" setup.

And blobs with history generally delta very well (_much_ better than 
regular compression).

Trees should _delta_ very well, but they basically don't compress, 
especially after deltaing. The SHA1's are totally incompressible (in a 
tree they aren't even ASCII), and as a deta, the names won't compress much 
either because they are short.

Commits are fairly small, shouldn't delta all that much, and they don't 
even compress _that_ well either (they're normal text and often have some 
redundancy with the committer and author being the same, but they are 
short and have some fairly incompressible elements, so..)

The thing with trees in particular is that they are very common for the 
kernel (and probably not so much for many other projects). A single commit 
ends up quite commonly being just one commit object, one blob (that deltas 
really well), and three or four trees. Merges often have no new blobs at 
all, just several new trees and the commit object.

So a huge amount of the wins from packing come from the file _history_, 
the part that a shallow clone (on purpose) leaves behind. 

The regular compression will pick up a fair amount of slack with the 
blobs, but it's a much smaller factor than the delta compression for 
something that has a long history.

It's somewhat interesting to note that over the year that we've used git, 
the kernel pack-size hasn't even increased all that much. I forget exactly 
what it was when we started packing, but it was on the order of ~75M. It 
is now 115M for me. And the old linux-history thing (full BK history over 
three years) is 177M - not much more than twice the size of just a few 
kernel versions - with some higher packing ratios..

Exactly because blobs delta so incredibly well.

		Linus
