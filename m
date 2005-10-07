From: Alex Riesen <fork0@users.sourceforge.net>
Subject: Re: First cut at git port to Cygwin
Date: Fri, 7 Oct 2005 23:39:52 +0200
Message-ID: <20051007213952.GA8821@steel.home>
References: <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home> <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com> <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com> <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com> <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home> <20051007212250.GA1423@steel.home> <4346E8AC.5030503@citi.umich.edu>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Christopher Faylor <me@cgf.cx>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 23:41:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENzwz-0000cb-VE
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 23:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbVJGVkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 17:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVJGVkS
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 17:40:18 -0400
Received: from devrace.com ([198.63.210.113]:13327 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932675AbVJGVkR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 17:40:17 -0400
Received: from tigra.home (p54A0E11D.dip.t-dialin.net [84.160.225.29])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j97LqIwF080725;
	Fri, 7 Oct 2005 16:52:19 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1ENzwW-0005oo-00; Fri, 07 Oct 2005 23:39:52 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1ENzwW-0002IY-FY; Fri, 07 Oct 2005 23:39:52 +0200
To: Chuck Lever <cel@citi.umich.edu>
Content-Disposition: inline
In-Reply-To: <4346E8AC.5030503@citi.umich.edu>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.4 required=4.5 tests=AWL,BAYES_05,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9818>

Chuck Lever, Fri, Oct 07, 2005 23:29:16 +0200:
> s/malloc/xmalloc/

It's not that funny after second repost...

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
+		struct cache_entry *newce = xmalloc(size);
+		offset = offset + size;
+		active_cache[i] = memcpy(newce, ce, size);
 	}
+	munmap(map, size);
 	return active_nr;
 
 unmap:
