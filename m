From: Linus Torvalds <torvalds@osdl.org>
Subject: More "git-apply" safety fixes
Date: Sat, 25 Mar 2006 13:28:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603251321330.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Mar 25 22:28:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNGJR-0001XH-Qj
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 22:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWCYV2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 16:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWCYV2e
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 16:28:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751053AbWCYV2e (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 16:28:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2PLSTDZ031263
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Mar 2006 13:28:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2PLSSSE012800;
	Sat, 25 Mar 2006 13:28:28 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18001>


This was triggered by me testing the "@@" numbering shorthand by GNU 
patch, which not only showed that git-apply thought it meant the number 
was duplicated (when it means that the second number is 1), but my tests 
showed than when git-apply mis-understood the number, it would then not 
raise an alarm about it if the patch ended early.

Now, this doesn't actually _matter_, since with a three-line context, the 
only case that "x,1" will be shorthanded to "x" is when x itself is 1 (in 
which case git-apply got it right), but the fact that git-apply would also 
silently accept truncated patches was a missed opportunity for additional 
sanity-checking.

So make git-apply refuse to look at a patch fragment that ends early.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

If you already applied the first hunk, just ignore that part, and apply 
the second one that adds the test for oldlines/newlines being zero after 
the patch.

Neither of these two changes should matter for a well-formed patch, but 
it's definitely the right thing to do.

diff --git a/apply.c b/apply.c
index 2da225a..c50b3a6 100644
--- a/apply.c
+++ b/apply.c
@@ -693,7 +693,7 @@ static int parse_range(const char *line,
 	line += digits;
 	len -= digits;
 
-	*p2 = *p1;
+	*p2 = 1;
 	if (*line == ',') {
 		digits = parse_num(line+1, p2);
 		if (!digits)
@@ -901,6 +901,8 @@ static int parse_fragment(char *line, un
 			break;
 		}
 	}
+	if (oldlines || newlines)
+		return -1;
 	/* If a fragment ends with an incomplete line, we failed to include
 	 * it in the above loop because we hit oldlines == newlines == 0
 	 * before seeing it.
