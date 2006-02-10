From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] stat() for existence in safe_create_leading_directories()
Date: Thu, 09 Feb 2006 17:56:13 -0800
Message-ID: <15788.1139536573@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Fri Feb 10 02:56:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7NWF-0002lb-Ey
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 02:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWBJB4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 20:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWBJB4R
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 20:56:17 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:12961 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750923AbWBJB4R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 20:56:17 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k1A1uExZ015794
	for <git@vger.kernel.org>; Thu, 9 Feb 2006 17:56:14 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k1A1uEf8015793
	for <git@vger.kernel.org>; Thu, 9 Feb 2006 17:56:14 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15857>

Use stat() to explicitly check for existence rather than
relying on the non-portable EEXIST error in sha1_file.c's
safe_create_leading_directories().  There certainly are
optimizations possible, but then the code becomes almost
the same as that in coreutil's lib/mkdir-p.c.

Other uses of EEXIST seem ok.  Tested on Solaris 8, AIX 5.2L,
and a few Linux versions.  AIX has some unrelated (I think)
failures right now; I haven't tried many recent gits there.
Anyone have an old Ultrix box to break everything?  ;)

Also remove extraneous #includes.  Everything's already in
git-compat-util.h, included through cache.h.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 sha1_file.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

597de7026f284d7bb5ea5b929a70b3cf3077e4e7
diff --git a/sha1_file.c b/sha1_file.c
index 20f6419..3d11a9b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -6,8 +6,6 @@
  * This handles basic git sha1 object files - packing, unpacking,
  * creation etc.
  */
-#include <sys/types.h>
-#include <dirent.h>
 #include "cache.h"
 #include "delta.h"
 #include "pack.h"
@@ -74,6 +72,8 @@ int adjust_shared_perm(const char *path)
 int safe_create_leading_directories(char *path)
 {
 	char *pos = path;
+	struct stat st;
+
 	if (*pos == '/')
 		pos++;
 
@@ -82,12 +82,17 @@ int safe_create_leading_directories(char
 		if (!pos)
 			break;
 		*pos = 0;
-		if (mkdir(path, 0777) < 0) {
-			if (errno != EEXIST) {
+		if (!stat(path, &st)) {
+			/* path exists */
+			if (!S_ISDIR(st.st_mode)) {
 				*pos = '/';
-				return -1;
+				return -3;
 			}
 		}
+		else if (mkdir(path, 0777)) {
+			*pos = '/';
+			return -1;
+		}
 		else if (adjust_shared_perm(path)) {
 			*pos = '/';
 			return -2;
-- 
1.1.5
