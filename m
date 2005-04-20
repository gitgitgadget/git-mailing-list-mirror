From: Linus Torvalds <torvalds@osdl.org>
Subject: chunking (Re: [ANNOUNCEMENT] /Arch/ embraces `git')
Date: Wed, 20 Apr 2005 15:22:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201510520.6467@ppc970.osdl.org>
References: <200504201000.DAA04988@emf.net> <20050420213114.GF19112@pasky.ji.cz>
 <Pine.LNX.4.61.0504201754450.2630@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Tom Lord <lord@emf.net>,
	gnu-arch-users@gnu.org, gnu-arch-dev@lists.seyza.com,
	Git Mailing List <git@vger.kernel.org>, talli@museatech.net
X-From: git-owner@vger.kernel.org Thu Apr 21 00:23:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DONaH-0008Ct-NC
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 00:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVDTW0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 18:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVDTW0V
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 18:26:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:8388 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261835AbVDTW0E (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 18:26:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KMKEs4010755
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 15:20:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KMKDow032000;
	Wed, 20 Apr 2005 15:20:13 -0700
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504201754450.2630@cag.csail.mit.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, C. Scott Ananian wrote:
> 
> I'm hoping my 'chunking' patches will fix this.  This ought to reduce the 
> size of the object store by (in effect) doing delta compression; rsync
> will then Do The Right Thing and only transfer the needed deltas.
> Running some benchmarks right now to see how well it lives up to this 
> promise...

What's the disk usage results? I'm on ext3, for example, which means that
even small files invariably take up 4.125kB on disk (with the inode).

Even uncompressed, most source files tend to be small. Compressed, I'm 
seeing the median blob size being ~1.6kB in my trivial checks. That's 
blobs only, btw.

My point being that about 75% of all blobs already take up less than the
minimal amount of space that most filesystems can sanely allocate. And I'm
_not_ going to say "you have to use reiserfs" with git.

So the disk fragmentation really does matter. It doesn't help to make a 
file smaller than 4kB, it hurts - while that can be offset by sharing 
chunks, it might not be.

Also, while network performance is important, so is the handshaking on
which objects to get. Lots of small objects potentially need lots of
handshaking to figure out _which_ of the objects to do.

		Linus
