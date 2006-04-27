From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix "git help -a" terminal autosizing
Date: Thu, 27 Apr 2006 09:02:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604270859050.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Apr 27 18:03:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZ8xc-0000P8-Ql
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 18:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWD0QDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 12:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWD0QDS
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 12:03:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965142AbWD0QDR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 12:03:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3RG2ttH020549
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Apr 2006 09:02:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3RG2sWe002054;
	Thu, 27 Apr 2006 09:02:54 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19237>


When I split out the builtin commands into their own files, I left the 
include of <sys/ioctl.h> in git.c rather than moving it to the file that 
needed it (builtin-help.c).

Nobody seems to have noticed, because everything still worked, but because 
the TIOCGWINSZ macro was now no longer defined when compiling the 
"term_columns()" function, it would no longer automatically notice the 
terminal size unless your system used the ancient "COLUMNS" environment 
variable approach.

Trivially fixed by just moving the header include to the file that 
actually needs it.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/builtin-help.c b/builtin-help.c
index 10a59cc..7470faa 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -3,6 +3,7 @@
  *
  * Builtin help-related commands (help, usage, version)
  */
+#include <sys/ioctl.h>
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
diff --git a/git.c b/git.c
index aa2b814..01b7e28 100644
--- a/git.c
+++ b/git.c
@@ -8,7 +8,6 @@ #include <string.h>
 #include <errno.h>
 #include <limits.h>
 #include <stdarg.h>
-#include <sys/ioctl.h>
 #include "git-compat-util.h"
 #include "exec_cmd.h"
 
