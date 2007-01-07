From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How git affects kernel.org performance
Date: Sat, 6 Jan 2007 21:39:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
References: <20061214223718.GA3816@elf.ucw.cz>  <20061216094421.416a271e.randy.dunlap@oracle.com>
  <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com> 
 <1166297434.26330.34.camel@localhost.localdomain>  <1166304080.13548.8.camel@nigel.suspend2.net>
  <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net>
 <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, nigel@nigel.suspend2.net,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 06:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Qlj-0002QS-5P
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 06:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbXAGFkX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 00:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbXAGFkX
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 00:40:23 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33110 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932403AbXAGFkW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 00:40:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l075dhWi028609
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 Jan 2007 21:39:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l075dgdL011058;
	Sat, 6 Jan 2007 21:39:42 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <45A083F2.5000000@zytor.com>
X-Spam-Status: No, hits=-0.669 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36127>



On Sat, 6 Jan 2007, H. Peter Anvin wrote:
> 
> During extremely high load, it appears that what slows kernel.org down more
> than anything else is the time that each individual getdents() call takes.
> When I've looked this I've observed times from 200 ms to almost 2 seconds!
> Since an unpacked *OR* unpruned git tree adds 256 directories to a cleanly
> packed tree, you can do the math yourself.

"getdents()" is totally serialized by the inode semaphore. It's one of the 
most expensive system calls in Linux, partly because of that, and partly 
because it has to call all the way down into the filesystem in a way that 
almost no other common system call has to (99% of all filesystem calls can 
be handled basically at the VFS layer with generic caches - but not 
getdents()).

So if there are concurrent readdirs on the same directory, they get 
serialized. If there is any file creation/deletion activity in the 
directory, it serializes getdents(). 

To make matters worse, I don't think it has any read-ahead at all when you 
use hashed directory entries. So if you have cold-cache case, you'll read 
every single block totally individually, and serialized. One block at a 
time (I think the non-hashed case is likely also suspect, but that's a 
separate issue)

In other words, I'm not at all surprised it hits on filldir time. 
Especially on ext3.

		Linus
