From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 'git status' is not read-only fs friendly
Date: Fri, 9 Feb 2007 11:56:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, GIT list <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 20:56:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFbr9-0007wt-75
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 20:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992790AbXBIT4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 14:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423258AbXBIT4Y
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 14:56:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41753 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423246AbXBIT4X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 14:56:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l19JuIUI013880
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Feb 2007 11:56:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l19JuIbM024218;
	Fri, 9 Feb 2007 11:56:18 -0800
In-Reply-To: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
X-Spam-Status: No, hits=-0.43 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39193>



On Fri, 9 Feb 2007, Marco Costalba wrote:
>
> In a repository under a mounted Windows directory (ntfs) I get this error:
> 
> $ git status
> fatal: unable to create '.git/index.lock': Read-only file system
> $
> 
> Is this correct? there exist a workaround? I just need to know if
> current working directory is clean and report back to qgit user, so
> read-only access would be ok for me.

"git status" is kind of strange. It's really technically the engine behind 
the messages for "git commit": both in a very real technical sense (it's 
_literally_ the same script:"git-commit.sh" is not just "git-commit", but 
also "git-status"), but also in a very real historical "that is what the 
code was written for".

And you wouldn't think that it really needs write access, and you'd be 
largely correct, EXCEPT for the fact that git status actually does a 
refresh of the index, to make sure that we don't claim that something is 
dirty just because somebody has touched the file.

IOW, there's an implicit "git update-index --refresh" as part of 
calculating the status, and that's the thing that wants to lock the index 
file (and thus write to the filesystem).

> All other commands commonly used to browse a repository seems to work
> well, without pretending to write stuff.

"git status" doesn't "pretend" to write stuff. It really does. 

You *can* just use "git-runstatus" instead. That's the command that 
actually does all the heavy lifting. But you can see the difference by 
doing this:

	touch Makefile
	git runstatus

vs

	touch Makefile
	git status

Notice how the "runstatus" one claims that Makefile is "modified:". That's 
exactly because it doesn't do the index refresh.

			Linus
