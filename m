From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix ptrdiff_t vs. int
Date: Fri, 27 May 2005 10:25:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505271024280.17402@ppc970.osdl.org>
References: <42971EB4.2050403@oberhumer.com> <Pine.LNX.4.58.0505271013260.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 19:24:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbiXR-0002Pv-3R
	for gcvg-git@gmane.org; Fri, 27 May 2005 19:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVE0RYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVE0RYP
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 13:24:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:12976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262524AbVE0RXw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 13:23:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RHNljA022809
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 10:23:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RHNkNZ031298;
	Fri, 27 May 2005 10:23:46 -0700
To: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
In-Reply-To: <Pine.LNX.4.58.0505271013260.17402@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Linus Torvalds wrote:
> 
> I can compile a kernel with "-m64", but since I don't have any 64-bit
> libraries installed, user space doesn't work that well ;)

Btw, since this was the piece of code that I didn't bother simplifying 
last time it was discussed (then it was just "ugly"), I took a different 
approach instead, and committed the following..

		Linus

---
diff-tree 84c1afd7e7c69c6c3c0677d5ee01925d4c70d318 (from a9c9cef161b26ca610783dd0b180d18956c7b119)
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Fri May 27 10:22:09 2005 -0700
    
    git-diff-tree: simplify header output with '-z'
    
    No need to make them multiple lines, in fact we explicitly don't want that.
    
    This also fixes a 64-bit problem pointed out by Markus F.X.J. Oberhumer,
    where we gave "%.*s" a "ptrdiff_t" length argument instead of an "int".

diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -269,18 +269,11 @@ static int call_diff_flush(void)
 		return 0;
 	}
 	if (header) {
-		if (diff_output_format == DIFF_FORMAT_MACHINE) {
-			const char *ep, *cp;
-			for (cp = header; *cp; cp = ep) {
-				ep = strchr(cp, '\n');
-				if (ep == 0) ep = cp + strlen(cp);
-				printf("%.*s%c", ep-cp, cp, 0);
-				if (*ep) ep++;
-			}
-		}
-		else {
-			printf("%s", header);
-		}
+		const char *fmt = "%s";
+		if (diff_output_format == DIFF_FORMAT_MACHINE)
+			fmt = "%s%c";
+		
+		printf(fmt, header, 0);
 		header = NULL;
 	}
 	diff_flush(diff_output_format, 1);
