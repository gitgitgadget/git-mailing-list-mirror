From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-daemon on NSLU2
Date: Sun, 26 Aug 2007 10:15:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708260959050.25853@woody.linux-foundation.org>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com> 
 <20070824062106.GV27913@spearce.org>  <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
  <alpine.LFD.0.999.0708241618070.16727@xanadu.home> 
 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com> 
 <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org> 
 <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com> 
 <20070826093331.GC30474@coredump.intra.peff.net>
 <9e4733910708260934i1381e73ftb31c7de0d23f6cae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jeff King <peff@peff.net>, jnareb@gmail.com,
	Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 19:16:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPLiS-0001pL-Fq
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 19:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbXHZRP4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 13:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbXHZRP4
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 13:15:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52568 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753505AbXHZRPz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Aug 2007 13:15:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7QHFPcH000376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Aug 2007 10:15:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7QHFOo8003592;
	Sun, 26 Aug 2007 10:15:24 -0700
In-Reply-To: <9e4733910708260934i1381e73ftb31c7de0d23f6cae@mail.gmail.com>
X-Spam-Status: No, hits=-2.75 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56704>



On Sun, 26 Aug 2007, Jon Smirl wrote:
> 
> Changing git-daemon only for the initial clone case also means that
> people don't need to change the way they manage packs.

I do agree that we might want to do some special-case handling for the 
initial clone (because it *is* kind of special), but it's not necessarily 
as easy as just re-using an existing pack.

At a minimum, we'd need to have something that knows how to make a single 
pack out of several packs and some loose objects. That shouldn't be 
*hard*, but it's certainly nontrivial, especially in the presense of the 
same objects possibly being available more than once in different packs.

[ The "duplicate object" thing does actually happen: even if you use only 
  "git native" protocols, you can get duplicate objects because a file was 
  changed back to an earlier version. The incremental packs you get from 
  push/pull'ing between two repositories try to send the minimal 
  incremental changes, but the keyword here is _try_: they will 
  potentially send objects that the receiver already has, if it's not 
  obvious that the receiver has them from the "commit boundary" cases ]

Maybe the client side will handle a pack with duplicate objects perfectly 
fine, and it's not an issue. Maybe. It might even be likely (I can't think 
of anything that would obviously break). But at a minimum, it would be 
something that needs some code on the sending side, and a lot of 
verification that the end result works ok on the receiving side.

And there's actually a deeper problem: the current native protocol 
guarantees that the objects sent over are only those that are reachable. 
That matters. It matters for subtle security issues (maybe you are 
exporting some repository that was rebased, and has objects that you 
didn't *intend* to make public!), but it also matters for issues like git 
"alternates" files.

If you only ever look at a single repo, you'll never see the alternates 
issue, but if you're seriously looking at serving git repositories, I 
don't really see the "single repo" case as being at all the most common or 
interesting case. 

And if you look at something like kernel.org, the "alternates" thing is 
*much* more important than how much memory git-daemon uses! Yes, 
kernel.org would probably be much happier if git-daemon wasn't such a 
memory pig occasionally, but on the other hand, the win from using 
alternates and being able to share 99% of all objects in all the various 
related kernel repositories is actually likely to be a *bigger* memory win 
than any git-daemon memory usage, because now the disk caching works a 
hell of a lot better!

So it's not actually clear how the initial clone thing can be optimized on 
the server side.

It's easier to optimize on the *client* side: just do the initial clone 
with rsync/http (and "git gc" it on the client afterwards), and then 
change it to the git native protocol after the clone.

That may not sound very user-friendly, but let's face it, I think there is 
exactly one person in the whole universe that tries to use an NSLU2 as a 
git server. So the "client-side workaround" is likely to affect a very 
limited number of clients ;)

		Linus
