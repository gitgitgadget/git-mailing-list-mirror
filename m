From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/2] Resolve double chmod() in move_temp_to_file()
Date: Thu, 26 Mar 2009 16:17:48 +0100
Message-ID: <200903261617.48362.johan@herland.net>
References: <200903250105.05808.johan@herland.net> <49CB51E2.9010903@viscovery.net> <200903261602.37857.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 16:20:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmrMv-0001Wm-Vc
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 16:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbZCZPSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 11:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZCZPSM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 11:18:12 -0400
Received: from sam.opera.com ([213.236.208.81]:48598 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbZCZPSM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 11:18:12 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n2QFHmuF009270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Mar 2009 15:17:48 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <200903261602.37857.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114789>

move_temp_to_file() used to chmod(foo, 0444) immediately before calling
adjust_shared_perm() which potentially does another call to chmod().

This patch splits a new function (called get_shared_perm()) out of
adjust_shared_perm(). The new function adjusts a given file mode value
according to the shared_repository setting, and returns the resulting
mode. It is used in move_temp_file() to generate the correct and final
permissions to pass to chmod() in a single call.

Signed-off-by: Johan Herland <johan@herland.net>
---
 cache.h     |    1 +
 path.c      |   26 +++++++++++++++++++-------
 sha1_file.c |    2 +-
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 9cf5a13..b24eb3a 100644
--- a/cache.h
+++ b/cache.h
@@ -623,6 +623,7 @@ enum sharedrepo {
 	PERM_EVERYBODY      = 0664,
 };
 int git_config_perm(const char *var, const char *value);
+int get_shared_perm(int mode);
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
diff --git a/path.c b/path.c
index 42898e0..497db19 100644
--- a/path.c
+++ b/path.c
@@ -311,16 +311,13 @@ char *enter_repo(char *path, int strict)
 	return NULL;
 }
 
-int adjust_shared_perm(const char *path)
+int get_shared_perm(int mode)
 {
-	struct stat st;
-	int mode, tweak, shared;
+	int tweak, shared;
 
 	if (!shared_repository)
-		return 0;
-	if (lstat(path, &st) < 0)
-		return -1;
-	mode = st.st_mode;
+		return mode;
+
 	if (shared_repository < 0)
 		shared = -shared_repository;
 	else
@@ -343,6 +340,21 @@ int adjust_shared_perm(const char *path)
 		mode |= FORCE_DIR_SET_GID;
 	}
 
+	return mode;
+}
+
+int adjust_shared_perm(const char *path)
+{
+	struct stat st;
+	int mode, tweak, shared;
+
+	if (!shared_repository)
+		return 0;
+	if (lstat(path, &st) < 0)
+		return -1;
+
+	mode = get_shared_perm(st.st_mode);
+
 	if (((shared_repository < 0
 	      ? (st.st_mode & (FORCE_DIR_SET_GID | 0777))
 	      : (st.st_mode & mode)) != mode) &&
diff --git a/sha1_file.c b/sha1_file.c
index 87ac53b..05af3c5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2252,7 +2252,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 		/* FIXME!!! Collision check here ? */
 	}
 
-	if (chmod(filename, 0444) || adjust_shared_perm(filename))
+	if (chmod(filename, get_shared_perm(0444)))
 		return error("unable to set permission to '%s'", filename);
 	return 0;
 }
-- 
1.6.1.2.461.g5bad6
