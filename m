From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/7] Final words
Date: Sat, 22 Mar 2008 11:06:20 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221049090.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221030380.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221033430.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221038320.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 19:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd87r-0007dv-RG
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 19:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbYCVSGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 14:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755100AbYCVSGp
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 14:06:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54239 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753894AbYCVSGo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 14:06:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MI6LHs005151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 11:06:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MI6KrE020889;
	Sat, 22 Mar 2008 11:06:20 -0700
In-Reply-To: <alpine.LFD.1.00.0803221038320.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.755 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77838>



So the whole patch series looks like this:

	 Makefile            |    1 +
	 builtin-read-tree.c |    2 +-
	 cache.h             |   36 +++++++++-------
	 config.c            |    5 ++
	 dir.c               |    2 +-
	 environment.c       |    1 +
	 name-hash.c         |  119 +++++++++++++++++++++++++++++++++++++++++++++++++++
	 read-cache.c        |   65 +--------------------------
	 unpack-trees.c      |   43 ++++++++++++++++---
	 unpack-trees.h      |   22 +++++-----
	 10 files changed, 199 insertions(+), 97 deletions(-)
	 create mode 100644 name-hash.c

and clearly does add more lines than it deletes, but it all really is 
pretty simple, and none of this is rocket science or even very intrusive. 
What took me longest to do was not the actual code itself, but to get 
_just_ the right approach so that the end result would be as simple and 
nonintrusive as possible. That core patch 6/7 was redone at least ten 
times before I was happy with it.

Anyway, perhaps exactly because I tried very hard to make it all make 
sense, I'm actually very very happy with the patch. I suspect it's too 
late for v1.5.5 even if I think all the patches are really simple, but I'm 
hoping it can go into at least "pu" and have people actually *test* it.

Talking about testing, the kind of safety I wanted to get with this patch 
is perhaps best described by the tests I did not on case-insensitive 
filesystems, but on regular *good* filesystems together with setting the 
"core.ignorecase" config variable.

Here's an example of how that patch 6/7 works and tries to be really 
careful even on a case-sensitive filesystem:

	mkdir test-case
	cd test-case
	git init
	git config core.ignorecase true

	echo "File" > File
	git add File
	git commit -m "Create 'File'"

	git checkout -b other
	git rm File
	echo "file" > file
	git add file
	git commit -m "Create 'file'"

	echo "File" > File
	git checkout master

and now it complains about

	error: Untracked working tree file 'File' would be overwritten by merge.

which is correct, because while it is doing its case-insensitivity checks, 
it also noticed that "File" did *not* match the stat information for 
'file', so it really _is_ an untracked working tree file.

So it's actually trying to be a lot more careful than just saying "ok, we 
already know about 'File'". See what happens next:

	rm File
	ln file File
	git checkout master

and now it very happily did the switch to master, even though 'File' got 
overwritten, because now it again found that untracked file 'File', but 
now it could match it up *exactly* against the case-insensitive file 
'file', so git was happy that it wasn't actually throwing away any info, 
and the fact that it overwrite 'File' was ok, because it considered it the 
same file as 'file'.

So the whole thing is not only able to handle these name aliases, it 
actually handles them by checking that it's safe.

Final note: I also did notice that I didn't fix the 'git add" case like I 
thought I did, it currently only fixes "git status". So I still want to 
fix "git add" and "git mv" to do the right thing when there are case- 
insensitive aliases, but that's a separate issue from this particular 
series..

		Linus
