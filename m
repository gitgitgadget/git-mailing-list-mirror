From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH 1/3] configure.ac: check tv_nsec field in struct stat
Date: Sun, 21 Dec 2014 10:53:34 -0800
Message-ID: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
Cc: Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 19:54:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2ldx-0001mW-R4
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 19:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbaLUSyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 13:54:13 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:56596 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaLUSyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 13:54:12 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so4495449pab.6
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VFn8w5RmFZW25gxZMBTXN/K7Rw0LXcxdzEyokLP2F+M=;
        b=IaXxZogDK/jMc5qyxJTj8rSEi4CmIkd0KfIYy1fvif6isaVrLVHvrDpNOQ8RoEinA3
         5mnQDa7gilpl2Pa2wmYn2TMdNNfZfQ7HSouXN48RbvtZkCWaWza+4njodTmIAwWl8RHx
         FDljuE5jIqNsSiWWDx+C1o6CaG9g9QMZ0ZgQ6hovibVXZodoEf7Lbufldl05Zfih7aiA
         txfYhOLAPOLaMxUjW2PiR/RhBslVV2fGy6otPBsLMh6XVSQseFvsoC5twVAhqKFUg8fr
         oGR/MOVoj/ZKQwn1eeHZfaYWD5N7Z5rAGwQ8g+mrQRZmbtryWMrnOgYPuL40ESW1Icgc
         LHhw==
X-Received: by 10.68.68.197 with SMTP id y5mr29545702pbt.82.1419188052154;
        Sun, 21 Dec 2014 10:54:12 -0800 (PST)
Received: from zoidberg.san.rr.com (cpe-76-88-40-245.san.res.rr.com. [76.88.40.245])
        by mx.google.com with ESMTPSA id cm10sm15263211pad.46.2014.12.21.10.54.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Dec 2014 10:54:11 -0800 (PST)
X-Mailer: git-send-email 2.2.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261619>

This check will automatically set the correct NO_NSEC setting.
---
 configure.ac | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/configure.ac b/configure.ac
index 6af9647..3cfdd51 100644
--- a/configure.ac
+++ b/configure.ac
@@ -754,6 +754,25 @@ AC_CHECK_TYPES([struct itimerval],
 [#include <sys/time.h>])
 GIT_CONF_SUBST([NO_STRUCT_ITIMERVAL])
 #
+# Define HAVE_ST_MTIM=No if you don't have struct stat.st_mtim.tv_nsec.
+AC_CHECK_MEMBER([struct stat.st_mtim.tv_nsec],
+[HAVE_ST_MTIM=Yes],
+[HAVE_ST_MTIM=No],
+[#include <sys/stat.h>])
+#
+# Define HAVE_ST_MTIMESPEC=No if you don't have struct stat.st_mtimespec.tv_nsec.
+AC_CHECK_MEMBER([struct stat.st_mtimespec.tv_nsec],
+[HAVE_ST_MTIMESPEC=Yes],
+[HAVE_ST_MTIMESPEC=No],
+[#include <sys/stat.h>])
+#
+# Define NO_NSEC if both HAVE_ST_MTIMESPEC and HAVE_ST_MTIM are set to No.
+if test '(' "$HAVE_ST_MTIM" = "No" ')' -a '(' "$HAVE_ST_MTIMESPEC" = "No" ')' ; then
+	NO_NSEC=YesPlease
+	GIT_CONF_SUBST([NO_NSEC])
+fi
+
+#
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,
 [NO_D_INO_IN_DIRENT=],
-- 
2.2.0.GIT
