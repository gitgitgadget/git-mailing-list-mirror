From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix git-rev-parse breakage
Date: Tue, 23 Aug 2005 19:17:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508231908170.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 04:18:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7kq3-0000nH-1F
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 04:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVHXCRr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 22:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVHXCRq
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 22:17:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750715AbVHXCRq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 22:17:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7O2HfjA021485
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Aug 2005 19:17:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7O2HcSC021249;
	Tue, 23 Aug 2005 19:17:39 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7698>


The --flags cleanup caused problems: we used to depend on the fact that 
"revs_only" magically suppressed flags, adn that assumption was broken by 
the recent fixes.

It wasn't a good assumption in the first place, so instead of 
re-introducing it, let's just get rid of it.

This makes "--revs-only" imply "--no-flags".

[ Side note: we might want to get rid of these confusing two-way flags, 
  where some flags say "only print xxx", and others say "don't print yyy". 
  We'd be better off with just three flags that say "print zzz", where zzz
  is one of "flags, revs, norevs" ]

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -160,6 +160,7 @@ int main(int argc, char **argv)
 			}
 			if (!strcmp(arg, "--revs-only")) {
 				revs_only = 1;
+				no_flags = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--no-revs")) {
