From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: index-pack died on pread
Date: Thu, 26 Jul 2007 09:13:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707260911040.3442@woody.linux-foundation.org>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com> 
 <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org> 
 <200707260115.13234.robin.rosenberg.lists@dewire.com> 
 <alpine.LFD.0.999.0707251636490.3607@woody.linux-foundation.org>
 <81b0412b0707260542o58fcb73bu81ae09aa1df84c81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Michal Rokos <michal.rokos@gmail.com>,
	GIT <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 18:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE5yS-0006KT-Dx
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 18:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759920AbXGZQN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 12:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759186AbXGZQN4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 12:13:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41500 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758898AbXGZQNz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 12:13:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6QGDgRg030146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jul 2007 09:13:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6QGDaq6007981;
	Thu, 26 Jul 2007 09:13:36 -0700
In-Reply-To: <81b0412b0707260542o58fcb73bu81ae09aa1df84c81@mail.gmail.com>
X-Spam-Status: No, hits=-2.734 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53842>



On Thu, 26 Jul 2007, Alex Riesen wrote:
> > 
> > It's true that pread() is used much less than normal reads, and maybe the
> > cygwin pread() is indeed broken. But it's intriguing how apparently both
> > HP-UX and Cygwin are showing the same breakage.
> 
> Maybe because neither _has_ POSIX pread?

HP-UX? No pread()? It wouldn't link if it didn't have pread(). So it 
clearly has pread(), it's just somehow broken.

And no, git doesn't need "POSIX pread". Look at what git does if you say 
"NO_PREAD=1". It does a simple lseek/read pair instead.

> This is cygwin's pread, I believe:
> 
> http://cygwin.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_disk_file.cc?rev=1.225&content-type=text/x-cvsweb-markup&cvsroot=src

I'm not saying that's great programming, but the "git_pread()" that git 
will use in the absense of a real pread() is actually even *less* of a 
POSIX pread, since it doesn't even try to save/restore the old position 
(it knows that git doesn't care).

So I don't think that explains why git doesn't like cygwin's pread. I 
suspect an earlier version of cygwin had an even more broken version of 
pread at some point.

		Linus
