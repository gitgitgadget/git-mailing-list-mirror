From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 12:47:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201237340.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504201323.05447.mason@suse.com>
 <Pine.LNX.4.58.0504201040400.6467@ppc970.osdl.org> <200504201504.59541.mason@suse.com>
 <Pine.LNX.4.58.0504201218360.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 21:42:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOL5G-0000J8-EO
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 21:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVDTTqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVDTTqQ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 15:46:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:10123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261753AbVDTTqF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 15:46:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KJk1s4026985
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 12:46:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KJk0RS024058;
	Wed, 20 Apr 2005 12:46:00 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <Pine.LNX.4.58.0504201218360.6467@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Linus Torvalds wrote:
>
> It would be nicer for the cache to make the index file "header" be a 
> "footer", and write it out last - that way we'd be able to do the SHA1 as 
> we write rather than doing a two-pass thing. That's for another time.

That other time was now.

The header is still a header, but the sha1 is now at the end of the file, 
which means that the header version has been incremented by 1 (to 2).

This is also sadly an incompatible change, so once you update and install
the new tools, you'll need to do

	tree=$(cat-file commit $(cat .git/HEAD) | sed 's/tree //;q')
	read-tree $tree
	update-cache --refresh

to re-build your index file.

Sorry about that, but the end result should be quite fast (especially if
your sha1 is fast). The best benchmark is probably to just do a "time
update-cache Makefile" in the kernel (before and after), when the cache
was already up-to-date and with no time spent on stating lots of files.  
That kind of "one file changed" timing is actually the common case (in
this case Makefile won't have changed, but update-cache doesn't care).

(Of course, I could optimize it to notice that the update-cache didn't do
anything and avoid the write altogether, but that's likely optimizing for
the wrong case, since normally you'd call update-cache when you know
something changed).

Yeah, it's somewhat silly doing optimizations at this point, but I want to
make sure that the data structures are all ready for a real release, and
as part of that I want to make sure there are no stupid low-hanging fruit
that we'll curse later. Better get it done with now.

			Linus
