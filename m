From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC PATCH] Add support for figuring out where in the git archive
 we are
Date: Tue, 16 Aug 2005 19:50:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508161946350.3553@g5.osdl.org>
References: <Pine.LNX.4.58.0508161536390.3553@g5.osdl.org>
 <7vll315u3w.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508161655460.3553@g5.osdl.org>
 <7vhddp5sfz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508161803250.3553@g5.osdl.org>
 <7vwtml490s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 04:51:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5E0y-0001mx-HV
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 04:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVHQCur (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 22:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVHQCur
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 22:50:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11198 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbVHQCuq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 22:50:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7H2ocjA024405
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Aug 2005 19:50:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7H2obxV029693;
	Tue, 16 Aug 2005 19:50:38 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtml490s.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 16 Aug 2005, Junio C Hamano wrote:
> 
> Merged, pushed out, and tested.  Ouch.  Fails on t0000 test.

It's because the new git-diff-files expects there to be a valid readable 
.git/HEAD, and is unhappy since the test hasn't updated HEAD.

This trivial patch fixes it.

		Linus
----
Fix test failure due to overly strict .git directory tests

We may not actually have a valid HEAD at all times, so relax the validity 
tests for a .git subdirectory accordingly.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
-----
diff --git a/setup.c b/setup.c
--- a/setup.c
+++ b/setup.c
@@ -81,10 +81,9 @@ const char *setup_git_directory(void)
 	offset = len = strlen(cwd);
 	for (;;) {
 		/*
-		 * We always want to see a .git/HEAD and a .git/refs/
-		 * subdirectory
+		 * We always want to see a .git/refs/ subdirectory
 		 */
-		if (!access(".git/HEAD", R_OK) && !access(".git/refs/", X_OK)) {
+		if (!access(".git/refs/", X_OK)) {
 			/*
 			 * Then we need either a GIT_OBJECT_DIRECTORY define
 			 * or a .git/objects/ directory
