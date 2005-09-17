From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix "git-rev-list" revision range parsing
Date: Fri, 16 Sep 2005 17:53:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161750420.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Sep 17 02:53:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGQxY-0006uG-3R
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 02:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVIQAxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 20:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVIQAxh
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 20:53:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46001 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750796AbVIQAxh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 20:53:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8H0rJBo030650
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 17:53:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8H0rJ6Q022723;
	Fri, 16 Sep 2005 17:53:19 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8745>


There were two bugs in there:
 - if the range didn't end up working, we restored the '.' character in 
   the wrong place.
 - an empty end-of-range should be interpreted as HEAD.

See rev-parse.c for the reference implementation of this.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -561,6 +561,8 @@ int main(int argc, char **argv)
 			struct commit *exclude = NULL;
 			struct commit *include = NULL;
 			*dotdot = 0;
+			if (!*next)
+				next = "HEAD";
 			exclude = get_commit_reference(arg, UNINTERESTING);
 			include = get_commit_reference(next, 0);
 			if (exclude && include) {
@@ -569,7 +571,7 @@ int main(int argc, char **argv)
 				handle_one_commit(include, &list);
 				continue;
 			}
-			*next = '.';
+			*dotdot = '.';
 		}
 		if (*arg == '^') {
 			flags = UNINTERESTING;
