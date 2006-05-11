From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Wed, 10 May 2006 17:11:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605101656110.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv>  <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>  <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
  <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE> 
 <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>  <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE>
  <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org> 
 <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com> 
 <Pine.LNX.4.64.0605100823350.3718@g5.osdl.org>
 <46a038f90605101617x1aa9bd2du959ead77ebf61795@mail.gmail.com>
 <Pine.LNX.4.64.0605101629230.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sean <seanlkml@sympatico.ca>, junkio@cox.net,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 11 02:13:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdymG-00018Z-0B
	for gcvg-git@gmane.org; Thu, 11 May 2006 02:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWEKALb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 20:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWEKALb
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 20:11:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54439 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965079AbWEKALb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 20:11:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4B0BItH021962
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 May 2006 17:11:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4B0BHOK030716;
	Wed, 10 May 2006 17:11:17 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0605101629230.3718@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19899>



On Wed, 10 May 2006, Linus Torvalds wrote:
>
>  - having the information in one place. I agree that the multi-file 
>    approach works fine for shell scripts (although I disagree that the new 
>    one would be harder - you just use git-repo-config instead), but I 
>    think it's quite confusing from a new user perspective.

Btw, I seriously believe that git has come to the point where we've licked 
the real technical issues. Stability hasn't been a concern for the last 
year - and even something as seriously as a repacking bug causing a 
SIGSEGV (yesterday) was actually basically designed to not be able to 
cause problems. The repack failed, and nothing happened to the old data. 
It was scary, but it wasn't "bad".

The last performance problem was a stupid one-liner, where one of the 
shell scripts didn't use the "--aggressive" flag for doing the trivial 
three-way merge, so it ended up forking and executing the "merge-one-file" 
shell script for 4500+ files for one unfortunate project that had a 
strange workflow. Adding the "--aggressive" flag took a 5-minute (where 
all of the time was spent in a shell script basically doing nothing) thing 
down to under a second.

So git should kick butt in performance, scale very well, and seems to take 
less disk space than just about anybody else. 

So what do people actually _complain_ about? 

I don't think we've seen a serious complaint lately that hasn't been about 
nice user interface and/or documentation. Anybody? 

So as far as I can tell, the #1 issue is that "new user" experience. You 
can pretty much forget about anything else. Working with git in a 
distributed manner is really easy and efficient, but from the comments 
I've seen, it's not always easy and obvious how to get to that point. 

Creating a remote repository and filling it. And being able to understand 
what the local vs remote branches actually _mean_. And I think our current 
.git/remotes/ thing is a part of that. It's not exactly user _hostile_, 
but it's very much "implementation friendly, and doesn't care about the 
user". So I think .git/config can help us there.

I also think we could do with a few scripts to just do setup of a remote 
repo:

	git remote clone <remoteaddress>
	git remote branch <remoteaddress> [-D]
	git remote fsck <remoteaddress>
	git remote repack <remoteaddress> -a -d

which would all basically boil down to "ssh to the remote address, cd into 
that directory, and do the named git command there" (well, not clone: 
doing a remote clone involves doing a mkdir/git-init-db/git-receive-pack 
remotely, and doing a git-send-pack locally, so some of them would be 
about doing things _both_ locally and remotely).

And documentation.

Now, I don't do documentation, and I really think somebody else could do 
the whole "git remote <cmd>" thing too. It _should_ really be pretty 
trivial. My real point is that almost none of this is about technology, 
and it's much more about trying to put a whole lot of lipstick on this 
pig. We have _got_ the technology already, and I think most people will 
agree git is doing pretty damn well there.

Because I really think the pig is quite charming, just sometimes you see 
some of its boorish sides right now..

(Or should that be "boarish", when we talk about pigs? ;)

		Linus
