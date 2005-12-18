From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "git help" react to window size correctly
Date: Sun, 18 Dec 2005 12:15:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512181211160.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Dec 18 21:16:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eo4xR-0001zd-4l
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 21:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbVLRUQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 15:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbVLRUQX
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 15:16:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965264AbVLRUQX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 15:16:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBIKG4DZ010361
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Dec 2005 12:16:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBIKFx8n024577;
	Sun, 18 Dec 2005 12:16:00 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Ericsson <exon@op5.se>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13801>


Currently the git "show commands" function will react to the environment 
variable COLUMNS, or just default to a width of 80 characters.

That's just soo eighties. Nobody sane sets COLUMNS any more, unless they 
need to support some stone-age software from before the age of steam 
engines, SIGWINCH and TIOCGWINSZ.

So get with the new century, and use TIOCGWINSZ to get the terminal size.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git.c b/git.c
index c26cac6..157c549 100644
--- a/git.c
+++ b/git.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <stdarg.h>
+#include <sys/ioctl.h>
 #include "git-compat-util.h"
 
 #ifndef PATH_MAX
@@ -26,6 +27,16 @@ static int term_columns(void)
 	if (col_string && (n_cols = atoi(col_string)) > 0)
 		return n_cols;
 
+#ifdef TIOCGWINSZ
+	{
+		struct winsize ws;
+		if (!ioctl(1, TIOCGWINSZ, &ws)) {
+			if (ws.ws_col)
+				return ws.ws_col;
+		}
+	}
+#endif
+
 	return 80;
 }
 
