From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH 1/3] configure.ac: check 'tv_nsec' field in 'struct stat'
Date: Thu,  8 Jan 2015 12:00:55 -0800
Message-ID: <1420747257-16132-1-git-send-email-reubenhwk@gmail.com>
Cc: Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 21:02:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9JHM-0001oe-LY
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 21:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbbAHUBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 15:01:40 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52093 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbbAHUB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 15:01:29 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so13731462pab.7
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 12:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5DEVywnw6dVFPOEPRgBPHWl2Zyayvd5I+HEQhXw+Cs4=;
        b=pDtJIQrKP6Qorp1FXfbo62+Tc6jKEP+px8wiOqLRwPmgtqpJW7QrJ+zErYgK3eEgwB
         DfdcU9h/yobOG2zdNwrbK1SYigTNe4/SnnO4gXpUDHVvZ+MuN25/zDlyBN5vdJey+2cc
         75OXTjca20DNaIfd69uS4fiJRj78X1yzchz90s/zG00uxJMDuN8KM+ONUPUivvaB9oG6
         c7OJ55L6dRi2fiRepIxqQYgst23C5Nqkk7WRt0cwVgkTByrAZ4rKR6z6RWCuvWBUikNv
         NWFfP3uqGu8vxmIzEsOdVdqcYeOimCvAmBLLaICoZyoxjcl8OpTXrOqRPB1p1HTQ7VH9
         klmg==
X-Received: by 10.66.66.166 with SMTP id g6mr18090798pat.88.1420747288328;
        Thu, 08 Jan 2015 12:01:28 -0800 (PST)
Received: from zoidberg.san.rr.com (cpe-76-88-40-245.san.res.rr.com. [76.88.40.245])
        by mx.google.com with ESMTPSA id do3sm5248879pac.48.2015.01.08.12.01.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jan 2015 12:01:27 -0800 (PST)
X-Mailer: git-send-email 2.2.0.68.g8f72f0c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262215>

Detect 'tv_nsec' field in 'struct stat' and set Makefile variable
NO_NSEC appropriately.

A side-effect of the above detection is that we also determine
whether 'stat.st_mtimespec' is available, so, as a bonus, set the
Makefile variable USE_ST_TIMESPEC, as well.

Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
---
 configure.ac | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure.ac b/configure.ac
index 6af9647..210eb4e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -754,6 +754,19 @@ AC_CHECK_TYPES([struct itimerval],
 [#include <sys/time.h>])
 GIT_CONF_SUBST([NO_STRUCT_ITIMERVAL])
 #
+# Define USE_ST_TIMESPEC=YesPlease when stat.st_mtimespec.tv_nsec exists.
+# Define NO_NSEC=YesPlease when neither stat.st_mtim.tv_nsec nor
+# stat.st_mtimespec.tv_nsec exists.
+AC_CHECK_MEMBER([struct stat.st_mtimespec.tv_nsec])
+AC_CHECK_MEMBER([struct stat.st_mtim.tv_nsec])
+if test x$ac_cv_member_struct_stat_st_mtimespec_tv_nsec = xyes ; then
+	USE_ST_TIMESPEC=YesPlease
+	GIT_CONF_SUBST([USE_ST_TIMESPEC])
+elif test x$ac_cv_member_struct_stat_st_mtim_tv_nsec != xyes ; then
+	NO_NSEC=YesPlease
+	GIT_CONF_SUBST([NO_NSEC])
+fi
+#
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,
 [NO_D_INO_IN_DIRENT=],
-- 
2.2.0.68.g8f72f0c.dirty
