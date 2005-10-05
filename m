From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 5 Oct 2005 15:16:31 +0200
Message-ID: <20051005131631.GA9442@diku.dk>
References: <433B3B10.5050407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 05 15:19:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EN98R-0007xZ-4q
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 15:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVJENQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 09:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbVJENQf
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 09:16:35 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:17120 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S965164AbVJENQf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 09:16:35 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id E5BA06E1520; Wed,  5 Oct 2005 15:16:26 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 92CEA6E147C; Wed,  5 Oct 2005 15:16:24 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 10D4060F42; Wed,  5 Oct 2005 15:16:32 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <433B3B10.5050407@zytor.com>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9706>

I have a few things I experienced with the merged cygwin stuff. Sorry I
haven't investigated it further, but there should be enough for a few
fixes.

When I ...

  user@machine /usr/local/dev/git/git
  $ make prefix=/usr/local install
  install -d -m755 /usr/local/bin
  install git-apply.exe [...]
  sh ./cmd-rename.sh /usr/local/bin
  ln: creating symbolic link `/usr/local/bin/git-http-pull.exe' to `git-http-fetch.exe': File exists
  make: *** [install] Error 1

Can be fixed by the patch below. I don't know if it would be cleaner to
pass cmd-rename.sh "$X" as a second argument from the Makefile.

--- cmd-rename.sh	2005-10-05 14:42:00.000000000 +0200
+++ cmd-rename.sh-orig	2005-10-05 14:43:48.000000000 +0200
@@ -3,7 +3,7 @@
 test -d "$d" || exit
 while read old new
 do
-	rm -f "$d/$old" "$d/$old.exe" 
+	rm -f "$d/$old"
 	if test -f "$d/$new"
 	then
 		ln -s "$new" "$d/$old" || exit


Some other obscurities ...

  user@machine /usr/local/dev/git/git
  $ git-log
  fatal: Not a git repository

  user@machine /usr/local/dev/git/git
  $ GIT_DIR=.git git-log | wc -l
  26094

and I cannot rebuild the index file with git-reset. First time I run it
it creates the index.lock file and errors out when writing. The second
time it errors out because the lock file was not removed in the first
case.

  user@machine /usr/local/dev/git/git
  $ GIT_DIR=.git git-reset
  fatal: unable to write new index file
  
  user@machine /usr/local/dev/git/git
  $ GIT_DIR=.git git-reset
  fatal: unable to create new cachefile
  
  user@machine /usr/local/dev/git/git
  $ uname -a
  CYGWIN_NT-5.1 antimatter 1.5.18(0.132/4/2) 2005-07-02 20:30 i686 unknown unknown Cygwin

-- 
Jonas Fonseca
