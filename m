From: Linus Torvalds <torvalds@osdl.org>
Subject: Default "tar" umask..
Date: Sat, 30 Dec 2006 10:45:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612301037570.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Dec 30 19:45:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0jD2-0004Km-JV
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 19:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWL3Sp2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 13:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWL3Sp2
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 13:45:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48579 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030189AbWL3Sp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 13:45:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBUIjN2J018335
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Dec 2006 10:45:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBUIjMJ7023810;
	Sat, 30 Dec 2006 10:45:23 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.678 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.165 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35623>


We just had a posting on the kernel security list where a person was 
upset that the 2.6.19.1 and .2 tar-files were apparently group and 
world-writable.

Now, the default kernel releases don't do that (at least any more), 
because I've got

	[tar]
		umask=022

in my git config file these days, but the stable team apparently doesn't.

Looking at some of the tar-files I have lying around, they all seem to 
have used that 022 umask, and maybe we should just change the git default 
to that?

Anybody who wants to, can get the zero umask by just using the config 
file, but maybe the default should be the common case, and the case that 
isn't as likely to be a security issue if you untar it.

GNU tar has a "--no-same-permissions" flag to use the user umask at untar 
time, but I think that's a GNU-tar specific feature (at least I can't see 
any short flag to do the same), and I have to admit that I've _never_ used 
it even though I've used "tar" a long time, so at least going by my 
personal experience, I'd say it's very uncommon for people to use it.

The trivial untested patch below should do it.

		Linus

---
diff --git a/archive-tar.c b/archive-tar.c
index af47fdc..d4a2fa4 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -15,7 +15,7 @@ static char block[BLOCKSIZE];
 static unsigned long offset;
 
 static time_t archive_time;
-static int tar_umask;
+static int tar_umask = 022;
 static int verbose;
 
 /* writes out the whole block, but only if it is full */
