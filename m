From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-daemon on NSLU2
Date: Sun, 26 Aug 2007 11:26:07 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708261118260.25853@woody.linux-foundation.org>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com> 
 <20070824062106.GV27913@spearce.org>  <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
  <alpine.LFD.0.999.0708241618070.16727@xanadu.home> 
 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com> 
 <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org> 
 <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com> 
 <20070826093331.GC30474@coredump.intra.peff.net> 
 <9e4733910708260934i1381e73ftb31c7de0d23f6cae@mail.gmail.com> 
 <alpine.LFD.0.999.0708260959050.25853@woody.linux-foundation.org>
 <9e4733910708261106u3fecde67m8045ddba3aa57650@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jeff King <peff@peff.net>, jnareb@gmail.com,
	Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 20:27:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPMpC-0005LX-Le
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 20:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbXHZS0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 14:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbXHZS0c
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 14:26:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54865 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752319AbXHZS0b (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Aug 2007 14:26:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7QIQ85K002958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Aug 2007 11:26:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7QIQ8N1005788;
	Sun, 26 Aug 2007 11:26:08 -0700
In-Reply-To: <9e4733910708261106u3fecde67m8045ddba3aa57650@mail.gmail.com>
X-Spam-Status: No, hits=-2.749 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56707>



On Sun, 26 Aug 2007, Jon Smirl wrote:
>
> On 8/26/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > And there's actually a deeper problem: the current native protocol
> > guarantees that the objects sent over are only those that are reachable.
> > That matters. It matters for subtle security issues (maybe you are
> > exporting some repository that was rebased, and has objects that you
> > didn't *intend* to make public!), but it also matters for issues like git
> > "alternates" files.
> 
> Are these objects visible through the other protocols? It seems
> dangerous to leave something on an open server that you want to keep
> hidden.

They'd be visible to any stupid walker, yes. But if you're 
security-conscious, you'd simply not *allow* any stupid walkers.

One of the goals of "git-daemon" was to have a simple service that was 
"obviously secure". Now, it's debatable just how obvious the daemon is, 
but it really is pretty simple, and I do think it should be possible to 
almost statically validate that it only ever reads files, and that it will 
only ever read files that act like valid *git* data. 

Some people may care about that kind of thing. I don't know how many,  but 
it really was one of the design criteria (which is why, for example, git 
daemon will just silently close the connection if it finds something 
fishy: no fishing expeditions with bad clients trying to figure out what 
files exist on a server allowed!).

So the fact that a web server or rsync will expose everything is kind of 
irrelevant - those are *designed* to expose everything. git-daemon was 
designed *not* to do that.

> Doesn't kernel.org use alternates or something equivalent for serving
> up all those nearly identical kernel trees?

Absolutely. And that's the point. "git-daemon" will serve a nice 
individualized pack, even though any particular repository doesn't have 
one, but is really a combination of "the base Linus pack + extensions".

> > So it's not actually clear how the initial clone thing can be optimized on
> > the server side.
> >
> > It's easier to optimize on the *client* side: just do the initial clone
> > with rsync/http (and "git gc" it on the client afterwards), and then
> > change it to the git native protocol after the clone.
> 
> Even better, get them to clone from kernel.org and then just fetch in
> the differences from my server. It's an educational problem.

Yes. 

> How about changing initial clone to refuse to use the git protocol?

Absolutely not. It's quite often the best one to use (the ssh protocol 
has the exact same issues, and is the only secure protocol).

But on a SNLU2, maybe *you* want to make your server side refuse it? I 
would be easy enough: if the client doesn't report any existing SHA1's, 
you just say "I'm not going to work with you".

			Linus
