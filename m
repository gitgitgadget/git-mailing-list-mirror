From: Alex Riesen <fork0@users.sourceforge.net>
Subject: Re: First cut at git port to Cygwin
Date: Fri, 7 Oct 2005 23:22:50 +0200
Message-ID: <20051007212250.GA1423@steel.home>
References: <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com> <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com> <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home> <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com> <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com> <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com> <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Christopher Faylor <me@cgf.cx>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 23:24:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENzgR-0004Us-Db
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 23:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbVJGVXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 17:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVJGVXF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 17:23:05 -0400
Received: from devrace.com ([198.63.210.113]:10510 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932560AbVJGVXD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 17:23:03 -0400
Received: from tigra.home (p54A0E11D.dip.t-dialin.net [84.160.225.29])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j97LZGGP080629;
	Fri, 7 Oct 2005 16:35:18 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1ENzg2-0005iD-00; Fri, 07 Oct 2005 23:22:50 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1ENzg2-0000df-HQ; Fri, 07 Oct 2005 23:22:50 +0200
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051007205450.GA14827@steel.home>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=-0.0 required=4.5 tests=AWL,BAYES_40,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9816>

Alex Riesen, Fri, Oct 07, 2005 22:54:50 +0200:
> Linus Torvalds, Fri, Oct 07, 2005 17:34:19 +0200:
> > > it suddenly get worse: now I'm stuck on git-pull.
> > > 
> > > git-merge-index (called at some point by git-pull) maps the index
> > > in, and starts git-merge-one-file for each (or the given) entry in
> > > the index.  git-merge-one-file calls git-update-index, which wants
> > > to update the index. Which doesn't work, because it's locked by
> > > that piece of s$%^.
> > 
> > NOTE! git doesn't use mmap() because it _needs_ to use mmap(), but because 
> > it was simple to do that way, and it's a total idiosyncracy of mine that I 
> > often try to mmap the data. I often also tend to do my own allocators 
> > instead of using malloc() (see my "sparse" project in case you're 
> > interested in other idiosyncracies of mine - macros to do list traversal 
> > etc).
> > 
> > The fact is, "mmap()" isn't really any better than "read()": it has some 
> > advantages wrt memory management for the kernel, which is probably one big 
> > reason why I do it, but quite frankly, if you were to change every single 
> > mmap() to be a "map_file()" instead, and made it optional whether it used 
> > mmap() or "malloc + read()", I personally don't think it would be 
> > horrible.
> > 
> > And it might make things much simpler for portability. The "use mmap" 
> > approach is very much a unixism, particularly the way unix people do it 
> > (mmap followed by close, making the file descriptor "go away"). Sure, 
> > other OS's have mmap too, but I think on them it tends to be less commonly 
> > used.
> 
> "Sounds like a thinly veiled threat or a very effective prodding" 8)
> 

Junio C Hamano, Fri, Oct 07, 2005 23:00:02 +0200:
> Huh?  where is your memcpy?

Unbelievable... I actually tested the change! But not _the_ patch.
Thanks. Next time, hit me :)

---

Make read_cache copy the index into memory, to improve portability on
other OS's which have mmap too, tend to use it less commonly.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -497,9 +497,12 @@ int read_cache(void)
 	offset = sizeof(*hdr);
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = map + offset;
-		offset = offset + ce_size(ce);
-		active_cache[i] = ce;
+		size_t size = ce_size(ce);
+		struct cache_entry *newce = malloc(size);
+		offset = offset + size;
+		active_cache[i] = memcpy(newce, ce, size);
 	}
+	munmap(map, size);
 	return active_nr;
 
 unmap:
