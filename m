From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What broke snapshots now?
Date: Sun, 10 Jul 2005 10:08:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507100954080.17536@g5.osdl.org>
References: <1120907336.8058.293.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0507090908490.17536@g5.osdl.org> 
 <1120952292.23706.49.camel@baythorne.infradead.org>
 <1121006378.23706.65.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 19:09:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrfI5-0000S9-5G
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 19:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVGJRIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 13:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVGJRIZ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 13:08:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27338 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261976AbVGJRIY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 13:08:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6AH8EjA030902
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Jul 2005 10:08:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6AH8D36023526;
	Sun, 10 Jul 2005 10:08:13 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1121006378.23706.65.camel@baythorne.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 10 Jul 2005, David Woodhouse wrote:
> 
> Now the mailing list feed isn't happy though -- it stopped being able to
> pull from your tree at around 0600 UTC (which I think is then the last
> DRM fix was added). I got this when trying to update...

Which script is this? I'm looking at your scripts, but
"cg-feedmaillist.sh" is unreadable for me, so I can't see all of it.

Anyway, it's possible that this is a temporary problem: one of the issues 
is that since you seem to be using the "rsync:" protocol for updating 
things, what happens is that if the mirroring is off a bit, you may have 
gotten a new head, but not all the objects. Then you'd get exactly this.

I don't know how to solve that, really. It's fundamental to any mirroring
that doesn't guarantee some kind of ordering, ie the dumb kind.

All the "native git" pack-file synchronization protocols should be
strictly ordered, ie they will unpack and write the new objects _before_
they write the new refs that point to them..

But you can just imagine what happens if the mirror script is busy
mirroring at the same time, and has already mirrored the object
directories before we wrote all of them, but then gets to the refs/
directory by the time we have written the new refs (and all the new object
- but it didn't notice that because it had already mirrored the object
dirs). 

See what I'm saying? The thing fixes itself after a while when you try 
again and the next round of mirroring has gotten the objects it missed the 
last time, but there fundamentally isn't anything to be done about the 
fact that the mirroring wasn't "atomic". Only a git-aware mirror could do 
an atomic snapshot.

I'm actually surprised that people haven't complained more about this than 
they have. I know it's happened a couple of times: it bit Dave Jones' 
scripts once, and it's caused webgit to sometimes report "permission 
denied" problems (or whatever) and then showing empty logs.

The fact that my upload scripts _do_ upload in the right order, together
with the fact that rsync normally syncs alphabetically (ie "objects"  
before "refs") means that we _normally_ don't see this, but it's
occasionally unavoidable when I happen to do a new push while a previous
mirror sweep is going on.

Of course, in this case it may also be just some cogito thing that doesn't
like pack-files. The fact that it complains about an object that is not
actually either of the "heads" of the diff makes me suspect it's really a
missing object, though, which in turn makes me suspect the above mirror
mis-feature.

			Linus
