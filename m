From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 17:51:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907221742010.3352@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 02:52:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTmY4-0007N5-4U
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 02:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbZGWAvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 20:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbZGWAvl
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 20:51:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59263 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751153AbZGWAvk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 20:51:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N0pc2O023782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jul 2009 17:51:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N0pc06027337;
	Wed, 22 Jul 2009 17:51:38 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123816>



On Wed, 22 Jul 2009, Linus Torvalds wrote:
> 
> Try this:
> 
> 	git pack-refs --all
> 
> 	rmdir .git/refs/heads
> 	rmdir .git/refs/tags
> 
> 	mkdir .git/refs/heads
> 	mkdir .git/refs/tags
> 
> and see if it magically speeds up.

In fact, you could also just try

	mv .git/refs .git/temp-refs &&
	cp -a .git/temp-refs .git/refs &&
	rm -rf .git/temp-refs

which will re-create other subdirectories too (like .git/refs/remotes 
etc).

Of course, depending on your particular filesystem, a better fix might be 
to enable filename hashing, which gets rid of the whole "look through all 
the old empty stale directory entries to see if there's a filename there" 
issue. That won't fix 'readdir()' performance, but it should fix your 
insane 4-second lstat() thing.

If you have ext3, you'd do something like

	tune2fs -O dir_index /dev/<node-of-your-filesystem-goes-here>

but as mentioned, even with directory indexing it can actually make sense 
to recreate directories that at some point _used_ to be large, but got 
shrunk down to something much smaller. It's a generic directory problem 
(not just ext3, not just unix, it's a common issue across filesystems. 
It's not _universal_ - some smarter filesystems really do shrink their 
directories - but it's certainly not unusual).

		Linus
