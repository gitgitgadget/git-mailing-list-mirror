From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [RFC & PATCH] Solaris 8: ENOSYS when mkdir applied to automount.
Date: Wed, 01 Feb 2006 16:39:22 -0800
Message-ID: <24768.1138840762@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Thu Feb 02 01:39:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4SVS-0005V4-HT
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 01:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWBBAjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 19:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWBBAjX
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 19:39:23 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:31385 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751488AbWBBAjX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 19:39:23 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id k120dMxV024785
	for <git@vger.kernel.org>; Wed, 1 Feb 2006 16:39:22 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k120dMiF024784
	for <git@vger.kernel.org>; Wed, 1 Feb 2006 16:39:22 -0800 (PST)
To: git@vger.kernel.org
Subject: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15471>

I guess our home directories recently were changed from symlinks
to autmounts.  Solaris 8's mkdir(2) returns ENOSYS when applied
to these, breaking safe_create_leading_directories.  I don't
know if ENOSYS is available everywhere, or if this odd behavior
is appropriate everywhere.

This works for me, but should I wrap mkdir for bizarre behavior
by adding a compat/gitmkdir.c?

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 sha1_file.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

4f388cf48271ec1547817a407ef1afe432cd59d4
diff --git a/sha1_file.c b/sha1_file.c
index 20f6419..65407e2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -83,7 +83,15 @@ int safe_create_leading_directories(char
 			break;
 		*pos = 0;
 		if (mkdir(path, 0777) < 0) {
+#if !defined(ENOSYS)
 			if (errno != EEXIST) {
+#else
+			if (errno != EEXIST && errno != ENOSYS) {
+#endif
+/* 
+ * Solaris 8 appears to return ENOSYS when mkdir is applied 
+ * to an automount.
+ */
 				*pos = '/';
 				return -1;
 			}
-- 
1.1.6.g7159
