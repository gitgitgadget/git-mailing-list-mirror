From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix silly pathspec bug in git-ls-files
Date: Tue, 23 Aug 2005 17:14:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508231711350.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 24 02:15:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7iuN-000714-2F
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 02:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVHXAOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 20:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVHXAOU
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 20:14:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40072 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932504AbVHXAOU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 20:14:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7O0EEjA013466
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Aug 2005 17:14:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7O0EDFR016239;
	Tue, 23 Aug 2005 17:14:14 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7688>


The "verify_pathspec()" function doesn't test for ending NUL character in 
the pathspec, causing some really funky and unexpected behaviour. It just 
happened to work in the cases I had tested.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -496,7 +496,7 @@ static void verify_pathspec(void)
 			char c = n[i];
 			if (prev && prev[i] != c)
 				break;
-			if (c == '*' || c == '?')
+			if (!c || c == '*' || c == '?')
 				break;
 			if (c == '/')
 				len = i+1;
