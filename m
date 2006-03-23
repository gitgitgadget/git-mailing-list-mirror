From: Linus Torvalds <torvalds@osdl.org>
Subject: [RFC] Make dot-counting ignore ".1" at the end
Date: Wed, 22 Mar 2006 17:50:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603221746300.26286@g5.osdl.org>
References: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 23 02:50:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMEyB-0004Lq-Oj
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 02:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWCWBu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 20:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWCWBu3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 20:50:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750990AbWCWBu3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 20:50:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2N1oNDZ024599
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Mar 2006 17:50:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2N1oNwX006592;
	Wed, 22 Mar 2006 17:50:23 -0800
To: David Mansfield <cvsps@dm.cobite.com>
In-Reply-To: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17845>


I'm not 100% sure this is appropriate, but in general, I think "<rev>" and 
"<rev>.1" should be considered the same thing, no? Which implies that 
"1.1" and "1.1.1.1" are all the same thing, and collapse to just "1", ie a 
zero dot-count. They are all the same version, after all, no?

This gets rid of the insane (?) special case of "1.1.1.1" that exists 
there now, since it's now no longer a special case.

I also wonder if trailing ".1" revisions should be ignored when comparing 
two revisions.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Yeah, I don't know RCS file logic. This may be completely broken.

diff --git a/cvsps.c b/cvsps.c
index 2695a0f..2ad1595 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -2357,9 +2357,16 @@ static int revision_affects_branch(CvsFi
 static int count_dots(const char * p)
 {
     int dots = 0;
+    int len = strlen(p);
 
-    while (*p)
-	if (*p++ == '.')
+    while (len > 2) {
+	if (memcmp(p+len-2, ".1", 2))
+		break;
+	len -= 2;
+    }
+
+    while (len)
+	if (p[--len] == '.')
 	    dots++;
 
     return dots;
@@ -2613,7 +2620,7 @@ static void determine_branch_ancestor(Pa
 	/* HACK: we sometimes pretend to derive from the import branch.  
 	 * just don't do that.  this is the easiest way to prevent... 
 	 */
-	d2 = (strcmp(rev->rev, "1.1.1.1") == 0) ? 0 : count_dots(rev->rev);
+	d2 = count_dots(rev->rev);
 	
 	if (d2 > d1)
 	    head_ps->ancestor_branch = rev->branch;
