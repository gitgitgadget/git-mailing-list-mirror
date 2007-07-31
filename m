From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 18:44:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707301825130.4161@woody.linux-foundation.org>
References: <20070730180710.GA64467@nowhere>
 <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
 <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
 <20070730222028.GE64467@nowhere> <alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org>
 <20070731011707.GA91930@nowhere>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Craig Boston <craig@olyun.gank.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 03:44:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFgmu-00007F-Li
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 03:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761588AbXGaBoi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 21:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761643AbXGaBoi
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 21:44:38 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33268 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757630AbXGaBoh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 21:44:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6V1iIZH007665
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Jul 2007 18:44:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6V1iDqe009025;
	Mon, 30 Jul 2007 18:44:13 -0700
In-Reply-To: <20070731011707.GA91930@nowhere>
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.16__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54307>



On Mon, 30 Jul 2007, Craig Boston wrote:
> > 
> > So I _seriously_ hope that about 65 of those 67 seconds was the "cvs 
> > update -d" or something like that. 
> 
> No, the only thing included in that is
> 
> git ls-files -o | git update-index --add --stdin
> git commit -a -m "${COMMITMSG}"

Ouch.

> > Anything that takes a minute in git is way way *way* too slow. Any 
> > half-way normal git operations should take less than a second.
> 
> That said, I don't think it's git's fault.  I think most of the time is
> spent calling stat() on all the files.  The machine that took 60 seconds
> isn't what I'd call top-of-the-line:
> 
> 1st or maybe 2nd-gen Willamette CPU
> 512MB memory (stupid motherboard that won't accept more)
> Slow disks in RAID-5 configuration
> Running ZFS with less than half of the recommended minimum memory, to
> the point where I had to reduce the number of vnodes that the kernel is
> allowed to cache to avoid running out of KVA

Oh, ok. Solaris.

With slow pathname lookup, and hard limits on the inode cache sizes.

Git really normally avoids reading the data, so even in 512M you should 
_easily_ be able to cache the metadata (directory and inodes), which is 
all you need. But yeah, Linux will probably do that a whole lot more 
aggressively than Solaris does.

[ And to be honest, any CVS update would probably have blown the caches on 
  Linux too - I don't know what all CVS ends up doing, but from past
  experience, I'll bet it's not good ]

But just for comparison, on a lowly 480MB mac-mini (running Linux, not OS 
X, of course - and the 480MB is because the graphics is UMA and takes 
part of the 512MB total), and the kernel archive (which is just 22k files, 
not 37k), with a laptop drive:

 - cold-cache "git status":
	real    0m17.975s
	user    0m1.098s
	sys     0m0.539s

 - rerunning it immediately afterwards:
	real    0m1.079s
	user    0m0.896s
	sys     0m0.183s

so the target really _should_ generally be one second.

But yeah, in order to hit that target, you definitely do want to keep the 
metadata cached, and I guess that means more than 512M on Solaris.

			Linus
