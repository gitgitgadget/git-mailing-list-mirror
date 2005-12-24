From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add a "git-describe" command
Date: Sat, 24 Dec 2005 14:13:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512241409300.14098@g5.osdl.org>
References: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Dec 24 23:13:38 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqHdx-0001uY-EC
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 23:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVLXWNe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 17:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVLXWNe
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 17:13:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750740AbVLXWNd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 17:13:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBOMDSDZ028445
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 24 Dec 2005 14:13:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBOMDPWg013071;
	Sat, 24 Dec 2005 14:13:27 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14039>



On Sat, 24 Dec 2005, Linus Torvalds wrote:
> 
> This is useful for two things:
> 
>  - automatic version naming in Makefiles, for example. We could use it in 
>    git itself: when doing "git --version", we could use this to give a 
>    much more useful description of exactly what version was installed.

This trivial patch fails to do that correctly, but maybe somebody could 
fix it. 

The problem is not that it generates GIT_VERSION wrong. The problem is 
two-fold:
 - it should notice when "git-describe" doesn't exist, and fall back on 
   the old less-than-descriptive behaviour
 - it doesn't do dependencies correctly (ie it should now make "git" 
   depend on the version number, but it doesn't, so it doesn't re-build 
   git after a commit/pull)

but at least it shows the _idea_ of using git-describe.

With this I get

	[torvalds@g5 git]$ git --version
	git version v1.0.4-g6e9961d6

which I think is better than "1.0.GIT" which doesn't say anything about 
what the _actual_ version was.

(Ignore the particular SHA1 hash - it has my local commit that you can't 
re-create that just created that git-describe thing. You'll get your own 
version number).

		Linus

---
diff --git a/Makefile b/Makefile
index 47e7898..2e5c569 100644
--- a/Makefile
+++ b/Makefile
@@ -55,7 +55,7 @@ all:
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-cache perspective.
 
-GIT_VERSION = 1.0.GIT
+GIT_VERSION = $(shell git-describe HEAD | sed 's:refs/tags/::')
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
