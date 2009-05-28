From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Recover broken git index?
Date: Thu, 28 May 2009 11:09:56 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905281053030.3435@localhost.localdomain>
References: <4A1DB700.4080705@bcm.edu> <4A1E52FD.6090801@op5.se> <4A1E86D7.3060401@bcm.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Misha Koshelev <mk144210@bcm.edu>
X-From: git-owner@vger.kernel.org Thu May 28 20:10:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9k3V-0001Rs-64
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 20:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbZE1SKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 14:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754648AbZE1SKJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 14:10:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45631 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751039AbZE1SKI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 14:10:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4SI9unW008607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2009 11:09:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4SI9uB8012707;
	Thu, 28 May 2009 11:09:56 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A1E86D7.3060401@bcm.edu>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120205>



On Thu, 28 May 2009, Misha Koshelev wrote:
>
> I tried you checkout master && git reset --hard and it worked.

It probably "worked" for some limited meaning of "worked". 

It sounds like you have major corruption in your object database, and it 
would be interesting to know how it happened. 

I would suggest:

 - back up your whole source directory - both .git _and_ your checked out 
   tree. That's partly because I'd want you to do some destructive 
   testing, but partly because it might be interesting to see the 
   actual breakage. 

   Is this a public project where you could expose the whole thing for us 
   to look at?

 - AFTER copying the whole tree, blow away your checked-out tree entirely 
   (or just copy your ".git" directory somewhere else), and then do

	rm .git/index
	git reset --hard

Now, I realize you already did a "git reset --hard", but since you had a 
working tree _and_ you had a pre-existing index, that reset will have done 
various shortcuts, rather than actually use the git database fully.

For example, if the 'stat' information in the index matches the 
checked-out copy, then git reset --hard will happily just ignore it. Also, 
even if the stat info doesn't match, rather than writing a new file, it 
will look at the old file and see if the contents match the SHA1, and then 
just update the index. 

So there's just a ton of those kinds of optimizations where git tries to 
avoid causing unnecessary IO, and with a pre-existing index file and a 
checked-out tree, it's entirely possible that git will not have even 
bothered to check the objects themselves.

Now, it's entirely possible that you can re-create a lot of the objects by 
re-committing the last state (if the missing objects are all "recent" 
ones). The simplest way is likely to just do something like

	git add .
	git write-tree

in a version of the tree that has all files checked out. If the objects 
are literally just missing (rather than corrupted), then this will 
re-populate the git object database with the all the objects in the 
current tree (but not in any previous trees!).

Again, if you can make the whole tree available and there is no secret 
data there, I'd be interested in taking a look. No guarantees that I can 
fix anything, but the corruption patterns are always interesting, and so 
I'd like to see what I can do, if anything.

> I guess the problem is when I try to make a commit:
>  git commit -a -n
> error: invalid object 5e35b75e062c7688636a19334bd85e9e8a408b76
> fatal: Error building trees

This very much implies that there are missing or corrupt objects in your 
database. The fact that you had tons of fsck errors supports that too. 
It's probably a pack-file that is corrupt.

> I first noticed this after my computer was acting sluggish (I was
> running processor intensive tasks) and I restarted it.

Restarted without a clean shutdown? What OS, and what kind of filesystem? 
It very much sounds like some files in .git/objects were not fully written 
to disk.



			Linus
