From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 17:08:31 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905131639580.2147@iabervon.org>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>  <20090512151403.GS30527@spearce.org>  <20090512161638.GB29566@coredump.intra.peff.net>  <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain>  <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
  <alpine.LFD.2.01.0905131036040.3343@localhost.localdomain> <46a038f90905131126s79e5b8e1qd0c6c100ec836127@mail.gmail.com> <alpine.LFD.2.01.0905131131240.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 13 23:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Lgw-00007d-5K
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761290AbZEMVIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 17:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758604AbZEMVIb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:08:31 -0400
Received: from iabervon.org ([66.92.72.58]:39960 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbZEMVIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 17:08:30 -0400
Received: (qmail 8582 invoked by uid 1000); 13 May 2009 21:08:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 May 2009 21:08:31 -0000
In-Reply-To: <alpine.LFD.2.01.0905131131240.3343@localhost.localdomain>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119105>

On Wed, 13 May 2009, Linus Torvalds wrote:

> On Wed, 13 May 2009, Martin Langhoff wrote:
> > 
> > Do we need to take the real solution to the core of git?
> 
> Well, I suspect that if we really want to support it, then we'd better.
> 
> > What I am wondering is whether we can keep this simple in git
> > internals and catch problem filenames at git-add time.
> 
> I can almost guarantee that it will just cause more problems than it 
> solves, and generate some nasty cases that just aren't solvable.
> 
> Because it really isn't just "git add". It's every single thing that does 
> a lstat() on a filename inside of git.
> 
> Now, the simple OS X case is not a huge problem, since the lstat will 
> succeed with the fixed-up filename too.

I'm not seeing what the general case is, and how it could possibly behave.

There's the "insensitive" behavior: if you create "foo" and look for 
"FOO", it's there, but readdir() reports "foo".

There's the "converting" behavior: if you create "foo", readdir() reports 
"FOO", but lstat("foo") returns it.

The obvious general case is: if you create "foo", readdir() reports "FOO", 
and lstat("foo") doesn't find a match. But if you create "foo" again... it 
doesn't find "foo", so it creates a new file, which it also calls "FOO", 
and the filesystem now has two files with identical names?

It seems to me that the limits of minimally functional, non-inode-losing 
filesystems are: lstat() might take a filename and return the data for a 
non-byte-identical filename; open(name, O_CREAT|O_EXCL) might replace the 
given name with a non-byte-identical filename. But surely open(name) and 
lstat(name) (with the same name) must find the same file, even if 
readdir() would report it with a different name.

And I assume that a filesystem that rejected any non-NFD filenames or any 
non-NFC filenames would be totally unusable, in that users will manage to 
get unnormalized filenames into programs and find that the filesystem just 
doesn't work.

	-Daniel
*This .sig left intentionally blank*
