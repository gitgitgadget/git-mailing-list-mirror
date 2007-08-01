From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and
 Mercurial
Date: Tue, 31 Jul 2007 19:14:23 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
References: <200708010216.59750.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 04:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG3jQ-0000a1-0A
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 04:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445AbXHACOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 22:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbXHACOc
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 22:14:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60119 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752563AbXHACOb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 22:14:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l712ESqc016373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 Jul 2007 19:14:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l712ENMV002170;
	Tue, 31 Jul 2007 19:14:23 -0700
In-Reply-To: <200708010216.59750.jnareb@gmail.com>
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.18__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54396>



On Wed, 1 Aug 2007, Jakub Narebski wrote:
> 
> If I remember correctly there were some patches to git which tried to 
> better deal with large blobs. In this simple benchmark git was 
> outperformed by Mercurial and even Bazaar-NG a bit.

It's almost certainly not the binary blobs.

I think almost all the difference is from the cloning, without repacking 
the souce or using a local clone.

The default action for a git clone is to create a pack-file, and do a 
local clone as if you did it over the network. That is obviously much 
slower than using the "-l" flag for the _clone_ action, but it tends to be 
better for the end result - since you get a nice packed starting point, 
and none of the confusion with hardlinks etc.

[ Maybe I'm just a worry-wart, but hardlinking two repos still makes me 
  worried. Even though we never modify the object files. 

  Quite frankly, I almost wish we hadn't ever done "-l" at all, and I 
  cannot really suggest using it. Either use "-s" for the truly shared 
  repository, or use the default pack-generating one. The hardlinking one 
  was simple and made sense, but it's really not very nice.

  But that aversion to "git clone -l" is really totally illogical. The way 
  we do the object handling, hardlinking object files in git is just about 
  the most safe operation you can think of - and I *still* shudder at it ]

Now, I think the "always act as if you were network transparent" by 
default is great, but especially if you have never run "git gc" to 
generate a pack to begin with, it's going to be a very costly thing. And I 
think that's what the numbers show. That's the only op we do a *lot* worse 
on than we should.

(The "nonconflicting merge" is probably - once more - the diffstat 
generation that bites us. That's generally the most costly thing of the 
whole merge, but I *love* the diffstat).

That said, even if he had done a "git gc", to be fair he would have had to 
include the cost of that first garbage collect in the "initial import", so 
the end result would have been exactly the same. Git _does_ end up having 
a very odd performance profile, and while it's optimized for certain 
thing, the "initial import" is not one of them.

(Which admittedly is a bit odd. The reason I didn't ever seriously even 
consider monotone was that the initial import was so *incredibly* sucky, 
and took hours for the kernel. So use "-l" for benchmarks, and damn my 
"I hate hardlinking repos" idiocy).

So the only way to truly do a fast initial import *and* get a reasonably 
good initial clone is likely one of:

 - take full advantage of git, and use local branches, instead of 
   bothering with lots of clones.

   I think that this is often the right thing to do, but it's obviously 
   not fair for comparisons, since it's really something different from 
   what's likely available in the other SCM's. But it's the "git way".

 - use "git clone -s" (or "-l").

   I think the hg numbers are the result of hg defaulting to "-l" 
   behaviour.  Which makes sense for hg, since people need to clone more 
   (in git, you'd generally work with local branches instead).

 - or the initial import would be done with some "git fast-import" thing, 
   rather than "git add ." We don't do it now, and the resulting pack-file 
   wouldn't be optimal, but it would be reasonable. It would at least cut 
   down a _bit_ on the clone cost.

The other reaction I took away from that (quite reasonable, I think) 
comparison is that I think Murdock would have been much happier if git 
diff defaulted to "-C". We don't do that (for the best of reasons: 
interoperability), but maybe we should document the "-M/-C" options more. 

The options do show up in the man-page, but apparently not 
obviously enough, since he hadn't noticed.

			Linus
