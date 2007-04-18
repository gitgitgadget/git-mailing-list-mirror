From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix merge-recursive on cygwin: broken errno when unlinking a directory
Date: Thu, 19 Apr 2007 00:33:27 +0200
Message-ID: <20070418223327.GC2477@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 00:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeIiS-0001M6-ME
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 00:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992893AbXDRWda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992897AbXDRWd3
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 18:33:29 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:13039 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992893AbXDRWd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 18:33:29 -0400
Received: from tigra.home (Fca1e.f.strato-dslnet.de [195.4.202.30])
	by post.webmailer.de (mrclete mo50) (RZmta 5.5)
	with ESMTP id B0016cj3IKZ5ZC ; Thu, 19 Apr 2007 00:33:27 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 882FD277BD;
	Thu, 19 Apr 2007 00:33:27 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5F518BDDE; Thu, 19 Apr 2007 00:33:27 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl6Sg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44960>

Looks like this time it is not cygwin, the you-know-what actually does
return a permission error.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I am very tempted to conditionally #define gitunlink
to say something rude about win32 and delete c:\boot.ini
instead. It will even work, in most setups.

 merge-recursive.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 595b022..ae4032b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -610,16 +610,19 @@ static void update_file_flags(const unsigned char *sha,
 				die(msg, path, "");
 			}
 			if (unlink(path)) {
-				if (errno == EISDIR) {
+				struct stat st;
+				int err = errno;
+				if (err == EISDIR ||
+				    (err == EPERM && !lstat(path, &st) && S_ISDIR(st.st_mode))) {
 					/* something else exists */
 					error(msg, path, ": perhaps a D/F conflict?");
 					update_wd = 0;
 					goto update_index;
 				}
-				if (errno != ENOENT)
+				if (err != ENOENT)
 					die("failed to unlink %s "
 					    "in preparation to update: %s",
-					    path, strerror(errno));
+					    path, strerror(err));
 			}
 			if (mode & 0100)
 				mode = 0777;
-- 
1.5.1.1.876.ge36f76
