From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH 1/3] configure.ac: check tv_nsec field in struct stat
Date: Wed,  7 Jan 2015 12:23:54 -0800
Message-ID: <1420662236-27593-2-git-send-email-reubenhwk@gmail.com>
References: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
 <1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
Cc: Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 21:26:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8x9n-0003y8-9d
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 21:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbbAGUYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 15:24:31 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:41005 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbbAGUY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 15:24:29 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so6700938pdb.8
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 12:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EMfFbOor4vJ4yeCE4YsRfE5TisxQtuXAFoMFMdXbyXM=;
        b=pOwkTTzg7h7umHb6XECN3P39C8tYbZhRX2SJX5dolWZy6KYT2/pFWV4bjbKPSmJKrh
         G34hbQ41axWk+qv/LsDB1NeHzROxqEy2CjVMnmdabdNToAZowg+9oX/PLPmrBfLvslzh
         Xp+5QobJbYCWNNmfxZaNOGzM3BA3scvgdhlz8SGVoSQzYSnhyUjHkiLQZ4AhRc0CP5Bj
         OjgUJQM/iBcYeEQ2vp19bHLr1oEeWW/KZqtNYryuc+lKr8d4cUbYIEAFB+hfLgLsLrpg
         2ht8ScIt2DcNr6xjkaeiZ/8SZSR0Ll6JxzUHLXKTDW2B8tINmYdFnSJXB4KNK1f6sJW2
         dJXw==
X-Received: by 10.70.31.197 with SMTP id c5mr8553497pdi.93.1420662269290;
        Wed, 07 Jan 2015 12:24:29 -0800 (PST)
Received: from zoidberg.san.rr.com (cpe-76-88-40-245.san.res.rr.com. [76.88.40.245])
        by mx.google.com with ESMTPSA id j15sm2585869pdk.49.2015.01.07.12.24.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Jan 2015 12:24:28 -0800 (PST)
X-Mailer: git-send-email 2.2.0.68.g8f72f0c.dirty
In-Reply-To: <1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262155>

This check will automatically set the correct NO_NSEC setting.
---
 configure.ac | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configure.ac b/configure.ac
index 6af9647..dcc4bf0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -754,6 +754,18 @@ AC_CHECK_TYPES([struct itimerval],
 [#include <sys/time.h>])
 GIT_CONF_SUBST([NO_STRUCT_ITIMERVAL])
 #
+# Define USE_ST_TIMESPEC=YesPlease when stat.st_mtimespec.tv_nsec exist
+# Define NO_NSEC=YesPlease when neither stat.st_mtim.tv_nsec nor stat.st_mtimespec.tv_nsec exist
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
