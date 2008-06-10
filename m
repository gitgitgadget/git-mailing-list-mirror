From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 13:06:22 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>  <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org> <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Ben Lynn <benlynn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:07:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6A7n-0000jD-Gk
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 22:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbYFJUGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 16:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbYFJUGa
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 16:06:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39477 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751263AbYFJUG3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 16:06:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AK6NGP008842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 13:06:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AK6MDi026988;
	Tue, 10 Jun 2008 13:06:23 -0700
In-Reply-To: <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.383 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84542>



On Tue, 10 Jun 2008, Ben Lynn wrote:
>
> Nice! I believe I can prove there are no races now.

It's worth pointing out that even in the absense of races, you can 
obviously screw things up if you really work at it, and *want* to. We 
cannot guarantee that we see all file changes from the stat() information, 
and we don't even save the whole stat info (ie we only save the low 32 
bits).

The ctime check is there to help make it harder for people to play games 
by setting the mtime back in time after having changed things, but we may 
at some point be forced to remove it because it triggers with things like 
beagle that use inode attributes to save indexing information (and thus 
change ctime).

And different systems have different approaches to what happens when a 
file gets modified through a writable mmap(). Exactly what is the mtime 
going to be? 

So I think git does a really good job at matching the stat() information, 
and the suggested patch makes it even stricter, but I think we should not 
even try to make it handle "malicious" changes. I bet you can work at 
making it miss some update if you really *really* try.

And I think there is one known race: the index mtime itself is not 
race-free. Remember: it may take more than a second to write the index 
file! So I can imagine that if you can set it up so that you change the 
file as the index is written out, and the index write is delayed 
sufficiently, the racy timestamp logic can fail just because the timestamp 
on the index file ends up being later.

This is more easily shown by doing a 'touch' on the index file afterwards, 
of course.

And yes, we should have written the timestamp to the file itself, instead 
of reading it from the filesystem.

			Linus
