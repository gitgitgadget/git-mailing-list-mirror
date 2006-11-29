X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Bug in "git blame -C"
Date: Tue, 28 Nov 2006 20:27:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611282013430.3395@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 04:27:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32614>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpH2p-00086R-3n for gcvg-git@gmane.org; Wed, 29 Nov
 2006 05:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758761AbWK2E1g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 23:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758765AbWK2E1g
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 23:27:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:2009 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1758761AbWK2E1f (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 23:27:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAT4RPix012465
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 28
 Nov 2006 20:27:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAT4RObJ007728; Tue, 28 Nov
 2006 20:27:25 -0800
To: Junio C Hamano <junkio@cox.net>, Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org


Ok, this is interesting.

Try this sequence (which is a good sequence for showign how something like 
"git blame -C" _should_ work, but only ends up showing that it doesn't at 
all, because of some bug ;^):

	#
	# create 'testing' repository
	#
	mkdir testing
	cd testing/
	git init-db

	#
	# copy git.c and sha1_file.c there and commit initial
	# (Just to get _some_ initial state)
	#
	cp ~/git/git.c .
	cp ~/git/sha1_file.c .
	git add git.c sha1_file.c
	git commit -m Initial

	#
	# move the prepend_to_path() function from git.c to
	# sha1_file.c (I did it to just after the
	#	#ifndef O_NOATIME
	# block of preprocessor stuff
	#
	em git.c sha1_file.c
	git commit -a -m Movement
	git log -p

and the result of that "git log -p" should show something like

	commit a583b5aee68b89b7d554b8f900a95057e8ed61d9
	Author: Linus Torvalds <torvalds@woody.osdl.org>
	Date:   Tue Nov 28 20:13:00 2006 -0800
	
	    Movement
	
	diff --git a/git.c b/git.c
	index 357330e..43c01fd 100644
	--- a/git.c
	+++ b/git.c
	@@ -18,28 +18,6 @@
	 const char git_usage_string[] =
	        "git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [AR
	
	-static void prepend_to_path(const char *dir, int len)
	-{
	-       const char *old_path = getenv("PATH");
	-       char *path;
	-       int path_len = len;
	...
	diff --git a/sha1_file.c b/sha1_file.c
	index 63f416b..20168aa 100644
	--- a/sha1_file.c
	+++ b/sha1_file.c
	@@ -22,6 +22,28 @@
	 #endif
	 #endif
	
	+static void prepend_to_path(const char *dir, int len)
	+{
	+       const char *old_path = getenv("PATH");
	+       char *path;
	+       int path_len = len;
	+
	...

to show how that top commit moved the function. Ok, everything looks fine 
so far.

For the surreal behaviour, now do

	git blame -C sha1_file.c

and watch the result make no sense what-so-ever. It doesn't show the 
movement at all. It shows that everything in that file came from the 
original commit, even though the file obviously did change since.

Which is kind of "true", but it's still _wrong_. Yes, all the data comes 
from the same (initial) commit, but it doesn't come from the same _files_ 
in the same commit, so the fact that we don't see the filenames and 
original lines in those filenames is _broken_. The commit information is 
right, but it's decided not to show all the _other_ information that is 
crucial..

So this shows two problems:

 - the line numbers that "git blame -C" shows are the current line numbers 
   only, not the line numbers it came from in the version it shows. That 
   makes them useless. We _know_ the current linenumbers. What we want to 
   know is what they were in the commit that they came from.

   So right now, the line number information that "git blame -C" shows is 
   just the same thing we could have gotten by doing a "cat -n file".

 - "git blame -C" has apparently decided that it doesn't need to show 
   filenames that things came from, because they all came from the same 
   commit, but that's not a logical thing to compare. "same commit" does 
   not mean "same filename", so not showing the filename makes no sense.

I tried to bisect this a bit, but I don't think pickaxe has ever gotten 
this right, so I couldn't find a place where it was correct to start 
bisecting at ;)

