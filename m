From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] Support symlinks in git-ls-files --others.
Date: Thu, 12 May 2005 17:16:04 -0700
Message-ID: <7vwtq4asl7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 02:08:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWNjH-0007x6-IC
	for gcvg-git@gmane.org; Fri, 13 May 2005 02:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVEMAQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 20:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVEMAQQ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 20:16:16 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:25486 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262184AbVEMAQG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 20:16:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050513001605.ZUWD26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 20:16:05 -0400
To: Petr Baudis <pasky@ucw.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It is kind of surprising that this was missed in the last round,
but the work tree scanner in git-ls-files was still deliberately
ignoring symlinks.  This patch fixes it, so that --others will
correctly report unregistered symlinks.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

cache.h    |    1 +
ls-files.c |    8 +++++---
2 files changed, 6 insertions(+), 3 deletions(-)

--- a/cache.h
+++ b/cache.h
@@ -27,6 +27,7 @@
 #define DT_UNKNOWN	0
 #define DT_DIR		1
 #define DT_REG		2
+#define DT_LNK		3
 #define DTYPE(de)	DT_UNKNOWN
 #endif
 
--- a/ls-files.c
+++ b/ls-files.c
@@ -109,8 +109,9 @@
 
 /*
  * Read a directory tree. We currently ignore anything but
- * directories and regular files. That's because git doesn't
- * handle them at all yet. Maybe that will change some day.
+ * directories, regular files and symlinks. That's because git
+ * doesn't handle them at all yet. Maybe that will change some
+ * day.
  *
  * Also, we currently ignore all names starting with a dot.
  * That likely will not change.
@@ -141,7 +142,7 @@
 			case DT_UNKNOWN:
 				if (lstat(fullname, &st))
 					continue;
-				if (S_ISREG(st.st_mode))
+				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))
 					break;
 				if (!S_ISDIR(st.st_mode))
 					continue;
@@ -152,6 +153,7 @@
 					       baselen + len + 1);
 				continue;
 			case DT_REG:
+			case DT_LNK:
 				break;
 			}
 			add_name(fullname, baselen + len);
------------------------------------------------

