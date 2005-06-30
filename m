From: Linus Torvalds <torvalds@osdl.org>
Subject: "git-send-pack"
Date: Thu, 30 Jun 2005 10:54:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 19:47:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do36b-0004Ls-Io
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 19:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVF3Rw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 13:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVF3Rw7
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 13:52:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38533 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261212AbVF3Rwz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 13:52:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5UHqhjA010449
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 10:52:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5UHqgfp022014;
	Thu, 30 Jun 2005 10:52:43 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok,
 I'm happy to say that the first cut of my new packed-object-sending thing 
seems to work. I have successfully sent updates both locally and over ssh, 
and it seems to work fine, although it has some limitations.

The syntax is very simple indeed:

	git-send-pack destination

will go to the destination (which can be either a local directory or a
remote ssh one, with the remote destination format currently being _only_
the "machine:path" format), and it will go through all the refs in the 
remote destination, compare them with the local ones, and create a pack 
that updates from one to the other.

If the pack/unpack sequence is successful, it then updates the refs at the 
other end, and is done.

My quick tests were very successful, in the sense that it even performed
really well. But I only tested some small updates.

Anyway, what are the limitations? Here's a few obvious ones:

 - the code actually contains support for limiting the refs to be updated
   on the remote end, but I don't actually pass the arguments to the 
   remote git-receive-pack binary yet, so this is currently not 
   functional. Call me lazy.

 - the thing currently refuses to create new refs. Again, this is mainly 
   just me being lazy: it should be easy to add support for creating a new 
   branch, it just requires some care to make sure that we take the old 
   branches into account when generating the pack-file so that we don't 
   send too many objects over. 

 - I really hate how "ssh" apparently cannot be told to have alternate 
   paths. For example, on master.kernel.org, I don't control the setup, so 
   I can't install my own git binaries anywhere except in my ~/bin
   directory, but I also cannot get ssh to accept that that is a valid 
   path. This one really bums me out, and I think it's an ssh deficiency. 

   You apparently have to compile in the paths at compile-time into sshd, 
   and PermitUserEnvironment is disabled by default (not that it even 
   seems to work for the PATH environment, but that may have been my 
   testing that didn't re-start sshd).

   That just sucks.

 - It doesn't update the working directory at the other end. This is fine 
   for what it's intended for (pushing to a central "raw" git archives), 
   so this could be considered a feature, but it's worth pointing out. 
   Only a "pull" will update your working directory, and this pack sending 
   really is meant to be used in a kind of "push to central archive" way.

 - this is also (at least once we've tested it a lot more and added the
   code to allow it to create new refs on the remote side) meant to be a
   good way to mirror things out, since clearly rsync isn't scaling. 

   However, I don't know what the rules for acceptable mirroring 
   approaches are, and it's entirely possible (nay, probable) that an ssh
   connection from the "master" ain't it. It would be good to know what 
   (of any) would be acceptable solutions..

Anyway, please do give it a test. I think I'll use this to sync up to
kernel.org, except I _really_ would want to solve that ssh issue some 
other way than hardcoding the /home/torvalds/bin/ path in my local 
copies.. If somebody knows a good solution, pls holler.

		Linus
