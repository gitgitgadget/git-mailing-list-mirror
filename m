From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Sun, 12 Feb 2006 20:57:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com> 
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 05:57:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Vma-0003Dl-CU
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 05:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbWBME5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 23:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWBME5t
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 23:57:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751614AbWBME5s (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 23:57:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1D4vTDZ009218
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Feb 2006 20:57:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1D4vPar002661;
	Sun, 12 Feb 2006 20:57:28 -0800
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16044>



On Sun, 12 Feb 2006, Linus Torvalds wrote:
> 
> If it takes an hour per merge, it _is_ unusable. I consider 15 _seconds_ 
> to be pretty unusable.

Btw, one thing to realize is that git is inherently a lot better at 
handling lots of files in _subdirectories_, especially if those 
subdirectories don't change.

I've never used maildir layout, but if it is a couple of large _flat_ 
subdirectories, git will potentially handle that a lot worse than if you 
have a hierarchy of directories.

I say "potentially", because if the directories are all mutable and 
change, then the flat approach is better. But if they tend to have some 
kind of stability, a lot of git operations (diffing and merging in 
particular) are able to see that two subdirectories are 100% equal, and 
will entirely skip them.

This is a large part of why git performs well on the kernel. Most merges 
don't actually touch all - or even a very big percentage - of the over 
thousand subdirectories in the kernel. Git can quickly see and ignore the 
whole subdirectory when that happens - the SHA1 is exactly the same, so 
git knows that every file under that subdirectory (and every recursive 
directory) is the same.

In contrast, if you have a million files in one directory, and 10 of them 
changed, git will still have to check the SHA1's for matches for the other 
999,990 files. Which is going to be slow.

That said, I suspect there's space for optimization. 

		Linus
